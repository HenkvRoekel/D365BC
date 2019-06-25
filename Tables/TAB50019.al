table 50019 "Item/Unit"
{

    Caption = 'Item/Unit';

    fields
    {
        field(1; "Item No."; Code[20])
        {
            Caption = 'Item No.';

            TableRelation = Item;

            trigger OnValidate()
            begin

                Variety := CopyStr("Item No.", 1, 5);

            end;
        }
        field(3; "Unit of Measure"; Code[10])
        {
            Caption = 'Unit of Measure';
            TableRelation = IF ("Item No." = FILTER (<> '')) "Item Unit of Measure".Code WHERE ("Item No." = FIELD ("Item No."))
            ELSE
            IF ("Item No." = FILTER ('')) "Unit of Measure".Code;
        }
        field(4; Description; Text[50])
        {
            CalcFormula = Lookup (Item.Description WHERE ("No." = FIELD ("Item No.")));
            Caption = 'Description';
            Editable = false;
            FieldClass = FlowField;
        }
        field(10; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(15; "Sales Person Filter"; Code[20])
        {
            Caption = 'Sales Person Filter';
            FieldClass = FlowFilter;
            TableRelation = "Salesperson/Purchaser";
        }
        field(16; "Customer Filter"; Code[10])
        {
            Caption = 'Customer Filter';
            FieldClass = FlowFilter;
            TableRelation = Customer;
        }
        field(17; "Unit of Measure Filter"; Code[10])
        {
            Caption = 'Unit of Measure Filter';
            FieldClass = FlowFilter;
            TableRelation = "Unit of Measure";
        }
        field(21; Invoiced; Decimal)
        {
            CalcFormula = Sum ("Item Ledger Entry"."Invoiced Quantity" WHERE ("Item No." = FIELD ("Item No."),
                                                                            "Unit of Measure Code" = FIELD ("Unit of Measure"),
                                                                             "Posting Date" = FIELD ("Date Filter"),
                                                                             "Entry Type" = CONST (Sale),
                                                                             "Source No." = FIELD ("Customer Filter"),
                                                                             "B Salesperson" = FIELD ("Sales Person Filter")));
            Caption = 'Invoiced';
            FieldClass = FlowField;
        }
        field(22; Prognoses; Decimal)
        {
            CalcFormula = Sum ("Prognosis/Allocation Entry".Prognoses WHERE ("Item No." = FIELD ("Item No."),
                                                                            "Unit of Measure" = FIELD ("Unit of Measure"),
                                                                            "Sales Date" = FIELD ("Date Filter"),
                                                                            Salesperson = FIELD ("Sales Person Filter"),
                                                                            Customer = FIELD ("Customer Filter"),
                                                                            "Purchase Date" = FIELD ("Date Filter Previous Year")));
            Caption = 'Prognoses';
            Description = 'BEJOWW5.0.006 the same as 20';
            FieldClass = FlowField;
        }
        field(23; "Prognoses to Order"; Decimal)
        {
            CalcFormula = Sum ("Prognosis/Allocation Entry".Prognoses WHERE ("Item No." = FIELD ("Item No."),
                                                                            "Unit of Measure" = FIELD ("Unit of Measure"),
                                                                            "Purchase Date" = FIELD ("Date Filter"),
                                                                            Salesperson = FIELD ("Sales Person Filter"),
                                                                            Customer = FIELD ("Customer Filter"),
                                                                            "Sales Date" = FIELD ("Date Filter Previous Year")));
            Caption = 'Prognoses to Order';
            Description = 'BEJOWW5.0.012';
            FieldClass = FlowField;
        }
        field(25; Variety; Code[5])
        {
            Caption = 'Variety';
        }
        field(30; Allocated; Decimal)
        {
            CalcFormula = Sum ("Prognosis/Allocation Entry".Allocated WHERE ("Item No." = FIELD ("Item No."),
                                                                            "Sales Date" = FIELD ("Date Filter"),
                                                                            Salesperson = FIELD ("Sales Person Filter")));
            Caption = 'Allocated';
            FieldClass = FlowField;
        }
        field(40; "Promo Status"; Code[20])
        {
            CalcFormula = Lookup (Varieties."Promo Status" WHERE ("No." = FIELD (Variety)));
            Caption = 'Promo Status';
            Description = 'BEJOWW5.01.009';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Promo Status";
        }
        field(41; "Promo Status Description"; Text[50])
        {
            CalcFormula = Lookup ("Promo Status".Description WHERE (Code = FIELD ("Promo Status")));
            Caption = 'Promo Status Description';
            Description = 'BEJOWW5.01.009';
            Editable = false;
            FieldClass = FlowField;
        }
        field(100; Organic; Boolean)
        {
            CalcFormula = Lookup (Varieties.Organic WHERE ("No." = FIELD (Variety)));
            Caption = 'Organic';
            Description = 'BEJOWW5.0.007';
            FieldClass = FlowField;
        }
        field(110; "Search Description"; Code[35])
        {
            CalcFormula = Lookup (Item."Search Description" WHERE ("No." = FIELD ("Item No.")));
            Caption = 'Search Description';
            Description = 'BEJOWW5.0.007';
            Editable = false;
            FieldClass = FlowField;
        }
        field(120; "Sales Previous Year"; Decimal)
        {
            CalcFormula = Sum ("Item Ledger Entry"."Invoiced Quantity" WHERE ("Item No." = FIELD ("Item No."),
                                                                             "Unit of Measure Code" = FIELD ("Unit of Measure"),
                                                                             "Posting Date" = FIELD ("Date Filter Previous Year"),
                                                                             "Entry Type" = CONST (Sale),
                                                                             "Source No." = FIELD ("Customer Filter"),
                                                                             "B Salesperson" = FIELD ("Sales Person Filter")));
            Caption = 'Sales Previous Year';
            Description = 'BEJOWW5.0.007';
            Editable = false;
            FieldClass = FlowField;
        }
        field(121; "Sales Estimate Current Year"; Decimal)
        {
            Caption = 'Sales Estimate Current Year';
            Description = 'BEJOWW5.0.007';
            Editable = false;

            trigger OnLookup()
            begin
                "Sales Estimate Current Year" := Prognoses + Invoiced
            end;
        }
        field(122; "Production Forecast Year+1"; Decimal)
        {
            Caption = 'Production Forecast Year+1';
            Description = 'BEJOWW5.0.007';
        }
        field(123; "Production Forecast Year+2"; Decimal)
        {
            Caption = 'Production Forecast Year+2';
            Description = 'BEJOWW5.0.007';
        }
        field(124; "Production Forecast Year+3"; Decimal)
        {
            Caption = 'Production Forecast Year+3';
            Description = 'BEJOWW5.0.007';
        }
        field(125; "Production Forecast Year+4"; Decimal)
        {
            Caption = 'Production Forecast Year+4';
            Description = 'BEJOWW5.0.007';
        }
        field(126; "Production Forecast Year+5"; Decimal)
        {
            Caption = 'Production Forecast Year+5';
            Description = 'BEJOWW5.0.007';
        }
        field(127; "Date Filter Previous Year"; Date)
        {
            Caption = 'Date Filter Previous Year';
            Description = 'BEJOWW5.0.007';
            FieldClass = FlowFilter;
        }
    }

    keys
    {
        key(Key1; "Item No.", "Unit of Measure")
        {
        }
        key(Key2; Variety)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        BejoSetup: Record "Bejo Setup";
    begin

        BejoSetup.Get;
        SetRange("Date Filter", BejoSetup."Begin Date", CalcDate('<+5Y>', BejoSetup."Begin Date"));
        CalcFields(Prognoses);
        if Prognoses <> 0 then begin
            if not Confirm(text50001, true) then
                Error(text50002);
        end;
    end;

    trigger OnInsert()
    begin

        Variety := CopyStr("Item No.", 1, 5);

    end;

    var
        gRecBejoSetup: Record "Bejo Setup";
        text50001: Label 'There are existing prognoses, do you want to continue?';
        text50002: Label 'Nothing deleted!';

    procedure CreateItemUnit("Item No.": Code[20]; "Unit Of Measure Code": Code[10]) New: Boolean
    var
        lItemUnit: Record "Item/Unit";
    begin

        if "Item No." = '' then
            exit;
        if "Unit Of Measure Code" = '' then
            exit;

        if not BejoItem("Item No.") then
            exit;

        if lItemUnit.Get("Item No.", "Unit Of Measure Code") then
            exit;

        lItemUnit."Item No." := "Item No.";
        lItemUnit."Unit of Measure" := "Unit Of Measure Code";
        lItemUnit.Variety := CopyStr("Item No.", 1, 5);
        lItemUnit.Insert;

        New := true;
    end;

    procedure DisplayPromoStatus(): Text[250]
    begin

        if "Promo Status" <> '' then begin
            CalcFields("Promo Status Description");
            exit("Promo Status" + ': ' + "Promo Status Description");
        end;
    end;

    procedure BejoItem("No.": Code[20]) BejoItemOK: Boolean
    var
        lVarInteger: Integer;
    begin

        if ("No." > '00000000') and ("No." < '92999999') and
           (StrLen("No.") = 8) and
           Evaluate(lVarInteger, "No.") then
            BejoItemOK := true;
    end;
}

