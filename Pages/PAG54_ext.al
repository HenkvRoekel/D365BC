pageextension 90054 PurchaseOrderSFBTPageExt extends "Purchase Order Subform"
{

    layout
    {
        addafter(Nonstock)
        {
            field("<B VAT Bus. Posting Group>"; "VAT Bus. Posting Group")
            {
                Visible = false;
                ApplicationArea = All;
            }
        }
        addafter("VAT Prod. Posting Group")
        {
            field("<B Gen. Bus. Posting Group>"; "Gen. Bus. Posting Group")
            {
                Visible = false;
                ApplicationArea = All;
            }
            field("<B Gen. Prod. Posting Group>"; "Gen. Prod. Posting Group")
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
            field("B External Document No."; "B External Document No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Unit of Measure")
        {
            field("B ReservEntryLotNo"; "B ReservEntryLotNo")
            {
                Caption = 'Lot No.';
                Editable = false;
                ApplicationArea = All;
            }
            field("B Allocation exceeded"; "B Allocation exceeded")
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
        addafter(ShortcutDimCode8)
        {
            field("<Reason Code Bejo>"; "B Reason Code")
            {
                ApplicationArea = All;
            }
        }
    }
}

