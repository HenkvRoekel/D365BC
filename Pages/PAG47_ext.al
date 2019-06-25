pageextension 90047 SalesInvoiceSubformBTPageExt extends "Sales Invoice Subform"
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
    }
}

