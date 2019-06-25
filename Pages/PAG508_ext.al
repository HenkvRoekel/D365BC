pageextension 90508 BlanketSalesOrderSFBTPageExt extends "Blanket Sales Order Subform"
{


    layout
    {
        addafter(Description)
        {
            field("Description 2"; "Description 2")
            {
                ApplicationArea = All;
            }
            field("Description 3"; "B ItemExtensionCode")
            {
                Caption = 'Description 3';
                ApplicationArea = All;
            }
        }
        addafter("ShortcutDimCode[8]")
        {
            field("B Reason Code"; "B Reason Code")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter("F&unctions")
        {
            group("&Bejo")
            {
                Caption = '&Bejo';
                Image = Sales;
                action("Stock Position")
                {
                    Caption = 'Stock Position';
                    Image = Statistics;
                    RunObject = Page "Stock Information";
                    RunPageLink = "No." = FIELD ("B Variety");
                    RunPageView = SORTING ("No.")
                                  ORDER(Ascending);
                    ShortCutKey = 'Shift+F6';
                    ApplicationArea = All;
                }
                action("Print Lot History")
                {
                    Caption = 'Print Lot History';
                    Image = PrintExcise;
                    RunObject = Report "Lot History";
                    ApplicationArea = All;
                }
            }
        }
    }
}

