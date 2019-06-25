table 50048 "Item Extension"
{

    Caption = 'Item Extension';

    fields
    {
        field(1; Extension; Code[5])
        {
            Caption = 'Extension';
        }
        field(2; Description; Text[60])
        {
            Caption = 'Description';
        }
        field(3; "Extension Code"; Text[10])
        {
            Caption = 'Extension Code';
        }
        field(10; Language; Code[10])
        {
            Caption = 'Language';
            TableRelation = Language;
        }
    }

    keys
    {
        key(Key1; Extension, Language)
        {
        }
    }

    fieldgroups
    {
    }
}

