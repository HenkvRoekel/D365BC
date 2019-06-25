page 50066 "Sales Lines Bejo"
{

    Caption = 'Sales Lines';
    DataCaptionFields = "No.", Description;
    Editable = false;
    PageType = List;
    SourceTable = "Sales Line";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Document No."; "Document No.")
                {
                    ApplicationArea = All;
                }
                field("B Line type"; "B Line type")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer No."; "Sell-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("grecCustomer.Name"; grecCustomer.Name)
                {
                    Caption = 'Sell-to Customer Name';
                    ApplicationArea = All;
                }
                field("B Salesperson"; "B Salesperson")
                {
                    ApplicationArea = All;
                }
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field("Shipment Date"; "Shipment Date")
                {
                    ApplicationArea = All;
                }
                field("Outstanding Quantity"; "Outstanding Quantity")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Outstanding Qty. (Base)"; "Outstanding Qty. (Base)")
                {
                    ApplicationArea = All;
                }
                field("Qty. to Invoice (Base)"; "Qty. to Invoice (Base)")
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

        if not grecCustomer.Get("Sell-to Customer No.") then
            Clear(grecCustomer);

    end;

    var
        grecCustomer: Record Customer;
}

