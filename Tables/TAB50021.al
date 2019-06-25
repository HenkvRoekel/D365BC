table 50021 "Variety Price Classification"
{

    Caption = 'Variety Price Classification';

    fields
    {
        field(1; "Variety Price Group Code"; Code[30])
        {
            Caption = 'Variety Price Group Code';
            NotBlank = true;
            TableRelation = "Variety Price Group";
        }
        field(3; "Sales Code"; Code[20])
        {
            Caption = 'Sales Code';
            NotBlank = true;
            TableRelation = IF ("Sales Type" = CONST ("Customer Price Group")) "Customer Price Group"
            ELSE
            IF ("Sales Type" = CONST (Customer)) Customer
            ELSE
            IF ("Sales Type" = CONST (Campaign)) Campaign;
        }
        field(4; "Variety No."; Code[5])
        {
            Caption = 'Variety No.';
            NotBlank = true;
            TableRelation = Varieties;
        }
        field(10; "Variety Description"; Text[50])
        {
            CalcFormula = Lookup (Varieties.Description WHERE ("No." = FIELD ("Variety No.")));
            Caption = 'Variety Description';
            FieldClass = FlowField;
            TableRelation = Varieties.Description;
        }
        field(20; "Crop Code"; Code[3])
        {
            CalcFormula = Lookup (Varieties."Crop Code" WHERE ("No." = FIELD ("Variety No.")));
            Caption = 'Crop Code';
            FieldClass = FlowField;
            TableRelation = Varieties."Crop Code";
        }
        field(30; "Sales Type"; Option)
        {
            Caption = 'Sales Type';
            OptionCaption = 'Customer,Customer Price Group,All Customers,Campaign';
            OptionMembers = Customer,"Customer Price Group","All Customers",Campaign;
        }
    }

    keys
    {
        key(Key1; "Variety Price Group Code", "Sales Type", "Sales Code", "Variety No.")
        {
        }
    }

    fieldgroups
    {
    }
}

