table 50013 "Treatment Code"
{


    Caption = 'Treament Code';

    fields
    {
        field(1; "Treatment Code"; Code[10])
        {
            Caption = 'Treatment Code';
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(3; "Not Chemically Treated"; Boolean)
        {
            Caption = 'Not Chemically Treated';
        }
        field(4; "Description Reports"; Text[50])
        {
            Caption = 'Description reports';
        }
    }

    keys
    {
        key(Key1; "Treatment Code")
        {
        }
    }

    fieldgroups
    {
    }
}

