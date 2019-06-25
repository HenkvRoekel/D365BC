table 50015 "Shipment Notification"
{

    Caption = 'Shipment Notification';

    fields
    {
        field(1; "Lot No."; Code[20])
        {
            Caption = 'Lot No.';
            TableRelation = "Lot No. Information"."Lot No.";
        }
        field(2; "Country of Origin"; Code[10])
        {
            Caption = 'Country of Origin';
            TableRelation = "Country/Region".Code;
        }
        field(3; "Phyto Certificate No."; Code[20])
        {
            Caption = 'Phyto Certificate No.';
        }
        field(4; "Date Imported"; Date)
        {
            Caption = 'Date Imported';
        }
        field(5; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
    }

    keys
    {
        key(Key1; "Lot No.", "Country of Origin")
        {
        }
    }

    fieldgroups
    {
    }
}

