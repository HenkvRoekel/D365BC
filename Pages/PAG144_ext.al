pageextension 90144 PostedSlsCreditMemosBTPageExt extends "Posted Sales Credit Memos"
{


    layout
    {
        addafter("Sell-to Customer Name")
        {
            field("Customer Price Group"; "Customer Price Group")
            {
                ApplicationArea = All;
            }
        }
    }
}

