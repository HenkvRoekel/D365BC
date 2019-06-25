page 50023 "Stock Information sub 5"
{

    Caption = 'Purchase Orders';
    DataCaptionFields = "No.";
    Editable = false;
    PageType = List;
    SourceTable = "Purchase Line";
    SourceTableView = WHERE ("Document Type" = FILTER (Order));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field(Type; Type)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Description 2"; "Description 2")
                {
                    ApplicationArea = All;
                }
                field("Descirption 3"; grecItemExtension."Extension Code")
                {
                    Caption = 'Description 3';
                    ApplicationArea = All;
                }
                field("Requested Receipt Date"; "Requested Receipt Date")
                {
                    ApplicationArea = All;
                }
                field("Buy-from Vendor No."; "Buy-from Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Document No."; "Document No.")
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; "Currency Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Quantity; Quantity)
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
                field("grecPurchaseHeader.""Vendor Order No."""; grecPurchaseHeader."Vendor Order No.")
                {
                    Caption = 'Vendor Order No.';
                    ApplicationArea = All;
                }
                field("grecPurchaseHeader.""Vendor Invoice No."""; grecPurchaseHeader."Vendor Invoice No.")
                {
                    Caption = 'Vendor Invoice No.';
                    ApplicationArea = All;
                }
                field("grecPurchaseHeader.""Order Address Code"""; grecPurchaseHeader."Order Address Code")
                {
                    Caption = 'Order Address Code';
                    ApplicationArea = All;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = All;
                }
                field("Direct Unit Cost"; "Direct Unit Cost")
                {
                    ApplicationArea = All;
                }
                field("Line Discount %"; "Line Discount %")
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
    var
        lrecItem: Record Item;
    begin
        grecPurchaseHeader.Get("Document Type", "Document No.");

        if lrecItem.Get("No.") then;
        if grecItemExtension.Get(lrecItem."B Extension", grecPurchaseHeader."Language Code") then;
    end;

    var
        grecPurchaseHeader: Record "Purchase Header";
        grecItemExtension: Record "Item Extension";
}

