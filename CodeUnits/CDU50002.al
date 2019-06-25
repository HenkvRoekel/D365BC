codeunit 50002 "Sales charges - Item Tracking"
{
    TableNo = "Sales Header";

    trigger OnRun()
    var
        lrecBejoSetup: Record "Bejo Setup";
    begin

        lrecBejoSetup.Get;
        lrecBejoSetup.TestField("G/L Shipping Charges");
        AddGLAccountSalesLine(Rec, lrecBejoSetup."G/L Shipping Charges");

    end;

    var
        gAvailQty: Decimal;
        Text50024: Label 'You must select a lot with the correct unit of measure.';
        Text50025: Label 'Nothing available.';
        Text50026: Label 'New line(s) created, press F5 or click Refresh.';
        Text50027: Label 'Quantity per Unit of Measure cannot be 0!';
        gcuSalesLineReserve: Codeunit "Sales Line-Reserve";
        gcuItemJnlLineReserve: Codeunit "Item Jnl. Line-Reserve";
        gcuItemTrackingMgt: Codeunit "Item Tracking Management";
        Text50028: Label 'Insufficient Available.';
        Text50029: Label 'Program code error GetBin %1.';

    procedure UpdateWhseTrackingSummarySlsLn(var TempReservEntry: Record "Reservation Entry" temporary; var TempEntrySummary: Record "Entry Summary" temporary; var SalesLine: Record "Sales Line"; onlyLotNo: Code[20])
    var
        ItemLedgEntry: Record "Item Ledger Entry";
        WarehouseEntry: Record "Warehouse Entry";
        Item: Record Item;
        LotNoInfo: Record "Lot No. Information";
        LastEntryNo: Integer;
        ReservEntry: Record "Reservation Entry";
        onlyItemNo: Code[20];
    begin


        Clear(onlyItemNo);
        if SalesLine."Document Type" = SalesLine."Document Type"::"Credit Memo" then
            onlyItemNo := SalesLine."No.";
        Clear(TempEntrySummary);
        TempEntrySummary.DeleteAll;
        Clear(TempReservEntry);
        TempReservEntry.DeleteAll;

        if SalesLine.Type <> SalesLine.Type::Item then
            exit;
        if SalesLine."No." = '' then
            exit;
        Item.Get(SalesLine."No.");


        // set filters reservation entry
        ReservEntry.Reset;
        if not ReservEntry.SetCurrentKey("Item No.", "Variant Code", "Location Code",
          "Source Type", "Source Subtype", "Reservation Status", "Expected Receipt Date") then
            ReservEntry.SetCurrentKey("Item No.", "Source Type", "Source Subtype", "Reservation Status", "Location Code", "Variant Code"
             , "Shipment Date", "Expected Receipt Date", "Serial No.", "Lot No.");
        ReservEntry.SetRange("Reservation Status",
          ReservEntry."Reservation Status"::Reservation, ReservEntry."Reservation Status"::Surplus);

        if (onlyItemNo = '') then
            ReservEntry.SetFilter("Item No.", ItemFilterIncludingExtention(Item))

        else
            ReservEntry.SetRange("Item No.", onlyItemNo);
        ReservEntry.SetRange("Location Code", SalesLine."Location Code");
        if onlyLotNo = '' then
            ReservEntry.SetFilter("Lot No.", '<>%1', '')
        else
            ReservEntry.SetRange("Lot No.", onlyLotNo);

        ReservEntry.SetFilter("Source Type", '..31|33..38|40..');

        // end set filters reservation entry


        // set filters warehouse entry
        WarehouseEntry.Reset;
        if not WarehouseEntry.SetCurrentKey("Item No.", "Variant Code", "Location Code", "Lot No.", "Bin Code") then
            WarehouseEntry.SetCurrentKey("Item No.", "Bin Code", "Location Code", "Variant Code");
        if (onlyItemNo = '') then
            WarehouseEntry.SetFilter("Item No.", ItemFilterIncludingExtention(Item))

        else
            WarehouseEntry.SetRange("Item No.", onlyItemNo);
        if onlyLotNo = '' then
            WarehouseEntry.SetFilter("Lot No.", '<>%1', '')
        else
            WarehouseEntry.SetRange("Lot No.", onlyLotNo);
        WarehouseEntry.SetRange("Location Code", SalesLine."Location Code");
        // end set filters warehouse entry

        // fill TempReservEntry from warehouseentry
        if WarehouseEntry.FindSet then
            repeat
                WarehouseEntry.SetRange("Lot No.", WarehouseEntry."Lot No.");
                WarehouseEntry.SetRange("Bin Code", WarehouseEntry."Bin Code");
                WarehouseEntry.CalcSums("Qty. (Base)", Quantity);
                if WarehouseEntry."Qty. (Base)" > 0 then begin
                    TempReservEntry.Init;
                    TempReservEntry."Entry No." := -WarehouseEntry."Entry No.";
                    TempReservEntry."Reservation Status" := ReservEntry."Reservation Status"::Surplus;
                    TempReservEntry."Item No." := WarehouseEntry."Item No.";
                    TempReservEntry."Lot No." := WarehouseEntry."Lot No.";
                    TempReservEntry."Location Code" := WarehouseEntry."Location Code";
                    TempReservEntry."Quantity (Base)" := WarehouseEntry."Qty. (Base)";
                    TempReservEntry."Source Type" := DATABASE::"Warehouse Entry";
                    TempReservEntry."Source Ref. No." := WarehouseEntry."Entry No.";
                    TempReservEntry."Serial No." := WarehouseEntry."Serial No.";
                    TempReservEntry.Positive := true;
                    if TempReservEntry.Positive then begin
                        TempReservEntry."Warranty Date" := WarehouseEntry."Warranty Date";
                        TempReservEntry."Expiration Date" := WarehouseEntry."Expiration Date";
                        TempReservEntry."Expected Receipt Date" := 0D
                    end else
                        TempReservEntry."Shipment Date" := DMY2Date(31, 12, 9999);

                    ItemLedgEntry.Reset;
                    ItemLedgEntry.SetCurrentKey("Item No.", "Variant Code", Open);
                    ItemLedgEntry.SetRange("Item No.", WarehouseEntry."Item No.");
                    ItemLedgEntry.SetRange(Open, true);
                    ItemLedgEntry.SetRange("Lot No.", WarehouseEntry."Lot No.");
                    if not ItemLedgEntry.FindFirst then
                        ItemLedgEntry.Init;


                    TempReservEntry."Qty. per Unit of Measure" := ItemLedgEntry."Qty. per Unit of Measure";
                    if WarehouseEntry.Quantity <> 0 then
                        TempReservEntry.Quantity := CalcUofMQty(WarehouseEntry.Quantity, ItemLedgEntry."Qty. per Unit of Measure");
                    TempReservEntry.Insert;
                end;
                WarehouseEntry.FindLast;
                WarehouseEntry.SetRange("Bin Code");
                if onlyLotNo = '' then
                    WarehouseEntry.SetFilter("Lot No.", '<>%1', '')
                else
                    WarehouseEntry.SetRange("Lot No.", onlyLotNo);
            until WarehouseEntry.Next = 0;
        // end fill TempReservEntry from warehouseentry

        // fill tempreserventry form reserventry
        if ReservEntry.Find('-') then repeat
                                          TempReservEntry := ReservEntry;
                                          TempReservEntry.Insert;
            until ReservEntry.Next = 0;
        // end fill tempreserventry form reserventry

        // fill entrysummary from tempreserventry
        if TempReservEntry.FindSet then
            repeat
                TempEntrySummary.SetRange("B Item No.", TempReservEntry."Item No.");
                TempEntrySummary.SetRange("Lot No.", TempReservEntry."Lot No.");

                TempEntrySummary.SetRange("B Unit of Measure Code", GetUnitOfMeasure(TempReservEntry));


                TempEntrySummary.SetRange("B Bin Code", GetBin(TempReservEntry));
                if not TempEntrySummary.FindFirst then begin
                    TempEntrySummary.Init;
                    TempEntrySummary."Entry No." := LastEntryNo + 1;
                    LastEntryNo := TempEntrySummary."Entry No.";
                    TempEntrySummary."Table ID" := TempReservEntry."Source Type";
                    TempEntrySummary."Summary Type" := '';

                    TempEntrySummary."Lot No." := TempReservEntry."Lot No.";
                    TempEntrySummary."B Item No." := TempReservEntry."Item No.";
                    TempEntrySummary."B Location Code" := TempReservEntry."Location Code";

                    TempEntrySummary."B Bin Code" := GetBin(TempReservEntry);

                    TempEntrySummary."B Unit of Measure Code" := GetUnitOfMeasure(TempReservEntry);
                    TempEntrySummary."B Qty. per Unit of Measure" := TempReservEntry."Qty. per Unit of Measure";

                    if not LotNoInfo.Get(TempEntrySummary."B Item No.", '', TempEntrySummary."Lot No.") then
                        LotNoInfo.Init;

                    TempEntrySummary."B Treatment Code" := LotNoInfo."B Treatment Code";
                    TempEntrySummary."B Tsw. in gr." := LotNoInfo."B Tsw. in gr.";
                    TempEntrySummary."B Line type" := LotNoInfo."B Line type";
                    TempEntrySummary."B Germination" := LotNoInfo."B Germination";
                    TempEntrySummary."B Abnormals" := LotNoInfo."B Abnormals";
                    TempEntrySummary."B Grade Code" := LotNoInfo."B Grade Code";
                    TempEntrySummary."B Remark" := LotNoInfo."B Remark";
                    TempEntrySummary."B Best used by" := LotNoInfo."B Best used by";
                    TempEntrySummary."B Blocked" := LotNoInfo.Blocked;
                    TempEntrySummary.Insert;
                end;

                // Base
                if TempReservEntry.Positive then begin
                    TempEntrySummary."Warranty Date" := TempReservEntry."Warranty Date";
                    TempEntrySummary."Expiration Date" := TempReservEntry."Expiration Date";
                    if TempReservEntry."Entry No." < 0 then
                        TempEntrySummary."Total Quantity" += TempReservEntry."Quantity (Base)";
                    if TempReservEntry."Reservation Status" = TempReservEntry."Reservation Status"::Reservation then
                        TempEntrySummary."Total Reserved Quantity" += TempReservEntry."Quantity (Base)";
                end else begin
                    TempEntrySummary."Total Requested Quantity" -= TempReservEntry."Quantity (Base)";
                end;
                TempEntrySummary."Total Available Quantity" :=
                  TempEntrySummary."Total Quantity" -
                  TempEntrySummary."Total Requested Quantity" +
                  TempEntrySummary."Current Reserved Quantity";

                // UoM
                if TempReservEntry.Positive then begin
                    if TempReservEntry."Entry No." < 0 then
                        TempEntrySummary."B Total Quantity (UofM)" += TempReservEntry.Quantity;
                    if TempReservEntry."Reservation Status" = TempReservEntry."Reservation Status"::Reservation then
                        TempEntrySummary."B Tot Reserved Quantity (UofM)" += TempReservEntry.Quantity;
                end else begin
                    TempEntrySummary."B Tot Requested Quantity(UofM)" -= TempReservEntry.Quantity;
                end;
                TempEntrySummary."B Tot Available Quantity(UofM)" :=
                  TempEntrySummary."B Total Quantity (UofM)" -
                  TempEntrySummary."B Tot Requested Quantity(UofM)";

                TempEntrySummary.Modify;
            until TempReservEntry.Next = 0;

        // end fill entrysummary from tempreserventry

        TempEntrySummary.Reset;
    end;

    procedure LotNoLookup(var Rec: Record "Sales Line")
    var
        tempReservEntry: Record "Reservation Entry" temporary;
        tempEntrySummary: Record "Entry Summary";
        itemTrackingSummaryForm: Page "Item Tracking Summary";
    begin


        UpdateWhseTrackingSummarySlsLn(tempReservEntry, tempEntrySummary, Rec, '');

        itemTrackingSummaryForm.SetSources(tempReservEntry, tempEntrySummary);
        itemTrackingSummaryForm.LookupMode(true);
        if tempEntrySummary.FindFirst then
            itemTrackingSummaryForm.SetRecord(tempEntrySummary);
        tempEntrySummary.Reset;

        Commit;

        if itemTrackingSummaryForm.RunModal = ACTION::LookupOK then begin
            itemTrackingSummaryForm.GetRecord(tempEntrySummary);
            CheckUnitofMeasureCode(tempEntrySummary."B Unit of Measure Code", Rec);

            tempEntrySummary.TestField("B Item No.");

            Rec.TestField(Quantity);
            gAvailQty := tempEntrySummary."B Tot Available Quantity(UofM)";

            UpdateItemNo(tempEntrySummary."B Item No.", Rec);

            if gAvailQty > 0 then begin
                Rec.Validate("Bin Code", tempEntrySummary."B Bin Code");
            end else begin
                Rec.Validate("B Lot No.", '');
            end;

            Rec."B AvailableQty" := gAvailQty;

            Rec.Validate("B Lot No.", tempEntrySummary."Lot No.");

        end;
    end;

    local procedure CalcUofMQty(Qty: Decimal; QtyperUofM: Decimal): Decimal
    begin

        if QtyperUofM = 0 then
            Error(Text50027);
        exit(Round(Qty / QtyperUofM, 0.00001));
    end;

    procedure CheckUnitofMeasureCode(UofM: Code[10]; var SalesLine: Record "Sales Line")
    begin

        SalesLine.TestField("Unit of Measure Code");
        if UofM <> SalesLine."Unit of Measure Code" then
            Error(Text50024);
    end;

    procedure UpdateReservEntrySlsLn(var SalesLine: Record "Sales Line"; var QuantatyAvailable: Decimal)
    var
        TempTrackingSpecification: Record "Tracking Specification" temporary;
        SourceTrackingSpecification: Record "Tracking Specification";
        resEntry: Record "Reservation Entry";
        salesLineNew: Record "Sales Line";
        ConfCreateNwSLine: Page "Confirm Create New Line";
        totalAvailQuantofLotNo: Decimal;
        DocumentDimension: Record "Dimension Set Entry";
        DocumentDimensionNew: Record "Dimension Set Entry";
        ReservEngineMgt: Codeunit "Reservation Engine Mgt.";
        ReserveSalesLine: Codeunit "Sales Line-Reserve";
        ItemTrackingLines: Page "Item Tracking Lines";
        lrecSalesCommentLine: Record "Sales Comment Line";
        lrecSalesCommentLineNew: Record "Sales Comment Line";
        lcuTransferExtendedText: Codeunit "Transfer Extended Text";
        lrecToSalesLine: Record "Sales Line";
        LineSpacing: Integer;
        NextLineNo: Integer;
        lText50000: Label 'There is not enough space to insert new sales lines.';
        OrigBinCode: Code[20];
    begin


        SalesLine.TestField(Type, SalesLine.Type::Item);
        SalesLine.TestField(Quantity);

        ReservEngineMgt.InitFilterAndSortingFor(resEntry, false);
        ReserveSalesLine.FilterReservFor(resEntry, SalesLine);

        if SalesLine."B Lot No." <> '' then begin
            if SalesLine."Document Type" = SalesLine."Document Type"::Order then begin

                totalAvailQuantofLotNo := QuantatyAvailable;
                if totalAvailQuantofLotNo <= 0 then
                    Error(Text50025);
                if SalesLine.Quantity > totalAvailQuantofLotNo then begin
                    Commit;
                    Clear(ConfCreateNwSLine);

                    ConfCreateNwSLine.SetLotNo(SalesLine."B Lot No.");
                    ConfCreateNwSLine.SetQuantity(totalAvailQuantofLotNo);
                    ConfCreateNwSLine.RunModal;

                    if ConfCreateNwSLine.GetCreateNewLine then begin


                        lrecToSalesLine.SetRange("Document Type", SalesLine."Document Type");
                        lrecToSalesLine.SetRange("Document No.", SalesLine."Document No.");
                        lrecToSalesLine.SetRange("Attached to Line No.", 0);
                        lrecToSalesLine := SalesLine;
                        if lrecToSalesLine.Find('>') then begin
                            LineSpacing :=
                              (lrecToSalesLine."Line No." - SalesLine."Line No.") div 2;
                            if LineSpacing = 0 then
                                Error(lText50000);
                        end else begin
                            LineSpacing := 10000;
                        end;

                        lrecToSalesLine.SetRange("Attached to Line No.", SalesLine."Line No.");
                        if lrecToSalesLine.FindLast then begin
                            NextLineNo := lrecToSalesLine."Line No." + LineSpacing;
                        end else
                            NextLineNo := SalesLine."Line No." + LineSpacing;


                        salesLineNew.Init;
                        salesLineNew := SalesLine;

                        salesLineNew.Validate(Quantity, SalesLine.Quantity - ConfCreateNwSLine.GetQuantity);
                        salesLineNew."B Lot No." := '';
                        salesLineNew.Validate("Bin Code", '');


                        salesLineNew.Validate("Unit Price", SalesLine."Unit Price");


                        salesLineNew."Line No." := NextLineNo;
                        salesLineNew.Insert;

                        if lcuTransferExtendedText.SalesCheckIfAnyExtText(salesLineNew, false) then begin
                            lcuTransferExtendedText.InsertSalesExtText(salesLineNew);
                        end;

                        lrecSalesCommentLine.SetRange("No.", SalesLine."Document No.");
                        if lrecSalesCommentLine.FindSet then
                            repeat
                                lrecSalesCommentLineNew.Init;
                                lrecSalesCommentLineNew := lrecSalesCommentLine;
                                lrecSalesCommentLineNew."Line No." := salesLineNew."Line No.";
                                if lrecSalesCommentLineNew.Insert then;
                            until lrecSalesCommentLine.Next = 0;

                        Message(Text50026);
                    end;


                    OrigBinCode := SalesLine."Bin Code";


                    SalesLine.Validate(Quantity, ConfCreateNwSLine.GetQuantity);

                    SalesLine.Validate("Unit Price", salesLineNew."Unit Price");

                    SalesLine.Validate("Bin Code", OrigBinCode);

                    Commit;
                end;
            end;


            if resEntry.FindFirst then

                ReserveSalesLine.DeleteLine(SalesLine);

            SourceTrackingSpecification.InitFromSalesLine(SalesLine);

            SourceTrackingSpecification."Entry No." += 1;
            TempTrackingSpecification := SourceTrackingSpecification;
            TempTrackingSpecification."Lot No." := SalesLine."B Lot No.";

            TempTrackingSpecification.Insert;
            ItemTrackingLines.SetBlockCommit(true);
            ItemTrackingLines.RegisterItemTrackingLines(SourceTrackingSpecification, SalesLine."Shipment Date", TempTrackingSpecification);


            with TempTrackingSpecification do begin
                Reset;
                SetCurrentKey("Lot No.", "Serial No.");

                repeat
                    SetRange("Lot No.", TempTrackingSpecification."Lot No.");
                    SetRange("Serial No.", TempTrackingSpecification."Serial No.");
                    "New Lot No." := TempTrackingSpecification."New Lot No.";
                    Modify;
                until TempTrackingSpecification.Next = 0;
            end;


            SalesLine.Modify;
        end else begin
            DeleteItemTrackingLinesOrder(SalesLine);
            SalesLine.Validate("Bin Code", '');
        end;
    end;

    procedure UpdateWhseTrackingSummaryItmJn(var TempReservEntry: Record "Reservation Entry" temporary; var TempEntrySummary: Record "Entry Summary" temporary; var ItemJournalLine: Record "Item Journal Line"; onlyLotNo: Code[20])
    var
        ItemLedgEntry: Record "Item Ledger Entry";
        WarehouseEntry: Record "Warehouse Entry";
        Item: Record Item;
        LotNoInfo: Record "Lot No. Information";
        LastEntryNo: Integer;
        ReservEntry: Record "Reservation Entry";
        onlyItemNo: Code[20];
    begin
        Clear(onlyItemNo);
        Clear(TempEntrySummary);
        TempEntrySummary.DeleteAll;
        Clear(TempReservEntry);
        TempReservEntry.DeleteAll;

        if ItemJournalLine."Item No." = '' then
            exit;
        Item.Get(ItemJournalLine."Item No.");

        ReservEntry.Reset;
        if not ReservEntry.SetCurrentKey("Item No.", "Variant Code", "Location Code",
          "Source Type", "Source Subtype", "Reservation Status", "Expected Receipt Date") then
            ReservEntry.SetCurrentKey("Item No.", "Source Type", "Source Subtype", "Reservation Status", "Location Code", "Variant Code"
             , "Shipment Date", "Expected Receipt Date", "Serial No.", "Lot No.");
        ReservEntry.SetRange("Reservation Status",
          ReservEntry."Reservation Status"::Reservation, ReservEntry."Reservation Status"::Surplus);

        if (onlyItemNo = '') then

            ReservEntry.SetFilter("Item No.", Item."No.")
        else
            ReservEntry.SetRange("Item No.", onlyItemNo);
        ReservEntry.SetRange("Location Code", ItemJournalLine."Location Code");
        if onlyLotNo = '' then
            ReservEntry.SetFilter("Lot No.", '<>%1', '')
        else
            ReservEntry.SetRange("Lot No.", onlyLotNo);

        ReservEntry.SetFilter("Source Type", '..31|33..38|40..');

        WarehouseEntry.Reset;

        if not WarehouseEntry.SetCurrentKey("Item No.", "Variant Code", "Location Code", "Lot No.", "Bin Code") then
            WarehouseEntry.SetCurrentKey("Item No.", "Bin Code", "Location Code", "Variant Code");


        WarehouseEntry.SetFilter("Item No.", Item."No.");

        if onlyLotNo = '' then
            WarehouseEntry.SetFilter("Lot No.", '<>%1', '')
        else
            WarehouseEntry.SetRange("Lot No.", onlyLotNo);


        WarehouseEntry.SetRange("Location Code", ItemJournalLine."Location Code");

        if WarehouseEntry.FindSet then
            repeat
                WarehouseEntry.SetRange("Lot No.", WarehouseEntry."Lot No.");
                WarehouseEntry.SetRange("Bin Code", WarehouseEntry."Bin Code");
                WarehouseEntry.CalcSums("Qty. (Base)", Quantity);
                if WarehouseEntry."Qty. (Base)" > 0 then begin
                    TempReservEntry.Init;
                    TempReservEntry."Entry No." := -WarehouseEntry."Entry No.";
                    TempReservEntry."Reservation Status" := ReservEntry."Reservation Status"::Surplus;
                    TempReservEntry."Item No." := WarehouseEntry."Item No.";
                    TempReservEntry."Lot No." := WarehouseEntry."Lot No.";
                    TempReservEntry."Location Code" := WarehouseEntry."Location Code";

                    TempReservEntry."Quantity (Base)" := WarehouseEntry."Qty. (Base)";

                    TempReservEntry."Source Type" := DATABASE::"Warehouse Entry";
                    TempReservEntry."Source Ref. No." := WarehouseEntry."Entry No.";
                    TempReservEntry."Serial No." := WarehouseEntry."Serial No.";
                    TempReservEntry."New Lot No." := WarehouseEntry."Lot No.";
                    TempReservEntry.Positive := true;
                    if TempReservEntry.Positive then begin
                        TempReservEntry."Warranty Date" := WarehouseEntry."Warranty Date";
                        TempReservEntry."Expiration Date" := WarehouseEntry."Expiration Date";
                        TempReservEntry."Expected Receipt Date" := 0D
                    end else
                        TempReservEntry."Shipment Date" := DMY2Date(31, 12, 9999);

                    ItemLedgEntry.Reset;
                    ItemLedgEntry.SetCurrentKey("Item No.", "Variant Code", Open);
                    ItemLedgEntry.SetRange("Item No.", WarehouseEntry."Item No.");
                    ItemLedgEntry.SetRange(Open, true);
                    ItemLedgEntry.SetFilter("Remaining Quantity", '>0');
                    ItemLedgEntry.SetRange("Lot No.", WarehouseEntry."Lot No.");
                    if not ItemLedgEntry.Find('-') then
                        ItemLedgEntry.Init;


                    TempReservEntry."Qty. per Unit of Measure" := ItemLedgEntry."Qty. per Unit of Measure";
                    if WarehouseEntry.Quantity <> 0 then
                        TempReservEntry.Quantity := CalcUofMQty(WarehouseEntry.Quantity, ItemLedgEntry."Qty. per Unit of Measure");
                    TempReservEntry.Insert;
                end;
                WarehouseEntry.FindLast;
                WarehouseEntry.SetRange("Bin Code");
                if onlyLotNo = '' then
                    WarehouseEntry.SetFilter("Lot No.", '<>%1', '')
                else
                    WarehouseEntry.SetRange("Lot No.", onlyLotNo);
            until WarehouseEntry.Next = 0;

        if ReservEntry.FindSet then repeat
                                        TempReservEntry := ReservEntry;
                                        TempReservEntry.Insert;
            until ReservEntry.Next = 0;

        if TempReservEntry.FindSet then
            repeat
                TempEntrySummary.SetRange("B Item No.", TempReservEntry."Item No.");
                TempEntrySummary.SetRange("Lot No.", TempReservEntry."Lot No.");

                TempEntrySummary.SetRange("B Unit of Measure Code", GetUnitOfMeasure(TempReservEntry));

                TempEntrySummary.SetRange("B Bin Code", GetBin(TempReservEntry));
                if not TempEntrySummary.Find('-') then begin
                    TempEntrySummary.Init;
                    TempEntrySummary."Entry No." := LastEntryNo + 1;
                    LastEntryNo := TempEntrySummary."Entry No.";
                    TempEntrySummary."Table ID" := TempReservEntry."Source Type";
                    TempEntrySummary."Summary Type" := '';

                    TempEntrySummary."Lot No." := TempReservEntry."Lot No.";
                    TempEntrySummary."B Item No." := TempReservEntry."Item No.";
                    TempEntrySummary."B Location Code" := TempReservEntry."Location Code";

                    TempEntrySummary."B Bin Code" := GetBin(TempReservEntry);

                    TempEntrySummary."B Unit of Measure Code" := GetUnitOfMeasure(TempReservEntry);
                    TempEntrySummary."B Qty. per Unit of Measure" := TempReservEntry."Qty. per Unit of Measure";

                    if not LotNoInfo.Get(TempEntrySummary."B Item No.", '', TempEntrySummary."Lot No.") then
                        LotNoInfo.Init;
                    TempEntrySummary."B Treatment Code" := LotNoInfo."B Treatment Code";
                    TempEntrySummary."B Tsw. in gr." := LotNoInfo."B Tsw. in gr.";
                    TempEntrySummary."B Line type" := LotNoInfo."B Line type";
                    TempEntrySummary."B Germination" := LotNoInfo."B Germination";
                    TempEntrySummary."B Abnormals" := LotNoInfo."B Abnormals";

                    TempEntrySummary."B Grade Code" := LotNoInfo."B Grade Code";
                    TempEntrySummary."B Remark" := LotNoInfo."B Remark";
                    TempEntrySummary."B Best used by" := LotNoInfo."B Best used by";

                    TempEntrySummary."B Blocked" := LotNoInfo.Blocked;
                    TempEntrySummary.Insert;
                end;

                // Base
                if TempReservEntry.Positive then begin
                    TempEntrySummary."Warranty Date" := TempReservEntry."Warranty Date";
                    TempEntrySummary."Expiration Date" := TempReservEntry."Expiration Date";
                    if TempReservEntry."Entry No." < 0 then
                        TempEntrySummary."Total Quantity" += TempReservEntry."Quantity (Base)";
                    if TempReservEntry."Reservation Status" = TempReservEntry."Reservation Status"::Reservation then
                        TempEntrySummary."Total Reserved Quantity" += TempReservEntry."Quantity (Base)";
                end else begin
                    TempEntrySummary."Total Requested Quantity" -= TempReservEntry."Quantity (Base)";
                end;
                TempEntrySummary."Total Available Quantity" :=
                  TempEntrySummary."Total Quantity" -
                  TempEntrySummary."Total Requested Quantity" +
                  TempEntrySummary."Current Reserved Quantity";

                // UoM
                if TempReservEntry.Positive then begin
                    if TempReservEntry."Entry No." < 0 then
                        TempEntrySummary."B Total Quantity (UofM)" += TempReservEntry.Quantity;
                    if TempReservEntry."Reservation Status" = TempReservEntry."Reservation Status"::Reservation then
                        TempEntrySummary."B Tot Reserved Quantity (UofM)" += TempReservEntry.Quantity;
                end else begin
                    TempEntrySummary."B Tot Requested Quantity(UofM)" -= TempReservEntry.Quantity;
                end;
                TempEntrySummary."B Tot Available Quantity(UofM)" :=
                  TempEntrySummary."B Total Quantity (UofM)" -
                  TempEntrySummary."B Tot Requested Quantity(UofM)";


                TempEntrySummary.Modify;
            until TempReservEntry.Next = 0;

        TempEntrySummary.Reset;
    end;

    procedure UpdateReservEntryItmJn(var ItemJournalLine: Record "Item Journal Line"; var QuantatyAvailable: Decimal)
    var
        TempTrackingSpecification: Record "Tracking Specification" temporary;
        SourceTrackingSpecification: Record "Tracking Specification";
        resEntry: Record "Reservation Entry";
        totalAvailQuantofLotNo: Decimal;
        ReservEngineMgt: Codeunit "Reservation Engine Mgt.";
        ReserveItemJnlLine: Codeunit "Item Jnl. Line-Reserve";
        ItemTrackingLines: Page "Item Tracking Lines";
    begin

        ItemJournalLine.TestField(Quantity);

        ReservEngineMgt.InitFilterAndSortingFor(resEntry, false);
        ReserveItemJnlLine.FilterReservFor(resEntry, ItemJournalLine);


        if ItemJournalLine."Lot No." <> '' then begin
            totalAvailQuantofLotNo := QuantatyAvailable;

            if ItemJournalLine."Entry Type" <> ItemJournalLine."Entry Type"::"Positive Adjmt." then
                if not ItemJournalLine."B Scanning" then
                    if totalAvailQuantofLotNo < ItemJournalLine.Quantity then
                        Error(Text50028);

            if not resEntry.FindFirst then begin

                SourceTrackingSpecification.InitFromItemJnlLine(ItemJournalLine);

                SourceTrackingSpecification."Entry No." += 1;
                TempTrackingSpecification := SourceTrackingSpecification;

                TempTrackingSpecification."Lot No." := ItemJournalLine."Lot No.";

                TempTrackingSpecification."New Lot No." := ItemJournalLine."Lot No.";
                TempTrackingSpecification.Insert;

                ItemTrackingLines.SetBlockCommit(true);
                ItemTrackingLines.RegisterItemTrackingLines(SourceTrackingSpecification,
                                                            ItemJournalLine."Posting Date", TempTrackingSpecification);


                with TempTrackingSpecification do begin
                    Reset;
                    SetCurrentKey("Lot No.", "Serial No.");

                    repeat
                        SetRange("Lot No.", TempTrackingSpecification."Lot No.");
                        SetRange("Serial No.", TempTrackingSpecification."Serial No.");
                        "New Lot No." := TempTrackingSpecification."New Lot No.";
                        Modify;
                    until TempTrackingSpecification.Next = 0;
                end;


            end;

            ItemJournalLine.Modify;
        end else begin
            DeleteItemTrackingLinesJnl(ItemJournalLine);
        end;
    end;

    procedure LotNoLookupItmJn(var Rec: Record "Item Journal Line")
    var
        tempReservEntry: Record "Reservation Entry" temporary;
        tempEntrySummary: Record "Entry Summary" temporary;
        itemTrackingSummaryForm: Page "Item Tracking Summary";
    begin

        UpdateWhseTrackingSummaryItmJn(tempReservEntry, tempEntrySummary, Rec, '');
        itemTrackingSummaryForm.SetSources(tempReservEntry, tempEntrySummary);
        itemTrackingSummaryForm.LookupMode(true);
        if tempEntrySummary.FindFirst then
            itemTrackingSummaryForm.SetRecord(tempEntrySummary);
        tempEntrySummary.Reset;
        if itemTrackingSummaryForm.RunModal = ACTION::LookupOK then begin
            itemTrackingSummaryForm.GetRecord(tempEntrySummary);
            CheckUnitofMeasureCodeItmJn(tempEntrySummary."B Unit of Measure Code", Rec);

            tempEntrySummary.TestField("B Item No.");
            gAvailQty := tempEntrySummary."B Tot Available Quantity(UofM)";
            Rec.TestField(Quantity);

            if gAvailQty > 0 then
                Rec.Validate("Bin Code", tempEntrySummary."B Bin Code") else
                Rec.Validate("Lot No.", '');

            Rec."B LookUpLotNoAvailQty" := gAvailQty;

            Rec.Validate("Lot No.", tempEntrySummary."Lot No.");

        end;
    end;

    local procedure CalcUofMQtyItmJn(Qty: Decimal; QtyperUofM: Decimal): Decimal
    begin

        if QtyperUofM = 0 then
            Error(Text50027);
        exit(Round(Qty / QtyperUofM, 0.00001));
    end;

    procedure CheckUnitofMeasureCodeItmJn(UofM: Code[10]; var ItemJournalLine: Record "Item Journal Line")
    begin

        ItemJournalLine.TestField("Unit of Measure Code");
        if UofM <> ItemJournalLine."Unit of Measure Code" then
            Error(Text50024);
    end;

    procedure DeleteItemTrackingLinesOrder(SalesLine: Record "Sales Line")
    var
        ReservEntry: Record "Reservation Entry";
        SourceTrackingSpecification: Record "Tracking Specification";
    begin

        Clear(ReservEntry);
        ReservEntry.SetRange("Source Type", DATABASE::"Sales Line");
        ReservEntry.SetRange("Source Subtype", SalesLine."Document Type");
        ReservEntry.SetRange("Source ID", SalesLine."Document No.");
        ReservEntry.SetRange("Source Batch Name", '');
        ReservEntry.SetRange("Source Prod. Order Line", 0);
        ReservEntry.SetRange("Source Ref. No.", SalesLine."Line No.");
        ReservEntry.DeleteAll(true);

    end;

    procedure DeleteItemTrackingLinesJnl(ItemJnlLine: Record "Item Journal Line")
    var
        ReservEntry: Record "Reservation Entry";
        SourceTrackingSpecification: Record "Tracking Specification";
    begin

        Clear(ReservEntry);
        ReservEntry.SetRange("Source Type", DATABASE::"Item Journal Line");
        ReservEntry.SetRange("Source Subtype", ItemJnlLine."Entry Type");
        ReservEntry.SetRange("Source ID", ItemJnlLine."Journal Template Name");
        ReservEntry.SetRange("Source Batch Name", ItemJnlLine."Journal Batch Name");
        ReservEntry.SetRange("Source Ref. No.", ItemJnlLine."Line No.");
        ReservEntry.DeleteAll(true);

    end;

    procedure DeleteItemTrackingLines(var SourceTrackingSpecification: Record "Tracking Specification"; var ReservEntry: Record "Reservation Entry")
    var
        TempTrackingSpecification: Record "Tracking Specification" temporary;
    begin

        SourceTrackingSpecification.TestField("Source Type");
        if gcuItemTrackingMgt.SumUpItemTracking(ReservEntry, TempTrackingSpecification, false, true) then begin
            TempTrackingSpecification.FindFirst;
            repeat
                TempTrackingSpecification."Quantity (Base)" := -Abs(TempTrackingSpecification."Quantity (Base)");
                TempTrackingSpecification.Modify;
            until TempTrackingSpecification.Next = 0;
        end;

    end;

    procedure GetUnitOfMeasure(aReservationEntry: Record "Reservation Entry") UnitOfMeasure: Code[10]
    var
        lItemLedgerEntry: Record "Item Ledger Entry";
    begin


        lItemLedgerEntry.SetCurrentKey("Item No.", "Lot No.");
        lItemLedgerEntry.SetRange("Item No.", aReservationEntry."Item No.");
        lItemLedgerEntry.SetRange("Lot No.", aReservationEntry."Lot No.");
        lItemLedgerEntry.SetFilter(Positive, '1');

        lItemLedgerEntry.FindLast;  

        UnitOfMeasure := lItemLedgerEntry."Unit of Measure Code";
    end;

    procedure GetBin(aReservEntry: Record "Reservation Entry") BinCode: Code[20]
    var
        lSalesLine: Record "Sales Line";
        lWarehouseEntry: Record "Warehouse Entry";
        lrecTransferLine: Record "Transfer Line";
    begin


        case aReservEntry."Source Type" of
            37:
                begin
                    lSalesLine.Get(aReservEntry."Source Subtype", aReservEntry."Source ID", aReservEntry."Source Ref. No.");
                    BinCode := lSalesLine."Bin Code";
                end;
            7312:
                begin
                    lWarehouseEntry.Get(aReservEntry."Source Ref. No.");
                    BinCode := lWarehouseEntry."Bin Code";
                end;

            5741:
                begin
                    lrecTransferLine.Get(aReservEntry."Source ID", aReservEntry."Source Ref. No.");
                    if aReservEntry.Positive
                            then BinCode := lrecTransferLine."Transfer-To Bin Code"
                    else BinCode := lrecTransferLine."Transfer-from Bin Code";
                end;

            else
                Error(Text50029, aReservEntry."Source Type")
        end;
    end;

    procedure UpdateBejoFields(var aSalesLine: Record "Sales Line")
    var
        lReservationEntry: Record "Reservation Entry";
        LotNoInformation: Record "Lot No. Information";
        lUnitOfMeasure: Record "Unit of Measure";
    begin
        if not (aSalesLine.Type = aSalesLine.Type::Item) then
            exit;

        aSalesLine."B Reserved weight" := 0;

        aSalesLine.CalcFields("B Tracking Quantity");
        if aSalesLine."B Tracking Quantity" <> 0 then begin
            lReservationEntry.Reset;
            if not lReservationEntry.SetCurrentKey("Source ID") then
                lReservationEntry.SetCurrentKey("Source Type", "Source Subtype", "Source ID");
            lReservationEntry.SetRange("Source Type", 37);
            lReservationEntry.SetRange("Source ID", aSalesLine."Document No.");
            lReservationEntry.SetRange("Source Ref. No.", aSalesLine."Line No.");
            if lReservationEntry.FindFirst then begin
                aSalesLine."B Lot No." := lReservationEntry."Lot No.";
                LotNoInformation.Reset;
                LotNoInformation.SetCurrentKey("Lot No.");
                LotNoInformation.SetRange("Lot No.", lReservationEntry."Lot No.");
                if LotNoInformation.FindFirst then begin
                    lUnitOfMeasure.Get(aSalesLine."Unit of Measure Code");
                    if lUnitOfMeasure."B Unit in Weight" then
                        aSalesLine."Net Weight" := aSalesLine."Qty. per Unit of Measure" else
                        aSalesLine."Net Weight" := (LotNoInformation."B Tsw. in gr." / 1000000) * aSalesLine."Qty. per Unit of Measure";

                    aSalesLine."B Reserved weight" := aSalesLine."Net Weight" *               // Reserved Weight = in KG for all packages
                                                    aSalesLine."B Tracking Quantity";
                end;
            end;
        end;
    end;

    procedure ItemNoExtention(lrecItem: Record Item): Code[8]
    var
        lcuBejoManagement: Codeunit "Bejo Management";
        lAlternativeItemNo: Code[20];
    begin


        if lrecItem."No." = '' then
            exit('');

        if StrLen(lrecItem."No.") <> 8 then
            exit('');

        if not (lcuBejoManagement.GetAlternativeItemNo(lrecItem."No.", lAlternativeItemNo)) then
            exit('');

        exit(lAlternativeItemNo);


    end;

    procedure ItemFilterIncludingExtention(lrecItem: Record Item): Text[100]
    begin


        if lrecItem."No." = '' then
            exit('');

        if ItemNoExtention(lrecItem) = '' then
            exit(lrecItem."No.");

        exit(lrecItem."No." + '|' + ItemNoExtention(lrecItem));


    end;

    procedure UpdateItemNo(itemNo: Code[20]; var paramrecSalesLine: Record "Sales Line")
    var
        lLocationOLD: Code[20];
    begin


        paramrecSalesLine.TestField(Type, paramrecSalesLine.Type::Item);
        if itemNo = paramrecSalesLine."No." then
            exit;
        lLocationOLD := paramrecSalesLine."Location Code";


        paramrecSalesLine."No." := itemNo;
        paramrecSalesLine."Location Code" := lLocationOLD;

    end;

    local procedure AddGLAccountSalesLine(var SalesHeader: Record "Sales Header"; GLAccountNo: Code[20])
    var
        lrecGLAccount: Record "G/L Account";
        lrecSalesLine: Record "Sales Line";
    begin


        SalesHeader.TestField(Status, SalesHeader.Status::Open);
        lrecGLAccount.Get(GLAccountNo);

        with lrecSalesLine do begin
            Init;
            SetRange("Document Type", SalesHeader."Document Type");
            SetRange("Document No.", SalesHeader."No.");
            if FindLast then
                "Line No." := "Line No." + 10000
            else
                "Line No." := 10000;

            "Document Type" := SalesHeader."Document Type";
            "Document No." := SalesHeader."No.";
            Init;

            Validate("Sell-to Customer No.", SalesHeader."Sell-to Customer No.");
            Validate(Type, Type::"G/L Account");
            Validate("No.", lrecGLAccount."No.");
            Validate(Quantity, 1);
            Insert(true);
        end;
    end;

    procedure AddSpecialCharges(var SalesHeader: Record "Sales Header")
    var
        lrecBejoSetup: Record "Bejo Setup";
    begin


        lrecBejoSetup.Get;
        lrecBejoSetup.TestField("G/L Shipping Charges 2");
        AddGLAccountSalesLine(SalesHeader, lrecBejoSetup."G/L Shipping Charges 2");
    end;
}

