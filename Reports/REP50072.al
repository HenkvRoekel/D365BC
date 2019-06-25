report 50072 "Stock List"
{


    DefaultLayout = RDLC;
    RDLCLayout = './RDLC/Stock List.rdlc';

    dataset
    {
        dataitem("Warehouse Entry"; "Warehouse Entry")
        {
            DataItemTableView = SORTING ("Item No.", "Lot No.", "Location Code", "Bin Code");
            RequestFilterFields = "Item No.", "Location Code", "Lot No.", "Bin Code", "Registering Date";
            column("Filter"; "Warehouse Entry".GetFilters)
            {
            }
            column(gShowInvCostPosted; gShowInvCostPosted)
            {
            }
            column(Filter2; Text50014 + ': ' + Format(gBestUsedByStart) + '..' + Format(gBestUsedByEnd))
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            column(USERID; UserId)
            {
            }
            column(ItemNo_WarehouseEntry; "Warehouse Entry"."Item No.")
            {
                IncludeCaption = true;
            }
            column(grecItem_Description; grecItem.Description)
            {
                IncludeCaption = true;
            }
            column(grecItem_Description2; grecItem."Description 2")
            {
                IncludeCaption = true;
            }
            column(grecItemExt_ExtensionCode; grecItemExt."Extension Code")
            {
            }
            column(grecVariety_OrganicCheckmarkText; grecVariety.OrganicCheckmarkText)
            {
            }
            column(grecItem_PromoStatus; PromoStatusExtended)
            {
            }
            column(grecItem_BlockingCode; BlockingCodeExtended)
            {
            }
            column(LocationCode_WarehouseEntry; "Warehouse Entry"."Location Code")
            {
                IncludeCaption = true;
            }
            column(BinCode_WarehouseEntry; "Warehouse Entry"."Bin Code")
            {
                IncludeCaption = true;
            }
            column(LotNo_WarehouseEntry; "Warehouse Entry"."Lot No.")
            {
                IncludeCaption = true;
            }
            column(gQuantity; gQuantity)
            {
            }
            column(grecILE_UnitOfMeasureCode; grecILE."Unit of Measure Code")
            {
            }
            column(QtyBase_WarehouseEntry; "Warehouse Entry"."Qty. (Base)")
            {
                DecimalPlaces = 0 : 2;
            }
            column(gTrackQtyLot; gTrackQtyLot)
            {
                DecimalPlaces = 0 : 2;
            }
            column(grecLotNoInfo_Germination; grecLotNoInfo."B Germination")
            {
            }
            column(grecGrade_Description; grecGrade.Description)
            {
            }
            column(grecLotNoInfo_BestUsedBy; Format(grecLotNoInfo."B Best used by", 0, 0))
            {
            }
            column(gExpired; gExpired)
            {
            }
            column(grecLotNoInfo_Remark; grecLotNoInfo."B Remark")
            {
            }
            column(gDate1; Format(gDate[1], 0, 0))
            {
            }
            column(gDate2; Format(gDate[2], 0, 0))
            {
            }
            column(gDate3; Format(gDate[3], 0, 0))
            {
            }
            column(gText1; gText[1])
            {
            }
            column(gText2; gText[2])
            {
            }
            column(gText3; gText[3])
            {
            }
            column(gStockValueText; gStockValueText)
            {
            }
            column(gTotalPrintTrackQtyLotAux; gTotalPrintTrackQtyLotAux)
            {
            }
            column(gText50022Text; gText50022Text)
            {
            }
            column(gInvCostPostedToGLText; gInvCostPostedToGLText)
            {
            }
            column(gTotTrackQtyLot; gTotTrackQtyLot)
            {
            }
            column(Text50023; Text50023)
            {
            }
            column(gInvCostPostedToGL; gInvCostPostedToGL)
            {
            }
            column(gTotalInvCostPostedToGL; gTotalInvCostPostedToGL)
            {
            }
            column(gGrandTotalInvCostPostedToGL; gGrandTotalInvCostPostedToGL)
            {
            }
            column(Text50018; Text50018)
            {
            }
            column(ItemBlockDescription; gcuBlockingMgt.ItemBlockDescription(grecItem))
            {
            }
            column(PromoStatusDescription; grecItem."B Promo Status Description")
            {
            }
            column(lComment; lComment)
            {
            }
            column(bShowSection; bShowSection)
            {
            }
            column(gShowItemTrackingComment; gShowItemTrackingComment)
            {
            }
            column(gLotDetail; gLotDetail)
            {
            }
            column(gTotItem; gTotItem)
            {
            }
            column(totalInventoryCostPostedToGL; totalInventoryCostPostedToGL)
            {
            }
            column(gPrintStockValue; gPrintStockValue)
            {
            }
            column(grecLotNoInfo_Tswingr; grecLotNoInfo."B Tsw. in gr.")
            {
            }
            column(ILEQtyperUnitofMeasure; grecILE."Qty. per Unit of Measure")
            {
            }

            trigger OnAfterGetRecord()
            var
                lrecValueEntry: Record "Value Entry";
                PromoStatus: Record "Promo Status";
                BlockingMgt: Codeunit "Blocking Management";
                ItemLedgerEntry: Record "Item Ledger Entry";
                VECostPostedtoGL: Decimal;
            begin
                grecLotNoInfo.SetCurrentKey("Lot No.");
                grecLotNoInfo.SetRange("Lot No.", "Lot No.");
                if not grecLotNoInfo.FindFirst then
                    grecLotNoInfo.Init;

                if ((gBestUsedByEnd <> 0D) and (grecLotNoInfo."B Best used by" > gBestUsedByEnd)) or
                   ((gBestUsedByStart <> 0D) and (grecLotNoInfo."B Best used by" < gBestUsedByStart)) then
                    CurrReport.Skip;


                gExpired := '';
                if (grecLotNoInfo."B Best used by" <> 0D) and (grecLotNoInfo."B Best used by" < CalcDate('<+1M>', Today)) then
                    gExpired := '!';

                grecBinContent.Init;
                grecBinContent.SetRange("Item No.", "Item No.");
                grecBinContent.SetRange("Location Code", "Location Code");
                if not grecBinContent.FindFirst then
                    grecBinContent.Init;


                BlockingCodeExtended := '';
                PromoStatusExtended := '';

                if grecItem.Get("Item No.") then begin

                    grecItem.CalcFields(Inventory, "B Promo Status");

                    if PromoStatus.Get(grecItem."B Promo Status") then
                        PromoStatusExtended := StrSubstNo('%1: %2', grecItem."B Promo Status", PromoStatus.Description);
                    BlockingCodeExtended := BlockingMgt.ItemBlockDescription(grecItem);

                end;


                if "Qty. per Unit of Measure" = 0 then
                    "Qty. per Unit of Measure" := 1;

                if not grecGrade.Get(grecLotNoInfo."B Grade Code") then
                    grecGrade.Init;

                if not grecItemExt.Get(grecItem."B Extension", '') then
                    grecItemExt.Init;


                if not grecVariety.Get(grecItem."B Variety") then
                    grecVariety.Init;




                if ("Qty. (Base)" <> 0) then begin
                    grecReservEntry.SetRange("Item No.", "Item No.");
                    grecReservEntry.SetRange("Lot No.", "Lot No.");
                    grecReservEntry.SetRange("Location Code", "Location Code");
                    grecReservEntry.CalcSums(grecReservEntry."Quantity (Base)");
                    gTrackQtyLot := -grecReservEntry."Quantity (Base)";
                    gTotalPrintTrackQtyLot += -grecReservEntry."Quantity (Base)";
                    gAux := gAux - grecReservEntry."Quantity (Base)";

                    grecILE.SetRange("Lot No.", "Lot No.");
                    grecILE.SetRange("Item No.", "Item No.");

                    if gPrtExcelComment then begin
                        grecILE.SetRange("Location Code", "Location Code");

                        if grecILE.FindFirst then
                            repeat
                                if StrLen(lComment + StrSubstNo(Text50027, grecILE."B Comment", grecILE."Remaining Quantity")) < 1024 then //BEJOW110.00.025 113572
                                    if grecILE."B Comment" <> '' then lComment += StrSubstNo(Text50027, grecILE."B Comment", grecILE."Remaining Quantity");
                            until grecILE.Next = 0;
                    end;



                    if grecILE.FindFirst then;


                    if (gPrtExcel = true) then begin
                        gRowNo += 1;
                        gColumnNo := 1;

                        if gPrtExcelPSBC then begin
                            grecItem.CalcFields("B Promo Status", "B Promo Status Description");

                        end;


                        if gPrintStockValue then begin

                            if gTotItem then gColumnNo += 1;

                            if gLotDetail then gColumnNo += 2;
                        end;

                    end;
                end;

                Clear(gText);
                Clear(gDate);
                Clear(gX);


                if "Qty. (Base)" <> 0 then begin

                    LocalisationCdu.R50072_GetComment("Lot No.", gText, gDate);

                end;

                if ("Qty. (Base)" <> 0) and gLotDetail then begin
                    gTotalPrintTrackQtyLotAux := gTotalPrintTrackQtyLot;
                    gTotalPrintTrackQtyLot := 0;
                    grecILE.SetRange("Lot No.", "Lot No.");
                    grecILE.SetRange("Item No.", "Item No.");
                    if gRegDateFilter <> '' then grecILE.SetFilter("Posting Date", gRegDateFilter);

                    grecILE.SetRange(Open);

                    gLotValue := 0;
                    if grecILE.FindFirst then
                        repeat
                            grecILE.CalcFields("Cost Amount (Actual)");
                            gLotValue += grecILE."Cost Amount (Actual)";
                        until grecILE.Next = 0;

                    grecILE.CalcSums(Quantity);

                    if gPrtExcel then begin
                        gRowNo += 1;
                        gColumnNo := 1;



                        if gPrintStockValue then begin

                            if gTotItem then gColumnNo += 1;

                        end;

                    end;
                end;


                if grecILE.Quantity <> 0 then
                    gLotValuedivgrecILEQuantity := gLotValue / grecILE.Quantity else
                    gLotValuedivgrecILEQuantity := 0;



                if (gTotItem = true) and ("Qty. (Base)" <> 0) then begin
                    gTotTrackQtyLot := gAux;
                    gAux := 0;
                end;



                if (gShowInvCostPosted) and ("Qty. (Base)" <> 0) then begin
                    lrecValueEntry.SetCurrentKey("Item No.", "Posting Date", "Location Code", "Item Ledger Entry No.");
                    lrecValueEntry.SetRange("Item No.", "Item No.");
                    if gRegDateFilter <> '' then lrecValueEntry.SetFilter("Posting Date", gRegDateFilter);
                    if "Warehouse Entry".GetFilter("Location Code") <> '' then
                        lrecValueEntry.SetFilter("Location Code", "Warehouse Entry".GetFilter("Location Code"));

                    gTotalInvCostPostedToGL := 0;
                    gInvCostPostedToGL := 0;
                    if lrecValueEntry.FindSet then repeat
                                                       if ItemLedgerEntry.Get(lrecValueEntry."Item Ledger Entry No.") then begin

                                                           if ItemLedgerEntry.Quantity <> 0 then
                                                               VECostPostedtoGL := lrecValueEntry."Cost Posted to G/L" *
                                                                                        (ItemLedgerEntry."Remaining Quantity" / ItemLedgerEntry.Quantity)
                                                           else
                                                               VECostPostedtoGL := 0;

                                                           if (ItemLedgerEntry."Lot No." = "Lot No.") and (ItemLedgerEntry."Remaining Quantity" <> 0) then begin
                                                               gInvCostPostedToGL += VECostPostedtoGL;
                                                           end;
                                                           if ItemLedgerEntry."Remaining Quantity" <> 0 then begin
                                                               gTotalInvCostPostedToGL += VECostPostedtoGL;
                                                               gGrandTotalInvCostPostedToGL += VECostPostedtoGL;
                                                           end;
                                                       end;
                        until lrecValueEntry.Next = 0;

                end;


                SetStockValueText;

            end;

            trigger OnPreDataItem()
            begin
                gSubtot := true;
                CurrReport.CreateTotals(gTrackQtyLot);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(gBestUsedByStart; gBestUsedByStart)
                    {
                        Caption = 'Show Best Used By From Date';
                        ApplicationArea = All;
                    }
                    field(gBestUsedByEnd; gBestUsedByEnd)
                    {
                        Caption = 'Show Best Used By To Date';
                        ApplicationArea = All;
                    }
                    field(gShowItemTrackingComment; gShowItemTrackingComment)
                    {
                        Caption = 'Show Item Tracking Comments';
                        ApplicationArea = All;
                    }
                    field(gTotItem; gTotItem)
                    {
                        Caption = 'Print Total Per Item';
                        ApplicationArea = All;
                    }
                    field(gLotDetail; gLotDetail)
                    {
                        Caption = 'Print Total per LOT';
                        ApplicationArea = All;
                    }
                    field(gShowInvCostPosted; gShowInvCostPosted)
                    {
                        Caption = 'Show Inv. Cost Posted';
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
        ReportName = 'Stock List';
        lblPage = 'Page:';
        lblORG = 'Org';
        lblDesc3 = 'Descr. 3';
        lblPS = 'PS';
        lblQty = 'Qty.';
        lblUoM = 'Unit of Measure';
        lblRemainingQty = 'Rem. Qty.';
        lblTrackingQty = 'Tracking Qty.';
        lblGerm = 'Germ.';
        lblGrade = 'Grade';
        lblBestUseBy = 'Best used by';
        lblRemark = 'Remark';
        lblTotalLot = 'Total Lot';
        lblDesc = 'Descr.';
        lblDesc1 = 'Descr. 2';
        lblTSWingr = 'Tsw. in gr.';
        lblComment = 'Comment';
        lblTotal = 'Total';
        lblBC = 'BC';
        lbInvCostPosted = 'Inv. Cost Posted';
    }

    trigger OnInitReport()
    begin

        grecReservEntry.SetCurrentKey("Item No.", "Source Type", "Source Subtype", "Reservation Status", "Location Code",
                                   "Variant Code", "Shipment Date", "Expected Receipt Date", "Serial No.", "Lot No.");
        grecReservEntry.SetRange("Source Type", 37);
        grecReservEntry.SetRange("Source Subtype", 1);
        grecReservEntry.SetRange("Reservation Status", grecReservEntry."Reservation Status"::Surplus);

        grecILE.SetCurrentKey("Item No.", "Lot No.");
        grecILE.SetFilter("Unit of Measure Code", '<>%1', '');


        grecBejoSetup.Get;


    end;

    trigger OnPreReport()
    begin
        gPrtExcelComment := true;
        gPrtExcelPSBC := true;
        gPrtExcel := true;

        gRegDateFilter := "Warehouse Entry".GetFilter("Registering Date");

        if gRegDateFilter <> '' then
            grecILE.SetFilter("Posting Date", gRegDateFilter)
        else

            grecILE.SetRange(Open, true);
    end;

    var
        Text50000: Label 'Location';
        Text50001: Label 'Item No.';
        Text50002: Label 'Stock List';
        Text50003: Label 'Item No.';
        Text50004: Label 'Description';
        Text50005: Label 'Lot No.';
        Text50006: Label 'Qty.';
        Text50007: Label 'Unit';
        Text50008: Label 'Total';
        Text50009: Label 'Tracking Qty.';
        Text50010: Label 'Descr. 3';
        Text50011: Label 'Grade';
        Text50012: Label 'Tsw. in gr.';
        Text50013: Label 'Germ.';
        Text50014: Label 'Best Used By';
        Text50015: Label 'Remark';
        Text50016: Label 'Bin Code';
        Text50018: Label '! = Best Used By date is less than 30 days.';
        Text50021: Label 'Descr. 2';
        Text50022: Label 'InvCostPostedToGL';
        Text50023: Label 'Total Inventory Cost Posted to G\L';
        Text50024: Label 'Promo Status';
        Text50025: Label 'Blocking Code';
        Text50026: Label 'Movements Comment';
        Text50027: Label ' %1 (Qty=%2); ';
        Text50028: Label 'You cannot print Movement Comments for History StockList ';
        Text50029: Label 'Inventory Value %1';
        Text50030: Label 'Total Item %1 LOT %2 : ';
        Text50031: Label 'Unit Cost %1';
        Text50032: Label 'Org';
        grecItem: Record Item;
        grecGrade: Record Grade;
        gSortingToShow: Option Locatie,Ras;
        gSortingText: Text[30];
        gSubtot: Boolean;
        gPrtExcel: Boolean;
        gSubTotParty: Boolean;
        gTotItem: Boolean;
        grecLotNoInfo: Record "Lot No. Information";
        grecItemExt: Record "Item Extension";
        grecBinContent: Record "Bin Content";
        gExpired: Text[5];
        grecItemTrackComment: Record "Item Tracking Comment";
        gX: Integer;
        gText: array[5] of Text[80];
        gDate: array[5] of Date;
        gBestUsedByStart: Date;
        gcuBejoMgt: Codeunit "Bejo Management";
        gBestUsedByEnd: Date;
        gTrackQtyLot: Decimal;
        grecReservEntry: Record "Reservation Entry";
        gShowItemTrackingComment: Boolean;
        grecTempExcelBuffer: Record "Excel Buffer" temporary;
        gRowNo: Integer;
        gColumnNo: Integer;
        gTotTrackQtyLot: Decimal;
        gAux: Decimal;
        grecILE: Record "Item Ledger Entry";
        gInvCostPostedToGL: Decimal;
        gTotalInvCostPostedToGL: Decimal;
        gFileName: Text[250];
        grecBejoSetup: Record "Bejo Setup";
        gPrtExcelPSBC: Boolean;
        gcuBlockingMgt: Codeunit "Blocking Management";
        gPrtExcelComment: Boolean;
        gRegDateFilter: Text[100];
        gLotDetail: Boolean;
        gLotValue: Decimal;
        gQuantity: Decimal;
        gLotValuedivgrecILEQuantity: Decimal;
        gPrintStockValue: Boolean;
        gStockValueText: Text[1024];
        grecVariety: Record Varieties;
        gInvCostPostedToGLText: Text[30];
        gText50022Text: Text[30];
        gTotalPrintTrackQtyLot: Decimal;
        gTotalPrintTrackQtyLotAux: Decimal;
        lComment: Text[1024];
        bShowSection: Boolean;
        totalInventoryCostPostedToGL: Decimal;
        oldItem: Text;
        LocalisationCdu: Codeunit "Localisation Codeunit";
        PromoStatusExtended: Text;
        BlockingCodeExtended: Text;
        gGrandTotalInvCostPostedToGL: Decimal;
        gShowInvCostPosted: Boolean;

    local procedure EnterCell(parCellValue: Text[250]; parRowNo: Integer; parColumnNo: Integer; parBold: Boolean; parUnderLine: Boolean; parNumberFormat: Boolean; parColNoIncr: Integer)
    begin
        grecTempExcelBuffer.Init;
        grecTempExcelBuffer."Cell Value as Text" := parCellValue;
        grecTempExcelBuffer.Validate("Row No.", parRowNo);
        grecTempExcelBuffer.Validate("Column No.", parColumnNo);
        grecTempExcelBuffer.Formula := '';
        grecTempExcelBuffer.Bold := parBold;
        grecTempExcelBuffer.Underline := parUnderLine;
        if parNumberFormat then grecTempExcelBuffer.NumberFormat := '#,##0.00';
        grecTempExcelBuffer.Insert;

        gColumnNo += parColNoIncr;

    end;

    procedure SetStockValueText()
    begin

        totalInventoryCostPostedToGL := 0;
        if gPrintStockValue then begin
            gStockValueText := StrSubstNo(Text50029, Format(gLotValue, 0, '<Precision,2><Standard Format,0>')) + '  ' +
            StrSubstNo(Text50031, Round(gLotValuedivgrecILEQuantity, 0.00001));
            gInvCostPostedToGLText := Format(gInvCostPostedToGL, 0, '<Precision,2><Standard Format,0>');
            totalInventoryCostPostedToGL := gInvCostPostedToGL;
            gText50022Text := Text50022;
        end else begin
            gStockValueText := '';
            gInvCostPostedToGLText := '';
            gText50022Text := '';
        end;

    end;
}

