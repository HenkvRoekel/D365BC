table 50025 "Internal Promostatus Entry"
{


    Caption = 'Internal Promostatus Entry';

    fields
    {
        field(1; "Variety Code"; Code[5])
        {
            Caption = 'Variety Code';
            NotBlank = true;
            TableRelation = Varieties;

            trigger OnValidate()
            begin

                CalcFields("Variety Description");

            end;
        }
        field(2; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            NotBlank = false;
            TableRelation = Item WHERE ("B Variety" = FIELD ("Variety Code"));

            trigger OnValidate()
            begin
                TestField("Variety Code");

                CalcFields("Item Description");

            end;
        }
        field(4; Salesperson; Code[10])
        {
            Caption = 'Salesperson';
            NotBlank = false;
            TableRelation = "Salesperson/Purchaser";

            trigger OnValidate()
            begin

                TestField("Variety Code");
                CalcFields("Salesperson Name");

            end;
        }
        field(5; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            NotBlank = false;
            TableRelation = Customer;

            trigger OnValidate()
            begin
                TestField(Salesperson);
                CalcFields("Customer Name");
            end;
        }
        field(10; "Internal Promo Status Code"; Code[20])
        {
            Caption = 'Internal Promo Status';
            TableRelation = "Promo Status";

            trigger OnValidate()
            begin
                CalcFields("Internal Promo Status Descr.");
            end;
        }
        field(100; "User ID"; Code[20])
        {
            Caption = 'User ID';
            Editable = false;
            TableRelation = User;
            ValidateTableRelation = false;
        }
        field(101; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(200; "Customer Name"; Text[50])
        {
            CalcFormula = Lookup (Customer.Name WHERE ("No." = FIELD ("Customer No.")));
            Caption = 'Customer Name';

            Editable = false;
            FieldClass = FlowField;
        }
        field(201; "Item Description"; Text[35])
        {
            CalcFormula = Lookup (Item.Description WHERE ("No." = FIELD ("Item No.")));
            Caption = 'Item Description';

            Editable = false;
            FieldClass = FlowField;
        }
        field(202; "Internal Promo Status Descr."; Text[50])
        {
            CalcFormula = Lookup ("Promo Status".Description WHERE (Code = FIELD ("Internal Promo Status Code")));
            Caption = 'Internal Promo Status Description';
            Editable = false;
            FieldClass = FlowField;
        }
        field(203; "Variety Description"; Text[50])
        {
            CalcFormula = Lookup (Varieties.Description WHERE ("No." = FIELD ("Variety Code")));
            Caption = 'Variety Description';

            Editable = false;
            FieldClass = FlowField;
        }
        field(205; "Salesperson Name"; Text[50])
        {
            CalcFormula = Lookup ("Salesperson/Purchaser".Name WHERE (Code = FIELD (Salesperson)));
            Caption = 'Salesperson Name';

            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Variety Code", Salesperson, "Customer No.", "Item No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        UpdateModificationData;
    end;

    trigger OnModify()
    begin
        UpdateModificationData;
    end;

    trigger OnRename()
    begin
        UpdateModificationData;

    end;

    var
        Text001: Label 'This record can not be renamed.';

    local procedure UpdateModificationData()
    begin
        "User ID" := CopyStr(UserId, 1, MaxStrLen("User ID"));
        "Last Date Modified" := Today;
    end;
}

