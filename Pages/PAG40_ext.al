pageextension 90040 ItemJournalBTPageExt extends "Item Journal"
{


    layout
    {
        addafter("Unit of Measure Code")
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
                DrillDown = true;
                Lookup = true;
                ApplicationArea = All;
            }
        }
    }
}

