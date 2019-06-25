tableextension 97023 SalesPriceWorksheetBTExt extends "Sales Price Worksheet"
{

    fields
    {
        field(50000; "B Item Description 2"; Text[50])
        {
            CalcFormula = Lookup (Item."Description 2" WHERE ("No." = FIELD ("Item No.")));

            Editable = false;
            FieldClass = FlowField;
        }
    }
}

