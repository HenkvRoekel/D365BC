page 50107 "PDetailed Cus. Ledger Entry"
{

    PageType = List;
    SourceTable = "Detailed Cust. Ledg. Entry";

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
                field("Cust. Ledger Entry No."; "Cust. Ledger Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Entry Type"; "Entry Type")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Document Type"; "Document Type")
                {
                    ApplicationArea = All;
                }
                field("Document No."; "Document No.")
                {
                    ApplicationArea = All;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = All;
                }
                field("Customer No."; "Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Amount (LCY)"; "Amount (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; "Currency Code")
                {
                    ApplicationArea = All;
                }
                field("Debit Amount"; "Debit Amount")
                {
                    ApplicationArea = All;
                }
                field("Credit Amount"; "Credit Amount")
                {
                    ApplicationArea = All;
                }
                field("Debit Amount (LCY)"; "Debit Amount (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Credit Amount (LCY)"; "Credit Amount (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Initial Entry Global Dim. 1"; "Initial Entry Global Dim. 1")
                {
                    ApplicationArea = All;
                }
                field("Initial Entry Global Dim. 2"; "Initial Entry Global Dim. 2")
                {
                    ApplicationArea = All;
                }
                field("Gen. Bus. Posting Group"; "Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("VAT Bus. Posting Group"; "VAT Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("VAT Prod. Posting Group"; "VAT Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Applied Cust. Ledger Entry No."; "Applied Cust. Ledger Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Customer.Name"; gRecCustomer.Name)
                {
                    ApplicationArea = All;
                }
                field("Customer.Search Name"; gRecCustomer."Search Name")
                {
                    ApplicationArea = All;
                }
                field("Customer.City"; gRecCustomer.City)
                {
                    ApplicationArea = All;
                }
                field("Customer.Global Dimension 1 Code"; gRecCustomer."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Customer.Global Dimension 2 Code"; gRecCustomer."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Customer.Chain Name"; gRecCustomer."Chain Name")
                {
                    ApplicationArea = All;
                }
                field("Customer.Credit Limit (LCY)"; gRecCustomer."Credit Limit (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Customer Posting Group"; gRecCustomer."Customer Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Customer Price Group"; gRecCustomer."Customer Price Group")
                {
                    ApplicationArea = All;
                }
                field("Salesperson Code"; gRecCustomer."Salesperson Code")
                {
                    ApplicationArea = All;
                }
                field("Shipment Method Code"; gRecCustomer."Shipment Method Code")
                {
                    ApplicationArea = All;
                }
                field("Country/Region Code"; gRecCustomer."Country/Region Code")
                {
                    ApplicationArea = All;
                }
                field("Customer.Amount"; gRecCustomer.Amount)
                {
                    ApplicationArea = All;
                }
                field("Bill-to Customer No."; gRecCustomer."Bill-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Post Code"; gRecCustomer."Post Code")
                {
                    ApplicationArea = All;
                }
                field(County; gRecCustomer.County)
                {
                    ApplicationArea = All;
                }
                field("Customer.Balance"; gRecCustomer.Balance)
                {
                    ApplicationArea = All;
                }
                field("Customer.Balance (LCY)"; gRecCustomer."Balance (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Customer.Sales (LCY)"; gRecCustomer."Sales (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Customer.Payments"; gRecCustomer.Payments)
                {
                    ApplicationArea = All;
                }
                field("Customer.Invoice Amounts"; gRecCustomer."Invoice Amounts")
                {
                    ApplicationArea = All;
                }
                field("Customer.Cr. Memo Amounts"; gRecCustomer."Cr. Memo Amounts")
                {
                    ApplicationArea = All;
                }
                field("Customer.Outstanding Orders"; gRecCustomer."Outstanding Orders")
                {
                    ApplicationArea = All;
                }
                field("Customer.Shipped Not Invoiced"; gRecCustomer."Shipped Not Invoiced")
                {
                    ApplicationArea = All;
                }
                field("Customer.Debit Amount"; gRecCustomer."Debit Amount")
                {
                    ApplicationArea = All;
                }
                field("Customer.Credit Amount"; gRecCustomer."Credit Amount")
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
        gRecCustomer.Reset;
        if gRecCustomer.Get("Customer No.") then begin
            gRecCustomer.CalcFields(Balance, "Balance (LCY)", "Sales (LCY)", "Invoice Amounts", "Cr. Memo Amounts", "Outstanding Orders",
              "Shipped Not Invoiced", "Debit Amount", "Credit Amount");
        end;
    end;

    var
        gRecCustomer: Record Customer;
}

