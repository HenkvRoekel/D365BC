table 50026 "Market Potential"
{

    fields
    {
        field(2; "Crop Variant Code"; Code[20])
        {
            Caption = 'Crop Variant Code';
            NotBlank = true;

            trigger OnValidate()
            begin
                ValidateCropCropType("Crop Variant Code", "Crop Type");

                if "Crop Variant Code" <> xRec."Crop Variant Code" then
                    GetCropCropTypeValues;
            end;
        }
        field(3; "Crop Type"; Code[20])
        {
            Caption = 'Crop Type';
            NotBlank = true;

            trigger OnValidate()
            begin
                ValidateCropCropType("Crop Variant Code", "Crop Type");

                if "Crop Type" <> xRec."Crop Type" then
                    GetCropCropTypeValues;
            end;
        }
        field(4; Year; Integer)
        {
            Caption = 'Year';

            trigger OnValidate()
            begin

                if (Year < ThisYear) or ((Year > ThisYear) and (CurrFieldNo = FieldNo(Year))) then
                    FieldError(Year);

            end;
        }
        field(5; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;
        }
        field(6; "Salesperson Code"; Code[10])
        {
            Caption = 'Salesperson Code';
            TableRelation = "Salesperson/Purchaser";
        }
        field(10; "Crop Variant Description"; Text[50])
        {
            Caption = 'Crop Variant Description';
            Editable = false;
        }
        field(20; "Crop Type Description"; Text[50])
        {
            Caption = 'Crop Type Description';
            Editable = false;
        }
        field(50; "Modification Date"; Date)
        {
            Caption = 'Modification Date';
            Editable = false;
        }
        field(100; "Conventional Acreage Current"; Decimal)
        {
            BlankZero = true;
            Caption = 'Conventional Acreage Current';
            DecimalPlaces = 0 : 0;

            trigger OnValidate()
            begin
                if "Conventional Acreage Current" <> xRec."Conventional Acreage Current" then
                    if "Conventional Acreage Future" = 0 then
                        "Conventional Acreage Future" := "Conventional Acreage Current";
            end;
        }
        field(110; "Sowing Ratio Current"; Decimal)
        {
            BlankZero = true;
            CaptionClass = '1,5,,' + fnOnCaptionClassTranslate('50026,110,0');
            Caption = 'Sowing Ratio Current';
            DecimalPlaces = 3 : 3;

            trigger OnValidate()
            begin
                if "Sowing Ratio Current" <> xRec."Sowing Ratio Current" then
                    if "Sowing Ratio Future" = 0 then
                        "Sowing Ratio Future" := "Sowing Ratio Current";
            end;
        }
        field(200; "Conventional Acreage Future"; Decimal)
        {
            BlankZero = true;
            Caption = 'Conventional Acreage Future';
            DecimalPlaces = 0 : 0;
        }
        field(210; "Sowing Ratio Future"; Decimal)
        {
            BlankZero = true;
            CaptionClass = '1,5,,' + fnOnCaptionClassTranslate('50026,210,0');
            Caption = 'Sowing Ratio Future';
            DecimalPlaces = 3 : 3;
        }
        field(230; "Organic Acreage Current"; Decimal)
        {
            BlankZero = true;
            Caption = 'Organic Acreage Current';
            DecimalPlaces = 0 : 0;

            trigger OnValidate()
            begin
                if "Organic Acreage Current" <> xRec."Organic Acreage Current" then
                    if "Organic Acreage Future" = 0 then
                        "Organic Acreage Future" := "Organic Acreage Current";
            end;
        }
        field(240; "Organic Acreage Future"; Decimal)
        {
            BlankZero = true;
            Caption = 'Organic Acreage Future';
            DecimalPlaces = 0 : 0;
        }
        field(300; "Calculation Aid 1"; Decimal)
        {
            BlankZero = true;
            Caption = 'Calculation Aid 1';
            Editable = false;
        }
        field(301; "Calculation Aid 2"; Decimal)
        {
            BlankZero = true;
            Caption = 'Calculation Aid 2';
            Editable = false;
        }
        field(302; "Calculation Aid 3"; Decimal)
        {
            BlankZero = true;
            Caption = 'Calculation Aid 3';
            Editable = false;
        }
        field(303; "Calculation Aid 4"; Decimal)
        {
            BlankZero = true;
            Caption = 'Calculation Aid 4';
            Editable = false;
        }
        field(304; "Calculation Aid 5"; Decimal)
        {
            BlankZero = true;
            Caption = 'Calculation Aid 5';
            Editable = false;
        }
        field(400; Remark; Text[50])
        {
        }
        field(1000; EmptyLine; Boolean)
        {
            Caption = 'Empty Line';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Crop Variant Code", "Crop Type", Year, "Customer No.", "Salesperson Code")
        {
            SumIndexFields = "Conventional Acreage Current", "Conventional Acreage Future", "Sowing Ratio Current", "Sowing Ratio Future";
        }
        key(Key2; Year)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Modification Date" := Today;
        AutoCalcFollowingYears;
        CalculateEmptyLine;

    end;

    trigger OnModify()
    begin
        "Modification Date" := Today;
        AutoCalcFollowingYears;
        CalculateEmptyLine;

    end;

    trigger OnRename()
    begin
        TestField("Conventional Acreage Current", 0);
    end;

    var
        Text001: Label 'The combination of Crop and Crop Type is not allowed. You can define this in the Variety table.';
        grecVariety: Record Varieties;
        grecBejoSetup: Record "Bejo Setup";
        Text002: Label 'Do you want NAV to automatically create all possible entries for %1 ?';
        Text003: Label 'You need to set a Year at least.';

    procedure GetCropCropType(ABSCropCode: Code[20]; ABSCropTypeCode: Code[20]) Success: Boolean
    begin
        Success := true;
        if (ABSCropCode <> '') and (ABSCropTypeCode <> '') then begin
            grecVariety.SetRange("Crop Variant Code", ABSCropCode);
            grecVariety.SetRange("Crop Type Code", ABSCropTypeCode);
            Success := grecVariety.FindFirst;
        end;
    end;

    procedure GetCropCropTypeValues()
    begin
        "Crop Variant Description" := grecVariety.ABSCropDescription("Crop Variant Code", '');
        "Crop Type Description" := grecVariety.ABSCropTypeDescription("Crop Type", '');
        "Sowing Ratio Current" := grecVariety.ABSCurrentSowingRate("Crop Variant Code", "Crop Type", '');
        "Sowing Ratio Future" := grecVariety.ABSFutureSowingRate("Crop Variant Code", "Crop Type", '');
    end;

    procedure ValidateCropCropType(ABSCropCode: Code[20]; ABSCropTypeCode: Code[20])
    var
        lrecVariety: Record Varieties;
    begin

        if (ABSCropCode <> '') and (ABSCropTypeCode <> '') then begin
            if not GetCropCropType(ABSCropCode, ABSCropTypeCode) then
                Error(Text001);
        end;
    end;

    local procedure AutoCalcFollowingYears()
    begin

        grecBejoSetup.Get;
        if grecBejoSetup."Auto-update Next Years" then
            CalculateFollowingYears;
    end;

    procedure CalculateFollowingYears()
    var
        lrecMarketPotentialNextYear: Record "Market Potential";
        lxRecMarketPotentialNextYear: Record "Market Potential";
        y: Integer;
        lNewYear: Integer;
    begin
        grecBejoSetup.Get;
        if grecBejoSetup."Years for Market Potential" > 0 then begin
            for y := 1 to grecBejoSetup."Years for Market Potential" do begin
                lNewYear := Year + y;

                if lNewYear > ThisYear then begin

                    if lrecMarketPotentialNextYear.Get("Crop Variant Code", "Crop Type", lNewYear, "Customer No.", "Salesperson Code") then begin
                        lxRecMarketPotentialNextYear := lrecMarketPotentialNextYear;
                    end else begin
                        Clear(lxRecMarketPotentialNextYear);
                        lrecMarketPotentialNextYear.Init;
                        lrecMarketPotentialNextYear.Validate("Crop Variant Code", "Crop Variant Code");
                        lrecMarketPotentialNextYear.Validate("Crop Type", "Crop Type");
                        lrecMarketPotentialNextYear.Validate(Year, lNewYear);
                        lrecMarketPotentialNextYear.Validate("Customer No.", "Customer No.");
                        lrecMarketPotentialNextYear.Validate("Salesperson Code", "Salesperson Code");
                        lrecMarketPotentialNextYear.Validate("Crop Variant Description", "Crop Variant Description");
                        lrecMarketPotentialNextYear.Validate("Crop Type Description", "Crop Type Description");

                        lrecMarketPotentialNextYear.Insert;
                    end;
                    lrecMarketPotentialNextYear."Modification Date" := Today;

                    lrecMarketPotentialNextYear."Conventional Acreage Current" :=
                      IncrementedValue("Conventional Acreage Current", "Conventional Acreage Future", y,
                                                                                 grecBejoSetup."Years for Market Potential", 0);


                    lrecMarketPotentialNextYear."Organic Acreage Current" :=
                      IncrementedValue("Organic Acreage Current", "Organic Acreage Current", y, grecBejoSetup."Years for Market Potential", 0);


                    lrecMarketPotentialNextYear."Sowing Ratio Current" :=
                      IncrementedValue("Sowing Ratio Current", "Sowing Ratio Future", y, grecBejoSetup."Years for Market Potential", 3);

                    lrecMarketPotentialNextYear."Conventional Acreage Future" :=
                      InTimeValue("Conventional Acreage Future", lrecMarketPotentialNextYear."Conventional Acreage Current", "Conventional Acreage Current");

                    lrecMarketPotentialNextYear."Organic Acreage Future" :=
                      InTimeValue("Organic Acreage Future", lrecMarketPotentialNextYear."Organic Acreage Current", "Organic Acreage Current");

                    lrecMarketPotentialNextYear."Sowing Ratio Future" :=
                      InTimeValue("Sowing Ratio Future", lrecMarketPotentialNextYear."Sowing Ratio Current", "Sowing Ratio Current");


                    lrecMarketPotentialNextYear.CalculateEmptyLine;

                    lrecMarketPotentialNextYear.Modify;
                end;
            end;
        end;
    end;

    local procedure IncrementedValue(BaseValue: Decimal; FinalValue: Decimal; YearNo: Integer; YearsToGo: Integer; Decimals: Integer) NewValue: Decimal
    begin

        if YearsToGo <> 0 then begin
            case Decimals of
                3:
                    NewValue := Round(BaseValue + (YearNo / YearsToGo) * (FinalValue - BaseValue), 0.001);
                else
                    NewValue := Round(BaseValue + (YearNo / YearsToGo) * (FinalValue - BaseValue), 1);
            end;
            if NewValue < 0 then
                NewValue := 0;
        end else
            NewValue := BaseValue;
    end;

    local procedure InTimeValue(OldInTime: Decimal; NewBase: Decimal; OldBase: Decimal) NewInTime: Decimal
    begin

        NewInTime := OldInTime + (NewBase - OldBase);
        if NewInTime < 0 then
            NewInTime := 0;
    end;

    procedure Prognosis(): Decimal
    var
        Result: Decimal;
    begin

        CalcPrognosis(Rec, Result);
        exit(Result);

    end;

    procedure CreateAllForAppliedFilter(lYearFilter: Integer; lCustomerFilter: Code[20]; lSalesPersonFilter: Code[10]; lCropVariantFilter: Code[20]; lCropTypeFilter: Code[20])
    var
        lrecVariety: Record Varieties;
        lrecMarketPotential: Record "Market Potential";
    begin

        if lYearFilter <> 0 then begin
            lrecVariety.Reset;

            if lCropVariantFilter <> '' then
                lrecVariety.SetRange("Crop Variant Code", lCropVariantFilter)
            else
                lrecVariety.SetFilter("Crop Variant Code", '<>%1', '');

            if lCropTypeFilter <> '' then
                lrecVariety.SetRange("Crop Type Code", lCropTypeFilter)
            else
                lrecVariety.SetFilter("Crop Type Code", '<>%1', '');

            if lrecVariety.FindSet then repeat
                                            Clear(lrecMarketPotential);
                                            if lrecMarketPotential.Get(
                                              lrecVariety."Crop Variant Code",
                                              lrecVariety."Crop Type Code",
                                              lYearFilter,
                                              lCustomerFilter,
                                              lSalesPersonFilter) then begin
                                                if (lrecMarketPotential."Conventional Acreage Current" = 0) and (lrecMarketPotential."Conventional Acreage Future" = 0) then begin
                                                    lrecMarketPotential.GetCropCropTypeValues;
                                                    lrecMarketPotential.Modify;
                                                end;
                                            end else begin
                                                lrecMarketPotential.Init;
                                                lrecMarketPotential."Crop Variant Code" := lrecVariety."Crop Variant Code";
                                                lrecMarketPotential.Validate("Crop Type", lrecVariety."Crop Type Code");
                                                lrecMarketPotential.Year := lYearFilter;
                                                lrecMarketPotential."Customer No." := lCustomerFilter;
                                                lrecMarketPotential."Salesperson Code" := lSalesPersonFilter;
                                                lrecMarketPotential."Modification Date" := Today;
                                                lrecMarketPotential.CalculateEmptyLine;
                                                lrecMarketPotential.Insert;
                                            end;
                until lrecVariety.Next = 0;
        end;

    end;

    procedure QueryCreateAllForAppliedFilter(lYearFilter: Integer; lCustomerFilter: Code[20]; lSalesPersonFilter: Code[10]; lCropVariantFilter: Code[20]; lCropTypeFilter: Code[20]): Boolean
    var
        AppliedFilter: Text[1024];
    begin

        AppliedFilter := '';

        if lYearFilter = 0 then
            Error(Text003);

        AppliedFilter := AddFilterdescription(AppliedFilter, FieldCaption(Year), Format(lYearFilter));
        AppliedFilter := AddFilterdescription(AppliedFilter, FieldCaption("Customer No."), Format(lCustomerFilter));
        AppliedFilter := AddFilterdescription(AppliedFilter, FieldCaption("Salesperson Code"), Format(lSalesPersonFilter));
        AppliedFilter := AddFilterdescription(AppliedFilter, FieldCaption("Crop Variant Code"), Format(lCropVariantFilter));
        AppliedFilter := AddFilterdescription(AppliedFilter, FieldCaption("Crop Type"), Format(lCropTypeFilter));

        if AppliedFilter <> '' then
            exit(Confirm(Text002, false, AppliedFilter))
        else
            exit(false);

    end;

    local procedure AddFilterdescription(ExistingAppliedFilter: Text[1024]; NewFilterCaption: Text[50]; NewFilterValue: Text[30]) NewAppliedFilter: Text[1024]
    begin

        NewAppliedFilter := ExistingAppliedFilter;
        if NewFilterValue <> '' then begin
            if NewAppliedFilter <> '' then
                NewAppliedFilter := NewAppliedFilter + ', ';

            NewAppliedFilter := CopyStr(NewAppliedFilter + StrSubstNo('%1 = %2', NewFilterCaption, NewFilterValue), 1, MaxStrLen(NewAppliedFilter));
        end;

    end;

    procedure CalculateEmptyLine()
    begin

        EmptyLine :=
          ("Conventional Acreage Current" = 0) and ("Conventional Acreage Future" = 0);

    end;

    local procedure fnOnCaptionClassTranslate(CaptionExpr: Text[1024]): Text[1024]
    var
        CaptionArea: Text[80];
        CaptionRef: Text[1024];
        CommaPosition: Integer;
    begin
        CommaPosition := StrPos(CaptionExpr, ',');
        if (CommaPosition > 0) and (CommaPosition < 80) then begin
            CaptionArea := CopyStr(CaptionExpr, 1, CommaPosition - 1);
            CaptionRef := CopyStr(CaptionExpr, CommaPosition + 1);
            case CaptionArea of
                '50026':
                    exit(fnMarketPotentialCapClassTransl(CaptionRef));
                '50072':
                    exit(fnMktPotCapClassTransl2(CaptionRef));
            end;
        end;
    end;

    local procedure fnMarketPotentialCapClassTransl(CaptionExpr: Text[80]) Result: Text[80]
    var
        TextInTime: Label 'in %1 yrs';
        TextHA: Label '(ha)';
        TextMIOperHA: Label '(mio/ha)';
        TextMIO: Label '(mio)';
        TextPerMIO: Label '(per mio)';
        TextOld: Label '(old)';
        TextNew: Label '(new)';
        "Text50030--1": Label 'Market Share (%)';
        "Text50030--2": Label 'Market Share (%)';
        "Text50030-100-0": Label 'Acreage';
        "Text50030-100-1": Label 'Total acreage';
        "Text50030-110-0": Label 'Sowing ratio';
        "Text50030-110-1": Label 'Total seed volume';
        "Text50030-120-0": Label 'Seed value';
        lrecBejoSetup: Record "Bejo Setup";
        lBaseCaption: Text[80];
        lUnitCaption: Text[80];
        lTextInTimeCaption: Text[80];
        lOldNewCaption: Text[80];
        lBaseCaptionExpr: Text[80];
        lUnitCaptionExpr: Text[80];
        lOldNewCaptionExpr: Text[80];
        lCommaPos: Integer;
        "Text50030-120-1": Label 'Total seed value';
        "Text50030-200-0": Label 'Acreage';
        "Text50030-200-1": Label 'Total acreage';
        "Text50030-210-0": Label 'Sowing ratio';
        "Text50030-210-1": Label 'Total seed volume';
        "Text50030-220-0": Label 'Seed value';
        "Text50030-220-1": Label 'Total seed value';
    begin

        lrecBejoSetup.Get;
        lCommaPos := StrPos(CaptionExpr, ',');
        if (lCommaPos > 0) and (lCommaPos <= MaxStrLen(lBaseCaptionExpr)) then begin
            lBaseCaptionExpr := CopyStr(CaptionExpr, 1, lCommaPos - 1);
            lUnitCaptionExpr := CopyStr(CaptionExpr, lCommaPos + 1, MaxStrLen(lUnitCaptionExpr));
        end else begin
            lBaseCaptionExpr := CopyStr(CaptionExpr, 1, MaxStrLen(lUnitCaptionExpr));
            lUnitCaptionExpr := '0,0';
        end;
        lCommaPos := StrPos(lUnitCaptionExpr, ',');
        if lCommaPos > 0 then begin
            lOldNewCaptionExpr := CopyStr(lUnitCaptionExpr, lCommaPos + 1);
            lUnitCaptionExpr := CopyStr(lUnitCaptionExpr, 1, lCommaPos - 1);
        end else begin
            lOldNewCaptionExpr := '0';
        end;
        lTextInTimeCaption := CopyStr(StrSubstNo(TextInTime, lrecBejoSetup."Years for Market Potential"), 1, MaxStrLen(lTextInTimeCaption));
        case lBaseCaptionExpr of
            '100':
                begin
                    if lUnitCaptionExpr = '1' then
                        lBaseCaption := "Text50030-100-1"
                    else
                        lBaseCaption := "Text50030-100-0";
                    lUnitCaption := TextHA;
                    lTextInTimeCaption := '';
                end;
            '110':
                begin
                    if lUnitCaptionExpr = '1' then begin
                        lBaseCaption := "Text50030-110-1";
                        lUnitCaption := TextMIO;
                    end else begin
                        lBaseCaption := "Text50030-110-0";
                        lUnitCaption := TextMIOperHA;
                    end;
                    lTextInTimeCaption := '';
                end;
            '120':
                begin
                    if lUnitCaptionExpr = '1' then begin
                        lBaseCaption := "Text50030-120-1";
                        lUnitCaption := '';
                    end else begin
                        lBaseCaption := "Text50030-120-0";
                        lUnitCaption := TextPerMIO;
                    end;
                    lTextInTimeCaption := '';
                end;
            '200':
                begin
                    if lUnitCaptionExpr = '1' then
                        lBaseCaption := "Text50030-200-1"
                    else
                        lBaseCaption := "Text50030-200-0";
                    lUnitCaption := TextHA;
                end;
            '210':
                begin
                    if lUnitCaptionExpr = '1' then begin
                        lBaseCaption := "Text50030-210-1";
                        lUnitCaption := TextMIO;
                    end else begin
                        lBaseCaption := "Text50030-210-0";
                        lUnitCaption := TextMIOperHA;
                    end;
                end;
            '220':
                begin
                    if lUnitCaptionExpr = '1' then begin
                        lBaseCaption := "Text50030-220-1";
                        lUnitCaption := ''
                    end else begin
                        lBaseCaption := "Text50030-220-0";
                        lUnitCaption := TextPerMIO;
                    end;
                end;
            '-1':
                begin
                    lBaseCaption := "Text50030--1";
                    lUnitCaption := '';
                    lTextInTimeCaption := '';
                end;
            '-2':
                begin
                    lBaseCaption := "Text50030--2";
                    lUnitCaption := '';
                end;
            else
                lBaseCaption := CaptionExpr;
        end;
        case lOldNewCaptionExpr of
            '1':
                lOldNewCaption := TextOld;
            '2':
                lOldNewCaption := TextNew;
            else
                lOldNewCaption := '';
        end;
        Result := lBaseCaption;
        if lTextInTimeCaption <> '' then
            Result := CopyStr(Result + ' ' + lTextInTimeCaption, 1, MaxStrLen(Result));
        if lUnitCaption <> '' then
            Result := CopyStr(Result + ' ' + lUnitCaption, 1, MaxStrLen(Result));
        if lOldNewCaption <> '' then
            Result := CopyStr(Result + ' ' + lOldNewCaption, 1, MaxStrLen(Result));

    end;

    local procedure fnMktPotCapClassTransl2(CaptionExpr: Text[80]) Result: Text[80]
    var
        lrecVariety: Record Varieties;
        lCommaPos: Integer;
        lCropCode: Code[20];
        lCropTypeCode: Code[20];
    begin

        lCommaPos := StrPos(CaptionExpr, ',');
        if (lCommaPos > 0) and (lCommaPos <= MaxStrLen(lCropCode)) then begin
            lCropCode := CopyStr(CaptionExpr, 1, lCommaPos - 1);
            lCropTypeCode := CopyStr(CaptionExpr, lCommaPos + 1, MaxStrLen(lCropTypeCode));
        end else begin
            lCropCode := CopyStr(CaptionExpr, 1, MaxStrLen(lCropCode));
            lCropTypeCode := '';
        end;
        lrecVariety.SetCurrentKey("Crop Variant Code", "Crop Type Code");
        lrecVariety.SetRange("Crop Variant Code", lCropCode);
        if lCropTypeCode <> '' then
            lrecVariety.SetRange("Crop Type Code", lCropTypeCode);
        if not lrecVariety.FindFirst then begin
            lrecVariety.Init;
            lrecVariety."Crop Variant Description" := lCropCode;
            lrecVariety."Crop Type Description" := lCropTypeCode;
        end;
        if lCropTypeCode = '' then
            Result := lrecVariety."Crop Variant Description"
        else
            Result := CopyStr(StrSubstNo('%1 %2', lrecVariety."Crop Variant Description", lrecVariety."Crop Type Description"),
                            1, MaxStrLen(Result));

    end;

    local procedure ThisYear() Y: Integer
    var
        YSD: Date;
        lrecBejoSetup: Record "Bejo Setup";
    begin

        lrecBejoSetup.Get;
        lrecBejoSetup.TestField("Begin Date");
        YSD := lrecBejoSetup."Begin Date";
        Y := Date2DMY(YSD, 3);
    end;

    [BusinessEvent(false)]
    local procedure CalcPrognosis(Rec: Record "Market Potential"; var Result: Decimal)
    begin

    end;
}

