pageextension 90139 PostedPurchInvoiceSFBTPageExt extends "Posted Purch. Invoice Subform"
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

