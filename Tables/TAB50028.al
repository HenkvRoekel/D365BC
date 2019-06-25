table 50028 "EOSS per Item"
{

    fields
    {
        field(1; "Item No."; Code[20])
        {

            trigger OnValidate()
            var
                lrecBejoSetup: Record "Bejo Setup";
            begin
                lrecBejoSetup.Get;
                lrecBejoSetup.TestField("Begin Date");
                lrecBejoSetup.TestField("End Date");
                "Begin Date" := lrecBejoSetup."Begin Date";
                "End Date" := lrecBejoSetup."End Date";
                "Modified Date" := Today;
            end;
        }
        field(2; "Posting Date"; Date)
        {
        }
        field(3; "Document No."; Code[20])
        {
        }
        field(10; Description; Text[50])
        {
        }
        field(20; Quantity; Decimal)
        {
            DecimalPlaces = 4 : 4;
            Description = 'Qty number in millions or kg';
        }
        field(30; "Quantity in kg"; Boolean)
        {
        }
        field(40; "Begin Date"; Date)
        {
        }
        field(50; "End Date"; Date)
        {
        }
        field(60; "Modified Date"; Date)
        {
        }
        field(70; "Allocation Created"; Boolean)
        {
        }
        field(80; "Allocation Date"; Date)
        {
        }
        field(90; Exported; Boolean)
        {
        }
        field(100; "Export Date"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Item No.", "Document No.")
        {
        }
    }

    fieldgroups
    {
    }
}

