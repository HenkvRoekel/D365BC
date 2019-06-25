tableextension 97002 SalesPriceBTExt extends "Sales Price"
{

    fields
    {
        field(50010; "B Item Description"; Text[50])
        {
            CalcFormula = Lookup (Item.Description WHERE ("No." = FIELD ("Item No.")));
            Caption = 'Item Description';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50015; "B Item Description 2"; Text[50])
        {
            CalcFormula = Lookup (Item."Description 2" WHERE ("No." = FIELD ("Item No.")));
            Caption = 'Item Description 2';
            Editable = false;
            FieldClass = FlowField;
        }
    }
}

