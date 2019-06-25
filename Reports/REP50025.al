report 50025 "Price List Bejo"
{

    DefaultLayout = RDLC;
    RDLCLayout = './RDLC/Price List Bejo.rdlc';


    dataset
    {
        dataitem("Variety Price Classification"; "Variety Price Classification")
        {
            CalcFields = "Crop Code";
            DataItemTableView = SORTING ("Variety Price Group Code", "Sales Type", "Sales Code", "Variety No.") ORDER(Ascending);
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Sales Type", "Sales Code", "Variety Price Group Code", "Variety No.";
            RequestFilterHeading = 'Variety Price Group, Sales Code Filter';
            dataitem("Variety Price Group"; "Variety Price Group")
            {
                DataItemLink = Code = FIELD ("Variety Price Group Code");
                DataItemTableView = SORTING (Code) ORDER(Ascending);

                trigger OnAfterGetRecord()
                begin
                    gIsNextVarietyPriceGroup := true;
                end;
            }
            dataitem(Varieties; Varieties)
            {
                CalcFields = "Promo Status Description";
                DataItemLink = "No." = FIELD ("Variety No.");
                DataItemTableView = SORTING ("No.") ORDER(Ascending);
                dataitem(Item; Item)
                {
                    DataItemLink = "B Variety" = FIELD ("No.");
                    DataItemTableView = SORTING ("B Crop", "B Variety", "No.") ORDER(Ascending);
                    PrintOnlyIfDetail = true;
                    RequestFilterFields = "No.", "B Crop Extension";
                    RequestFilterHeading = 'Item Filter';
                    dataitem("Crop Extension Description"; "Crop Extension Description")
                    {
                        DataItemLink = "Crop Code" = FIELD ("B Crop"), Extension = FIELD ("B Crop Extension");
                        DataItemTableView = SORTING ("Crop Code", Extension, Language) ORDER(Ascending);
                        RequestFilterFields = Language, Extension;

                        trigger OnAfterGetRecord()
                        begin

                            if "Crop Extension Description".GetFilter(Language) = '' then begin
                                "Crop Extension Description".SetRange(Language, gLanguage);
                            end;
                        end;
                    }
                    dataitem("Sales Price"; "Sales Price")
                    {
                        DataItemLink = "Item No." = FIELD ("No.");
                        DataItemTableView = SORTING ("Item No.", "Sales Type", "Sales Code", "Starting Date", "Unit Price", "Unit of Measure Code") ORDER(Ascending);
                        RequestFilterFields = "Starting Date", "Ending Date";
                        RequestFilterHeading = 'Sales Price, Date Filter';

                        trigger OnAfterGetRecord()
                        var
                            lrecSalesPrice: Record "Sales Price";
                            lIsLastSalesPriceForUOM: Boolean;
                            lCount: Integer;
                            lDummy: Integer;
                        begin

                            if gExportToExcel and gIsNextVariety then begin
                                if gIsNewVarietyPriceGroup then begin
                                    fnWriteExcelVarietyGroupHeader();
                                    gIsNewVarietyPriceGroup := false;
                                end;
                                if "Variety Price Classification"."Sales Code" = gFirstSalesCode then begin
                                    fnWriteExcelVarietyHeader();
                                end;
                                gIsNextVariety := false;
                            end;


                            if gNumberOfSalesCode = 1 then begin
                                if ("Unit of Measure Code" <> gPreviousUOM) then begin
                                    gSalesPriceArrayIndex := 0;
                                    gPreviousUOM := "Unit of Measure Code";
                                end;

                                if (gSalesPriceArrayIndex > 0) then
                                    if (gUnitPrice[gSalesPriceArrayIndex] <> "Unit Price") then
                                        Error(Text50201, "Item No.", "Unit of Measure Code", "Sales Code");


                                gSalesPriceArrayIndex += 1;
                                gMinQuantity[gSalesPriceArrayIndex] := "Minimum Quantity";
                                gUnitPrice[gSalesPriceArrayIndex] := "Unit Price";

                                lrecSalesPrice.Copy("Sales Price");
                                if lrecSalesPrice.Next <> 0 then begin
                                    if "Unit of Measure Code" <> lrecSalesPrice."Unit of Measure Code" then
                                        lIsLastSalesPriceForUOM := true;
                                end else begin
                                    lIsLastSalesPriceForUOM := true;
                                end;


                                if gExportToExcel and lIsLastSalesPriceForUOM then begin
                                    fnWriteExcelUOMDataRow();
                                end;

                                if not lIsLastSalesPriceForUOM then
                                    CurrReport.Skip;
                            end;

                            if gNumberOfSalesCode > 1 then begin
                                if ("Unit of Measure Code" <> gPreviousUOM) then begin
                                    gSalesPriceArrayIndex := 0;
                                    gPreviousUOM := "Unit of Measure Code";

                                end;

                                lCount := 1;
                                while lCount <= gNumberOfSalesCode do begin
                                    gMinQuantity[lCount] := 0;
                                    gUnitPrice[lCount] := 0;
                                    lCount += 1;
                                end;

                                lrecSalesPrice.Copy("Sales Price");
                                lrecSalesPrice.SetCurrentKey("Item No.", "Sales Type", "Sales Code", "Starting Date", "Unit Price", "Unit of Measure Code");
                                lrecSalesPrice.SetFilter("Sales Code", grecTempVarietyPriceClas.GetFilter("Sales Code"));
                                lrecSalesPrice.SetRange("Unit of Measure Code", "Sales Price"."Unit of Measure Code");
                                repeat
                                    lCount := 1;
                                    while lCount <= gNumberOfSalesCode do begin
                                        if lrecSalesPrice."Sales Code" = gSalesCode[lCount] then begin
                                            gMinQuantity[lCount] := lrecSalesPrice."Minimum Quantity";
                                            if gUnitPrice[lCount] <> 0 then
                                                Error(Text50201, lrecSalesPrice."Item No.", lrecSalesPrice."Unit of Measure Code", lrecSalesPrice."Sales Code")
                                            else
                                                gUnitPrice[lCount] := lrecSalesPrice."Unit Price";
                                        end;
                                        lCount += 1;
                                    end;
                                until lrecSalesPrice.Next = 0;

                                Clear(lrecSalesPrice);
                                lrecSalesPrice.Copy("Sales Price");
                                if lrecSalesPrice.Next <> 0 then begin
                                    if "Unit of Measure Code" <> lrecSalesPrice."Unit of Measure Code" then
                                        lIsLastSalesPriceForUOM := true;
                                end else begin
                                    lIsLastSalesPriceForUOM := true;
                                end;

                                if gExportToExcel and lIsLastSalesPriceForUOM then begin
                                    fnWriteExcelUOMDataRow();
                                end;

                                if not lIsLastSalesPriceForUOM then
                                    CurrReport.Skip;
                            end;


                        end;

                        trigger OnPreDataItem()
                        begin


                            SetFilter("Sales Code", '%1', gFirstSalesCode);

                            if GetFilter("Starting Date") = '' then
                                SetRange("Starting Date", gValidFromDate);
                            if GetFilter("Ending Date") = '' then
                                SetRange("Ending Date", gValidToDate);
                        end;
                    }

                    trigger OnAfterGetRecord()
                    begin

                        Clear(gPreviousUOM);
                        Clear(gUnitPrice);

                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    gIsNextVariety := true;
                end;
            }
            dataitem("Price List Buffer Table"; "Price List Buffer Table")
            {
                DataItemLink = "Variety Price Group Code" = FIELD ("Variety Price Group Code"), "Sales Code" = FIELD ("Sales Code");
                DataItemTableView = SORTING ("Variety Price Group Code", "Sales Code", "Crop Code", "Crop Extension Code", "Qty. per Unit of Measure") ORDER(Ascending);

                trigger OnAfterGetRecord()
                var
                    lrecCropExtension: Record "Crop Extension Description";
                    lrecPriceListBufferTable: Record "Price List Buffer Table";
                    lCount: Integer;
                begin

                    if gIsLastVarietyPriceGroup then begin

                        if not gDataColumnCaptionsWritten then begin
                            fnWriteDataColumnCaptions();
                            gDataColumnCaptionsWritten := true;
                        end;

                        lCount := 1;

                        gExcelRow += 1;

                        EnterCell(gExcelRow, 1, "Price List Buffer Table"."Crop Extension Code", false, false, '@', ExcelBuffer."Cell Type"::Text);

                        if lrecCropExtension.Get("Crop Code", "Crop Extension Code", gLanguage) then
                            EnterCell(gExcelRow, 3, lrecCropExtension.Description, false, false, '@', ExcelBuffer."Cell Type"::Text);
                        EnterCell(gExcelRow, 7, "Price List Buffer Table"."Unit of Measure Code", false, false, '@', ExcelBuffer."Cell Type"::Text);
                        while lCount <= gNumberOfSalesCode do begin
                            lrecPriceListBufferTable.SetRange("Variety Price Group Code", "Price List Buffer Table"."Variety Price Group Code");
                            lrecPriceListBufferTable.SetRange("Crop Code", "Price List Buffer Table"."Crop Code");
                            lrecPriceListBufferTable.SetRange("Crop Extension Code", "Price List Buffer Table"."Crop Extension Code");
                            lrecPriceListBufferTable.SetRange("Unit of Measure Code", "Price List Buffer Table"."Unit of Measure Code");
                            lrecPriceListBufferTable.SetRange("Price List Instance GUID", "Price List Buffer Table"."Price List Instance GUID");
                            lrecPriceListBufferTable.SetRange("Sales Code", gSalesCode[lCount]);
                            if lrecPriceListBufferTable.FindFirst then begin
                                EnterCell(gExcelRow, 8 + lCount, Format(lrecPriceListBufferTable.Price, 0, 1), false, false, '@', ExcelBuffer."Cell Type"::Number);
                            end;
                            lCount += 1;
                        end;
                    end;
                end;

                trigger OnPreDataItem()
                begin
                    "Price List Buffer Table".SetRange("Price List Buffer Table"."Price List Instance GUID", gInstanceGUID);
                end;
            }

            trigger OnAfterGetRecord()
            var
                lrecVarietyPriceClass: Record "Variety Price Classification";
            begin

                gIsNextVarPriceClassification := true;

                lrecVarietyPriceClass.Copy("Variety Price Classification");
                lrecVarietyPriceClass.SetRange("Variety Price Group Code", "Variety Price Classification"."Variety Price Group Code");
                if lrecVarietyPriceClass.Next = 0 then begin
                    gIsLastVarietyPriceGroup := true;
                    gDataColumnCaptionsWritten := false;
                end else
                    gIsLastVarietyPriceGroup := false;

                if (gLastVarPriceGroupCode = '')
                    or (gLastVarPriceGroupCode < "Variety Price Classification"."Variety Price Group Code") then begin
                    gIsNewVarietyPriceGroup := true;
                end;

                if gLastVarPriceGroupCode <> "Variety Price Classification"."Variety Price Group Code" then
                    gVarietyPriceGroupWritten := false
                else
                    gVarietyPriceGroupWritten := true;

                gLastVarPriceGroupCode := "Variety Price Classification"."Variety Price Group Code";

                if gFirstSalesCode = '' then
                    gFirstSalesCode := "Variety Price Classification"."Sales Code";
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
                    field(gExportToExcel; gExportToExcel)
                    {
                        Caption = 'Export to Excel';
                        Visible = false;
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
    }

    trigger OnInitReport()
    var
        lDummyPriceValue: Text[30];
        lDecimalSeparator: Text[1];
    begin
        gExportToExcel := true;
        gInstanceGUID := CreateGuid();


        lDummyPriceValue := Format(9.99, 0, 1);
        lDecimalSeparator := CopyStr(lDummyPriceValue, (StrLen(lDummyPriceValue) - 2), 1);
        gNumberFormat := '0' + lDecimalSeparator + '00';
    end;

    trigger OnPostReport()
    var
        lrecPriceListBufferTable: Record "Price List Buffer Table";
        lrecBejoSetup: Record "Bejo Setup";
        lFileName: Text[250];
    begin

        lrecBejoSetup.Get();
        lFileName := lrecBejoSetup."Export Path";
        lFileName += Text50000;
        lFileName += '.xlsx';

        //if gExportToExcel then begin
        //    ExcelBuffer.CreateBook(lFileName, Text50000);
        //    ExcelBuffer.WriteSheet(Text50000, CompanyInfo.Name, UserId);
        //    ExcelBuffer.CloseBook;
        //    ExcelBuffer.OpenExcel();

        //end;


        lrecPriceListBufferTable.SetRange("Price List Instance GUID", gInstanceGUID);
        lrecPriceListBufferTable.DeleteAll;
    end;

    trigger OnPreReport()
    var
        lrecBejoSetup: Record "Bejo Setup";
        lrecGenLedgerSetup: Record "General Ledger Setup";
        lrecLanguage: Record Language;
        lrecPriceListBufferTable: Record "Price List Buffer Table";
        lrecPriceListBuffer: Record "Price List Buffer Table";
    begin
        CompanyInfo.Get;


        ExcelBuffer.DeleteAll;


        lrecPriceListBuffer.SetFilter("Entry Date", '<%1', CalcDate('<-2D>', Today));
        if lrecPriceListBuffer.FindSet then
            lrecPriceListBuffer.DeleteAll;

        gTextValidFromDate := "Sales Price".GetFilter("Starting Date");
        gTextValidToDate := "Sales Price".GetFilter("Ending Date");
        gValidFromDate := "Sales Price".GetRangeMin("Starting Date");
        gValidToDate := "Sales Price".GetRangeMax("Ending Date");

        grecTempVarietyPriceClas.SetFilter("Sales Code", "Variety Price Classification".GetFilter("Sales Code"));

        gCaptionColumnUOM := Text50200;
        fnCreateDataColumnCaptions;

        if lrecBejoSetup.Get then;
        if gTextValidFromDate = '' then begin
            gValidFromDate := lrecBejoSetup."Begin Date";
            gTextValidFromDate := Format(gValidFromDate);
        end;

        if gTextValidToDate = '' then begin
            gValidToDate := lrecBejoSetup."End Date";
            gTextValidToDate := Format(gValidToDate);
        end;

        gTxtValidFromToDate := Text50014 + ' ' + gTextValidFromDate + ' ' + Text50015 + ' ' + gTextValidToDate;

        if lrecGenLedgerSetup.Get then;
        if "Sales Price".GetFilter("Currency Code") = '' then begin
            gCurrencyCode := lrecGenLedgerSetup."LCY Code";
            gTxtAllPackages := Text50013 + ' ' + gCurrencyCode
        end else begin
            gCurrencyCode := "Sales Price".GetFilter("Currency Code");
            gTxtAllPackages := Text50013 + ' ' + gCurrencyCode;
        end;

        gLanguage := "Crop Extension Description".GetFilter(Language);
        if gLanguage = '' then begin
            lrecLanguage.SetCurrentKey(Code);
            lrecLanguage.SetRange("Windows Language ID", CurrReport.Language);
            if lrecLanguage.FindFirst then begin
                gLanguage := lrecLanguage.Code;
            end;
        end;


        if gExportToExcel then begin

            EnterCell(1, 1, Text50000, true, false, '@', ExcelBuffer."Cell Type"::Text);
            EnterCell(1, 2, '', true, false, '@', ExcelBuffer."Cell Type"::Text);
            EnterCell(1, 3, Format("Variety Price Classification".GetFilter("Sales Code")), true, false, '@', ExcelBuffer."Cell Type"::Text);
            EnterCell(1, 15, Format(Today), true, false, '@', ExcelBuffer."Cell Type"::Text);

            EnterCell(4, 1, gTxtAllPackages, true, false, '@', ExcelBuffer."Cell Type"::Text);
            EnterCell(5, 1, gTxtValidFromToDate, true, false, '@', ExcelBuffer."Cell Type"::Text);


            gExcelRow := 7;
        end;
    end;

    var
        gValidFromDate: Date;
        gValidToDate: Date;
        gTextValidFromDate: Text[30];
        gTextValidToDate: Text[30];
        gNumberFormat: Text[30];
        gCurrencyCode: Code[10];
        gLanguage: Code[10];
        grecTempVarietyPriceClas: Record "Variety Price Classification" temporary;
        gMinQuantity: array[6] of Decimal;
        gUnitPrice: array[6] of Decimal;
        gSalesPriceArrayIndex: Integer;
        gPreviousUOM: Code[10];
        gExportToExcel: Boolean;
        gFileName: Text[250];
        gExcelRow: Integer;
        gIsNextVariety: Boolean;
        gVarietyPriceGroupWritten: Boolean;
        gIsNewVarietyPriceGroup: Boolean;
        gIsNextVarietyPriceGroup: Boolean;
        gIsNextVarPriceClassification: Boolean;
        gLastVarPriceGroupCode: Code[30];
        gTxtAllPackages: Text[250];
        gTxtValidFromToDate: Text[250];
        gNumberOfSalesCode: Integer;
        gSalesCode: array[6] of Code[30];
        gCaptionColumnUOM: Text[30];
        gCaptionColumnData: array[6] of Text[30];
        gInstanceGUID: Guid;
        gIsLastVarietyPriceGroup: Boolean;
        gDataColumnCaptionsWritten: Boolean;
        gFirstSalesCode: Code[20];
        Text50000: Label 'PriceList';
        Text50011: Label 'Price';
        Text50013: Label 'All prices mentioned are per package and in';
        Text50014: Label 'Valid from';
        Text50015: Label 'until';
        Text50050: Label 'File name';
        Text50200: Label 'Unit of Measure';
        Text50201: Label 'Error: there is a second price for Item %1, %2 in Variety Price Group %3. ';
        Text50202: Label 'Error: all sales prices for Sales Code %1, Variety Price Group %2 (%3), Extension %4 and Package %5 should be the same.';
        Text50300: Label 'No filename supplied for the export to excel.';
        ExcelBuffer: Record "Excel Buffer";
        CompanyInfo: Record "Company Information";
        sFile: File;
        sStream: OutStream;

    procedure fnCreateDataColumnCaptions()
    var
        lrecCustomerPriceGroup: Record "Customer Price Group";
        lCount: Integer;
    begin
        lrecCustomerPriceGroup.SetFilter(lrecCustomerPriceGroup.Code, "Variety Price Classification".GetFilter("Sales Code"));
        if lrecCustomerPriceGroup.FindSet(false) then
            gNumberOfSalesCode := lrecCustomerPriceGroup.Count;

        if gNumberOfSalesCode > 6 then gNumberOfSalesCode := 6;

        if gNumberOfSalesCode = 1 then begin
            gCaptionColumnData[1] := Text50011;
            gSalesCode[1] := lrecCustomerPriceGroup.Code;
        end;

        if gNumberOfSalesCode > 1 then begin
            repeat
                lCount += 1;
                gCaptionColumnData[lCount] := lrecCustomerPriceGroup.Code;
                gSalesCode[lCount] := lrecCustomerPriceGroup.Code;
            until lrecCustomerPriceGroup.Next = 0;
        end;
    end;

    procedure fnWriteExcelVarietyGroupHeader()
    begin
        gExcelRow += 1;
        EnterCell(gExcelRow, 1, "Variety Price Classification"."Crop Code" + ' ' + "Variety Price Group".Description, true, false, '@', ExcelBuffer."Cell Type"::Text);
    end;

    procedure fnWriteExcelVarietyHeader()
    begin
        gExcelRow += 1;
        EnterCell(gExcelRow, 1, Varieties."No.", false, false, '@', ExcelBuffer."Cell Type"::Text);
        EnterCell(gExcelRow, 3, Varieties.Description, false, false, '@', ExcelBuffer."Cell Type"::Text);
        EnterCell(gExcelRow, 5, Varieties."Promo Status Description", false, false, '@', ExcelBuffer."Cell Type"::Text);
    end;

    procedure fnWriteExcelUOMDataRow()
    var
        lrecPriceListBuffer: Record "Price List Buffer Table";
        lrecItemUOM: Record "Item Unit of Measure";
        lCount: Integer;
        lrecDoublePriceListBuffer: Record "Price List Buffer Table";
    begin
        lCount := 1;
        while lCount <= gNumberOfSalesCode do begin
            with lrecPriceListBuffer do begin
                Init;
                "Variety Price Group Code" := "Variety Price Classification"."Variety Price Group Code";

                "Sales Code" := gSalesCode[lCount];
                "Crop Code" := "Variety Price Classification"."Crop Code";
                "Crop Extension Code" := Item."B Crop Extension";

                "Unit of Measure Code" := "Sales Price"."Unit of Measure Code";
                if lrecItemUOM.Get("Sales Price"."Item No.", "Sales Price"."Unit of Measure Code") then
                    "Qty. per Unit of Measure" := lrecItemUOM."Qty. per Unit of Measure";

                Price := gUnitPrice[lCount];
                "Price List Instance GUID" := gInstanceGUID;


                if Insert(true) then begin
                    Commit;
                end else begin

                    if lrecDoublePriceListBuffer.Get("Variety Price Group Code", "Sales Code", "Crop Extension Code",
                                                    "Unit of Measure Code", "Price List Instance GUID") then begin
                        if lrecDoublePriceListBuffer.Price <> Price then begin
                            Error(Text50202, "Sales Code", "Variety Price Group".Code, "Variety Price Group".Description,
                               "Crop Extension Description".Extension, "Unit of Measure Code");
                        end;
                    end;
                end;
                lCount += 1;
            end;
        end;
    end;

    procedure fnWriteDataColumnCaptions()
    begin
        gExcelRow += 1;

        EnterCell(gExcelRow, 7, gCaptionColumnUOM, false, false, '@', ExcelBuffer."Cell Type"::Text);
        EnterCell(gExcelRow, 9, '    ' + gCaptionColumnData[1], false, false, '@', ExcelBuffer."Cell Type"::Text);
        EnterCell(gExcelRow, 10, '    ' + gCaptionColumnData[2], false, false, '@', ExcelBuffer."Cell Type"::Text);

        EnterCell(gExcelRow, 11, '    ' + gCaptionColumnData[3], false, false, '@', ExcelBuffer."Cell Type"::Text);
        EnterCell(gExcelRow, 12, '    ' + gCaptionColumnData[4], false, false, '@', ExcelBuffer."Cell Type"::Text);

        EnterCell(gExcelRow, 13, '    ' + gCaptionColumnData[5], false, false, '@', ExcelBuffer."Cell Type"::Text);
        EnterCell(gExcelRow, 14, '    ' + gCaptionColumnData[6], false, false, '@', ExcelBuffer."Cell Type"::Text);
    end;

    local procedure EnterCell(RowNo: Integer; ColumnNo: Integer; CellValue: Text[250]; Bold: Boolean; UnderLine: Boolean; NumberFormat: Text[30]; CellType: Option)
    begin
        ExcelBuffer.Init;
        ExcelBuffer.Validate("Row No.", RowNo);
        ExcelBuffer.Validate("Column No.", ColumnNo);
        ExcelBuffer."Cell Value as Text" := CellValue;
        ExcelBuffer.Formula := '';
        ExcelBuffer.Bold := Bold;
        ExcelBuffer.Underline := UnderLine;
        ExcelBuffer.NumberFormat := NumberFormat;
        ExcelBuffer."Cell Type" := CellType;
        ExcelBuffer.Insert;
    end;
}

