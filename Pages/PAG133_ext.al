pageextension 90133 PostedSalesInvoiceSFBTPageEtx extends "Posted Sales Invoice Subform"
{

    layout
    {
        addafter("No.")
        {
            field("B Line Text"; "B Line Text")
            {
                ApplicationArea = All;
            }
        }
        addafter(Description)
        {
            field("<Reason Code Bejo>"; "B Reason Code")
            {
                Visible = false;
                ApplicationArea = All;
            }
        }
    }
}

