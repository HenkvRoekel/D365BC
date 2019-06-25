pageextension 90042 SalesOrderBTPageExt extends "Sales Order"
{


    layout
    {
        addafter("Work Description")
        {
            field("B OrderStatus"; "B OrderStatus")
            {
                Importance = Additional;
                ApplicationArea = All;
            }
            field("<Warehouse Remark Bejo>"; "B Warehouse Remark")
            {
                Importance = Additional;
                ApplicationArea = All;
            }
        }
        addafter("Bill-to Country/Region Code")
        {
            field("<Reason Code Bejo>"; "Reason Code")
            {
                ApplicationArea = All;
            }
        }
        addafter("Area")
        {
            field("B Gross weight"; "B Gross weight")
            {
                ApplicationArea = All;
            }
            field("B Reserved weight"; "B Reserved weight")
            {
                ApplicationArea = All;
            }
            field("B Marks"; "B Marks")
            {
                ApplicationArea = All;
            }
            field("B Contents"; "B Contents")
            {
                ApplicationArea = All;
            }
            field("B Packing Description"; "B Packing Description")
            {
                ApplicationArea = All;
            }
        }
        addafter("Prepmt. Pmt. Discount Date")
        {
            group("Prepayment Unpaid Amount")
            {
                Caption = 'Prepayment Unpaid Amount';
                Visible = "Last Prepayment No." <> '';
                field(PrepayUnpaidAmt; "B PrepayUnpaidAmount")
                {
                    Caption = 'Unpaid Amount';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        addfirst(Navigation)
        {
            group("&Bejo")
            {
                Caption = '&Bejo';
                action("Bejo Proforma Invoice")
                {
                    Caption = 'Bejo Proforma Invoice';
                    Image = Invoice;
                    RunObject = Page "Sales Actions Referrer";
                    RunPageLink = "B Page_Action ID" = CONST ('P42_50091');
                    RunPageOnRec = true;
                    ApplicationArea = All;
                }
                action("&Item Tracking per Order")
                {
                    Caption = '&Item Tracking per Order';
                    Image = EntryStatistics;
                    RunObject = Page "Sales Actions Referrer";
                    RunPageLink = "B Page_Action ID" = CONST ('P42_50057');
                    RunPageOnRec = true;
                    ApplicationArea = All;
                }
                action("P&ick List")
                {
                    Caption = 'P&ick List';
                    Image = PickLines;
                    RunObject = Page "Sales Actions Referrer";
                    RunPageLink = "B Page_Action ID" = CONST ('P42_50069');
                    RunPageOnRec = true;
                    ApplicationArea = All;
                }
                action("P&acking List")
                {
                    Caption = 'P&acking List';
                    Image = PickWorksheet;
                    RunObject = Page "Sales Actions Referrer";
                    RunPageLink = "B Page_Action ID" = CONST ('P42_50071');
                    RunPageOnRec = true;
                    ApplicationArea = All;
                }
                action("Stock Position")
                {
                    Caption = 'Stock Position';
                    RunObject = Page "Stock Information";
                    ShortCutKey = 'Shift+F6';
                    ApplicationArea = All;
                }
                action("Print Lot &History")
                {
                    Caption = 'Print Lot &History';
                    Image = PrintExcise;
                    RunObject = Page "Sales Actions Referrer";
                    RunPageLink = "B Page_Action ID" = CONST ('P42_50085');
                    RunPageOnRec = true;
                    ApplicationArea = All;
                }
                action("S&hipping Charges")
                {
                    Caption = 'S&hipping Charges';
                    Image = ShipmentLines;
                    RunObject = Page "Sales Actions Referrer";
                    RunPageLink = "B Page_Action ID" = CONST ('P42_50088');
                    RunPageOnRec = true;
                    ApplicationArea = All;
                }
                action("Shi&pping Charges 2")
                {
                    Caption = 'Shi&pping Charges 2';
                    Image = ShipmentLines;
                    RunObject = Page "Sales Actions Referrer";
                    RunPageLink = "B Page_Action ID" = CONST ('P42_50090');
                    RunPageOnRec = true;
                    ApplicationArea = All;
                }
                action("Merge Orders")
                {
                    Caption = 'Merge Orders';
                    Image = OrderTracking;
                    RunObject = Page "Sales Actions Referrer";
                    RunPageLink = "B Page_Action ID" = CONST ('P42_50093');
                    RunPageOnRec = true;
                    ApplicationArea = All;
                }
                action("Release Order")
                {
                    Caption = 'Release Order';
                    Image = ReleaseShipment;
                    RunObject = Page "Sales Actions Referrer";
                    RunPageLink = "B Page_Action ID" = CONST ('P42_50096');
                    RunPageOnRec = true;
                    ApplicationArea = All;
                }
            }
        }
    }
}

