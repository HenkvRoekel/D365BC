pageextension 90039 GeneralJournalBTPageExt extends "General Journal"
{


    layout
    {
        addafter("Bal. Gen. Prod. Posting Group")
        {
            field("<B VAT Base Amount>"; "VAT Base Amount")
            {
                Visible = false;
                ApplicationArea = All;
            }
            field("<B VAT Registration No.>"; "VAT Registration No.")
            {
                Visible = false;
                ApplicationArea = All;
            }
        }
    }
}

