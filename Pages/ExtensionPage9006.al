pageextension 69006 ExtendNavigationArea extends "Order Processor Role Center"
{

    actions
    {
        addlast(Sections)
        {
            group("BEJO Trade")
            {
                action("BEJO Setup")
                {
                    RunObject = page "BEJO Setup";
                    ApplicationArea = All;
                }
                action("Crops")
                {
                    RunObject = page "Crops List";
                    ApplicationArea = All;
                }
                action("Grades")
                {
                    RunObject = page "Grade";
                    ApplicationArea = All;
                }

                action("Block Codes")
                {
                    RunObject = page "Block Code Setup";
                    ApplicationArea = All;
                }

                action("Promo Status")
                {
                    RunObject = page "Promo Status Setup";
                    ApplicationArea = All;
                }
                action("Treatments")
                {
                    RunObject = page "Treatment Codes";
                    ApplicationArea = All;
                }
                action("Varieties")
                {
                    RunObject = page "Varieties List";
                    ApplicationArea = All;
                }
                action("Sales Terms")
                {
                    RunObject = page "Sales Terms";
                    ApplicationArea = All;
                }
                action("Crop Extension")
                {
                    RunObject = page "Crop Extension Descr. List";
                    ApplicationArea = All;
                }
                action("Lots")
                {
                    RunObject = page "Lot No. Information List";
                    ApplicationArea = All;
                }
            }
        }
    }
}
