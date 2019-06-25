table 50003 Grade
{

    Caption = 'Grade';

    fields
    {
        field(1; "Grade code"; Integer)
        {
            Caption = 'Grade code';
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; "Grade code")
        {
        }
    }

    fieldgroups
    {
    }
}

