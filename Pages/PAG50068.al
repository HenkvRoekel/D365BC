page 50068 "Invoiced Quantity"
{

    Caption = 'Invoiced Quantity';
    Editable = false;
    PageType = List;
    SourceTable = "Item Ledger Entry";
    SourceTableView = WHERE ("Entry Type" = CONST (Sale),
                            "Invoiced Quantity" = FILTER (<> 0));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = All;
                }
                field("B Requested Delivery Date"; "B Requested Delivery Date")
                {
                    ApplicationArea = All;
                }
                field("Item No."; "Item No.")
                {
                    ApplicationArea = All;
                }
                field("Lot No."; "Lot No.")
                {
                    ApplicationArea = All;
                }
                field("grecValueEntry.""Document No."""; grecValueEntry."Document No.")
                {
                    Caption = 'Invoice No.';
                    ApplicationArea = All;
                }
                field("Document No."; "Document No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("B Salesperson"; "B Salesperson")
                {
                    ApplicationArea = All;
                }
                field("Source No."; "Source No.")
                {
                    ApplicationArea = All;
                }
                field("grecCustomer.Name"; grecCustomer.Name)
                {
                    Caption = 'Sell-to Customer Name';
                    ApplicationArea = All;
                }
                field("Invoiced Quantity"; "Invoiced Quantity")
                {
                    ApplicationArea = All;
                }
                field("""Invoiced Quantity""/""Qty. per Unit of Measure"""; "Invoiced Quantity" / "Qty. per Unit of Measure")
                {
                    Caption = 'Quantity';
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Requested Delivery Date2"; "B Requested Delivery Date")
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
        grecSalesInvoiceLine.SetRange(grecSalesInvoiceLine."Document No.", "Document No.");
        if not grecSalesInvoiceLine.Find('-') then
            grecSalesInvoiceLine.Init;


        grecValueEntry.Init;
        grecValueEntry.SetCurrentKey(grecValueEntry."Item Ledger Entry No.");
        grecValueEntry.SetRange("Item Ledger Entry No.", "Entry No.");
        if not grecValueEntry.Find('-') then
            grecValueEntry.Init;

        if not grecCustomer.Get("Source No.") then
            Clear(grecCustomer);

    end;

    trigger OnInit()
    begin

        if not SetCurrentKey("Item No.", "Entry Type") then
            SetCurrentKey("Entry Type", "Item No.", "Variant Code", "Source Type", "Source No.", "Posting Date");

    end;

    var
        grecSalesInvoiceLine: Record "Sales Invoice Line";
        grecValueEntry: Record "Value Entry";
        grecCustomer: Record Customer;
}

