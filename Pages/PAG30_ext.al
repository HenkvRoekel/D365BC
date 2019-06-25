pageextension 90030 ItemCardBTPageExt extends "Item Card"
{


    layout
    {
        addafter(Type)
        {
            field("Description 2"; "Description 2")
            {
                ApplicationArea = All;
            }
            field("B ItemExtensionDescription"; "B ItemExtensionDescription")
            {
                Caption = 'Description 3';
                Editable = false;
                ApplicationArea = All;
            }
        }
        addafter("Costs & Posting")
        {
            group(Bejo)
            {
                Caption = 'Bejo';
                field("B Organic"; "B Organic")
                {
                    ApplicationArea = All;
                }
                field("B Crop Extension"; "B Crop Extension")
                {
                    ApplicationArea = All;
                }
                field("B Purchase BZ Lead Time Calc"; "B Purchase BZ Lead Time Calc")
                {
                    ApplicationArea = All;
                }
                field("B DisplayPromoStatus"; "B DisplayPromoStatus")
                {
                    Caption = 'Promo Status';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("B ItemBlockDescription"; "B ItemBlockDescription")
                {
                    Caption = 'Blocking Code';
                    ApplicationArea = All;
                }
                field("B VarietyDateToBeDiscontinued"; "B VarietyDateToBeDiscontinued")
                {
                    Caption = 'Date to be Discontinued';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("B VarietySalesComment"; "B VarietySalesComment")
                {
                    Caption = 'Sales Comment';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("B Qty. on Blanket Sales Order"; "B Qty. on Blanket Sales Order")
                {
                    ApplicationArea = All;
                }
                field("B Qty. to Invoice"; "B Qty. to Invoice")
                {
                    ApplicationArea = All;
                }
                field("B Sales (Qty.) Current season"; "B Sales (Qty.) Current season")
                {
                    ApplicationArea = All;
                }
                field("B Sales (Qty.) Last season"; "B Sales (Qty.) Last season")
                {
                    ApplicationArea = All;
                }
                field("Sales (Qty.)"; "Sales (Qty.)")
                {
                    ApplicationArea = All;
                }
                field("B Purch. (Qty.) Current season"; "B Purch. (Qty.) Current season")
                {
                    ApplicationArea = All;
                }
                field("B Purch. (Qty.) Last season"; "B Purch. (Qty.) Last season")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        addafter(Resources)
        {
            group("&Reports Bejo Trade")
            {
                Caption = '&Reports Bejo Trade';
                action("Print &Stock List")
                {
                    Caption = 'Print &Stock List';
                    Image = ItemReservation;
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Stock List";
                    ApplicationArea = All;
                }
                action("Print &Lot History")
                {
                    Caption = 'Print &Lot History';
                    Image = ItemAvailability;
                    RunObject = Report "Lot History";
                    ApplicationArea = All;
                }
            }
        }
    }
}

