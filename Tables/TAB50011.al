table 50011 "Interface log"
{

    Caption = 'Interface log';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
        }
        field(10; "Process name"; Text[30])
        {
            Caption = 'Process name';
        }
        field(20; Identifier; Text[30])
        {
            Caption = 'Identifier';
        }
        field(30; "Log date"; Date)
        {
            Caption = 'Log date';
        }
        field(31; "Log time"; Time)
        {
            Caption = 'Log time';
        }
        field(32; Processed; Boolean)
        {
            Caption = 'Processed';
        }
        field(40; "Extra 1"; Text[250])
        {
            Caption = 'Extra 1';
        }
        field(41; "Extra 2"; Text[250])
        {
            Caption = 'Extra 2';
        }
        field(42; "Extra 3"; Text[250])
        {
            Caption = 'Extra 3';
        }
        field(43; "Extra 4"; Text[250])
        {
            Caption = 'Extra 4';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Log date" := Today;
        "Log time" := Time;
    end;
}

