pageextension 90143 PostedSalesInvoicesBTPageExt extends "Posted Sales Invoices"
{

    layout
    {
        addafter("Ship-to Contact")
        {
            field("<B Customer Price Group>"; "Customer Price Group")
            {
                Visible = false;
                ApplicationArea = All;
            }
        }
    }
}

