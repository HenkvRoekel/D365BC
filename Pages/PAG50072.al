page 50072 "Year Prog Market Pot Subf"
{

    Caption = 'Market Potential Subform';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = ListPart;
    SourceTable = "Market Potential";
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field(Year; Year)
                {
                    ApplicationArea = All;
                }
                field("Customer No."; "Customer No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Salesperson Code"; "Salesperson Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("""Conventional Acreage Current"" + ""Organic Acreage Current"""; "Conventional Acreage Current" + "Organic Acreage Current")
                {
                    Caption = 'Acreage Current';
                    ApplicationArea = All;
                }
                field("Calculation Aid 3"; "Calculation Aid 3")
                {
                    BlankZero = true;
                    Caption = 'Total Market Potential(mil sds)';
                    ApplicationArea = All;
                }
                field("Calculation Aid 1"; "Calculation Aid 1")
                {
                    Caption = 'TotalPrognPer CropType (mil sds)';
                    DecimalPlaces = 0 : 4;
                    ApplicationArea = All;
                }
                field("Calculation Aid 2"; "Calculation Aid 2")
                {
                    Caption = 'Progno/Market Potential (%)';
                    DecimalPlaces = 0 : 2;
                    ApplicationArea = All;
                }
                field("Calculation Aid 4"; "Calculation Aid 4")
                {
                    Caption = 'Sales  (mil sds)';
                    ApplicationArea = All;
                }
                field("Calculation Aid 5"; "Calculation Aid 5")
                {
                    Caption = 'Sales/Market Potential (%)';
                    DecimalPlaces = 0 : 2;
                    ApplicationArea = All;
                }
                field("Crop Variant Code"; "Crop Variant Code")
                {
                    ApplicationArea = All;
                }
                field("Crop Variant Description"; "Crop Variant Description")
                {
                    ApplicationArea = All;
                }
                field("Crop Type"; "Crop Type")
                {
                    ApplicationArea = All;
                }
                field("Crop Type Description"; "Crop Type Description")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    var
        gcduMarketPotentialMgt: Codeunit "Market Potential Mgt.";
        grecBejoSetup: Record "Bejo Setup";
        gFromYear: Integer;
        gToYear: Integer;
        Text001: Label 'Calculating Market Potential for Crop / Crop Type #1### #2### #3##';
        SalesDateFilter: Text;

    procedure GetData(CropCode: Code[20]; CropTypeCode: Code[20]; FromYear: Integer)
    var
        lrecVariety: Record Varieties;
        lrecMarketPotential: Record "Market Potential";
        i: Integer;
        lWindow: Dialog;
        lrecItemUnit: Record "Item/Unit";
        lrecUoM: Record "Unit of Measure";
    begin
        grecBejoSetup.Get;
        if grecBejoSetup."Years for Market Potential" = 0 then
            grecBejoSetup."Years for Market Potential" := 5;

        if FromYear <> 0 then
            gFromYear := FromYear
        else begin
            gFromYear := gcduMarketPotentialMgt.ThisYear;
        end;

        gToYear := gFromYear + grecBejoSetup."Years for Market Potential";

        Reset;

        if (CropCode <> '') or (CropTypeCode <> '') then begin
            for i := gFromYear to gToYear do begin
                if not Get(CropCode, CropTypeCode, i, '', '') then begin
                    if GuiAllowed then
                        lWindow.Open(Text001, CropCode, CropTypeCode, i);

                    Init;
                    "Crop Variant Code" := CropCode;
                    "Crop Type" := CropTypeCode;
                    Year := i;
                    "Customer No." := '';
                    "Salesperson Code" := '';
                    "Crop Variant Description" := lrecVariety.ABSCropDescription("Crop Variant Code", '');
                    "Crop Type Description" := lrecVariety.ABSCropTypeDescription("Crop Type", '');
                    "Calculation Aid 1" := Prognosis();
                    Insert;

                    lrecMarketPotential.SetRange("Crop Variant Code", CropCode);
                    lrecMarketPotential.SetRange("Crop Type", CropTypeCode);
                    lrecMarketPotential.SetRange(Year, i);
                    if lrecMarketPotential.FindSet then repeat
                                                            "Conventional Acreage Current" += lrecMarketPotential."Conventional Acreage Current";
                                                            "Sowing Ratio Current" += lrecMarketPotential."Sowing Ratio Current";
                                                            "Calculation Aid 3" += lrecMarketPotential."Conventional Acreage Current" * lrecMarketPotential."Sowing Ratio Current";
                                                            "Conventional Acreage Future" += lrecMarketPotential."Conventional Acreage Future";
                                                            "Sowing Ratio Future" += lrecMarketPotential."Sowing Ratio Future";
                        until lrecMarketPotential.Next = 0;


                    lrecVariety.SetRange("Crop Type Code", "Crop Type");
                    lrecVariety.SetRange("Crop Variant Code", "Crop Variant Code");
                    if lrecVariety.FindSet then repeat
                                                    lrecItemUnit.Reset;
                                                    lrecItemUnit.SetCurrentKey(Variety);
                                                    lrecItemUnit.SetRange(Variety, lrecVariety."No.");
                                                    lrecItemUnit.SetFilter("Date Filter", SalesDateFilter);
                                                    GetSalesDateFilter();
                                                    lrecItemUnit.SetFilter("Unit of Measure", '<>%1', '');
                                                    if lrecItemUnit.FindFirst then repeat
                                                                                       if lrecUoM.Get(lrecItemUnit."Unit of Measure") then begin
                                                                                           lrecItemUnit.CalcFields(Invoiced);

                                                                                           if lrecUoM."B Unit in Weight" and (lrecVariety.TSW > 0) then begin

                                                                                               "Calculation Aid 4" := "Calculation Aid 4" - (lrecItemUnit.Invoiced / lrecVariety.TSW);
                                                                                           end else begin
                                                                                               "Calculation Aid 4" := "Calculation Aid 4" - lrecItemUnit.Invoiced / 1000000;
                                                                                           end;
                                                                                       end;
                                                        until lrecItemUnit.Next = 0;
                        until lrecVariety.Next = 0;


                    if ("Conventional Acreage Current" * "Sowing Ratio Current") = 0 then begin
                        "Calculation Aid 2" := 0;
                        "Calculation Aid 5" := 0;
                    end else begin

                        "Calculation Aid 2" := 100 * "Calculation Aid 1" / "Calculation Aid 3";
                        "Calculation Aid 5" := 100 * "Calculation Aid 4" / "Calculation Aid 3";
                    end;

                    Modify;
                    if GuiAllowed then
                        lWindow.Close;
                end;
            end;

        end;

        SetRange("Crop Variant Code", CropCode);
        SetRange("Crop Type", CropTypeCode);
        SetRange(Year, gFromYear, gToYear);

        if not FindFirst then;
        CurrPage.Update(false);
    end;

    procedure RefreshData(CropCode: Code[20]; CropTypeCode: Code[20]; FromYear: Integer)
    var
        i: Integer;
    begin

        grecBejoSetup.Get;
        if grecBejoSetup."Years for Market Potential" = 0 then
            grecBejoSetup."Years for Market Potential" := 5;

        if FromYear <> 0 then
            gFromYear := FromYear
        else begin

            gFromYear := gcduMarketPotentialMgt.ThisYear;

        end;

        gToYear := gFromYear + grecBejoSetup."Years for Market Potential";

        Reset;

        if (CropCode <> '') or (CropTypeCode <> '') then begin
            for i := gFromYear to gToYear do begin
                SetRange("Crop Variant Code", CropCode);
                SetRange("Crop Type", CropTypeCode);
                SetRange(Year, i);
                DeleteAll;
            end;
        end;

        GetData(CropCode, CropTypeCode, FromYear);

    end;

    local procedure GetSalesDateFilter()
    var
        StartDatePrevYear: Date;
        EndDatePrevYear: Date;
    begin

        StartDatePrevYear := CalcDate('-1Y', grecBejoSetup."Begin Date");
        EndDatePrevYear := CalcDate('-1Y', grecBejoSetup."End Date");
        SalesDateFilter := StrSubstNo('%1..%2', StartDatePrevYear, EndDatePrevYear);
    end;
}

