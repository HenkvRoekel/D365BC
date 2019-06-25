pageextension 90137 PostedPurchaseRcptSFBTPageExt extends "Posted Purchase Rcpt. Subform"
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

