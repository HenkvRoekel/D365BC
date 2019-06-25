pageextension 97023 SalesPriceWorksheetBTPageExt extends "Sales Price Worksheet"
{

    layout
    {
        addafter("Item Description")
        {
            field("B Item Description 2"; "B Item Description 2")
            {
                Caption = 'Item Description 2';
                ApplicationArea = All;
            }
        }
    }
}

