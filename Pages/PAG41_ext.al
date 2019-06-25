pageextension 90041 SalesQuoteBTPageExt extends "Sales Quote"
{


    layout
    {
        addafter(Status)
        {
            field("<Reason Code Bejo>"; "Reason Code")
            {
                ApplicationArea = All;
            }
        }
    }
}

