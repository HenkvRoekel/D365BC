pageextension 90392 PhysInventoryJournalBTPageExt extends "Phys. Inventory Journal"
{

    layout
    {
        addafter("Bin Code")
        {
            field("B Line type"; "B Line type")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter("P&osting")
        {
            group(Bejo)
            {
                Caption = 'Bejo';
                action(CalculateInventoryBejo)
                {
                    Caption = 'Calculate &Inventory Bejo';
                    Ellipsis = true;
                    Image = CalculateInventory;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Report "Calculate Inventory Bejo";
                    Scope = Repeater;
                    ApplicationArea = All;
                }
                action(CreateEOSS)
                {
                    Caption = 'Create End of Season Stock';
                    Ellipsis = true;
                    Image = BinContent;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Item Jnl. Actions Referrer";
                    RunPageLink = "B Page_Action ID" = CONST ('P392_50007');
                    RunPageOnRec = true;
                    Scope = Repeater;
                    ApplicationArea = All;
                }
                action(CreateEOSSExport)
                {
                    Caption = 'Export End of Season Stock';
                    Ellipsis = true;
                    Image = XMLFile;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Item Jnl. Actions Referrer";
                    RunPageLink = "B Page_Action ID" = CONST ('P392_50011');
                    RunPageOnRec = true;
                    Scope = Repeater;
                    ApplicationArea = All;
                }
            }
        }
    }
}

