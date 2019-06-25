page 50092 "Int. Promostatus Entry Subform"
{

    Caption = 'Internal Promostatus Entry Subform';
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = "Internal Promostatus Entry";
    SourceTableView = SORTING ("Variety Code", Salesperson, "Customer No.", "Item No.")
                      ORDER(Ascending);

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Variety Code"; "Variety Code")
                {
                    ApplicationArea = All;
                }
                field("Variety Description"; "Variety Description")
                {
                    ApplicationArea = All;
                }
                field("Item No."; "Item No.")
                {
                    ApplicationArea = All;
                }
                field("Item Description"; "Item Description")
                {
                    ApplicationArea = All;
                }
                field(Salesperson; Salesperson)
                {
                    ApplicationArea = All;
                }
                field("Salesperson Name"; "Salesperson Name")
                {
                    ApplicationArea = All;
                }
                field("Customer No."; "Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; "Customer Name")
                {
                    DrillDown = false;
                    Lookup = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Internal Promo Status Code"; "Internal Promo Status Code")
                {
                    ApplicationArea = All;
                }
                field("Internal Promo Status Descr."; "Internal Promo Status Descr.")
                {
                    DrillDown = false;
                    Lookup = false;
                    Visible = true;
                    ApplicationArea = All;
                }
                field("User ID"; "User ID")
                {
                    ApplicationArea = All;
                }
                field("Last Date Modified"; "Last Date Modified")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

