report 50062 "Crop/Variety - Top 10 List"
{

    DefaultLayout = RDLC;
    RDLCLayout = './RDLC/CropVariety - Top 10 List.rdlc';


    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = SORTING ("No.");
            RequestFilterFields = "No.", "Inventory Posting Group", "Statistics Group", "Date Filter", "B Crop", "B Gen.Prod.Posting Grp Filter", "B Gen.Bus.Posting Grp Filter", "Global Dimension 1 Filter";

            trigger OnAfterGetRecord()
            begin

                gdlgWindow.Update(1, "No.");

                if isCropOrVariety = isCropOrVariety::Crop then begin

                    CalcFields("Sales (LCY)", "COGS (LCY)");
                    gFilterHold := GetFilter("Date Filter");
                    gFilterHold2 := GetFilter("Global Dimension 1 Filter");
                    SetRange("Date Filter", 0D, (GetRangeMax("Date Filter")));

                    SetRange("Global Dimension 1 Filter");

                    CalcFields("Net Change");
                    if gUseInvValue then
                        Inventory := CalcInventoryValue(Item)
                    else
                        Inventory := "Net Change";

                    if gExcldItemCharges and gUseInvValue
                       and (Inventory > 1)
                    then Inventory -= CalcInvtItemCharges(Item);


                    SetFilter("Date Filter", gFilterHold);

                    if gFilterHold2 <> '' then
                        SetRange("Global Dimension 1 Filter", gFilterHold2);

                    if (gShowMarginBar = gShowMarginBar::Margin) then begin
                        if ("Sales (LCY)" = 0) and (Inventory = 0) and ("COGS (LCY)" = 0) and not gPrintAlsoIfZero then
                            CurrReport.Skip;
                    end
                    else

                        if ("Sales (LCY)" = 0) and (Inventory = 0) and not gPrintAlsoIfZero then
                            CurrReport.Skip;

                    grecItemAmount.Reset;
                    grecItemAmount.SetRange("Item No.", Item."B Crop");
                    if not grecItemAmount.FindFirst then begin
                        grecItemAmount.Init;
                        grecItemAmount.Amount := 0;
                        grecItemAmount."Amount 2" := 0;
                        grecItemAmount."Item No." := "B Crop";
                    end else
                        grecItemAmount.Delete;


                    grecItemAmount3.Reset;
                    grecItemAmount3.SetRange("Item No.", Item."B Crop");
                    if not grecItemAmount3.FindFirst then begin
                        grecItemAmount3.Init;
                        grecItemAmount3.Amount := 0;
                        grecItemAmount3."Amount 2" := 0;
                        grecItemAmount3."Item No." := "B Crop";
                    end else
                        grecItemAmount3.Delete;

                    if gShowSorting = gShowSorting::Largest then
                        gFactor := -1
                    else
                        gFactor := 1;

                    if gShowType = gShowType::"Sales (LCY)" then begin
                        grecItemAmount.Amount += "Sales (LCY)" * gFactor;
                        grecItemAmount."Amount 2" += Inventory * gFactor;
                    end else begin
                        grecItemAmount.Amount += Inventory * gFactor;
                        grecItemAmount."Amount 2" += "Sales (LCY)" * gFactor;
                    end;

                    if gExcldItemCharges then
                        "COGS (LCY)" -= CalcSalesItemCharges(Item);

                    grecItemAmount.Insert;


                    grecItemAmount3.Amount += "COGS (LCY)";
                    grecItemAmount3.Insert;


                    gItemSales += "Sales (LCY)";
                    gQtyOnHand += Inventory;
                    gCOGS += "COGS (LCY)";
                end
                else begin

                    CalcFields("Sales (LCY)", "COGS (LCY)");
                    gFilterHold := GetFilter("Date Filter");
                    SetRange("Date Filter", 0D, (GetRangeMax("Date Filter")));
                    CalcFields("Net Change");
                    if gUseInvValue then
                        Inventory := CalcInventoryValue(Item)
                    else
                        Inventory := "Net Change";

                    SetFilter("Date Filter", gFilterHold);
                    if gFilterHold2 <> '' then
                        SetRange("Global Dimension 1 Filter", gFilterHold2);

                    if (gShowMarginBar = gShowMarginBar::Margin) then begin
                        if ("Sales (LCY)" = 0) and (Inventory = 0) and ("COGS (LCY)" = 0) and not gPrintAlsoIfZero then
                            CurrReport.Skip;
                    end
                    else
                        if ("Sales (LCY)" = 0) and (Inventory = 0) and not gPrintAlsoIfZero then
                            CurrReport.Skip;

                    grecItemAmount.Reset;
                    grecItemAmount.SetRange("Item No.", Item."B Variety");
                    if not grecItemAmount.FindFirst then begin
                        grecItemAmount.Init;
                        grecItemAmount.Amount := 0;
                        grecItemAmount."Amount 2" := 0;
                        grecItemAmount."Item No." := Item."B Variety";
                    end else
                        grecItemAmount.Delete;


                    grecItemAmount3.Reset;
                    grecItemAmount3.SetRange("Item No.", Item."B Variety");
                    if not grecItemAmount3.FindFirst then begin
                        grecItemAmount3.Init;
                        grecItemAmount3.Amount := 0;
                        grecItemAmount3."Amount 2" := 0;
                        grecItemAmount3."Item No." := Item."B Variety";
                    end else
                        grecItemAmount3.Delete;

                    if gShowSorting = gShowSorting::Largest then
                        gFactor := -1
                    else
                        gFactor := 1;


                    if gShowType = gShowType::"Sales (LCY)" then begin

                        grecItemAmount.Amount += "Sales (LCY)" * gFactor;
                        grecItemAmount."Amount 2" += Inventory * gFactor;

                    end else begin

                        grecItemAmount.Amount += Inventory * gFactor;
                        grecItemAmount."Amount 2" += "Sales (LCY)" * gFactor;

                    end;

                    if gExcldItemCharges then
                        "COGS (LCY)" -= CalcSalesItemCharges(Item);

                    grecItemAmount.Insert;

                    grecItemAmount3.Amount += "COGS (LCY)";
                    grecItemAmount3.Insert;

                    gItemSales += Item."Sales (LCY)";
                    gQtyOnHand += Item.Inventory;
                    gCOGS += "COGS (LCY)";
                end
            end;

            trigger OnPreDataItem()
            begin
                grecItemAmount.DeleteAll;
                grecItemAmount3.DeleteAll;
                gdlgWindow.Open(Text000);
            end;
        }
        dataitem("Integer"; "Integer")
        {
            DataItemTableView = SORTING (Number) WHERE (Number = FILTER (1 ..));

            column(UserId; UserId)
            {
            }
            column(CompanyName; CompanyName)
            {
            }
            column(gItemDateFilter; StrSubstNo(Text001, gItemDateFilter))
            {
            }
            column(hdrMessage; StrSubstNo(Text002, gSequence, gHeading))
            {
            }
            column(gItemFilter; StrSubstNo('%1: %2', Item.TableCaption, gItemFilter))
            {
            }
            column(PortionOfSalesLCYCaption; StrSubstNo(Text003, gHeading))
            {
            }
            column(ReportTitle; ReportTitle)
            {
            }
            column(gNoCaption; gNoCaption)
            {
            }
            column(gDescriptionCaption; gDescriptionCaption)
            {
            }
            column(gSalesLCYCaption; gSalesLCYCaption)
            {
            }
            column(gInventoryCaption; gInventoryCaption)
            {
            }
            column(gShowSorting; gShowSorting)
            {
            }
            column(gShowType; gShowType)
            {
            }
            column(gNoOfRecordsToPrint; gNoOfRecordsToPrint)
            {
            }
            column(gUseInvValue; gUseInvValue)
            {
            }
            column(gShowMarginBar; gShowMarginBar)
            {
            }
            column(gPrintAlsoIfZero; gPrintAlsoIfZero)
            {
            }
            column(gExcldItemCharges; gExcldItemCharges)
            {
            }
            column(Number; Number)
            {
            }
            column(CropCode_Crop; grecCrop."Crop Code")
            {
            }
            column(Desription_Crop; grecCrop.Description)
            {
            }
            column(gCropSalesLCY; gCropSalesLCY)
            {
            }
            column(gCropInventory; gCropInventory)
            {
            }
            column(gCropCOGS; gCropCOGS)
            {
            }
            column(Margin_Lines; gCropSalesLCY - gCropCOGS)
            {
            }
            column(MarginPercent_Lines; Pct((gCropSalesLCY - gCropCOGS), gCropSalesLCY))
            {
            }
            column(gBarText; gBarText)
            {
            }
            column(gTopNSalesLCY; gTopNSalesLCY)
            {
            }
            column(gTopNInventory; gTopNInventory)
            {
            }
            column(gItemSales; gItemSales)
            {
            }
            column(gSalesAmountPct; Pct(gTopNSalesLCY, gItemSales))
            {
            }
            column(gQtyOnHand; gQtyOnHand)
            {
            }
            column(gQtyOnHandPct; Pct(gTopNInventory, gQtyOnHand))
            {
            }
            column(gTopNCOGS; gTopNCOGS)
            {
            }
            column(TotalSales; gTopNSalesLCY - gTopNCOGS)
            {
            }
            column(TotalSalesPct; Pct((gTopNSalesLCY - gTopNCOGS), gTopNSalesLCY))
            {
            }
            column(gCOGS; gCOGS)
            {
            }
            column(TotalCOGS; gItemSales - gCOGS)
            {
            }
            column(TotalCOGSPct; Pct((gItemSales - gCOGS), gItemSales))
            {
            }
            column(isCropOrVariety; isCropOrVariety)
            {
            }
            column(No_Variety; grecVariety."No.")
            {
            }
            column(Description_Variety; grecVariety.Description)
            {
            }
            column(gVarietySalesLCY; gVarietySalesLCY)
            {
            }
            column(gVarietyInventory; gVarietyInventory)
            {
            }
            column(Margin_Lines_Variery; gVarietySalesLCY - gVarietyCOGS)
            {
            }
            column(MarginPercent_Lines_Variety; Pct((gCropSalesLCY - gVarietyCOGS), gVarietySalesLCY))
            {
            }
            column(TotalVarietyCOGS; gItemSales - gCOGS)
            {
            }
            column(gVarietyCOGS; gVarietyCOGS)
            {
            }

            trigger OnAfterGetRecord()
            begin

                if isCropOrVariety = isCropOrVariety::Crop then begin
                    if Number = 1 then begin
                        if not grecItemAmount.FindSet then
                            CurrReport.Break;
                        if gShowSorting = gShowSorting::Largest then
                            gMaxAmount := -grecItemAmount.Amount
                        else
                            if gShowSorting <> gShowSorting::Sequential then begin
                                grecItemAmount2 := grecItemAmount;
                                if grecItemAmount.Next(gNoOfRecordsToPrint - 1) > 0 then;
                                gMaxAmount := grecItemAmount.Amount;
                                grecItemAmount := grecItemAmount2;
                            end;
                    end else
                        if grecItemAmount.Next = 0 then
                            CurrReport.Break;

                    if not (grecCrop.Get(grecItemAmount."Item No.")) then begin
                        Clear(grecCrop);
                        grecCrop."Crop Code" := grecItemAmount."Item No.";
                        grecCrop.Description := Text006;
                    end;

                    if gShowType = gShowType::"Sales (LCY)" then begin
                        gCropSalesLCY := grecItemAmount.Amount;
                        gCropInventory := grecItemAmount."Amount 2";
                    end else begin
                        gCropInventory := grecItemAmount.Amount;
                        gCropSalesLCY := grecItemAmount."Amount 2";
                    end;
                    if gShowSorting = gShowSorting::Largest then begin
                        gCropSalesLCY := -gCropSalesLCY;
                        gCropInventory := -gCropInventory;
                    end;

                    grecItemAmount3.Reset;
                    grecItemAmount3.SetRange("Item No.", grecItemAmount."Item No.");
                    if grecItemAmount3.FindFirst then;
                    gCropCOGS := grecItemAmount3.Amount;

                    gTopNSalesLCY += gCropSalesLCY;
                    gTopNInventory += gCropInventory;
                    gTopNCOGS += gCropCOGS;

                    if (gMaxAmount > 0) and (grecItemAmount.Amount <> 0) then
                        gBarText := PadStr('', Round(Abs(grecItemAmount.Amount) / gMaxAmount * 45, 1), '*')
                    else
                        gBarText := '';


                    if gHideInventory then
                        gCropInventory := 0;


                end
                else begin

                    if Number = 1 then begin
                        if not grecItemAmount.FindSet then
                            CurrReport.Break;
                        if gShowSorting = gShowSorting::Largest then
                            gMaxAmount := -grecItemAmount.Amount
                        else begin
                            grecItemAmount2 := grecItemAmount;
                            if grecItemAmount.Next(gNoOfRecordsToPrint - 1) > 0 then;
                            gMaxAmount := grecItemAmount.Amount;
                            grecItemAmount := grecItemAmount2;
                        end;
                    end else
                        if grecItemAmount.Next = 0 then
                            CurrReport.Break;

                    if not (grecVariety.Get(grecItemAmount."Item No.")) then begin
                        Clear(grecVariety);
                        grecVariety."No." := grecItemAmount."Item No.";
                        grecVariety.Description := Text006;
                    end;


                    if gShowType = gShowType::"Sales (LCY)" then begin
                        gVarietySalesLCY := grecItemAmount.Amount;
                        gVarietyInventory := grecItemAmount."Amount 2";
                    end else begin
                        gVarietyInventory := grecItemAmount.Amount;
                        gVarietySalesLCY := grecItemAmount."Amount 2";
                    end;

                    if gShowSorting = gShowSorting::Largest then begin
                        gVarietySalesLCY := -gVarietySalesLCY;
                        gVarietyInventory := -gVarietyInventory;
                    end;


                    grecItemAmount3.Reset;
                    grecItemAmount3.SetRange("Item No.", grecItemAmount."Item No.");
                    if grecItemAmount3.FindFirst then;
                    gVarietyCOGS := grecItemAmount3.Amount;

                    gTopNSalesLCY += gVarietySalesLCY;
                    gTopNInventory += gVarietyInventory;

                    if (gMaxAmount > 0) and (grecItemAmount.Amount <> 0) then
                        gBarText := PadStr('', Round(Abs(grecItemAmount.Amount) / gMaxAmount * 45, 1), '*')
                    else
                        gBarText := '';

                    if gHideInventory then
                        gVarietyInventory := 0;

                end
            end;

            trigger OnPreDataItem()
            begin

                if isCropOrVariety = isCropOrVariety::Crop then begin
                    SetRange(Number, 1, gNoOfRecordsToPrint);
                    gTopNSalesLCY := 0;
                    gTopNInventory := 0;

                    gNoCaption := grecCrop.FieldCaption("Crop Code");
                    gDescriptionCaption := grecCrop.FieldCaption(Description);
                    gSalesLCYCaption := Item.FieldCaption("Sales (LCY)");
                    gInventoryCaption := Item.FieldCaption(Inventory);
                    if gUseInvValue then
                        gInventoryCaption += ' Value';

                    grecItemAmount.Reset;
                    grecItemAmount3.Reset;

                    if gShowSorting = gShowSorting::Sequential then
                        grecItemAmount.SetCurrentKey("Item No.");
                end
                else begin


                    SetRange(Number, 1, gNoOfRecordsToPrint);
                    gTopNSalesLCY := 0;
                    gTopNInventory := 0;

                    gNoCaption := grecVariety.FieldCaption("No.");
                    gDescriptionCaption := grecVariety.FieldCaption(Description);
                    gSalesLCYCaption := Item.FieldCaption("Sales (LCY)");
                    gInventoryCaption := Item.FieldCaption(Inventory);

                    if gUseInvValue then
                        gInventoryCaption += ' Value';

                    grecItemAmount.Reset;
                    grecItemAmount3.Reset;

                end
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
                    field(isCropOrVariety; isCropOrVariety)
                    {
                        Caption = 'Crop,Variety';
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin
                            if isCropOrVariety = isCropOrVariety::Variety then begin

                                gPrintAlsoIfZero := true;
                                gExcldItemCharges := false;
                            end
                        end;
                    }
                    field(gShowSorting; gShowSorting)
                    {
                        Caption = 'Show';
                        OptionCaption = 'Largest,Smallest,Sequential';
                        ApplicationArea = All;
                    }
                    field(gShowType; gShowType)
                    {
                        Caption = 'Show';
                        OptionCaption = 'Sales (LCY),Inventory';
                        ApplicationArea = All;
                    }
                    field(gNoOfRecordsToPrint; gNoOfRecordsToPrint)
                    {
                        Caption = 'Quantity';
                        ApplicationArea = All;
                    }
                    field(gUseInvValue; gUseInvValue)
                    {
                        Caption = 'Show Inventory Value';
                        ApplicationArea = All;
                    }
                    field(gShowMarginBar; gShowMarginBar)
                    {
                        Caption = 'Show';
                        ApplicationArea = All;
                    }
                    field(gPrintAlsoIfZero; gPrintAlsoIfZero)
                    {
                        Caption = 'Include Items Not on Inventory or Not Sold';
                        MultiLine = true;
                        ApplicationArea = All;
                    }
                    field(gExcldItemCharges; gExcldItemCharges)
                    {
                        Caption = 'Exclude Item Charges from Inventory/COGS';
                        MultiLine = true;
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            if gNoOfRecordsToPrint = 0 then
                gNoOfRecordsToPrint := 10;
            if gExcldItemCharges = false then
                gExcldItemCharges := true;

            gUseInvValue := true;
        end;
    }

    labels
    {
        lblCropTop10 = 'Crop - Top 10 List';
        lblHeaderMessage = 'This report also includes items not on inventory or that are not sold.';
        lblRank = 'Rank';
        lblCostOfGoods = 'Cost of Goods Sold';
        lblGrossMargin = 'Gross Margin';
        lblGrossMarginPercent = 'Gross Margin %';
        lblTotal = 'Total';
        lblTotalSales = 'Total Sales';
        lblTotalSalesPercent = '% of Total Sales';
    }

    trigger OnPostReport()
    begin

        if gPrintToExcel then
            CreateExcelbook;

    end;

    trigger OnPreReport()
    begin
        gItemFilter := Item.GetFilters;
        gItemDateFilter := Item.GetFilter("Date Filter");
        gDateMaxFilter := Item.GetRangeMax("Date Filter");

        gSequence := LowerCase(Format(SelectStr(gShowSorting + 1, Text004)));
        if gShowSorting = gShowSorting::Sequential then
            gHeading := 'Crop Code'
        else
            gHeading := Format(SelectStr(gShowType + 1, Text005));


        if gPrintToExcel then
            MakeExcelInfo;


        if isCropOrVariety = isCropOrVariety::Crop then
            ReportTitle := 'Crop - Top 10 List'
        else
            ReportTitle := 'Variety - Top 10 List';
    end;

    var
        gdlgWindow: Dialog;
        grecItemAmount: Record "Item Amount" temporary;
        grecItemAmount2: Record "Item Amount";
        grecItemAmount3: Record "Item Amount" temporary;
        gItemFilter: Text[250];
        gItemDateFilter: Text[30];
        gSequence: Text[30];
        gHeading: Text[30];
        gShowSorting: Option Largest,Smallest,Sequential;
        gShowType: Option "Sales (LCY)",Inventory;
        gNoOfRecordsToPrint: Integer;
        gPrintAlsoIfZero: Boolean;
        gItemSales: Decimal;
        gQtyOnHand: Decimal;
        gSalesAmountPct: Decimal;
        gQtyOnHandPct: Decimal;
        gMaxAmount: Decimal;
        gBarText: Text[50];
        gI: Integer;
        gcuBejoMgt: Codeunit "Bejo Management";
        grecCrop: Record Crops;
        gCropSalesLCY: Decimal;
        gCropInventory: Decimal;
        gCropCOGS: Decimal;
        gTopNSalesLCY: Decimal;
        gTopNInventory: Decimal;
        gTopNCOGS: Decimal;
        gNoCaption: Text[250];
        gDescriptionCaption: Text[250];
        gSalesLCYCaption: Text[250];
        gInventoryCaption: Text[250];
        gFactor: Integer;
        gUseInvValue: Boolean;
        gFilterHold: Text[250];
        gFilterHold2: Text[250];
        gHideInventory: Boolean;
        gCOGS: Decimal;
        gShowMarginBar: Option Margin,Bar;
        gPrintToExcel: Boolean;
        grecExcelBuf: Record "Excel Buffer" temporary;
        [InDataSet]
        gExcldItemCharges: Boolean;
        TempItemEntry: Record "Item Ledger Entry" temporary;
        gDateMaxFilter: Date;
        Text000: Label 'Sorting items    #1##########';
        Text001: Label 'Period: %1';
        Text002: Label 'Ranked according to %1 %2';
        Text003: Label 'Portion of %1';
        Text004: Label 'Largest,Smallest,Sequential';
        Text005: Label 'Sales (LCY),Inventory';
        Text006: Label '*** Crop Record Not Found ***';
        Text007: Label 'Cannot hide inventory, when Show = Inventory.';
        Text101: Label 'Data';
        Text102: Label 'Crop - Top 10 List';
        Text103: Label 'Company Name';
        Text104: Label 'Report No.';
        Text105: Label 'Report Name';
        Text106: Label 'User ID';
        Text107: Label 'Date / Time';
        Text108: Label 'Ranked according to';
        Text109: Label 'Item Filters';
        Text110: Label 'This report also includes items not on inventory or that are not sold.';
        Text111: Label 'Period';
        Text112: Label 'Gross Margin';
        Text113: Label 'Gross Margin %';
        Text114: Label 'Rank';
        Text115: Label 'Value';
        Text116: Label 'Cost of Goods Sold';
        isCropOrVariety: Option Crop,Variety;
        grecVariety: Record Varieties;
        gVarietySalesLCY: Decimal;
        gVarietyInventory: Decimal;
        ReportTitle: Text[250];
        gVarietyCOGS: Decimal;

    local procedure Pct(parNumeral1: Decimal; parNumeral2: Decimal): Decimal
    begin
        if parNumeral2 = 0 then
            exit(0);
        exit(Round(parNumeral1 / parNumeral2 * 100, 0.1));
    end;

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

                  "Gen. Bus. Posting Group", "Gen. Prod. Posting Group", "Global Dimension 1 Code")

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

    local procedure CalcSalesItemCharges(var parItem: Record Item) rItemChargeCost: Decimal
    var
        lrecItemLedgEntry: Record "Item Ledger Entry";
        lrecValueEntry: Record "Value Entry";
        lrecItemLedgEntry2: Record "Item Ledger Entry";
        lrecItemCharge: Record "Item Charge";
        lCost: Decimal;
        lQuantity: Decimal;
        lCostPerUnit: Decimal;
        SeqNo: Integer;
    begin

        rItemChargeCost := 0;
        with lrecItemLedgEntry do begin
            SetCurrentKey("Item No.", "Entry Type", "Variant Code", "Drop Shipment", "Location Code", "Posting Date");
            SetRange("Entry Type", "Entry Type"::Sale);
            SetRange("Item No.", parItem."No.");
            parItem.CopyFilter("Location Filter", "Location Code");
            parItem.CopyFilter("Variant Filter", "Variant Code");
            parItem.CopyFilter("Global Dimension 1 Filter", "Global Dimension 1 Code");
            parItem.CopyFilter("Global Dimension 2 Filter", "Global Dimension 2 Code");
            parItem.CopyFilter("Date Filter", "Posting Date");
            if FindSet then
                repeat
                    rItemChargeCost += CalcItemCharges("Entry No.");
                until Next = 0;
        end;

    end;

    local procedure MakeExcelInfo()
    begin


    end;

    local procedure MakeExcelDataHeader()
    begin


    end;

    local procedure MakeExcelDataBody()
    begin


    end;

    local procedure CreateExcelbook()
    begin


    end;

    local procedure CalcInvtItemCharges(var parItem: Record Item) rItemChargeCost: Decimal
    var
        lrecItemLedgEntry: Record "Item Ledger Entry";
        lrecValueEntry: Record "Value Entry";
        lrecItemCharge: Record "Item Charge";
        lCost: Decimal;
        lQuantity: Decimal;
        lCostPerUnit: Decimal;
        lrecWarehouseEntry: Record "Warehouse Entry";
    begin

        rItemChargeCost := 0;
        with lrecItemLedgEntry do begin
            SetCurrentKey("Item No.", "Entry Type", "Variant Code", "Drop Shipment", "Location Code", "Posting Date");
            SetRange("Entry Type", "Entry Type"::Purchase);
            SetRange("Item No.", parItem."No.");
            SetFilter("Posting Date", '..%1', parItem.GetRangeMax("Date Filter"));

            parItem.CopyFilter("Location Filter", "Location Code");
            parItem.CopyFilter("Variant Filter", "Variant Code");
            parItem.CopyFilter("Global Dimension 1 Filter", "Global Dimension 1 Code");
            parItem.CopyFilter("Global Dimension 2 Filter", "Global Dimension 2 Code");
            parItem.CopyFilter("Date Filter", "Posting Date");


            if FindSet then repeat

                                parItem.SetRange("Lot No. Filter", "Lot No.");
                                parItem.CalcFields("Net Change");
                                if parItem."Net Change" > 0 then

                                    rItemChargeCost += CalcItemCharges("Entry No.");
                until Next = 0;
        end;

    end;

    procedure ______New()
    begin
    end;

    local procedure CalcItemCharges(parEntryNo: Decimal) rItemChargeCost: Decimal
    var
        lrecItemLedgEntry: Record "Item Ledger Entry";
        lrecValueEntry: Record "Value Entry";
        lrecItemLedgEntry2: Record "Item Ledger Entry";
        lrecItemCharge: Record "Item Charge";
        lCost: Decimal;
        lQuantity: Decimal;
        lCostPerUnit: Decimal;
        SeqNo: Integer;
    begin

        rItemChargeCost := 0;
        with lrecItemLedgEntry do begin
            SetRange("Entry No.", parEntryNo);
            if FindSet then repeat
                                TempItemEntry.DeleteAll;
                                FindAppliedEntry(lrecItemLedgEntry);
                                if TempItemEntry.FindSet then repeat
                                                                  lCostPerUnit := 0;
                                                                  if lrecItemCharge.FindSet then repeat
                                                                                                     lCost := 0;
                                                                                                     lQuantity := 0;
                                                                                                     lrecValueEntry.Reset;
                                                                                                     lrecValueEntry.SetCurrentKey("Item Ledger Entry No.", "Entry Type");
                                                                                                     lrecValueEntry.SetRange("Item Ledger Entry No.", TempItemEntry."Entry No.");
                                                                                                     lrecValueEntry.SetFilter("Item Charge No.", lrecItemCharge."No.");
                                                                                                     if lrecValueEntry.FindSet then
                                                                                                         repeat                                    //Sum up specific costs/quantities (including credit memos).
                                                                                                             lCost += lrecValueEntry."Cost Amount (Actual)";
                                                                                                             if lrecValueEntry."Cost Amount (Actual)" > 0
                                                                                                                then lQuantity += lrecValueEntry."Valued Quantity"
                                                                                                             else lQuantity -= lrecValueEntry."Valued Quantity";
                                                                                                         until lrecValueEntry.Next = 0;

                                                                                                     if lQuantity <> 0 then
                                                                                                         lCostPerUnit += lCost / lQuantity;          //Calculate unit cost
                                                                      until lrecItemCharge.Next = 0;

                                                                  rItemChargeCost += (TempItemEntry.Quantity) * lCostPerUnit;  //Calculate the Charge Item for the specific ILE
                                    until TempItemEntry.Next = 0;
                until Next = 0;
        end;

    end;

    local procedure FindAppliedEntry(ItemLedgEntry: Record "Item Ledger Entry")
    var
        ItemApplnEntry: Record "Item Application Entry";
        lauxQty: Decimal;
    begin

        with ItemLedgEntry do begin
            if Positive then
                if ItemLedgEntry."Entry Type" = ItemLedgEntry."Entry Type"::Purchase

                   then begin
                    ItemApplnEntry.Reset;
                    ItemApplnEntry.SetCurrentKey("Inbound Item Entry No.", "Outbound Item Entry No.", "Cost Application");
                    ItemApplnEntry.SetRange("Inbound Item Entry No.", "Entry No.");
                    ItemApplnEntry.SetFilter("Posting Date", '..%1', gDateMaxFilter);

                    if ItemApplnEntry.Find('-') then
                        repeat
                            lauxQty := lauxQty + ItemApplnEntry.Quantity;
                        until ItemApplnEntry.Next = 0;
                    InsertTempEntry(ItemApplnEntry."Inbound Item Entry No.", lauxQty);
                end


                else begin
                    ItemApplnEntry.Reset;
                    ItemApplnEntry.SetCurrentKey("Inbound Item Entry No.", "Outbound Item Entry No.", "Cost Application");
                    ItemApplnEntry.SetRange("Inbound Item Entry No.", "Entry No.");
                    ItemApplnEntry.SetFilter("Outbound Item Entry No.", '<>%1', 0);

                    if ItemApplnEntry.Find('-') then
                        repeat
                            InsertTempEntry(ItemApplnEntry."Outbound Item Entry No.", ItemApplnEntry.Quantity);
                        until ItemApplnEntry.Next = 0

                end else begin
                ItemApplnEntry.Reset;
                ItemApplnEntry.SetCurrentKey("Outbound Item Entry No.", "Item Ledger Entry No.", "Cost Application");
                ItemApplnEntry.SetRange("Outbound Item Entry No.", "Entry No.");
                ItemApplnEntry.SetRange("Item Ledger Entry No.", "Entry No.");

                if ItemApplnEntry.Find('-') then
                    repeat
                        InsertTempEntry(ItemApplnEntry."Inbound Item Entry No.", -ItemApplnEntry.Quantity);
                    until ItemApplnEntry.Next = 0;
            end;
        end;

    end;

    local procedure InsertTempEntry(EntryNo: Integer; AppliedQty: Decimal)
    var
        ItemLedgEntry: Record "Item Ledger Entry";
    begin

        ItemLedgEntry.Get(EntryNo);
        if AppliedQty * ItemLedgEntry.Quantity < 0 then
            exit;

        if not TempItemEntry.Get(EntryNo) then begin
            TempItemEntry.Init;
            TempItemEntry := ItemLedgEntry;
            TempItemEntry.Quantity := AppliedQty;
            TempItemEntry.Insert;
        end else begin
            TempItemEntry.Quantity := TempItemEntry.Quantity + AppliedQty;
            TempItemEntry.Modify;
        end;

    end;
}

