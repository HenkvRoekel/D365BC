table 50016 "Sales Terms"
{
   
    Caption = 'Sales Terms';

    fields
    {
        field(1;"Language Code";Code[10])
        {
            Caption = 'Language Code';
            TableRelation = Language;
        }
        field(2;"Entry No.";Integer)
        {
            Caption = 'Entry No.';
        }
        field(3;Description;Text[250])
        {
            Caption = 'Description';
        }
        field(4;"Description 2";Text[250])
        {
            Caption = 'Description 2';
        }
        field(5;"Description 3";Text[250])
        {
            Caption = 'Description 3';
        }
        field(6;"Description 4";Text[250])
        {
            Caption = 'Description 4';
        }
        field(7;"Description 5";Text[250])
        {
            Caption = 'Description 5';
        }
        field(8;"Description 6";Text[250])
        {
            Caption = 'Description 6';
        }
        field(9;"Description 7";Text[250])
        {
            Caption = 'Description 7';
        }
        field(10;"Description 8";Text[250])
        {
            Caption = 'Description 8';
        }
    }

    keys
    {
        key(Key1;"Language Code")
        {
        }
    }

    fieldgroups
    {
    }
}

