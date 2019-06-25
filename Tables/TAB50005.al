table 50005 "Block Entry"
{

    Caption = 'Block Entry';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; Priority; Integer)
        {
            Caption = 'Priority';
        }
        field(5; "Block Code Priority"; Integer)
        {
            Caption = 'Block Code Priority';
        }
        field(8; "Blocking Rule No."; Code[20])
        {
            Caption = 'Blocking Rule No.';
        }
        field(10; "Continent Code"; Code[10])
        {
            Caption = 'Continent Code';
        }
        field(20; "Country Code"; Code[10])
        {
            Caption = 'Country Code';
            TableRelation = "Country/Region";
        }
        field(30; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;
        }
        field(40; "Ship-to Code"; Code[10])
        {
            Caption = 'Ship-to Code';
            TableRelation = "Ship-to Address".Code WHERE ("Customer No." = FIELD ("Customer No."));
        }
        field(45; "Web Account"; Option)
        {
            Caption = 'Web Account';
            OptionCaption = ' ,No,Yes';
            OptionMembers = " ",No,Yes;
        }
        field(50; "Crop Code"; Code[10])
        {
            Caption = 'Crop Code';
            TableRelation = Crops;
        }
        field(60; "Variety Code"; Code[10])
        {
            Caption = 'Variety Code';
            TableRelation = Varieties;
        }
        field(70; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;
        }
        field(80; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = IF ("Item No." = FILTER (<> '')) "Item Unit of Measure".Code WHERE ("Item No." = FIELD ("Item No."))
            ELSE "Unit of Measure";
        }
        field(90; "Treatment Code"; Code[20])
        {
            Caption = 'Treatment Code';
            TableRelation = "Treatment Code";
        }
        field(100; "Block Code"; Code[10])
        {
            Caption = 'Block Code';
            TableRelation = "Block Code";
        }
        field(110; "Block Description"; Text[50])
        {
            CalcFormula = Lookup ("Block Code".Description WHERE (Code = FIELD ("Block Code")));
            Caption = 'Block Description';
            Editable = false;
            FieldClass = FlowField;
        }
        field(120; "Promo Status"; Code[10])
        {
            CalcFormula = Lookup (Varieties."Promo Status" WHERE ("No." = FIELD ("Variety Code")));
            Caption = 'Promo Status';
            Editable = false;
            FieldClass = FlowField;
        }
        field(130; "Promo Status Description"; Text[50])
        {
            CalcFormula = Lookup ("Promo Status".Description WHERE (Code = FIELD ("Promo Status")));
            Caption = 'Promo Status Description';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
        key(Key2; Priority, "Continent Code", "Country Code", "Customer No.", "Ship-to Code", "Crop Code", "Variety Code", "Item No.", "Unit of Measure Code", "Treatment Code")
        {
            MaintainSQLIndex = false;
        }
        key(Key3; Priority)
        {
        }
        key(Key4; "Block Code Priority", Priority)
        {
        }
        key(Key5; "Blocking Rule No.", "Country Code", "Customer No.", "Ship-to Code", "Block Code")
        {
        }
        key(Key6; "Continent Code")
        {
        }
        key(Key7; "Country Code")
        {
        }
        key(Key8; "Customer No.")
        {
        }
        key(Key9; "Ship-to Code")
        {
        }
        key(Key10; "Crop Code")
        {
        }
        key(Key11; Priority, "Country Code", "Variety Code")
        {
        }
        key(Key12; "Item No.", "Unit of Measure Code")
        {
        }
        key(Key13; "Item No.", "Treatment Code")
        {
        }
        key(Key14; "Variety Code")
        {
        }
    }

    fieldgroups
    {
    }
}

