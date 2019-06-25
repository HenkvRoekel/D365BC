page 50106 PItemLedgerEntries
{

    PageType = List;
    SourceTable = "Item Ledger Entry";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; "Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Item No."; "Item No.")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Entry Type"; "Entry Type")
                {
                    ApplicationArea = All;
                }
                field("Document No."; "Document No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Location Code"; "Location Code")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = All;
                }
                field("Remaining Quantity"; "Remaining Quantity")
                {
                    ApplicationArea = All;
                }
                field("Invoiced Quantity"; "Invoiced Quantity")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Qty. per Unit of Measure"; "Qty. per Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field("Item Category Code"; "Item Category Code")
                {
                    ApplicationArea = All;
                }
                field("Lot No."; "Lot No.")
                {
                    ApplicationArea = All;
                }
                field("Expiration Date"; "Expiration Date")
                {
                    ApplicationArea = All;
                }
                field("Country/Region Code"; "Country/Region Code")
                {
                    ApplicationArea = All;
                }
                field("B Treatment Code"; "B Treatment Code")
                {
                    ApplicationArea = All;
                }
                field("B Salesperson"; "B Salesperson")
                {
                    ApplicationArea = All;
                }
                field("Cost Amount (Actual)"; "Cost Amount (Actual)")
                {
                    ApplicationArea = All;
                }
                field("No. 2"; gRecItem."No. 2")
                {
                    ApplicationArea = All;
                }
                field("Item.Description"; gRecItem.Description)
                {
                    ApplicationArea = All;
                }
                field("Item.Search Description"; gRecItem."Search Description")
                {
                    ApplicationArea = All;
                }
                field("Inventory Posting Group"; gRecItem."Inventory Posting Group")
                {
                    ApplicationArea = All;
                }
                field(Variety; gRecItem."B Variety")
                {
                    ApplicationArea = All;
                }
                field(Organic; gRecItem."B Organic")
                {
                    ApplicationArea = All;
                }
                field(Crop; gRecItem."B Crop")
                {
                    ApplicationArea = All;
                }
                field(Inventory; gRecItem.Inventory)
                {
                    ApplicationArea = All;
                }
                field("Item.Remaining Quantity"; gRecItem."B Remaining Quantity")
                {
                    ApplicationArea = All;
                }
                field("Lot.Description"; gRecLot.Description)
                {
                    ApplicationArea = All;
                }
                field("Lot.Treatment Code"; gRecLot."B Treatment Code")
                {
                    ApplicationArea = All;
                }
                field("Tsw. in gr."; gRecLot."B Tsw. in gr.")
                {
                    ApplicationArea = All;
                }
                field(Germination; gRecLot."B Germination")
                {
                    ApplicationArea = All;
                }
                field(Abnormals; gRecLot."B Abnormals")
                {
                    ApplicationArea = All;
                }
                field("Grade Code"; gRecLot."B Grade Code")
                {
                    ApplicationArea = All;
                }
                field("Best used by"; gRecLot."B Best used by")
                {
                    ApplicationArea = All;
                }
                field("Lot.Inventory"; gRecLot.Inventory)
                {
                    ApplicationArea = All;
                }
                field("Lot.Qty. per UOM"; gRecLot."B Qty. per Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field("Lot.Location"; gRecLot.BLocation)
                {
                    ApplicationArea = All;
                }
                field("Lot.Bin"; gRecLot."B Bin")
                {
                    ApplicationArea = All;
                }
                field("Lot.Remaining Qty."; gRecLot."B Remaining Quantity")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin

        gRecItem.Reset;
        if (gRecItem.Get("Item No.")) and (StrLen(gRecItem."No.") = 8) then begin
            gRecItem.CalcFields(Inventory, "B Remaining Quantity");
        end;

        gRecLot.Reset;
        if gRecLot.Get("Item No.", "Variant Code", "Lot No.") then begin
            gRecLot.CalcFields(Inventory, "B Qty. per Unit of Measure", BLocation, "B Remaining Quantity");
        end;
    end;

    var
        gRecItem: Record Item;
        gRecLot: Record "Lot No. Information";
}

