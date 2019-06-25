pageextension 90098 PurchCrMemoSubformBTPageExt extends "Purch. Cr. Memo Subform"
{

    layout
    {
        addafter(Nonstock)
        {
            field("<B VAT Bus. Posting Group>"; "VAT Bus. Posting Group")
            {
                ApplicationArea = All;
            }
        }
        addafter("VAT Prod. Posting Group")
        {
            field("<B Gen. Bus. Posting Group>"; "Gen. Bus. Posting Group")
            {
                ApplicationArea = All;
            }
            field("<B Gen. Prod. Posting Group>"; "Gen. Prod. Posting Group")
            {
                ApplicationArea = All;
            }
        }
        addafter(Description)
        {
            field("<Description 2 Bejo>"; "Description 2")
            {
                Caption = 'Description 2';
                ApplicationArea = All;
            }
            field("Description 3"; "B ItemExtensionCode")
            {
                Caption = 'Description 3';
                ApplicationArea = All;
            }
        }
        addafter(Quantity)
        {
            field("Lot No."; "B ReservEntryLotNo")
            {
                Caption = 'Lot No.';
                ApplicationArea = All;
            }
        }
        addafter("Deferral Code")
        {
            field("B Box No."; "B Box No.")
            {
                Visible = false;
                ApplicationArea = All;
            }
            field("B Characteristic"; "B Characteristic")
            {
                Visible = false;
                ApplicationArea = All;
            }
        }
    }
}

