codeunit 50016 "Market Potential Mgt."
{
    trigger OnRun()
    var
        lrecVariety: Record Varieties;
    begin
    end;

    var
        gWindow: Dialog;
        gWindowOpen: Boolean;
        gWindowPrevCrop: Code[20];
        gWindowPrevCropType: Code[20];
        gWindowTextCalculating: Label 'Calculating #1######## #2########';
        gWindowTextExporting: Label 'Exporting #1######## #2########';
        gWindowText: Text[250];
        Text000: Label 'Country Market Potential';
        Text001: Label 'No Data Available';
        grecExcelBufferTEMP: Record "Excel Buffer" temporary;
        gExcelTextFormat: Text[30];
        Text002: Label 'Some existing records will be overwritten. Do you want to continue?';

    procedure CalcPrognosis(ForCrop: Code[20]; ForCropType: Code[20]; FromDate: Date; ToDate: Date) Result: Decimal
    var
        lrecVariety: Record Varieties;
        lPrognosis: Decimal;
    begin
        Result := 0;

        lPrognosis := 0;

        lrecVariety.Reset;
        lrecVariety.SetCurrentKey("Crop Variant Code", "Crop Type Code");
        lrecVariety.SetRange("Crop Variant Code", ForCrop);
        lrecVariety.SetRange("Crop Type Code", ForCropType);
        lrecVariety.SetRange("Date filter", FromDate, ToDate);
        if lrecVariety.FindSet then repeat
                                        lrecVariety.CalcFields("Year Prognosis");

                                        if lrecVariety."Year Prognosis in" = lrecVariety."Year Prognosis in"::KG then begin
                                            lrecVariety.TestField(TSW);
                                            lPrognosis += lrecVariety."Year Prognosis" / lrecVariety.TSW;
                                        end else
                                            lPrognosis += lrecVariety."Year Prognosis";
            until lrecVariety.Next = 0;

        Result := lPrognosis;
    end;

    procedure YearStartDate(ForDate: Date) YSD: Date
    var
        lThisYearStartDate: Date;
    begin

        lThisYearStartDate := ThisYearStartDate;
        YSD := DMY2Date(Date2DMY(lThisYearStartDate, 1), Date2DMY(lThisYearStartDate, 2), Date2DMY(ForDate, 3));


        if ForDate < YSD then
            YSD := CalcDate('<-1Y>', YSD);
    end;

    procedure YearEndDate(ForDate: Date) YED: Date
    var
        lThisYearEndDate: Date;
    begin

        lThisYearEndDate := ThisYearEndDate;
        YED := DMY2Date(Date2DMY(lThisYearEndDate, 1), Date2DMY(lThisYearEndDate, 2), Date2DMY(ForDate, 3));

        if ForDate > YED then
            YED := CalcDate('<+1Y>', YED);

    end;

    procedure ThisYear() Y: Integer
    begin

        Y := Date2DMY(ThisYearStartDate, 3);

    end;

    procedure ThisYearStartDate() YSD: Date
    var
        lrecBejoSetup: Record "Bejo Setup";
    begin

        lrecBejoSetup.Get;
        lrecBejoSetup.TestField("Begin Date");
        YSD := lrecBejoSetup."Begin Date";

    end;

    procedure ThisYearEndDate() YED: Date
    var
        lrecBejoSetup: Record "Bejo Setup";
    begin

        lrecBejoSetup.Get;
        lrecBejoSetup.TestField("End Date");
        YED := lrecBejoSetup."End Date";

    end;

    procedure CalcAllNextYears(ForCrop: Code[20]; ForCropType: Code[20]; ForYear: Integer)
    var
        lrecMarketPotential: Record "Market Potential";
        lrecMarketPotential2: Record "Market Potential";
        lrecBejoSetup: Record "Bejo Setup";
    begin
        WindowInit(gWindowTextCalculating);
        lrecMarketPotential.Reset;
        lrecMarketPotential.SetCurrentKey(Year);

        if ForCrop <> '' then
            lrecMarketPotential.SetRange("Crop Variant Code", ForCrop);

        if ForCropType <> '' then
            lrecMarketPotential.SetRange("Crop Type", ForCropType);

        if ForYear <> 0 then
            lrecMarketPotential.SetRange(Year, ForYear)
        else
            lrecMarketPotential.SetRange(Year, ThisYear);

        lrecBejoSetup.Get;
        lrecMarketPotential2.Copy(lrecMarketPotential);
        if ForYear <> 0 then
            lrecMarketPotential2.SetRange(Year, ForYear + 1, ForYear + lrecBejoSetup."Years for Market Potential")
        else
            lrecMarketPotential2.SetRange(Year, ThisYear + 1, ThisYear + lrecBejoSetup."Years for Market Potential");
        if lrecMarketPotential2.FindFirst then
            if not Confirm(Text002, false) then
                Error('');

        if lrecMarketPotential.FindSet then repeat
                                                WindowUpdate(lrecMarketPotential);
                                                lrecMarketPotential.CalculateFollowingYears;
            until lrecMarketPotential.Next = 0;
        WindowClose;
    end;

    procedure ExportMarketPotential()
    var
        lrecMarketPotential: Record "Market Potential";
        lrecExcelBufferTEMP: Record "Excel Buffer" temporary;
        lrecBejoSetup: Record "Bejo Setup";
        lStartYear: Integer;
        lEndYear: Integer;
        lNumFormat: Text[30];
    begin
        REPORT.RunModal(REPORT::"Export Market Potential");

    end;

    local procedure ExportMarketPotentialLine(var lrecMarketPotential: Record "Market Potential"; NumFormat: Text[30])
    begin

        ExcelNewRow;

        with lrecMarketPotential do begin
            ExcelTextColumn("Crop Variant Code", false);
            ExcelTextColumn("Crop Variant Description", false);
            ExcelTextColumn("Crop Type", false);
            ExcelTextColumn("Crop Type Description", false);
            ExcelTextColumn(Format(Year), false);
            ExcelTextColumn("Customer No.", false);
            ExcelTextColumn("Salesperson Code", false);
            ExcelColumn("Conventional Acreage Current" + "Organic Acreage Current", false, NumFormat);
            ExcelColumn("Conventional Acreage Future" + "Organic Acreage Future", false, NumFormat);
            ExcelColumn("Sowing Ratio Current", false, NumFormat);
            ExcelColumn("Sowing Ratio Future", false, NumFormat);
        end;
    end;

    local procedure WindowInit(UseText: Text[250])
    begin

        WindowClose;
        gWindowPrevCrop := '';
        gWindowPrevCropType := '';
        gWindowText := UseText;
    end;

    local procedure WindowUpdate(lrecMarketPotential: Record "Market Potential")
    begin

        if GuiAllowed then begin
            if (gWindowPrevCrop <> lrecMarketPotential."Crop Variant Code") or (gWindowPrevCropType <> lrecMarketPotential."Crop Type") then begin
                if gWindowOpen then
                    gWindow.Update
                else begin
                    gWindow.Open(gWindowText, lrecMarketPotential."Crop Variant Code", lrecMarketPotential."Crop Type");
                    gWindowOpen := true;
                end;
                gWindowPrevCrop := lrecMarketPotential."Crop Variant Code";
                gWindowPrevCropType := lrecMarketPotential."Crop Type";
            end;
        end;
    end;

    local procedure WindowClose()
    begin

        if gWindowOpen then
            gWindow.Close;
        gWindowOpen := false;
    end;

    procedure ExcelStart()
    begin
        Clear(grecExcelBufferTEMP);
        grecExcelBufferTEMP.ClearNewRow;

        gExcelTextFormat := '@';
    end;

    procedure ExcelFinish(SheetName: Text[250]; WorkBookName: Text[250])
    var
        lExcelHelper1: Text[30];
    begin
        with grecExcelBufferTEMP do
            if FindSet then begin

            end;
    end;

    procedure ExcelColumn(Value: Variant; IsBold: Boolean; NumFormat: Text[30])
    begin

    end;

    procedure ExcelTextColumn(Text: Text[250]; IsBold: Boolean)
    begin

    end;

    procedure ExcelSkipColumns(NoOfColumnsToSkip: Integer)
    var
        lCurrentRow: Integer;
        lCurrentCol: Integer;
        lCurrentRowVariant: Variant;
        lCurrentColVariant: Variant;
    begin
        with grecExcelBufferTEMP do begin
            UTgetGlobalValue('CurrentRow', lCurrentRowVariant);
            UTgetGlobalValue('CurrentCol', lCurrentColVariant);
            lCurrentRow := lCurrentRowVariant;
            lCurrentCol := lCurrentColVariant;
            SetCurrent(lCurrentRow, lCurrentCol + NoOfColumnsToSkip);
        end;
    end;

    procedure ExcelNewRow()
    begin
        grecExcelBufferTEMP.NewRow;
    end;
}

