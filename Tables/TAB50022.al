table 50022 "Crop Extension Description"
{

    Caption = 'Crop Extension Description';

    fields
    {
        field(1; "Crop Code"; Code[3])
        {
            Caption = 'Crop Code';
            NotBlank = true;
            TableRelation = Crops;
        }
        field(2; Extension; Code[5])
        {
            Caption = 'Extension';
            NotBlank = true;
        }
        field(3; Language; Code[10])
        {
            Caption = 'Language';
            Description = 'NotBlank set to NO';
            NotBlank = false;
            TableRelation = Language;
        }
        field(10; Description; Text[60])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; "Crop Code", Extension, Language)
        {
        }
    }

    fieldgroups
    {
    }
}

