pageextension 90031 ItemListBTPageExt extends "Item List"
{

    layout
    {
        addafter(Description)
        {
            field("Description 2"; "Description 2")
            {
                ApplicationArea = All;
            }
            field("B ItemExtensionDescription"; "B ItemExtensionDescription")
            {
                Caption = 'Description 3';
                ApplicationArea = All;
            }
            field("B Organic"; "B Organic")
            {
                ApplicationArea = All;
            }
        }
        addafter("Base Unit of Measure")
        {
            field("B Remaining Quantity"; "B Remaining Quantity")
            {
                ApplicationArea = All;
            }
            field("B Prognoses"; "B Prognoses")
            {
                BlankZero = true;
                DecimalPlaces = 3 : 5;
                ApplicationArea = All;
            }
            field("B Allocated"; "B Allocated")
            {
                BlankZero = true;
                DecimalPlaces = 3 : 5;
                ApplicationArea = All;
            }
            field("B Country allocated"; "B Country allocated")
            {
                BlankZero = true;
                DecimalPlaces = 3 : 5;
                ApplicationArea = All;
            }
            field(RestToBeAllocated; "B Country allocated" - "B Allocated")
            {
                BlankZero = true;
                Caption = 'Rest to be Allocated';
                DecimalPlaces = 3 : 5;
                Editable = false;
                ApplicationArea = All;
            }
            field("B ItemBlockDescription"; "B ItemBlockDescription")
            {
                Caption = 'Blocking Code';
                ApplicationArea = All;
            }
            field("B Promo Status"; "B Promo Status")
            {
                Visible = false;
                ApplicationArea = All;
            }
            field("B DisplayPromoStatus"; "B DisplayPromoStatus")
            {
                Caption = 'Promo Status Display';
                Editable = false;
                ApplicationArea = All;
            }
            field("B VarietyDateToBeDiscontinued"; "B VarietyDateToBeDiscontinued")
            {
                Caption = 'Date to be discontinued';
                ApplicationArea = All;
            }
            field("B VarietySalesComment"; "B VarietySalesComment")
            {
                Caption = 'Sales Comment';
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter(Resources)
        {
            group(Bejo)
            {
                Caption = 'Bejo';
                Description = 'Bejo';
                action("Allocation Main")
                {
                    Caption = 'Allocation Main';
                    Image = Allocations;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Allocation Main";
                    RunPageLink = "No." = FIELD ("No.");
                    RunPageView = SORTING ("No.")
                                  ORDER(Ascending);
                    ShortCutKey = 'Shift+F3';
                    ApplicationArea = All;
                }
                action("Stock Information")
                {
                    Caption = 'Stock Information';
                    Image = InventorySetup;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Stock Information";
                    RunPageLink = "No." = FIELD ("B Variety");
                    RunPageView = SORTING ("No.")
                                  ORDER(Ascending);
                    ShortCutKey = 'Shift+F6';
                    ApplicationArea = All;
                }
                action("Create Item Wizard")
                {
                    Caption = 'Create Item Wizard';
                    Image = ICPartner;
                    RunObject = Page "Create Item Wizard";
                    ApplicationArea = All;
                }
            }
        }
    }
}

