table 50002 Varieties
{

    Caption = 'Varieties';
    DataCaptionFields = "No.", Description;

    fields
    {
        field(1; "No."; Code[5])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin
                "Crop Code" := COPYSTR("No.", 1, 2);
            end;
        }
        field(2; "Dutch description"; Text[50])
        {
            Caption = 'Description Dutch';
        }
        field(21; "Search Description"; Code[20])
        {
            Caption = 'Search Description';
        }
        field(50; "Date filter"; Date)
        {
            Caption = 'Date filter';
            FieldClass = FlowFilter;
        }
        field(53; Comment; Boolean)
        {
            CalcFormula = Exist ("Comment Line" WHERE ("Table Name" = CONST (Item),
                                                      "B Comment Type" = CONST ("Var 5 pos"),
                                                      "B Variety" = FIELD ("No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(61; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(71; "Item Exist"; Boolean)
        {
            CalcFormula = Exist (Item WHERE ("B Variety" = FIELD ("No.")));
            Caption = 'Item Exist';
            Description = 'BEJOWW3.70.001';
            FieldClass = FlowField;
        }
        field(102; "Sales Comment"; Text[50])
        {
            Caption = 'Sales Comment';
        }
        field(103; "Date to be discontinued"; Date)
        {
            Caption = 'Date to be discontinued';
        }
        field(104; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
        }
        field(110; "Crop Code"; Code[3])
        {
            Caption = 'Crop Code';
            TableRelation = Crops;
        }
        field(120; "Promo Status"; Code[20])
        {
            Caption = 'Promo Status';
            TableRelation = "Promo Status";
        }
        field(121; "Promo Status Description"; Text[50])
        {
            CalcFormula = Lookup ("Promo Status".Description WHERE (Code = FIELD ("Promo Status")));
            Caption = 'Promo Status Description';
            Editable = false;
            FieldClass = FlowField;
        }
        field(130; "Old Promo Status"; Code[20])
        {
            Caption = 'OLD Promo Status';
            TableRelation = "Promo Status";
        }
        field(131; "Old Promo Status Description"; Text[50])
        {
            CalcFormula = Lookup ("Promo Status".Description WHERE (Code = FIELD ("Old Promo Status")));
            Caption = 'OLD Promo Status Description';
            Editable = false;
            FieldClass = FlowField;
        }
        field(140; "Old Blocking Code"; Code[20])
        {
            Caption = 'Old Blocking Code';
            TableRelation = "Block Code";
        }
        field(145; TSW; Decimal)
        {
            Caption = 'TSW';
            NotBlank = true;
        }
        field(150; "Year Prognosis"; Decimal)
        {
            CalcFormula = Sum ("Year Prognoses"."Quantity(period)" WHERE (Variety = FIELD ("No."),
                                                                         Date = FIELD ("Date filter")));
            Caption = 'Year Prognosis';
            DecimalPlaces = 4 : 4;
            Description = 'BEJOWW5.01.009';
            FieldClass = FlowField;
        }
        field(160; "Year Prognosis in"; Option)
        {
            Caption = 'Year Prognosis in';
            OptionCaption = 'KG,Million';
            OptionMembers = KG,Million;
        }
        field(170; "Year Prognosis Available"; Boolean)
        {
            Caption = 'Year Prognosis Available';
        }
        field(250; "Crop Variant Code"; Code[20])
        {
            Caption = 'Crop Variant Code';

            trigger OnValidate()
            begin

                IF "Crop Variant Code" <> xRec."Crop Variant Code" THEN BEGIN
                    "Crop Variant Description" := ABSCropDescription("Crop Variant Code", "No.");
                    "Sowing Ratio Current" := ABSCurrentSowingRate("Crop Variant Code", "Crop Type Code", "No.");
                    "Sowing Ratio In Future" := ABSFutureSowingRate("Crop Variant Code", "Crop Type Code", "No.");
                END;

            end;
        }
        field(251; "Crop Variant Description"; Text[50])
        {
            Caption = 'Crop Variant Description';

            trigger OnValidate()
            begin

                IF "Crop Variant Description" <> xRec."Crop Variant Description" THEN BEGIN
                    IF "Crop Variant Description" <> '' THEN
                        TESTFIELD("Crop Variant Code");

                    UpdateABSCropDescription("Crop Variant Code", "Crop Variant Description", "No.");
                END;

            end;
        }
        field(300; "Crop Type Code"; Code[20])
        {
            Caption = 'Crop Type Code';

            trigger OnValidate()
            begin

                IF "Crop Type Code" <> xRec."Crop Type Code" THEN BEGIN
                    "Crop Type Description" := ABSCropTypeDescription("Crop Type Code", "No.");
                    "Sowing Ratio Current" := ABSCurrentSowingRate("Crop Variant Code", "Crop Type Code", "No.");
                    "Sowing Ratio In Future" := ABSFutureSowingRate("Crop Variant Code", "Crop Type Code", "No.");
                END;

            end;
        }
        field(310; "Crop Type Description"; Text[50])
        {
            Caption = 'Crop Type Description';

            trigger OnValidate()
            begin

                IF "Crop Type Description" <> xRec."Crop Type Description" THEN BEGIN
                    IF "Crop Type Description" <> '' THEN
                        TESTFIELD("Crop Type Code");

                    UpdateABSCropTypeDescription("Crop Type Code", "Crop Type Description", "No.");
                END;

            end;
        }
        field(320; "Sowing Ratio Current"; Decimal)
        {
            BlankZero = true;
            CaptionClass = '1,5,,' + fnOnCaptionClassTranslate('50026,110,0');
            Caption = 'Sowing Ratio Current';
            DecimalPlaces = 3 : 3;

            trigger OnValidate()
            begin

                IF "Sowing Ratio Current" <> xRec."Sowing Ratio Current" THEN BEGIN
                    TESTFIELD("Crop Variant Code");
                    TESTFIELD("Crop Type Code");
                    UpdateCurrentABSSowingRate("Crop Variant Code", "Crop Type Code", "No.", "Sowing Ratio Current");
                END;

            end;
        }
        field(330; "Sowing Ratio In Future"; Decimal)
        {
            BlankZero = true;
            CaptionClass = '1,5,,' + fnOnCaptionClassTranslate('50026,210,0');
            Caption = 'Sowing Ratio In Future';
            DecimalPlaces = 3 : 3;

            trigger OnValidate()
            var
                lrecBejoSetup: Record "Bejo Setup";
            begin

                lrecBejoSetup.GET;
                lrecBejoSetup.TESTFIELD("Years for Market Potential");

                IF "Sowing Ratio In Future" <> xRec."Sowing Ratio In Future" THEN BEGIN
                    TESTFIELD("Crop Variant Code");
                    TESTFIELD("Crop Type Code");
                    UpdateFutureABSSowingRate("Crop Variant Code", "Crop Type Code", "No.", "Sowing Ratio In Future");
                END;

            end;
        }
        field(50140; Organic; Boolean)
        {
            Caption = 'Organic';
        }
        field(50141; "Year Prognosis Exist"; Decimal)
        {
            CalcFormula = Sum ("Year Prognoses"."Quantity(period)" WHERE (Variety = FIELD ("No.")));
            Caption = 'Year Prognoses Exist';
            Description = 'BEJOWW6.00.014';
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
        key(Key2; "Search Description")
        {
        }
        key(Key3; "Crop Variant Code", "Crop Type Code")
        {
        }
        key(Key4; "Crop Type Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        "Crop Code" := COPYSTR("No.", 1, 2);

    end;

    var
        grecBejoSetup: Record "Bejo Setup";
        Text13260: Label 'All Varieties belonging to Crop %1 %2 will be modified. Do you want to continue?';

    procedure WijzigPromostatus()
    begin
    end;

    procedure DisplayPromoStatus(): Text[250]
    begin

        IF "Promo Status" <> '' THEN BEGIN
            CALCFIELDS("Promo Status Description");
            EXIT("Promo Status" + ': ' + "Promo Status Description");
        END;
    end;

    procedure DisplayOldPromoStatus(): Text[250]
    begin

        IF "Old Promo Status" <> '' THEN BEGIN
            CALCFIELDS("Old Promo Status Description");
            EXIT("Old Promo Status" + ': ' + "Old Promo Status Description");
        END;
    end;

    procedure DisplayOldBlockingCode(): Text[250]
    var
        aBlockCode: Record "Block Code";
    begin

        IF aBlockCode.GET("Old Blocking Code") THEN
            EXIT("Old Blocking Code" + ': ' + aBlockCode.Description);
    end;

    procedure OrganicCheckmarkText() CheckMarkText: Text[1]
    begin

        CheckMarkText := '';
        IF Organic THEN
            CheckMarkText := 'v';

    end;

    procedure ABSCropDescription(CropCode: Code[20]; SkipVarietyNo: Code[5]) Result: Text[50]
    var
        lrecVariety: Record "Varieties";
    begin

        IF CropCode = '' THEN
            Result := ''
        ELSE BEGIN
            lrecVariety.SETRANGE("Crop Variant Code", CropCode);
            IF SkipVarietyNo <> '' THEN
                lrecVariety.SETFILTER("No.", '<>%1', SkipVarietyNo);
            IF lrecVariety.FINDFIRST THEN
                Result := lrecVariety."Crop Variant Description";
        END;

    end;

    procedure UpdateABSCropDescription(CropCode: Code[20]; CropDescription: Text[50]; SkipVarietyNo: Code[5])
    var
        lrecVariety: Record "Varieties";
        lrecMarketingPotential: Record "Market Potential";
    begin

        lrecVariety.SETRANGE("Crop Variant Code", CropCode);
        IF SkipVarietyNo <> '' THEN
            lrecVariety.SETFILTER("No.", '<>%1', SkipVarietyNo);
        IF NOT lrecVariety.ISEMPTY THEN
            lrecVariety.MODIFYALL("Crop Variant Description", CropDescription);

        lrecMarketingPotential.SETRANGE("Crop Variant Code", CropCode);
        IF NOT lrecMarketingPotential.ISEMPTY THEN
            lrecMarketingPotential.MODIFYALL("Crop Variant Description", CropDescription);

    end;

    procedure ABSCropTypeDescription(CropTypeCode: Code[20]; SkipVarietyNo: Code[5]) Result: Text[50]
    var
        lrecVariety: Record "Varieties";
    begin

        IF CropTypeCode = '' THEN
            Result := ''
        ELSE BEGIN
            lrecVariety.SETRANGE("Crop Type Code", CropTypeCode);
            IF SkipVarietyNo <> '' THEN
                lrecVariety.SETFILTER("No.", '<>%1', SkipVarietyNo);
            IF lrecVariety.FINDFIRST THEN
                Result := lrecVariety."Crop Type Description";
        END;

    end;

    procedure UpdateABSCropTypeDescription(CropTypeCode: Code[20]; CropTypeDescription: Text[50]; SkipVarietyNo: Code[5])
    var
        lrecVariety: Record "Varieties";
        lrecMarketingPotential: Record "Market Potential";
    begin

        lrecVariety.SETRANGE("Crop Type Code", CropTypeCode);
        IF SkipVarietyNo <> '' THEN
            lrecVariety.SETFILTER("No.", '<>%1', SkipVarietyNo);
        IF NOT lrecVariety.ISEMPTY THEN
            lrecVariety.MODIFYALL("Crop Type Description", CropTypeDescription);

        lrecMarketingPotential.SETRANGE("Crop Type", CropTypeCode);
        IF NOT lrecMarketingPotential.ISEMPTY THEN
            lrecMarketingPotential.MODIFYALL("Crop Type Description", CropTypeDescription);

    end;

    procedure ABSCurrentSowingRate(CropCode: Code[20]; CropTypeCode: Code[20]; SkipVarietyNo: Code[5]) Result: Decimal
    var
        lrecVariety: Record "Varieties";
    begin

        IF (CropCode = '') OR (CropTypeCode = '') THEN
            Result := 0
        ELSE BEGIN
            lrecVariety.SETRANGE("Crop Variant Code", CropCode);
            lrecVariety.SETRANGE("Crop Type Code", CropTypeCode);
            IF SkipVarietyNo <> '' THEN
                lrecVariety.SETFILTER("No.", '<>%1', SkipVarietyNo);
            IF lrecVariety.FINDFIRST THEN
                Result := lrecVariety."Sowing Ratio Current";
        END;

    end;

    procedure UpdateCurrentABSSowingRate(CropCode: Code[20]; CropTypeCode: Code[20]; SkipVarietyNo: Code[5]; NewSowingRate: Decimal)
    var
        lrecVariety: Record "Varieties";
    begin

        QueryUpdateABSSowingRate;
        lrecVariety.SETRANGE("Crop Variant Code", CropCode);
        lrecVariety.SETRANGE("Crop Type Code", CropTypeCode);
        IF SkipVarietyNo <> '' THEN
            lrecVariety.SETFILTER("No.", '<>%1', SkipVarietyNo);
        IF NOT lrecVariety.ISEMPTY THEN
            lrecVariety.MODIFYALL("Sowing Ratio Current", NewSowingRate);

    end;

    procedure ABSFutureSowingRate(CropCode: Code[20]; CropTypeCode: Code[20]; SkipVarietyNo: Code[5]) Result: Decimal
    var
        lrecVariety: Record "Varieties";
    begin

        IF (CropCode = '') OR (CropTypeCode = '') THEN
            Result := 0
        ELSE BEGIN
            lrecVariety.SETRANGE("Crop Variant Code", CropCode);
            lrecVariety.SETRANGE("Crop Type Code", CropTypeCode);
            IF SkipVarietyNo <> '' THEN
                lrecVariety.SETFILTER("No.", '<>%1', SkipVarietyNo);
            IF lrecVariety.FINDFIRST THEN
                Result := lrecVariety."Sowing Ratio In Future";
        END;

    end;

    procedure UpdateFutureABSSowingRate(CropCode: Code[20]; CropTypeCode: Code[20]; SkipVarietyNo: Code[5]; NewSowingRate: Decimal)
    var
        lrecVariety: Record "Varieties";
    begin

        QueryUpdateABSSowingRate;
        lrecVariety.SETRANGE("Crop Variant Code", CropCode);
        lrecVariety.SETRANGE("Crop Type Code", CropTypeCode);
        IF SkipVarietyNo <> '' THEN
            lrecVariety.SETFILTER("No.", '<>%1', SkipVarietyNo);
        IF NOT lrecVariety.ISEMPTY THEN
            lrecVariety.MODIFYALL("Sowing Ratio In Future", NewSowingRate);

    end;

    procedure QueryUpdateABSSowingRate()
    begin

        //IF NOT CONFIRM(Text13260, FALSE, "Crop Variant Description", "Crop Type Description") THEN
        //    ERROR('');

    end;

    local procedure fnOnCaptionClassTranslate(CaptionExpr: Text[1024]): Text[1024]
    var
        CaptionArea: Text[80];
        CaptionRef: Text[1024];
        CommaPosition: Integer;
    begin
        CommaPosition := STRPOS(CaptionExpr, ',');
        IF (CommaPosition > 0) AND (CommaPosition < 80) THEN BEGIN
            CaptionArea := COPYSTR(CaptionExpr, 1, CommaPosition - 1);
            CaptionRef := COPYSTR(CaptionExpr, CommaPosition + 1);
            CASE CaptionArea OF
                '50026':
                    EXIT(fnMarketPotentialCapClassTransl(CaptionRef));
                '50072':
                    EXIT(fnMktPotCapClassTransl2(CaptionRef));
            END;
        END;
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
        lrecBejoSetup: Record "BEJO Setup";
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

        lrecBejoSetup.GET;
        lCommaPos := STRPOS(CaptionExpr, ',');
        IF (lCommaPos > 0) AND (lCommaPos <= MAXSTRLEN(lBaseCaptionExpr)) THEN BEGIN
            lBaseCaptionExpr := COPYSTR(CaptionExpr, 1, lCommaPos - 1);
            lUnitCaptionExpr := COPYSTR(CaptionExpr, lCommaPos + 1, MAXSTRLEN(lUnitCaptionExpr));
        END ELSE BEGIN
            lBaseCaptionExpr := COPYSTR(CaptionExpr, 1, MAXSTRLEN(lUnitCaptionExpr));
            lUnitCaptionExpr := '0,0';
        END;
        lCommaPos := STRPOS(lUnitCaptionExpr, ',');
        IF lCommaPos > 0 THEN BEGIN
            lOldNewCaptionExpr := COPYSTR(lUnitCaptionExpr, lCommaPos + 1);
            lUnitCaptionExpr := COPYSTR(lUnitCaptionExpr, 1, lCommaPos - 1);
        END ELSE BEGIN
            lOldNewCaptionExpr := '0';
        END;
        lTextInTimeCaption := COPYSTR(STRSUBSTNO(TextInTime, lrecBejoSetup."Years for Market Potential"), 1, MAXSTRLEN(lTextInTimeCaption));
        CASE lBaseCaptionExpr OF
            '100':
                BEGIN
                    IF lUnitCaptionExpr = '1' THEN
                        lBaseCaption := "Text50030-100-1"
                    ELSE
                        lBaseCaption := "Text50030-100-0";
                    lUnitCaption := TextHA;
                    lTextInTimeCaption := '';
                END;
            '110':
                BEGIN
                    IF lUnitCaptionExpr = '1' THEN BEGIN
                        lBaseCaption := "Text50030-110-1";
                        lUnitCaption := TextMIO;
                    END ELSE BEGIN
                        lBaseCaption := "Text50030-110-0";
                        lUnitCaption := TextMIOperHA;
                    END;
                    lTextInTimeCaption := '';
                END;
            '120':
                BEGIN
                    IF lUnitCaptionExpr = '1' THEN BEGIN
                        lBaseCaption := "Text50030-120-1";
                        lUnitCaption := '';
                    END ELSE BEGIN
                        lBaseCaption := "Text50030-120-0";
                        lUnitCaption := TextPerMIO;
                    END;
                    lTextInTimeCaption := '';
                END;
            '200':
                BEGIN
                    IF lUnitCaptionExpr = '1' THEN
                        lBaseCaption := "Text50030-200-1"
                    ELSE
                        lBaseCaption := "Text50030-200-0";
                    lUnitCaption := TextHA;
                END;
            '210':
                BEGIN
                    IF lUnitCaptionExpr = '1' THEN BEGIN
                        lBaseCaption := "Text50030-210-1";
                        lUnitCaption := TextMIO;
                    END ELSE BEGIN
                        lBaseCaption := "Text50030-210-0";
                        lUnitCaption := TextMIOperHA;
                    END;
                END;
            '220':
                BEGIN
                    IF lUnitCaptionExpr = '1' THEN BEGIN
                        lBaseCaption := "Text50030-220-1";
                        lUnitCaption := ''
                    END ELSE BEGIN
                        lBaseCaption := "Text50030-220-0";
                        lUnitCaption := TextPerMIO;
                    END;
                END;
            '-1':
                BEGIN
                    lBaseCaption := "Text50030--1";
                    lUnitCaption := '';
                    lTextInTimeCaption := '';
                END;
            '-2':
                BEGIN
                    lBaseCaption := "Text50030--2";
                    lUnitCaption := '';
                END;
            ELSE
                lBaseCaption := CaptionExpr;
        END;
        CASE lOldNewCaptionExpr OF
            '1':
                lOldNewCaption := TextOld;
            '2':
                lOldNewCaption := TextNew;
            ELSE
                lOldNewCaption := '';
        END;
        Result := lBaseCaption;
        IF lTextInTimeCaption <> '' THEN
            Result := COPYSTR(Result + ' ' + lTextInTimeCaption, 1, MAXSTRLEN(Result));
        IF lUnitCaption <> '' THEN
            Result := COPYSTR(Result + ' ' + lUnitCaption, 1, MAXSTRLEN(Result));
        IF lOldNewCaption <> '' THEN
            Result := COPYSTR(Result + ' ' + lOldNewCaption, 1, MAXSTRLEN(Result));

    end;

    local procedure fnMktPotCapClassTransl2(CaptionExpr: Text[80]) Result: Text[80]
    var
        lrecVariety: Record "Varieties";
        lCommaPos: Integer;
        lCropCode: Code[20];
        lCropTypeCode: Code[20];
    begin

        lCommaPos := STRPOS(CaptionExpr, ',');
        IF (lCommaPos > 0) AND (lCommaPos <= MAXSTRLEN(lCropCode)) THEN BEGIN
            lCropCode := COPYSTR(CaptionExpr, 1, lCommaPos - 1);
            lCropTypeCode := COPYSTR(CaptionExpr, lCommaPos + 1, MAXSTRLEN(lCropTypeCode));
        END ELSE BEGIN
            lCropCode := COPYSTR(CaptionExpr, 1, MAXSTRLEN(lCropCode));
            lCropTypeCode := '';
        END;
        lrecVariety.SETCURRENTKEY("Crop Variant Code", "Crop Type Code");
        lrecVariety.SETRANGE("Crop Variant Code", lCropCode);
        IF lCropTypeCode <> '' THEN
            lrecVariety.SETRANGE("Crop Type Code", lCropTypeCode);
        IF NOT lrecVariety.FINDFIRST THEN BEGIN
            lrecVariety.INIT;
            lrecVariety."Crop Variant Description" := lCropCode;
            lrecVariety."Crop Type Description" := lCropTypeCode;
        END;
        IF lCropTypeCode = '' THEN
            Result := lrecVariety."Crop Variant Description"
        ELSE
            Result := COPYSTR(STRSUBSTNO('%1 %2', lrecVariety."Crop Variant Description", lrecVariety."Crop Type Description"),
                            1, MAXSTRLEN(Result));

    end;
}

