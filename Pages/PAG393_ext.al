pageextension 90393 ItemReclassJournalBTPageExt extends "Item Reclass. Journal"
{


    layout
    {
        addafter("Bin Code")
        {
            field("<Bejo Lot No.>"; "Lot No.")
            {
                Caption = '<Bejo Lot No.>';
                DrillDown = true;
                Lookup = true;
                ApplicationArea = All;
            }
            field("Lot No."; "Lot No.")
            {
                ApplicationArea = All;
            }
        }
    }
}

