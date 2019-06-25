pageextension 90038 ItemLedgerEntriesBTPageExt extends "Item Ledger Entries"
{


    layout
    {
        addafter("Order Line No.")
        {
            field("B Comment"; "B Comment")
            {
                ApplicationArea = All;
            }
        }
    }
}

