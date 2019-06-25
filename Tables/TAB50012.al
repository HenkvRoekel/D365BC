table 50012 Webservice
{

    Caption = 'Webservice';

    fields
    {
        field(50000; Webservice; Code[20])
        {
            Caption = 'Webservice';
            Description = 'webservice name';
            NotBlank = true;
        }
        field(50010; Description; Text[250])
        {
            Caption = 'Description';
        }
        field(50020; URL; Text[250])
        {
            Caption = 'URL';
        }
        field(50021; WSDL; Text[250])
        {
            Caption = 'WSDL';
        }
        field(50030; User; Text[30])
        {
            Caption = 'User';
        }
        field(50031; Password; Text[30])
        {
            Caption = 'Password';
        }
        field(50033; "Save XML to local disk"; Boolean)
        {
            Caption = 'Save XML to local disk';
        }
        field(50035; "Log result"; Boolean)
        {
            Caption = 'Log result';
        }
        field(50040; "Name Filter1"; Text[30])
        {
            Caption = 'Name Filter1';
        }
        field(50041; FilterDefault1; Text[30])
        {
            Caption = 'FilterDefault1';
        }
        field(50042; "Name Filter2"; Text[30])
        {
            Caption = 'Name Filter2';
        }
        field(50043; FilterDefault2; Text[30])
        {
            Caption = 'FilterDefault2';
        }
        field(50044; "Name Filter3"; Text[30])
        {
            Caption = 'Name Filter3';
        }
        field(50045; FilterDefault3; Text[30])
        {
            Caption = 'FilterDefault3';
        }
        field(50046; "Name Filter4"; Text[30])
        {
            Caption = 'Name Filter4';
        }
        field(50047; FilterDefault4; Text[30])
        {
            Caption = 'FilterDefault4';
        }
        field(50048; "Name Filter5"; Text[30])
        {
            Caption = 'Name Filter5';
        }
        field(50049; FilterDefault5; Text[30])
        {
            Caption = 'FilterDefault5';
        }
    }

    keys
    {
        key(Key1; Webservice)
        {
        }
    }

    fieldgroups
    {
    }
}

