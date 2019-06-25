table 50004 Crops
{

    Caption = 'Crops';

    fields
    {
        field(1; "Crop Code"; Code[3])
        {
            Caption = 'Crop Code';
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(3; "Description English"; Text[30])
        {
            Caption = 'Description English';
        }
        field(4; "Price per Qty."; Decimal)
        {
            Caption = 'Price per Qty.';
            DecimalPlaces = 0 : 3;
        }
        field(5; "Purity % NAL"; Decimal)
        {
            Caption = 'Purity % NAL';
        }
        field(6; "Amount countingdays Nal"; Decimal)
        {
            Caption = 'Amount countingdays Nal';
        }
        field(7; "Min. amount. Seeds Nal"; Decimal)
        {
            Caption = 'Min. amount. Seeds Nal';
        }
        field(8; Weeds; Decimal)
        {
            Caption = 'Weeds';
            Description = 'BEJOWW5.01.008';
        }
        field(9; "Latin Name"; Text[50])
        {
            Caption = 'Latin Name';
            Description = 'BEJOWW5.01.008';
        }
    }

    keys
    {
        key(Key1; "Crop Code")
        {
        }
    }

    fieldgroups
    {
    }
}

