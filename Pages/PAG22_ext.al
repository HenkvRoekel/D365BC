pageextension 90022 CustomerListBTPageExt extends "Customer List"
{

    layout
    {
        addafter("Salesperson Code")
        {
            field("<B VAT Registration No.>"; "VAT Registration No.")
            {
                Visible = false;
                ApplicationArea = All;
            }
        }
    }
}

