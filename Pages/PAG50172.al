page 50172 "Scan Transit From"
{

    Caption = 'Scan Transit From';
    DeleteAllowed = false;
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            field(ActionTxt; ActionTxt)
            {
                Editable = false;
                ApplicationArea = All;
            }
            field(ScanField; ScanField)
            {
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    case ScanMode of

                        ScanMode::Lot:
                            LotNoValidation();

                        ScanMode::Bin:
                            BinNoValidation();

                    end;

                    CurrPage.Update(false);
                end;
            }
            field(Descriptions; Descriptions)
            {
                Editable = false;
                MultiLine = true;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        CurrPage.Activate;

        ScanMode := ScanMode::Lot;
        ActionTxt := ctxtScanLot;

        BejoSetup.Get();
    end;

    var
        ScanField: Code[20];
        LotNoInf: Record "Lot No. Information";
        Bin: Record Bin;
        BinContent: Record "Bin Content";
        Bins: Text;
        TmpBin: Record Bin temporary;
        TmpBinLoc: Record Bin temporary;
        TmpWhseBin: Record Bin temporary;
        InfoMessage: Text;
        ItemJournalLine: Record "Item Journal Line";
        ItemJournalBatch: Record "Item Journal Batch";
        ItemJournalTemplate: Record "Item Journal Template";
        ItemJournalLineDelete: Record "Item Journal Line";
        LineNo: Integer;
        Descriptions: Text;
        ctxtScanLot: Label 'Scan Lot No.';
        ScanMode: Option Lot,Bin;
        ctxtScanBin: Label 'Scan Bin Code';
        BinCode: Code[20];
        ActionTxt: Text;
        Location: Record Location;
        ctxtItemAvail: Label 'The Lot cannot be transfered due to Reservations.', Comment = '%1=Item No.';
        ScanPage: Page "Scan Page";
        BejoSetup: Record "Bejo Setup";
        TmpLotNoInf: Record "Lot No. Information" temporary;
        ctxtLotsScanned: Label 'Lot(s) %1 in %2 (is)(are) placed in transit.';
        LotNos: Text;
        TmpReservationEntry: Record "Reservation Entry" temporary;
        ReservationEntry: Record "Reservation Entry";

    local procedure LotNoValidation()
    var
        ctxtUnknownLot: Label 'Lot %1 not found';
        ctxtNoBinForLot: Label 'No Bin found for Lot %1.';
        ctxtLot: Label 'Lot: %1';
        BEJOSetup: Record "Bejo Setup";
        ILEUnitOfMeasureCode: Code[10];
        ILEUnitQtyPerOfMeasure: Decimal;
        WarehouseEntry: Record "Warehouse Entry";
        LocationCode: Code[20];
    begin
        BEJOSetup.Get();
        if ScanField <> '' then begin

            TmpBin.DeleteAll;
            TmpBin.Reset;

            LotNoInf.Reset;

            LotNoInf.SetFilter("Lot No.", StrSubstNo('%1%2', ScanField, '*'));
            if LotNoInf.IsEmpty then begin


                Clear(LotNoInf);
                InfoMessage := StrSubstNo(ctxtUnknownLot, ScanField);
                ScanField := '';
                Bins := '';
                ScanMode := ScanMode::Lot;
                ActionTxt := ctxtScanLot;

            end else begin


                TmpLotNoInf.DeleteAll;
                if LotNoInf.FindSet then repeat


                                             TmpBinLoc.DeleteAll;
                                             TmpBinLoc.Reset;
                                             TmpWhseBin.DeleteAll;
                                             TmpWhseBin.Reset;


                                             TmpLotNoInf := LotNoInf;
                                             if TmpLotNoInf.Insert then;


                                             Bins := '';

                                             WarehouseEntry.Reset;
                                             WarehouseEntry.SetCurrentKey("Lot No.");
                                             WarehouseEntry.SetRange("Lot No.", LotNoInf."Lot No.");
                                             if WarehouseEntry.FindSet then repeat

                                                                                if not TmpWhseBin.Get(WarehouseEntry."Location Code", WarehouseEntry."Bin Code") then begin

                                                                                    TmpWhseBin.Init;
                                                                                    TmpWhseBin."Location Code" := WarehouseEntry."Location Code";
                                                                                    TmpWhseBin.Code := WarehouseEntry."Bin Code";
                                                                                    if TmpWhseBin.Insert then;

                                                                                    BinContent.SetRange("Location Code", WarehouseEntry."Location Code");
                                                                                    BinContent.SetRange("Bin Code", WarehouseEntry."Bin Code");
                                                                                    BinContent.SetRange("Item No.", LotNoInf."Item No.");
                                                                                    if BinContent.FindFirst then begin
                                                                                        BinContent.SetFilter("Lot No. Filter", WarehouseEntry."Lot No.");
                                                                                        BinContent.CalcFields(Quantity);
                                                                                        if BinContent.Quantity > 0 then begin

                                                                                            TmpBinLoc.Init;
                                                                                            TmpBinLoc."Location Code" := BinContent."Location Code";
                                                                                            TmpBinLoc.Code := BinContent."Bin Code";
                                                                                            if TmpBinLoc.Insert then;

                                                                                            TmpBin.Init;
                                                                                            TmpBin."Location Code" := '';
                                                                                            TmpBin.Code := BinContent."Bin Code";
                                                                                            if TmpBin.Insert then;

                                                                                        end;
                                                                                    end;

                                                                                end;

                                                 until WarehouseEntry.Next = 0;

                                             LocationCode := '';
                                             TmpBinLoc.SetCurrentKey("Location Code", Code);
                                             if TmpBinLoc.FindSet then repeat

                                                                           if LocationCode <> TmpBinLoc."Location Code" then begin
                                                                               if Bins = '' then
                                                                                   Bins := TmpBinLoc."Location Code" + '-' + TmpBinLoc.Code
                                                                               else
                                                                                   Bins += ', ' + TmpBinLoc."Location Code" + '-' + TmpBinLoc.Code;
                                                                           end else begin
                                                                               if Bins = '' then
                                                                                   Bins := TmpBinLoc.Code
                                                                               else
                                                                                   Bins += ', ' + TmpBinLoc.Code;
                                                                           end;
                                                                           LocationCode := TmpBinLoc."Location Code";

                                                 until TmpBinLoc.Next = 0;

                                             GetUOM(LotNoInf, ILEUnitOfMeasureCode, ILEUnitQtyPerOfMeasure);
                                             LotNoInf.CalcFields(Inventory);

                                             if Descriptions = '' then
                                                 Descriptions := StrSubstNo('%1 (%2)', LotNoInf."Lot No.", ILEUnitOfMeasureCode)
                                             else
                                                 Descriptions := StrSubstNo('%1\%2 (%3)', Descriptions, LotNoInf."Lot No.", ILEUnitOfMeasureCode);

                                             if Bins <> '' then begin
                                                 if ILEUnitQtyPerOfMeasure <> 0 then
                                                     Descriptions := StrSubstNo('%1\%2 (%3)', Descriptions, Bins, LotNoInf.Inventory / ILEUnitQtyPerOfMeasure)
                                                 else
                                                     Descriptions := StrSubstNo('%1\%2', Descriptions, Bins);
                                             end;

                    until LotNoInf.Next = 0;

                if TmpBin.Count = 1 then begin

                    TmpBin.FindFirst;
                    Bin.SetRange(Code, TmpBin.Code);
                    Bin.FindFirst;

                    BinCode := Bin.Code;
                    CreateReclassJournalLines();

                end else begin
                    if TmpBin.Count <> 0 then begin
                        ScanMode := ScanMode::Bin;
                        ActionTxt := ctxtScanBin;
                    end else begin
                        InfoMessage := StrSubstNo(ctxtNoBinForLot, LotNoInf."Lot No.");
                    end;
                end;

            end;

        end else begin
            Clear(LotNoInf);
            InfoMessage := '';
            ScanField := '';
            Bins := '';
            Descriptions := '';
            BinCode := '';
            ScanMode := ScanMode::Lot;
            ActionTxt := ctxtScanLot;
        end;

        if InfoMessage <> '' then begin
            Descriptions := InfoMessage;
            InfoMessage := '';
        end;

        ScanField := '';
    end;

    local procedure BinNoValidation()
    var
        ctxtUnknownBin: Label 'Bin %1 not found';
        ctxtUnknownBinLot: Label 'Lot is not on Bin %1';
    begin
        if ScanField <> '' then begin

            Bin.Reset;
            Bin.SetRange(Code, ScanField);
            if not Bin.FindFirst then begin
                Clear(Bin);
                InfoMessage := StrSubstNo(ctxtUnknownBin, ScanField);
                Descriptions := InfoMessage;
                InfoMessage := '';
                ScanField := '';
                BinCode := '';
            end else begin
                TmpBin.SetRange(Code, ScanField);
                if TmpBin.FindFirst then begin
                    BinCode := TmpBin.Code;
                    CreateReclassJournalLines();
                    Descriptions := InfoMessage;
                    InfoMessage := '';
                end else begin
                    InfoMessage := StrSubstNo(ctxtUnknownBinLot, ScanField);
                    Descriptions := InfoMessage;
                    InfoMessage := '';
                end;
            end;
        end;
    end;

    local procedure CreateReclassJournalLines()
    var
        BinContent: Record "Bin Content";
        ShortUserId: Code[50];
        ItemJnlPostBatch: Codeunit "Item Jnl.-Post Batch";
    begin
        BinContent.Reset;
        BinContent.SetRange("Bin Code", BinCode);
        BinContent.SetRange("Item No.", LotNoInf."Item No.");
        if BinContent.FindSet then begin

            ItemJournalTemplate.SetRange(Type, ItemJournalTemplate.Type::Transfer);
            ItemJournalTemplate.FindFirst;

            ShortUserId := CopyStr(UpperCase(UserId), 1, MaxStrLen(ItemJournalBatch.Name));
            if not ItemJournalBatch.Get(ItemJournalTemplate.Name, ShortUserId) then begin
                ItemJournalBatch."Journal Template Name" := ItemJournalTemplate.Name;
                ItemJournalBatch.Name := ShortUserId;
                ItemJournalBatch.Insert;
            end;

            ItemJournalLineDelete.SetRange("Journal Template Name", ItemJournalTemplate.Name);
            ItemJournalLineDelete.SetRange("Journal Batch Name", ItemJournalBatch.Name);
            if ItemJournalLineDelete.FindSet then repeat
                                                      ItemJournalLineDelete.Delete(true);
                until ItemJournalLineDelete.Next = 0;

            LineNo := 0;

            LotNos := '';
            repeat

                if TmpLotNoInf.FindSet then repeat

                                                BinContent.SetFilter("Lot No. Filter", TmpLotNoInf."Lot No.");
                                                BinContent.CalcFields(Quantity);
                                                if BinContent.Quantity <> 0 then begin


                                                    if LotNos = '' then
                                                        LotNos := TmpLotNoInf."Lot No."
                                                    else
                                                        LotNos := StrSubstNo('%1,%2', LotNos, TmpLotNoInf."Lot No.");


                                                    InsertJournalLine(TmpLotNoInf, BinContent, BinContent.Quantity);

                                                    if GetLastErrorText <> '' then begin
                                                        InfoMessage := GetLastErrorText;
                                                        CurrPage.Update(false);
                                                    end;

                                                end;

                    until TmpLotNoInf.Next = 0;

            until BinContent.Next = 0;

        end;


        ReservationEntry.SetRange("Item No.", LotNoInf."Item No.");
        ReservationEntry.SetRange("Source Type", 32);
        ReservationEntry.SetRange("Source Subtype", 0);
        ReservationEntry.SetRange("Reservation Status", ReservationEntry."Reservation Status"::Reservation);
        ReservationEntry.SetRange("Lot No.", LotNoInf."Lot No.");
        if ReservationEntry.FindSet then repeat
                                             TmpReservationEntry.Init;
                                             TmpReservationEntry := ReservationEntry;
                                             TmpReservationEntry.Insert;
            until ReservationEntry.Next = 0;
        ReservationEntry.DeleteAll;


        Commit;

        ClearLastError();

        if ItemJnlPostBatch.Run(ItemJournalLine) then;


        TmpReservationEntry.SetRange("Item No.", LotNoInf."Item No.");
        TmpReservationEntry.SetRange("Source Type", 32);
        TmpReservationEntry.SetRange("Source Subtype", 0);
        TmpReservationEntry.SetRange("Reservation Status", TmpReservationEntry."Reservation Status"::Reservation);
        TmpReservationEntry.SetRange("Lot No.", LotNoInf."Lot No.");
        if TmpReservationEntry.FindSet then repeat
                                                ReservationEntry.Init;
                                                ReservationEntry := TmpReservationEntry;
                                                ReservationEntry.Insert;
            until TmpReservationEntry.Next = 0;
        TmpReservationEntry.DeleteAll;


        if GetLastErrorText <> '' then
            InfoMessage := GetLastErrorText
        else
            InfoMessage := StrSubstNo(ctxtLotsScanned, LotNos, BinCode);

        ScanPage.UpdateSalesLines(LotNoInf."Lot No.", BejoSetup."Transit Bin");

        ScanMode := ScanMode::Lot;
        ActionTxt := ctxtScanLot;
        ScanField := '';
    end;

    procedure InsertJournalLine(TheLotNoInf: Record "Lot No. Information"; TheBinContent: Record "Bin Content"; TheQuantity: Decimal)
    var
        ILEUnitOfMeasureCode: Code[10];
        ILEUnitQtyPerOfMeasure: Decimal;
        ItemCheckAvail: Codeunit "Item-Check Avail.";
    begin
        with ItemJournalLine do begin

            Location.Get(TheBinContent."Location Code");

            Init;
            "Journal Template Name" := ItemJournalBatch."Journal Template Name";
            "Journal Batch Name" := ItemJournalBatch.Name;
            LineNo += 10000;
            ItemJournalLine."Line No." := LineNo;
            Insert(true);
            "Posting Date" := WorkDate;
            "Document Date" := WorkDate;
            "Document No." := 'TRANSIT';
            "Entry Type" := "Entry Type"::Transfer;
            "Source Code" := ItemJournalTemplate."Source Code";
            "Reason Code" := ItemJournalBatch."Reason Code";
            "Posting No. Series" := ItemJournalBatch."Posting No. Series";
            Validate("Item No.", TheBinContent."Item No.");
            Validate("Location Code", TheBinContent."Location Code");
            Validate("Bin Code", TheBinContent."Bin Code");
            Validate("Variant Code", TheBinContent."Variant Code");
            if GetUOM(TheLotNoInf, ILEUnitOfMeasureCode, ILEUnitQtyPerOfMeasure) then begin
                if ILEUnitQtyPerOfMeasure <> 0 then
                    Validate(Quantity, TheQuantity / ILEUnitQtyPerOfMeasure)
                else
                    Validate(Quantity, TheQuantity);
                Validate("Unit of Measure Code", ILEUnitOfMeasureCode);
            end;
            "B Scanning" := true;
            Validate("Lot No.", TheLotNoInf."Lot No.");
            Validate("New Location Code", TheBinContent."Location Code");
            Validate("New Bin Code", BejoSetup."Transit Bin");
            Modify(true);



        end;
    end;

    local procedure GetLocation(LocationCode: Code[10]; var Location: Record Location)
    begin
        if LocationCode = Location.Code then
            exit;

        if LocationCode = '' then
            Location.Init
        else
            Location.Get(LocationCode);
    end;

    local procedure GetUOM(var TheLotNoInf: Record "Lot No. Information"; var ILEUnitOfMeasureCode: Code[10]; var ILEUnitQtyPerOfMeasure: Decimal): Boolean
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
    begin
        ItemLedgerEntry.SetCurrentKey("Item No.", "Variant Code", Open);
        ItemLedgerEntry.SetRange("Item No.", TheLotNoInf."Item No.");
        ItemLedgerEntry.SetRange(Open, true);
        ItemLedgerEntry.SetRange("Lot No.", TheLotNoInf."Lot No.");
        if ItemLedgerEntry.FindFirst then begin
            ILEUnitOfMeasureCode := ItemLedgerEntry."Unit of Measure Code";
            ILEUnitQtyPerOfMeasure := ItemLedgerEntry."Qty. per Unit of Measure";
            exit(true);
        end;

        exit(false);
    end;
}

