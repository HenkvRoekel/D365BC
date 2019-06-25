pageextension 90135 PostedSalesCrMemoSFBTPageExt extends "Posted Sales Cr. Memo Subform"
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

