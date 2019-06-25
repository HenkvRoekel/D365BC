pageextension 90096 SalesCrMemoSubformBTPageExt extends "Sales Cr. Memo Subform"
{

    layout
    {
        addafter(Quantity)
        {
            field("B Lot No."; "B Lot No.")
            {
                Caption = 'Lot No.';
                Editable = false;
                ApplicationArea = All;
            }
        }
    }
}

