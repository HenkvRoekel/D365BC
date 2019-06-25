page 50008 "Bejo Setup"
{
    Caption = 'Bejo Setup';
    DeleteAllowed = true;
    ModifyAllowed = true;
    InsertAllowed = true;
    PageType = Card;
    UsageCategory = Administration;
    SourceTable = "Bejo Setup";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Begin Date"; "Begin Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; "End Date")
                {
                    ApplicationArea = All;
                }
                field("Customer No. BejoNL"; "Customer No. BejoNL")
                {
                    ApplicationArea = All;
                }
                field("G/L Shipping Charges"; "G/L Shipping Charges")
                {
                    ApplicationArea = All;
                }
                field("G/L Shipping Charges 2"; "G/L Shipping Charges 2")
                {
                    ApplicationArea = All;
                }
                field("Vendor No. BejoNL"; "Vendor No. BejoNL")
                {
                    ApplicationArea = All;
                }
                field("Commercial Location"; "Commercial Location")
                {
                    ApplicationArea = All;
                }
                field("Commercial Bin"; "Commercial Bin")
                {
                    ApplicationArea = All;
                }
                field("Sample Location"; "Sample Location")
                {
                    ApplicationArea = All;
                }
                field("Sample Bin"; "Sample Bin")
                {
                    ApplicationArea = All;
                }
                field("G/L Account No. Sales"; "G/L Account No. Sales")
                {
                    ApplicationArea = All;
                }
                field("Export Path"; "Export Path")
                {
                    ApplicationArea = All;
                }
                field("Import Path"; "Import Path")
                {
                    ApplicationArea = All;
                }
                field("Country Code"; "Country Code")
                {
                    ApplicationArea = All;
                }
                field("Default LocationFilter on Item"; "Default LocationFilter on Item")
                {
                    ApplicationArea = All;
                }

                field("PrognNotAllowed Filter"; "PrognNotAllowed Filter")
                {
                    ApplicationArea = All;
                }
                field("Years for Market Potential"; "Years for Market Potential")
                {
                    ApplicationArea = All;
                }
                field("Auto-update Next Years"; "Auto-update Next Years")
                {
                    ApplicationArea = All;
                }
                field("Continent Code"; "Continent Code")
                {
                    ApplicationArea = All;
                }
                field("Mobile Sales Profile"; "Mobile Sales Profile")
                {
                    ApplicationArea = All;
                }
            }
            group("Imported Purchase Lines")
            {
                Caption = 'Imported Purchase Lines';
                field("Bejo Zaden Freight Accounts"; "Bejo Zaden Freight Accounts")
                {
                    ApplicationArea = All;
                }
                field("Freight Item Charge No."; "Freight Item Charge No.")
                {
                    ApplicationArea = All;
                }
                field("Bejo Zaden Custom Tax.Accounts"; "Bejo Zaden Custom Tax.Accounts")
                {
                    ApplicationArea = All;
                }
                field("Custom Taxes Item Charge No."; "Custom Taxes Item Charge No.")
                {
                    ApplicationArea = All;
                }
                field("Bejo Zaden Handling Accounts"; "Bejo Zaden Handling Accounts")
                {
                    ApplicationArea = All;
                }
                field("Handling Item Charge No."; "Handling Item Charge No.")
                {
                    ApplicationArea = All;
                }
                field("Default Item Charge No."; "Default Item Charge No.")
                {
                    ApplicationArea = All;
                }
                field("Freight G/L Account"; "Freight G/L Account")
                {
                    ApplicationArea = All;
                }
            }
            group("Optional Settings")
            {
                Caption = 'Optional Settings';
                field("Post Warehouse Orders"; "Post Warehouse Orders")
                {
                    ApplicationArea = All;
                }
                field("Prognoses per Customer"; "Prognoses per Customer")
                {
                    ApplicationArea = All;
                }
                field("Prognoses per Salesperson"; "Prognoses per Salesperson")
                {
                    ApplicationArea = All;
                }
                field("Purchase Allocation Check"; "Purchase Allocation Check")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Sales Allocation Check"; "Sales Allocation Check")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Unique Lot No. per shipment"; "Unique Lot No. per shipment")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Variety Blocking"; "Variety Blocking")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Use SMTP Mail"; "Use SMTP Mail")
                {
                    ApplicationArea = All;
                }
                field("SMTP E-Mail"; "SMTP E-Mail")
                {
                    ApplicationArea = All;
                }
                field("Item Category Code Not Used"; "Item Category Code Not Used")
                {
                    ApplicationArea = All;
                }
                field("SO Post Alloc Rec Auto-Create"; "SO Post Alloc Rec Auto-Create")
                {
                    ApplicationArea = All;
                }
                field("Enforce NAV SO Status"; "Enforce NAV SO Status")
                {
                    ToolTip = 'Checked = NAV SO Status must be Released, to set Order Status to 3.Released or higher.';
                    ApplicationArea = All;
                }
                field("Enforce SO Reason Code"; "Enforce SO Reason Code")
                {
                    ApplicationArea = All;
                }
                field("Block Sales on Int.PromoStatus"; "Block Sales on Int.PromoStatus")
                {
                    ApplicationArea = All;
                }
                field("BlockPostSales if AllocExceed"; "BlockPostSales if AllocExceed")
                {
                    ApplicationArea = All;
                }
                field("BlockPrintProforma if AllocExc"; "BlockPrintProforma if AllocExc")
                {
                    ApplicationArea = All;
                }
                field("Validate Lot when OrderStatus2"; "Validate Lot when OrderStaus=2")
                {
                    ApplicationArea = All;
                }
                field("Mail Shipping"; "Mail Shipping")
                {
                    ApplicationArea = All;
                }
                field("Mail Allocation Change"; "Mail Allocation Change")
                {
                    ApplicationArea = All;
                }
                field("Best Used By in Red"; "Best Used By in Red")
                {
                    ApplicationArea = All;
                }
                field("Best Used By in Blue"; "Best Used By in Blue")
                {
                    ApplicationArea = All;
                }
                field("Sales Line Check Price"; "Sales Line Check Price")
                {
                    ApplicationArea = All;
                }
            }
            group("Dimension Grouping")
            {
                Caption = 'Dimension Grouping';
                field("Global Dimension to group on"; "Global Dimension to group on")
                {
                    ApplicationArea = All;
                }
                field("Dimension Group 1 Name"; "Dimension Group 1 Name")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Dimension Group 2 Name"; "Dimension Group 2 Name")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Dimension Group 3 Name"; "Dimension Group 3 Name")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Dimension Group 4 Name"; "Dimension Group 4 Name")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Dimension Group 1"; "Dimension Group 1")
                {
                    ApplicationArea = All;
                }
                field("Dimension Group 2"; "Dimension Group 2")
                {
                    ApplicationArea = All;
                }
                field("Dimension Group 3"; "Dimension Group 3")
                {
                    ApplicationArea = All;
                }
                field("Dimension Group 4"; "Dimension Group 4")
                {
                    ApplicationArea = All;
                }
            }
            group(Scanning)
            {
                Caption = 'Scanning';
                field("Transit Bin"; "Transit Bin")
                {
                    ApplicationArea = All;
                }
            }
            group("OData Setup")
            {
                Caption = 'OData Setup';
                field("Direct Expense Start Task No."; "Direct Expense Start Task No.")
                {
                    ApplicationArea = All;
                }
                field("Direct Expense End Task No."; "Direct Expense End Task No.")
                {
                    ApplicationArea = All;
                }
                field("Overhead Expense Start TaskNo."; "Overhead Expense Start TaskNo.")
                {
                    Caption = 'Overhead Expense Start Task No.';
                    ApplicationArea = All;
                }
                field("Overhead Expense End Task No."; "Overhead Expense End Task No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("S&how CONTEXTURL")
                {
                    Caption = 'S&how CONTEXTURL';
                    Image = ShowMatrix;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin

                        Message(Text50000 + '\' + GetUrl(CLIENTTYPE::Windows, CompanyName));

                    end;
                }

            }
        }
    }

    trigger OnOpenPage()
    begin
        Reset;
        if not Get then begin
            Init;
            Insert;
        end;
    end;

    var
        Text50000: Label 'The current CONTEXTURL.';
        Text50001: Label 'The CONTEXTURL is to long to fit in the field.';
}

