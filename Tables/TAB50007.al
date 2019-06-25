table 50007 "Promo Status"
{
    Caption = 'Promo Status';

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[50])
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

    trigger OnInsert()
    begin
        TESTFIELD(Code);
    end;

    procedure DisplayDescription(): Text[250]
    begin
        // - BEJOWW5.01.009 ---
        EXIT(Code + ': ' + Description);
    end;
}

