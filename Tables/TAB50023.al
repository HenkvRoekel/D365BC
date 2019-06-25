table 50023 "Price List Buffer Table"
{

    Caption = 'Price List Buffer Table';

    fields
    {
        field(1; "Variety Price Group Code"; Code[30])
        {
            Caption = 'Variety Price Group Code';
        }
        field(2; "Sales Code"; Code[20])
        {
            Caption = 'Sales Code';
        }
        field(3; "Crop Code"; Code[10])
        {
            Caption = 'Crop Code';
        }
        field(4; "Crop Extension Code"; Code[5])
        {
            Caption = 'Crop Extension Code';
        }
        field(5; "Price List Instance GUID"; Guid)
        {
            Caption = 'Price List Instance GUID';
        }
        field(10; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
        }
        field(11; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
        }
        field(20; Price; Decimal)
        {
            Caption = 'Price';
        }
        field(40; "User ID"; Text[132])
        {
            Caption = 'User ID';
        }
        field(50; "Entry Date"; Date)
        {
            Caption = 'Entry Date';
        }
        field(60; "Entry Time"; Time)
        {
            Caption = 'Entry Time';
        }
    }

    keys
    {
        key(Key1; "Variety Price Group Code", "Sales Code", "Crop Extension Code", "Unit of Measure Code", "Price List Instance GUID")
        {
        }
        key(Key2; "Variety Price Group Code", "Sales Code", "Crop Code", "Crop Extension Code", "Qty. per Unit of Measure")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        Rec."User ID" := UserId();
        Rec."Entry Date" := Today();
        Rec."Entry Time" := Time();
    end;
}

