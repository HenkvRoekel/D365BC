report 50089 "Inventory by Lot No."
{

    DefaultLayout = RDLC;
    RDLCLayout = './RDLC/Inventory by Lot No..rdlc';


    dataset
    {
        dataitem(Crops; Crops)
        {
            DataItemTableView = SORTING ("Crop Code") ORDER(Ascending);
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Crop Code";
            column(UserId; UserId)
            {
            }
            column(CompanyName; CompanyName)
            {
            }
            column(CropsFilter; Text111 + ':  ' + Crops.GetFilters)
            {
            }
            column(ItemFilter; Text109 + ': ' + gItemFilter)
            {
            }
            column(CropCode_Crops; Crops."Crop Code")
            {
            }
            column(DescriptionEnglish_Crops; Crops."Description English")
            {
            }
            column(CropTotalText; CropTotalText)
            {
            }
            column(RptTotalText; RptTotalText)
            {
            }
            column(gShowItemTotals; gShowItemTotals)
            {
            }
            dataitem(Item; Item)
            {
                CalcFields = Inventory;
                DataItemLink = "B Crop" = FIELD ("Crop Code");
                DataItemTableView = SORTING ("No.") ORDER(Ascending);
                RequestFilterFields = "No.", "Inventory Posting Group", "Location Filter";
                column(No_Item; Item."No.")
                {
                }
                column(Description_Item; Item.Description)
                {
                }
                column(gPerUnitCost; gPerUnitCost)
                {
                }
                dataitem("Item Ledger Entry"; "Item Ledger Entry")
                {
                    DataItemLink = "Item No." = FIELD ("No.");
                    DataItemTableView = SORTING ("Item No.", "Lot No.", Open, "Unit of Measure Code") ORDER(Ascending) WHERE (Open = CONST (true));
                    column(RemainingQuantity_ItemLedgerEntry; "Item Ledger Entry"."Remaining Quantity")
                    {
                    }
                    column(LocationCode_ItemLedgerEntry; "Item Ledger Entry"."Location Code")
                    {
                    }
                    column(UnitofMeasureCode_ItemLedgerEntry; "Item Ledger Entry"."Unit of Measure Code")
                    {
                    }
                    column(LotNo_ItemLedgerEntry; "Item Ledger Entry"."Lot No.")
                    {
                        IncludeCaption = true;
                    }
                    column(Units_ILE; "Item Ledger Entry"."Remaining Quantity" / "Item Ledger Entry"."Qty. per Unit of Measure")
                    {
                    }
                    column(gValue; gValue)
                    {
                    }
                    column(gPerUOM; gPerUOM)
                    {
                    }
                    column(grecPurchPrice_DirectUnitCost; grecPurchPrice."Direct Unit Cost")
                    {
                    }
                    column(gPerUOMgrecPurchPrice_DirectUnitCost; gPerUOM - grecPurchPrice."Direct Unit Cost")
                    {
                    }
                    column(gILEFound; gILEFound)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin

                        Clear(grecPurchPrice);
                        grecPurchPrice.SetRange("Item No.", "Item No.");
                        grecPurchPrice.SetFilter("Starting Date", '<=%1', gPurchPrcDt);
                        grecPurchPrice.SetFilter("Ending Date", '>=%1|%2', gPurchPrcDt, 0D);
                        grecPurchPrice.SetRange("Unit of Measure Code", "Unit of Measure Code");
                        if grecPurchPrice.ReadPermission then
                            if grecPurchPrice.FindLast then;

                        gInventory := "Remaining Quantity";
                        CalcFields("Cost Amount (Actual)");

                        if "Invoiced Quantity" = 0 then
                            gValue := 0
                        else
                            gValue := Round(("Cost Amount (Actual)" / "Invoiced Quantity") * gInventory);

                        gILEFound := true;


                        if "Remaining Quantity" <> 0 then
                            gPerUOM := gValue / ("Remaining Quantity" / "Qty. per Unit of Measure")
                        else
                            gPerUOM := 0;


                        if gPrintToExcel then begin
                            gZeroQtyRec := false;
                            MakeExcelDataBody;

                        end;
                    end;

                    trigger OnPreDataItem()
                    begin

                        Item.CopyFilter("Location Filter", "Location Code");
                        CurrReport.CreateTotals(gValue, gInventory);
                        if GetFilter("Posting Date") <> '' then
                            Error(Text50000, FieldCaption("Posting Date"));
                    end;
                }

                trigger OnAfterGetRecord()
                begin

                    gItemInvValue := CalcInventoryValue(Item);
                    if Inventory <> 0 then
                        gPerUnitCost := gItemInvValue / Inventory
                    else
                        gPerUnitCost := 0;

                    gILEFound := false;
                end;

                trigger OnPostDataItem()
                begin
                    gPrintTH := false;
                end;

                trigger OnPreDataItem()
                begin

                    if GetFilter("Date Filter") <> '' then
                        Error(Text50000, FieldCaption("Date Filter"));

                    CurrReport.CreateTotals(gInventory, gValue);
                    gPrintTH := true;
                end;
            }

            trigger OnPreDataItem()
            begin

                CurrReport.CreateTotals(gInventory, gValue);
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
                    field(PurchTargetDate; gPurchPrcDt)
                    {
                        Caption = 'Purchase Price Target Date';
                        ApplicationArea = All;
                    }
                    field(ShowItemTotals; gShowItemTotals)
                    {
                        Caption = 'Show Item Totals';
                        ApplicationArea = All;

                    }
                    field(ShowDupInfo; gShowDupInfoExcel)
                    {
                        Caption = 'Show Duplicate Info';
                        Enabled = true;
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin

                            if gPrintToExcel then
                                gShowItemTotals := false;
                        end;
                    }
                    field(ShowUnitCost; gShowUnitCostExcel)
                    {
                        Caption = 'Show Unit Cost';
                        Enabled = true;
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin

                            if gPrintToExcel then
                                gShowItemTotals := false;
                        end;
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
        lblReportName = 'Inventory by Lot No.';
        lblCropItemNo = 'Crop Code / Item No.';
        lblDescLocation = 'Description / Location Code';
        lblUnitCostUoM = 'Unit Cost / UOM Code';
        lblQty = 'Quantity';
        lblunits = 'Units';
        lblValue = 'Value';
        lblPerUoM = 'Per UoM';
        lblPurchasePerUoM = 'Purchase Per UOM';
        lblVariance = 'Variance';
    }

    trigger OnInitReport()
    begin
        gPurchPrcDt := Today;
    end;

    trigger OnPostReport()
    begin

        if gPrintToExcel then
            CreateExcelbook;
    end;

    trigger OnPreReport()
    begin

        if gPurchPrcDt = 0D then
            Error(Text50001);
        gItemFilter := Item.GetFilters;
        if grecCurrency.FindFirst then;

        if gPrintToExcel then
            MakeExcelInfo;
    end;

    var
        gcuBejoMgt: Codeunit "Bejo Management";
        grecPurchPrice: Record "Purchase Price";
        grecCurrency: Record Currency;
        gInventory: Decimal;
        gValue: Decimal;
        gPerUOM: Decimal;
        gItemFilter: Text[1000];
        gPrintTH: Boolean;
        gPurchPrcDt: Date;
        gShowItemTotals: Boolean;
        gPerUnitCost: Decimal;
        gItemInvValue: Decimal;
        gILEFound: Boolean;
        gPrintToExcel: Boolean;
        grecExcelBuf: Record "Excel Buffer" temporary;
        gZeroQtyRec: Boolean;
        gPrevCrop: Code[20];
        gPrevItem: Code[20];
        gShowDupInfoExcel: Boolean;
        gShowUnitCostExcel: Boolean;
        Text50000: Label 'A filter on %1 cannot be specified for this report.';
        Text50001: Label 'Please enter a Purchase Price Target Date, on the Options tab.';
        CropTotalText: Label 'Crop Total';
        RptTotalText: Label 'Report Total';
        ContinuedText: Label '( --- Continued --- )';
        Text101: Label 'Data';
        Text102: Label 'Inventory by Lot No.';
        Text103: Label 'Company Name';
        Text104: Label 'Report No.';
        Text105: Label 'Report Name';
        Text106: Label 'User ID';
        Text107: Label 'Date / Time';
        Text108: Label 'Units';
        Text109: Label 'Item Filters';
        Text111: Label 'Crops Filters';
        Text112: Label 'Per UOM';
        Text113: Label 'Purch. Per UOM';
        Text114: Label 'Unit Cost';
        Text115: Label 'Value';
        Text116: Label 'Variance';

    procedure CalcInventoryValue(var parItem: Record Item) rValue: Decimal
    var
        lrecValueEntry: Record "Value Entry";
    begin
        with lrecValueEntry do begin
            Reset;
            if (parItem.GetFilter("Global Dimension 1 Filter") <> '') or
               (parItem.GetFilter("Global Dimension 2 Filter") <> '')
            then
                SetCurrentKey(
                  "Item No.", "Posting Date", "Item Ledger Entry Type", "Entry Type",
                  "Variance Type", "Item Charge No.", "Location Code", "Variant Code",
                  "Global Dimension 1 Code", "Global Dimension 2 Code")
            else
                SetCurrentKey(
                  "Item No.", "Posting Date", "Item Ledger Entry Type", "Entry Type",
                  "Variance Type", "Item Charge No.", "Location Code", "Variant Code");
            SetRange("Item No.", parItem."No.");
            parItem.CopyFilter("Location Filter", "Location Code");
            parItem.CopyFilter("Variant Filter", "Variant Code");
            parItem.CopyFilter("Global Dimension 1 Filter", "Global Dimension 1 Code");
            parItem.CopyFilter("Global Dimension 2 Filter", "Global Dimension 2 Code");
            parItem.CopyFilter("Date Filter", "Posting Date");
            CalcSums("Cost Amount (Actual)");
            rValue := "Cost Amount (Actual)";
        end;
    end;

    local procedure MakeExcelInfo()
    begin

        grecExcelBuf.SetUseInfoSheet();

        grecExcelBuf.AddInfoColumn(Format(Text103), false, true, false, false, '', grecExcelBuf."Cell Type"::Text);
        grecExcelBuf.AddInfoColumn(CompanyName, false, false, false, false, '', grecExcelBuf."Cell Type"::Text);
        grecExcelBuf.NewRow;
        grecExcelBuf.AddInfoColumn(Format(Text105), false, true, false, false, '', grecExcelBuf."Cell Type"::Text);
        grecExcelBuf.AddInfoColumn(Format(Text102), false, false, false, false, '', grecExcelBuf."Cell Type"::Text);
        grecExcelBuf.NewRow;
        grecExcelBuf.AddInfoColumn(Format(Text104), false, true, false, false, '', grecExcelBuf."Cell Type"::Text);
        grecExcelBuf.AddInfoColumn(REPORT::"Vendor - Labels", false, false, false, false, '', grecExcelBuf."Cell Type"::Text);
        grecExcelBuf.NewRow;
        grecExcelBuf.AddInfoColumn(Format(Text106), false, true, false, false, '', grecExcelBuf."Cell Type"::Text);
        grecExcelBuf.AddInfoColumn(UserId, false, false, false, false, '', grecExcelBuf."Cell Type"::Text);
        grecExcelBuf.NewRow;
        grecExcelBuf.AddInfoColumn(Format(Text107), false, true, false, false, '', grecExcelBuf."Cell Type"::Text);
        grecExcelBuf.AddInfoColumn(Today, false, false, false, false, '', grecExcelBuf."Cell Type"::Text);
        grecExcelBuf.AddInfoColumn(Time, false, false, false, false, '', grecExcelBuf."Cell Type"::Text);
        grecExcelBuf.NewRow;
        grecExcelBuf.AddInfoColumn(Format(Text111), false, true, false, false, '', grecExcelBuf."Cell Type"::Text);
        grecExcelBuf.AddInfoColumn(Crops.GetFilters, false, false, false, false, '', grecExcelBuf."Cell Type"::Text);
        grecExcelBuf.NewRow;
        grecExcelBuf.AddInfoColumn(Format(Text109), false, true, false, false, '', grecExcelBuf."Cell Type"::Text);
        grecExcelBuf.AddInfoColumn(gItemFilter, false, false, false, false, '', grecExcelBuf."Cell Type"::Text);
        grecExcelBuf.ClearNewRow;
        MakeExcelDataHeader;
    end;

    local procedure MakeExcelDataHeader()
    begin
        grecExcelBuf.NewRow;
        grecExcelBuf.AddColumn(Crops.FieldCaption("Crop Code"), false, '', true, false, true, '', grecExcelBuf."Cell Type"::Text);
        grecExcelBuf.AddColumn(Crops.FieldCaption(Description), false, '', true, false, true, '', grecExcelBuf."Cell Type"::Text);
        grecExcelBuf.AddColumn(Item.FieldCaption("No."), false, '', true, false, true, '', grecExcelBuf."Cell Type"::Text);
        grecExcelBuf.AddColumn(Item.FieldCaption(Description), false, '', true, false, true, '', grecExcelBuf."Cell Type"::Text);
        if gShowUnitCostExcel then
            grecExcelBuf.AddColumn(Format(Text114), false, '', true, false, true, '', grecExcelBuf."Cell Type"::Text);
        grecExcelBuf.AddColumn("Item Ledger Entry".FieldCaption("Location Code"), false, '', true, false, true, '', grecExcelBuf."Cell Type"::Text);
        grecExcelBuf.AddColumn("Item Ledger Entry".FieldCaption("Lot No."), false, '', true, false, true, '', grecExcelBuf."Cell Type"::Text);
        grecExcelBuf.AddColumn("Item Ledger Entry".FieldCaption("Unit of Measure Code"), false, '', true, false, true, '', grecExcelBuf."Cell Type"::Text);
        grecExcelBuf.AddColumn("Item Ledger Entry".FieldCaption(Quantity), false, '', true, false, true, '', grecExcelBuf."Cell Type"::Text);
        grecExcelBuf.AddColumn(Format(Text108), false, '', true, false, true, '', grecExcelBuf."Cell Type"::Text);
        grecExcelBuf.AddColumn(Format(Text115), false, '', true, false, true, '', grecExcelBuf."Cell Type"::Text);
        grecExcelBuf.AddColumn(Format(Text112), false, '', true, false, true, '', grecExcelBuf."Cell Type"::Text);
        grecExcelBuf.AddColumn(Format(Text113), false, '', true, false, true, '', grecExcelBuf."Cell Type"::Text);
        grecExcelBuf.AddColumn(Format(Text116), false, '', true, false, true, '', grecExcelBuf."Cell Type"::Text);
    end;

    local procedure MakeExcelDataBody()
    begin
        grecExcelBuf.NewRow;
        if (gPrevCrop <> Crops."Crop Code") or (gShowDupInfoExcel) then begin
            grecExcelBuf.AddColumn(Crops."Crop Code", false, '', false, false, false, '@', grecExcelBuf."Cell Type"::Text);
            grecExcelBuf.AddColumn(Crops.Description, false, '', false, false, false, '', grecExcelBuf."Cell Type"::Text);
        end
        else begin
            grecExcelBuf.AddColumn(' ', false, '', false, false, false, '', grecExcelBuf."Cell Type"::Text);
            grecExcelBuf.AddColumn(' ', false, '', false, false, false, '', grecExcelBuf."Cell Type"::Text);
        end;
        if (gPrevItem <> Item."No.") or (gShowDupInfoExcel) then begin
            grecExcelBuf.AddColumn(Item."No.", false, '', false, false, false, '@', grecExcelBuf."Cell Type"::Text);
            grecExcelBuf.AddColumn(Item.Description, false, '', false, false, false, '', grecExcelBuf."Cell Type"::Text);
        end
        else begin
            grecExcelBuf.AddColumn(' ', false, '', false, false, false, '', grecExcelBuf."Cell Type"::Text);
            grecExcelBuf.AddColumn(' ', false, '', false, false, false, '', grecExcelBuf."Cell Type"::Text);
        end;
        if gZeroQtyRec then begin
            if gShowUnitCostExcel then
                grecExcelBuf.AddColumn(0, false, '', false, false, false, '#,##0.000000000000', grecExcelBuf."Cell Type"::Text);
            grecExcelBuf.AddColumn(' ', false, '', false, false, false, '', grecExcelBuf."Cell Type"::Text);
            grecExcelBuf.AddColumn(' ', false, '', false, false, false, '', grecExcelBuf."Cell Type"::Text);
            grecExcelBuf.AddColumn(' ', false, '', false, false, false, '', grecExcelBuf."Cell Type"::Text);
            grecExcelBuf.AddColumn(0, false, '', false, false, false, '#,##0', grecExcelBuf."Cell Type"::Text);
            grecExcelBuf.AddColumn(' ', false, '', false, false, false, '', grecExcelBuf."Cell Type"::Text);
            grecExcelBuf.AddColumn(gItemInvValue, false, '', false, false, false, '#,##0.00', grecExcelBuf."Cell Type"::Text);
        end
        else begin
            if gShowUnitCostExcel then
                grecExcelBuf.AddColumn(gPerUnitCost, false, '', false, false, false, '#,##0.000000000000', grecExcelBuf."Cell Type"::Text);
            grecExcelBuf.AddColumn("Item Ledger Entry"."Location Code", false, '', false, false, false, '', grecExcelBuf."Cell Type"::Text);
            grecExcelBuf.AddColumn("Item Ledger Entry"."Lot No.", false, '', false, false, false, '', grecExcelBuf."Cell Type"::Text);
            grecExcelBuf.AddColumn("Item Ledger Entry"."Unit of Measure Code", false, '', false, false, false, '', grecExcelBuf."Cell Type"::Text);
            grecExcelBuf.AddColumn(gInventory, false, '', false, false, false, '#,###', grecExcelBuf."Cell Type"::Text);
            grecExcelBuf.AddColumn(gInventory / "Item Ledger Entry"."Qty. per Unit of Measure", false, '', false, false, false, '#,###', grecExcelBuf."Cell Type"::Text);
            grecExcelBuf.AddColumn(gValue, false, '', false, false, false, '#,##0.00', grecExcelBuf."Cell Type"::Text);
            grecExcelBuf.AddColumn(gPerUOM, false, '', false, false, false, '#,##0.00', grecExcelBuf."Cell Type"::Text);
            grecExcelBuf.AddColumn(grecPurchPrice."Direct Unit Cost", false, '', false, false, false, '#,##0.00', grecExcelBuf."Cell Type"::Text);
            grecExcelBuf.AddColumn(gPerUOM - grecPurchPrice."Direct Unit Cost", false, '', false, false, false, '#,##0.00', grecExcelBuf."Cell Type"::Text);
        end;

        gPrevCrop := Crops."Crop Code";
        gPrevItem := Item."No.";
    end;

    local procedure CreateExcelbook()
    begin

        grecExcelBuf.CreateNewBook(Text102);
        grecExcelBuf.WriteSheet(Text101, CompanyName, UserId);
        grecExcelBuf.CloseBook;
        grecExcelBuf.OpenExcel();

    end;
}

