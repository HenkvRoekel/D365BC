report 50032 "Crop Statistics"
{

    DefaultLayout = RDLC;
    RDLCLayout = './RDLC/Crop Statistics.rdlc';


    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = SORTING ("B Crop", "B Variety", "No.");
            RequestFilterFields = "Date Filter", "B Salespersonfilter", "Global Dimension 1 Filter", "Global Dimension 2 Filter", "Location Filter", "B Crop", "B Variety", "No.", "B Organic", "B Extension";
            column(UserId; UserId)
            {
            }
            column(CompanyName; CompanyName)
            {
            }
            column(gFilter; gFilter)
            {
            }
            column(NoOfYear; Text012 + ': ' + Format(NoOfYear))
            {
            }
            column(PrintOptionText; text50011 + PrintOptionText)
            {
            }
            column(gBioInHeaderText; gBioInHeaderText)
            {
            }
            column(gStartDate1; Format(gStartDate[1], 0, 0))
            {
            }
            column(gStartDate2; Format(gStartDate[2], 0, 0))
            {
            }
            column(gStartDate3; Format(gStartDate[3], 0, 0))
            {
            }
            column(gStartDate4; Format(gStartDate[4], 0, 0))
            {
            }
            column(gStartDate5; Format(gStartDate[5], 0, 0))
            {
            }
            column(gEndDate1; Format(gEndDate[1], 0, 0))
            {
            }
            column(gEndDate2; Format(gEndDate[2], 0, 0))
            {
            }
            column(gEndDate3; Format(gEndDate[3], 0, 0))
            {
            }
            column(gEndDate4; Format(gEndDate[4], 0, 0))
            {
            }
            column(gEndDate5; Format(gEndDate[5], 0, 0))
            {
            }
            column(Customer_No; grecCustomer."No.")
            {
            }
            column(Customer_Name; grecCustomer.Name)
            {
            }
            column(Customer_address; grecCustomer.Address)
            {
            }
            column(Customer_PriceGroup; grecCustomer."Customer Price Group")
            {
            }
            column(Customer_CountryRegionCode; grecCustomer."Country/Region Code")
            {
            }
            column(Customer_Name2; grecCustomer."Name 2")
            {
            }
            column(Customer_City; grecCustomer.City)
            {
            }
            column(Customer_Postal; grecCustomer."Post Code")
            {
            }
            column(gNo; gNo)
            {
            }
            column(gCheck; gCheck)
            {
            }
            column(gDescription; gDescription)
            {
            }
            column(gPrintOption; gPrintOption)
            {
            }
            column(gPrintTotals; gPrintTotals)
            {
            }
            column(gPrintExcelProfit; gPrintExcelProfit)
            {
            }
            column(gPrintPromoBlock; prtexcelPSBC)
            {
            }
            column(Description2_Item; Item."Description 2")
            {
            }
            column(cropNo; cropNo)
            {
            }
            column(cropDescription; cropDescription)
            {
            }
            column(varietyNo; varietyNo)
            {
            }
            column(varietyDescription; varietyDescription)
            {
            }
            column(gSalesQty1; fnQtyInMillions(gSalesQty[1]))
            {
            }
            column(gSalesKG1; gSalesKG[1])
            {
            }
            column(gSalesLCY1; gSalesLCY[1])
            {
            }
            column(gSalesQty2; fnQtyInMillions(gSalesQty[2]))
            {
            }
            column(gSalesKG2; gSalesKG[2])
            {
            }
            column(gSalesLCY2; gSalesLCY[2])
            {
            }
            column(gSalesQty3; fnQtyInMillions(gSalesQty[3]))
            {
            }
            column(gSalesKG3; gSalesKG[3])
            {
            }
            column(gSalesLCY3; gSalesLCY[3])
            {
            }
            column(gSalesQty4; fnQtyInMillions(gSalesQty[4]))
            {
            }
            column(gSalesKG4; gSalesKG[4])
            {
            }
            column(gSalesLCY4; gSalesLCY[4])
            {
            }
            column(gSalesQty5; fnQtyInMillions(gSalesQty[5]))
            {
            }
            column(gSalesKG5; gSalesKG[5])
            {
            }
            column(gSalesLCY5; gSalesLCY[5])
            {
            }
            column(PrognosesQty; fnQtyInMillions(gPrognosesQty))
            {
            }
            column(gPrognoseKG; gPrognoseKG)
            {
            }
            column(gCountryAllocated; fnQtyInMillions(gCountryAllocated))
            {
            }
            column(gToAllocateKG; gToAllocateKG)
            {
            }
            column(text50015; text50015)
            {
            }
            column(ProfitCalculation1; ProfitCalculation(gSalesLCY[1], gCOGSLCY[1]))
            {
            }
            column(ProfitCalculation2; ProfitCalculation(gSalesLCY[2], gCOGSLCY[2]))
            {
            }
            column(ProfitCalculation3; ProfitCalculation(gSalesLCY[3], gCOGSLCY[3]))
            {
            }
            column(ProfitCalculation4; ProfitCalculation(gSalesLCY[4], gCOGSLCY[4]))
            {
            }
            column(ProfitCalculation5; ProfitCalculation(gSalesLCY[5], gCOGSLCY[5]))
            {
            }
            column(ItemPromo; (Item."B Promo Status" + ': ' + Item."B Promo Status Description"))
            {
            }
            column(ItemBlock; gcuBlockingMgt.ItemBlockDescription(Item))
            {
            }
            column(ProfitCalcVar1; ProfitCalculation(gSalesLCYTotaVariety[1], gCOGSLCYVarietyTotal[1]))
            {
            }
            column(ProfitCalcVar2; ProfitCalculation(gSalesLCYTotaVariety[2], gCOGSLCYVarietyTotal[2]))
            {
            }
            column(ProfitCalcVar3; ProfitCalculation(gSalesLCYTotaVariety[3], gCOGSLCYVarietyTotal[3]))
            {
            }
            column(ProfitCalcVar4; ProfitCalculation(gSalesLCYTotaVariety[4], gCOGSLCYVarietyTotal[4]))
            {
            }
            column(ProfitCalcVar5; ProfitCalculation(gSalesLCYTotaVariety[5], gCOGSLCYVarietyTotal[5]))
            {
            }
            column(ProfitCalcCrop1; ProfitCalculation(gSalesLCYTotaCrop[1], gCOGSLCYCropTotal[1]))
            {
            }
            column(ProfitCalcCrop2; ProfitCalculation(gSalesLCYTotaCrop[2], gCOGSLCYCropTotal[2]))
            {
            }
            column(ProfitCalcCrop3; ProfitCalculation(gSalesLCYTotaCrop[3], gCOGSLCYCropTotal[3]))
            {
            }
            column(ProfitCalcCrop4; ProfitCalculation(gSalesLCYTotaCrop[4], gCOGSLCYCropTotal[4]))
            {
            }
            column(ProfitCalcCrop5; ProfitCalculation(gSalesLCYTotaCrop[5], gCOGSLCYCropTotal[5]))
            {
            }

            trigger OnAfterGetRecord()
            var
                lUnitofMeasure: Record "Unit of Measure";
                i: Integer;
                itemSalesQty: Decimal;
                itemSalesLCY: Decimal;
                rI: Record Item;
                lcuBlockingMgt: Codeunit "Blocking Management";
            begin

                if gLastVarietyNo <> Item."B Variety" then begin
                    fnCreateVarietytotals;
                end;

                if gLastCropNo <> Item."B Crop" then begin
                    fnCreateCropTotals;
                end;

                Item.CalcFields("B Promo Status", "B Promo Status Description");
                if not lUnitofMeasure.Get("Base Unit of Measure") then
                    Error(Text50060, "Base Unit of Measure", "No.");

                grecItem.Get("No.");
                grecItem.CopyFilters(Item);
                for i := 1 to NoOfYear do begin
                    grecItem.SetRange("Date Filter", gStartDate[i], gEndDate[i]);
                    grecItem.CalcFields("Sales (Qty.)");
                    grecItem.CalcFields("Sales (LCY)");
                    if gPrintExcelProfit then
                        grecItem.CalcFields("COGS (LCY)");
                    if grecItem."Base Unit of Measure" = 'KG' then begin
                        gSalesQty[i] := 0;
                        gSalesKG[i] := grecItem."Sales (Qty.)";
                        gSalesLCY[i] := grecItem."Sales (LCY)";
                        if gPrintExcelProfit then
                            gCOGSLCY[i] := grecItem."COGS (LCY)";
                    end else begin
                        gSalesQty[i] := grecItem."Sales (Qty.)";
                        gSalesKG[i] := 0;
                        gSalesLCY[i] := grecItem."Sales (LCY)";
                        if gPrintExcelProfit then
                            gCOGSLCY[i] := grecItem."COGS (LCY)";
                    end;
                end;

                if not grecVariety.Get("B Variety") then
                    grecVariety.Init;
                gCheck := grecVariety.OrganicCheckmarkText;

                if gPrintOption = gPrintOption::"History and Prognoses" then begin
                    grecItem.SetRange("Date Filter", gStartDate[1], gEndDate[1]);
                    grecItem.CalcFields("B Prognoses");
                    grecItem.CalcFields("B Country allocated");
                    if lUnitofMeasure."B Unit in Weight" then begin
                        gPrognosesQty := 0;
                        gPrognoseKG := grecItem."B Prognoses";
                        gToAllocateKG := grecItem."B Country allocated";
                        gCountryAllocated := 0;
                    end else begin
                        gPrognosesQty := grecItem."B Prognoses";
                        gPrognoseKG := 0;
                        gToAllocateKG := 0;
                        gCountryAllocated := grecItem."B Country allocated";
                    end;
                    gPrognosesQtyTotalVariety := gPrognosesQtyTotalVariety + gPrognosesQty;
                    gPrognoseKGTotalVariety := gPrognoseKGTotalVariety + gPrognoseKG;
                    gToAllocateKGTotalVariety := gToAllocateKGTotalVariety + gToAllocateKG;
                    gCountryAllocatedTotalVariety := gCountryAllocatedTotalVariety + gCountryAllocated;

                    gPrognosesQtyTotalCrop := gPrognosesQtyTotalCrop + gPrognosesQty;
                    gPrognoseKGTotalCrop := gPrognoseKGTotalCrop + gPrognoseKG;
                    gToAllocateKGTotalCrop := gToAllocateKGTotalCrop + gToAllocateKG;
                    gCountryAllocatedTotalCrop := gCountryAllocatedTotalCrop + gCountryAllocated
                end;

                if grecItemTranslation.Get(Item."No.", '', gLanguageCode) then begin
                    Item.Description := grecItemTranslation.Description;
                    Item."Description 2" := grecItemTranslation."Description 2";
                end;


                gNo := '';
                gNoBold := '';
                gDescription := '';
                gDescription2 := '';
                gDescriptionBold := '';

                PrintQuantity :=
                  ((gSalesQty[1] <> 0) or (gSalesQty[2] <> 0) or (gSalesQty[3] <> 0) or (gSalesQty[4] <> 0) or (gSalesQty[5] <> 0) or
                  (gSalesKG[1] <> 0) or (gSalesKG[2] <> 0) or (gSalesKG[3] <> 0) or (gSalesKG[4] <> 0) or (gSalesKG[5] <> 0) or
                  (gSalesLCY[1] <> 0) or (gSalesLCY[2] <> 0) or (gSalesLCY[3] <> 0) or (gSalesLCY[4] <> 0) or (gSalesLCY[5] <> 0));


                gNo := Item."No.";
                gDescription := Item.Description;
                varietyNo := Item."B Variety";
                varietyDescription := grecVariety.Description;
                if not grecCrop.Get(Item."B Crop") then
                    grecCrop.Init;
                cropNo := Item."B Crop";
                cropDescription := grecCrop.Description;

                if not PrintQuantity then
                    CurrReport.Skip;
            end;

            trigger OnPreDataItem()
            begin
                Item.SetCurrentKey("B Crop", "B Variety", "No.");
                //CurrReport.CreateTotals(gSalesQty, gSalesKG, gSalesLCY);

                if gPrintExcelProfit then
                    CurrReport.CreateTotals(gCOGSLCY);

                if gPrintOption = gPrintOption::"History and Prognoses" then
                    CurrReport.CreateTotals(gPrognosesQty, gPrognoseKG, gCountryAllocated, gToAllocateKG);
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
                    field(PrintOption; gPrintOption)
                    {
                        Caption = 'Print Option';
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin
                            NoOfYear := 5;
                        end;
                    }
                    field(NoOfYear; NoOfYear)
                    {
                        Caption = 'No Of Year';
                        ApplicationArea = All;
                    }
                    field(PrintTotals; gPrintTotals)
                    {
                        Caption = 'Print total per';
                        ApplicationArea = All;
                    }
                    field(Language; gLanguageCode)
                    {
                        Caption = 'Language';
                        Enabled = true;
                        TableRelation = Language;
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin

                            CurrReport.Language := grecLanguage.GetLanguageID(gLanguageCode);
                        end;
                    }
                    field(InMillions; gInMillions)
                    {
                        Caption = 'Qty in millions';
                        Enabled = true;
                        ApplicationArea = All;
                    }
                    field(prtexcelPSBC; prtexcelPSBC)
                    {
                        Caption = ' + Promo Status and Blocking Code';
                        ApplicationArea = All;
                    }
                    field(gPrintExcelProfit; gPrintExcelProfit)
                    {
                        Caption = ' + Profit';
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin
            gPrintTotals := gPrintTotals::Item;
        end;
    }

    labels
    {
        lblReportName = 'Crop Statistics';
        lblNo = 'No';
        lblDescription = 'Description';
        lblSds = 'Qty. Sds.';
        lbQtylKg = 'Qty. Kg.';
        lblAmount = 'Amount';
        lblPrognoses = 'Prognoses';
        lblKg = 'Kg';
        lblAllocation = 'Allocation';
    }

    trigger OnInitReport()
    begin

        grecBejoSetup.Get;

        NoOfYear := 5;
    end;

    trigger OnPostReport()
    var
        lFormatting: Text[30];
        i: Integer;
        NumberFormat: Text[30];
    begin
    end;

    trigger OnPreReport()
    begin

        if not gPrintExcel and (prtexcelPSBC or gPrintExcelProfit) then
            gPrintExcel := true;
        if prtexcelPSBC and not (gPrintTotals = 2) then
            prtexcelPSBC := false;


        gFilter := Item.GetFilters;
        if Item.GetFilter("B Customerfilter") <> '' then begin
            if not grecCustomer.Get(Item.GetRangeMin("B Customerfilter")) then
                Clear(grecCustomer);
        end;

        case gPrintOption of
            gPrintOption::History:
                PrintOptionText := text50012;
            gPrintOption::"History and Prognoses":
                PrintOptionText := text50013;
        end;

        gStartDate[1] := Item.GetRangeMin("Date Filter");
        gEndDate[1] := Item.GetRangeMax("Date Filter");
        gStartDate[2] := CalcDate('<-1Y>', Item.GetRangeMin("Date Filter"));
        gEndDate[2] := CalcDate('<-1Y>', Item.GetRangeMax("Date Filter"));
        gStartDate[3] := CalcDate('<-2Y>', Item.GetRangeMin("Date Filter"));
        gEndDate[3] := CalcDate('<-2Y>', Item.GetRangeMax("Date Filter"));
        gStartDate[4] := CalcDate('<-3Y>', Item.GetRangeMin("Date Filter"));
        gEndDate[4] := CalcDate('<-3Y>', Item.GetRangeMax("Date Filter"));
        gStartDate[5] := CalcDate('<-4Y>', Item.GetRangeMin("Date Filter"));
        gEndDate[5] := CalcDate('<-4Y>', Item.GetRangeMax("Date Filter"));


        if gPrintTotals = gPrintTotals::Crop then
            gBioInHeaderText := ''
        else
            gBioInHeaderText := text50010;

    end;

    var
        grecCustomer: Record Customer;
        ExcelBuf: Record "Excel Buffer" temporary;
        grecItem: Record Item;
        gRecUnitofMeasure: Record "Unit of Measure";
        gcuBejoMgt: Codeunit "Bejo Management";
        gSalesQty: array[5] of Decimal;
        gSalesKG: array[5] of Decimal;
        gSalesLCY: array[5] of Decimal;
        gCOGSLCY: array[5] of Decimal;
        gPrognosesQty: Decimal;
        gCountryAllocated: Decimal;
        gPrintOption: Option History,"History and Prognoses";
        NoOfYear: Integer;
        gFilter: Text[250];
        grecVariety: Record Varieties;
        grecCrop: Record Crops;
        gPrintTotals: Option Crop,Variety,Item;
        gPrintToExcel: Boolean;
        k: Integer;
        gStartDate: array[5] of Date;
        gEndDate: array[5] of Date;
        gPrognoseKG: Decimal;
        gToAllocateKG: Decimal;
        grecItemTranslation: Record "Item Translation";
        gCheck: Text[1];
        gLanguageCode: Code[10];
        grecLanguage: Record Language;
        grecBejoSetup: Record "Bejo Setup";
        PrintOptionText: Text[30];
        PrintQuantity: Boolean;
        gDescription: Text[50];
        gDescription2: Text[50];
        gNo: Code[20];
        gDescriptionBold: Text[50];
        gNoBold: Code[20];
        gPrintExcel: Boolean;
        gPrintExcelProfit: Boolean;
        prtexcelPSBC: Boolean;
        gBioInHeaderText: Text[30];
        gInMillions: Boolean;
        Text001: Label 'Crop Statistics';
        Text002: Label 'Data';
        Text005: Label 'Company Name';
        Text006: Label 'Report No.';
        Text007: Label 'Report Name';
        Text008: Label 'User ID';
        Text009: Label 'Date';
        Text010: Label 'Item Filter';
        Text011: Label 'Period Filter';
        Text012: Label 'No of Periods';
        text50000: Label 'Crop Statistics';
        text50001: Label 'No.';
        text50002: Label 'Description';
        text50003: Label 'Qty. Seeds';
        text50004: Label 'Qty. KG';
        text50005: Label 'Amount';
        text50007: Label 'Prognoses';
        text50008: Label 'KG';
        text50009: Label 'To be allocated';
        text50010: Label 'ORG';
        text50011: Label 'Print Option: ';
        text50012: Label 'History';
        text50013: Label 'History and Prognoses';
        Text50014: Label 'Profit(%)';
        text50015: Label 'Grand Total';
        Text50016: Label 'Promo Status';
        Text50017: Label 'Blocking Code';
        Text50060: Label 'Base Unit of Measure %1 does not exist for Item %2';
        ctFileNameTitle: Label 'Export to Excel File';
        ctExtensions: Label 'Excel Files  (*.xls)|*.xls|All Files (*.*)|*.*';
        ctNoFilename: Label 'You must enter a file name.';
        ctFileExtention: Label '.xls';
        cropNo: Text;
        cropDescription: Text;
        varietyNo: Text;
        varietyDescription: Text;
        noOfItems: Integer;
        iItem: Integer;
        gSalesQtyTotalVariety: array[5] of Decimal;
        gSalesKGTotalVariety: array[5] of Decimal;
        gSalesLCYTotaVariety: array[5] of Decimal;
        gPrognosesQtyTotalVariety: Decimal;
        gPrognoseKGTotalVariety: Decimal;
        gToAllocateKGTotalVariety: Decimal;
        gCountryAllocatedTotalVariety: Decimal;
        noOfItemsInCrop: Integer;
        iCropItems: Integer;
        gPrognosesQtyTotalCrop: Decimal;
        gPrognoseKGTotalCrop: Decimal;
        gToAllocateKGTotalCrop: Decimal;
        gCountryAllocatedTotalCrop: Decimal;
        gSalesQtyTotalCrop: array[5] of Decimal;
        gSalesKGTotalCrop: array[5] of Decimal;
        gSalesLCYTotaCrop: array[5] of Decimal;
        gCOGSLCYCropTotal: array[5] of Decimal;
        gCOGSLCYVarietyTotal: array[5] of Decimal;
        gPrognosesQtyGrandTotal: Decimal;
        gPrognoseKGGrandTotal: Decimal;
        gToAllocateKGGrandTotal: Decimal;
        gCountryAllocatedGrandTotal: Decimal;
        gSalesQtyGrandTotal: array[5] of Decimal;
        gSalesKGGrandTotal: array[5] of Decimal;
        gSalesLCYGrandTotal: array[5] of Decimal;
        gCOGSLCYGrandTotal: array[5] of Decimal;
        gcuBlockingMgt: Codeunit "Blocking Management";
        gLastVarietyNo: Code[20];
        gLastCropNo: Code[10];

    procedure MakeExcelDataBodyCrop(No: Code[20]; Description: Text[250]; PromoStatus: Boolean; Bold: Boolean; AllBold: Boolean)
    var
        lcuBlockingMgt: Codeunit "Blocking Management";
        i: Integer;
        NumberFormat: Text[30];
        lFormatting: Text[30];
    begin

        for i := 1 to NoOfYear do begin
            NumberFormat := '#';
            if gSalesQtyTotalCrop[i] <> 0 then
                NumberFormat := lFormatting;
            ExcelBuf.AddColumn(fnQtyInMillions(gSalesQtyTotalCrop[i]), false, '', Bold, false, false, NumberFormat, ExcelBuf."Cell Type"::Number);
            NumberFormat := '#';
            if gSalesKGTotalCrop[i] <> 0 then
                NumberFormat := lFormatting;
            ExcelBuf.AddColumn(fnQtyInMillions(gSalesKGTotalCrop[i]), false, '', Bold, false, false, NumberFormat, ExcelBuf."Cell Type"::Number);
            NumberFormat := '#';
            if gSalesLCYTotaCrop[i] <> 0 then
                NumberFormat := lFormatting;
            ExcelBuf.AddColumn(fnQtyInMillions(gSalesLCYTotaCrop[i]), false, '', Bold, false, false, NumberFormat, ExcelBuf."Cell Type"::Number);
            if gPrintExcelProfit then
                ExcelBuf.AddColumn(Format(fnQtyInMillions(ProfitCalculation(gSalesLCYTotaCrop[i], gCOGSLCYCropTotal[i]))), false, '', AllBold, false, false, NumberFormat, ExcelBuf."Cell Type"::Number);

            gSalesQtyGrandTotal[i] := gSalesQtyGrandTotal[i] + gSalesQtyTotalCrop[i];
            gSalesKGGrandTotal[i] := gSalesKGGrandTotal[i] + gSalesKGTotalCrop[i];
            gSalesLCYGrandTotal[i] := gSalesLCYGrandTotal[i] + gSalesLCYTotaCrop[i];
            gCOGSLCYGrandTotal[i] := gCOGSLCYGrandTotal[i] + gCOGSLCYCropTotal[i];
        end;

        case gPrintOption of
            gPrintOption::History:
                begin
                end;
            gPrintOption::"History and Prognoses":
                begin
                    ExcelBuf.AddColumn('', false, '', true, false, true, '@', ExcelBuf."Cell Type"::Text);
                    NumberFormat := '#';
                    if gPrognosesQtyTotalCrop <> 0 then
                        NumberFormat := lFormatting;
                    ExcelBuf.AddColumn(fnQtyInMillions(gPrognosesQtyTotalCrop), false, '', Bold, false, false, NumberFormat, ExcelBuf."Cell Type"::Number);
                    NumberFormat := '#';
                    if gPrognoseKGTotalCrop <> 0 then
                        NumberFormat := lFormatting;
                    ExcelBuf.AddColumn(fnQtyInMillions(gPrognoseKGTotalCrop), false, '', Bold, false, false, NumberFormat, ExcelBuf."Cell Type"::Number);
                    NumberFormat := '#';
                    if gCountryAllocatedTotalCrop <> 0 then
                        NumberFormat := lFormatting;
                    ExcelBuf.AddColumn(fnQtyInMillions(gCountryAllocatedTotalCrop), false, '', Bold, false, false, NumberFormat, ExcelBuf."Cell Type"::Number);
                    NumberFormat := '#';
                    if gToAllocateKGTotalCrop <> 0 then
                        NumberFormat := lFormatting;
                    ExcelBuf.AddColumn(fnQtyInMillions(gToAllocateKGTotalCrop), false, '', Bold, false, false, NumberFormat, ExcelBuf."Cell Type"::Number);

                    gPrognosesQtyGrandTotal := gPrognosesQtyGrandTotal + gPrognosesQtyTotalCrop;
                    gPrognoseKGGrandTotal := gPrognoseKGGrandTotal + gPrognoseKGTotalCrop;
                    gToAllocateKGGrandTotal := gToAllocateKGGrandTotal + gPrognoseKGTotalCrop;
                    gCountryAllocatedGrandTotal := gCountryAllocatedGrandTotal + gCountryAllocatedTotalCrop;

                end;
        end;
    end;

    procedure ProfitCalculation(Sales: Decimal; COGS: Decimal): Decimal
    begin
        if Sales = 0 then
            exit(0.0)
        else
            exit(Round((Sales - COGS) / Sales * 100, 0.01));
    end;

    procedure fnQtyInMillions(aQtyIn: Decimal): Decimal
    begin

        if gInMillions then
            exit(aQtyIn / 1000000)
        else
            exit(aQtyIn)

    end;

    local procedure fnCreateVarietytotals()
    var
        lrecItem: Record Item;
        i: Integer;
        lSalesQty: array[5] of Decimal;
        lSalesKG: array[5] of Decimal;
        lSalesLCY: array[5] of Decimal;
        lCOGSLCY: array[5] of Decimal;
    begin

        if gLastVarietyNo <> Item."B Variety" then begin
            for i := 1 to NoOfYear do begin
                gSalesQtyTotalVariety[i] := 0;
                gSalesKGTotalVariety[i] := 0;
                gSalesLCYTotaVariety[i] := 0;
                gCOGSLCYVarietyTotal[i] := 0;
            end;
            gPrognosesQtyTotalVariety := 0;
            gPrognoseKGTotalVariety := 0;
            gToAllocateKGTotalVariety := 0;
            gCountryAllocatedTotalVariety := 0;

            gLastVarietyNo := Item."B Variety";
        end;

        lrecItem.CopyFilters(Item);
        lrecItem.SetRange("B Variety", Item."B Variety");
        if lrecItem.FindSet(false, false) then
            repeat
                i := 0;
                for i := 1 to NoOfYear do begin
                    lrecItem.SetRange("Date Filter", gStartDate[i], gEndDate[i]);
                    lrecItem.CalcFields("Sales (Qty.)");
                    lrecItem.CalcFields("Sales (LCY)");
                    lrecItem.CalcFields("COGS (LCY)");
                    if lrecItem."Base Unit of Measure" = 'KG' then begin
                        lSalesQty[i] := 0;
                        lSalesKG[i] := lrecItem."Sales (Qty.)";
                        lSalesLCY[i] := lrecItem."Sales (LCY)";
                        lCOGSLCY[i] := lrecItem."COGS (LCY)";
                    end else begin
                        lSalesQty[i] := lrecItem."Sales (Qty.)";
                        lSalesKG[i] := 0;
                        lSalesLCY[i] := lrecItem."Sales (LCY)";
                        lCOGSLCY[i] := lrecItem."COGS (LCY)";
                    end;
                    gSalesQtyTotalVariety[i] := gSalesQtyTotalVariety[i] + lSalesQty[i];
                    gSalesKGTotalVariety[i] := gSalesKGTotalVariety[i] + lSalesKG[i];
                    gSalesLCYTotaVariety[i] := gSalesLCYTotaVariety[i] + lSalesLCY[i];
                    gCOGSLCYVarietyTotal[i] := gCOGSLCYVarietyTotal[i] + lCOGSLCY[i];

                end;
            until lrecItem.Next = 0;
    end;

    local procedure fnCreateCropTotals()
    var
        lrecItem: Record Item;
        i: Integer;
        lSalesQty: array[5] of Decimal;
        lSalesKG: array[5] of Decimal;
        lSalesLCY: array[5] of Decimal;
        lCOGSLCY: array[5] of Decimal;
    begin

        if gLastCropNo <> Item."B Crop" then begin
            for i := 1 to NoOfYear do begin
                gSalesQtyTotalCrop[i] := 0;
                gSalesKGTotalCrop[i] := 0;
                gSalesLCYTotaCrop[i] := 0;
                gCOGSLCYCropTotal[i] := 0;
            end;
            gPrognosesQtyTotalCrop := 0;
            gPrognoseKGTotalCrop := 0;
            gToAllocateKGTotalCrop := 0;
            gCountryAllocatedTotalCrop := 0;

            gLastCropNo := Item."B Crop";
        end;

        lrecItem.CopyFilters(Item);
        lrecItem.SetRange("B Crop", Item."B Crop");
        if lrecItem.FindSet(false, false) then
            repeat
                i := 0;
                for i := 1 to NoOfYear do begin
                    lrecItem.SetRange("Date Filter", gStartDate[i], gEndDate[i]);
                    lrecItem.CalcFields("Sales (Qty.)");
                    lrecItem.CalcFields("Sales (LCY)");
                    lrecItem.CalcFields("COGS (LCY)");
                    if lrecItem."Base Unit of Measure" = 'KG' then begin
                        lSalesQty[i] := 0;
                        lSalesKG[i] := lrecItem."Sales (Qty.)";
                        lSalesLCY[i] := lrecItem."Sales (LCY)";
                        lCOGSLCY[i] := lrecItem."COGS (LCY)";
                    end else begin
                        lSalesQty[i] := lrecItem."Sales (Qty.)";
                        lSalesKG[i] := 0;
                        lSalesLCY[i] := lrecItem."Sales (LCY)";
                        lCOGSLCY[i] := lrecItem."COGS (LCY)";
                    end;

                    gSalesQtyTotalCrop[i] := gSalesQtyTotalCrop[i] + lSalesQty[i];
                    gSalesKGTotalCrop[i] := gSalesKGTotalCrop[i] + lSalesKG[i];
                    gSalesLCYTotaCrop[i] := gSalesLCYTotaCrop[i] + lSalesLCY[i];
                    gCOGSLCYCropTotal[i] := gCOGSLCYCropTotal[i] + lCOGSLCY[i];

                end;
            until lrecItem.Next = 0;
    end;
}

