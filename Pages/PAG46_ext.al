pageextension 90046 SalesOrderSubformBTPageExt extends "Sales Order Subform"
{


    layout
    {
        addafter(Nonstock)
        {
            field("Gen. Bus. Posting Group"; "Gen. Bus. Posting Group")
            {
                Visible = false;
                ApplicationArea = All;
            }
            field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
            {
                Visible = false;
                ApplicationArea = All;
            }
        }
        addafter(Description)
        {
            field("Description 2"; "Description 2")
            {
                ApplicationArea = All;
            }
            field("B ItemExtensionCode"; "B ItemExtensionCode")
            {
                Caption = 'Description 3';
                ApplicationArea = All;
            }
        }
        addafter("Qty. to Assemble to Order")
        {
            field("B Tracking Quantity"; "B Tracking Quantity")
            {
                ApplicationArea = All;
            }
        }
        addafter("Unit of Measure")
        {
            field("B Lot No."; "B Lot No.")
            {
                ApplicationArea = All;
            }
            field("B Line type"; "B Line type")
            {
                ApplicationArea = All;
            }
            field("B Characteristic"; "B Characteristic")
            {
                ApplicationArea = All;
            }
        }
        addafter("Appl.-to Item Entry")
        {
            field("<Reason Code Bejo>"; "B Reason Code")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter("O&rder")
        {
            group("&Bejo")
            {
                Caption = '&Bejo';
                Image = Sales;
                action("Page Stock Position")
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
                action("Page Allocation Main")
                {
                    Caption = 'Allocation';
                    Image = Allocate;
                    RunObject = Page "Allocation Main";
                    RunPageLink = "No." = FIELD ("No.");
                    RunPageView = SORTING ("No.")
                                  ORDER(Ascending);
                    ShortCutKey = 'Shift+F3';
                    ApplicationArea = All;
                }
            }
        }
    }
}

