pageextension 90055 PurchInvoiceSFBTPageExt extends "Purch. Invoice Subform"
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
        addafter(Nonstock)
        {
            field("<B VAT Bus. Posting Group>"; "VAT Bus. Posting Group")
            {
                Visible = false;
                ApplicationArea = All;
            }
        }
        addafter("VAT Prod. Posting Group")
        {
            field("<B Gen. Bus. Posting Group>"; "Gen. Bus. Posting Group")
            {
                Visible = false;
                ApplicationArea = All;
            }
            field("<B Gen. Prod. Posting Group>"; "Gen. Prod. Posting Group")
            {
                Visible = false;
                ApplicationArea = All;
            }
        }
    }
}

