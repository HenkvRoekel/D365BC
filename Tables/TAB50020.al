table 50020 "Variety Price Group"
{

    Caption = 'Variety Price Group';

    fields
    {
        field(1; "Code"; Code[30])
        {
            Caption = 'Code';
        }
        field(10; Description; Text[30])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }
}

