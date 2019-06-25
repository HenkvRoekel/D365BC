pageextension 90132 PostedSalesInvoiceBTPageExt extends "Posted Sales Invoice"
{


    layout
    {
        addafter("Salesperson Code")
        {
            field("<B Customer Price Group>"; "Customer Price Group")
            {
                Visible = false;
                ApplicationArea = All;
            }
        }
    }
}

