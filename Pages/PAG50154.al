page 50154 "Order Proc Role Center BEJO"
{

    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group(Control1900724808)
            {
                ShowCaption = false;
                part(Control1901851508; "SO Processor Activities")
                {
                    AccessByPermission = TableData "Sales Shipment Header" = R;
                    ApplicationArea = All;
                }
                part(Control1907692008; "My Customers")
                {
                    ApplicationArea = All;
                }
            }
            group(Control1900724708)
            {
                ShowCaption = false;
                part(Control1; "Trailing Sales Orders Chart")
                {
                    AccessByPermission = TableData "Sales Shipment Header" = R;
                    ApplicationArea = All;
                }
                part(Control4; "My Job Queue")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                part(Control1905989608; "My Items")
                {
                    AccessByPermission = TableData "My Item" = R;
                    ApplicationArea = All;
                }
                part(Control21; "Report Inbox Part")
                {
                    AccessByPermission = TableData "Report Inbox" = R;
                    ApplicationArea = All;
                }
                systempart(Control1901377608; MyNotes)
                {
                    ApplicationArea = All;
                }
                systempart(Control50001; Links)
                {
                    ApplicationArea = All;
                }
                part(Control3; "Power BI Report Spinner Part")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(reporting)
        {
            action("Customer - &Order Summary")
            {
                Caption = 'Customer - &Order Summary';
                Image = "Report";
                RunObject = Report "Customer - Order Summary";
                ApplicationArea = All;
            }
            action("Customer - &Top 10 List")
            {
                Caption = 'Customer - &Top 10 List';
                Image = "Report";
                RunObject = Report "Customer - Top 10 List";
                ApplicationArea = All;
            }
            action("Customer/&Item Sales")
            {
                Caption = 'Customer/&Item Sales';
                Image = "Report";
                RunObject = Report "Customer/Item Sales";
                ApplicationArea = All;
            }
            separator(Separator17)
            {
            }
            action("Salesperson - Sales &Statistics")
            {
                Caption = 'Salesperson - Sales &Statistics';
                Image = "Report";
                RunObject = Report "Salesperson - Sales Statistics";
                ApplicationArea = All;
            }
            action("Price &List")
            {
                Caption = 'Price &List';
                Image = "Report";
                RunObject = Report "Price List";
                ApplicationArea = All;
            }
            separator(Separator22)
            {
            }
            action("Inventory - Sales &Back Orders")
            {
                Caption = 'Inventory - Sales &Back Orders';
                Image = "Report";
                RunObject = Report "Inventory - Sales Back Orders";
                ApplicationArea = All;
            }
            group("Bejo Reports")
            {
                Caption = 'Bejo Reports';
                action("Stock List")
                {
                    Caption = 'Stock List';
                    Image = "Report";
                    RunObject = Report "Stock List";
                    ApplicationArea = All;
                }
                action("Crop - Top 10 List")
                {
                    Caption = 'Crop - Top 10 List';
                    Image = "Report";
                    RunObject = Report "Crop/Variety - Top 10 List";
                    ApplicationArea = All;
                }
                action("Customer Lot History")
                {
                    Caption = 'Customer Lot History';
                    Image = "Report";
                    RunObject = Report "Customer Lot History";
                    ApplicationArea = All;
                }
                action("Lot History")
                {
                    Caption = 'Lot History';
                    Image = "Report";
                    RunObject = Report "Lot History";
                    ApplicationArea = All;
                }
                action("Price List Bejo")
                {
                    Caption = 'Price List Bejo';
                    Image = "Report";
                    RunObject = Report "Price List Bejo";
                    ApplicationArea = All;
                }
            }
            group(Processing1)
            {
                Caption = 'Processing';
                group(ActionGroup50087)
                {
                    Caption = 'Processing';
                    Image = Report2;
                    action("Import Varieties")
                    {
                        Caption = 'Import Varieties';
                        Image = "Report";
                        RunObject = Report "Import Varieties";
                        ApplicationArea = All;
                    }
                    action("Import Allocations")
                    {
                        Caption = 'Import Allocations';
                        Image = "Report";
                        RunObject = Report "Import Allocation";
                        ApplicationArea = All;
                    }
                    action("Import Sales Prices")
                    {
                        Caption = 'Import Sales Prices';
                        Image = "Report";
                        RunObject = Report "Import Sales Price";
                        ApplicationArea = All;
                    }
                    action("Import Block Promo")
                    {
                        Caption = 'Import Block Promo';
                        Image = "Report";
                        RunObject = Report "Import Block Promo";
                        ApplicationArea = All;
                    }
                    action("Import Item Remarks")
                    {
                        Caption = 'Import Item Remarks';
                        Image = "Report";
                        RunObject = Report "Import Item Remarks";
                        ApplicationArea = All;
                    }
                }
                group(Reports)
                {
                    Caption = 'Reports';
                    Image = Report2;
                    action("Allocation Import List")
                    {
                        Caption = 'Allocation Import List';
                        Image = "Report";
                        RunObject = Report "Allocation Import List";
                        ApplicationArea = All;
                    }

                    action("Purchase Line Bejo")
                    {
                        Caption = 'Purchase Line Bejo';
                        Image = "Report";
                        RunObject = Report "Purchase Lines Bejo";
                        ApplicationArea = All;
                    }
                }
            }
            group("Prognosis/Allocation")
            {
                Caption = 'Prognosis/Allocation';
                action("Prognoses to Purchase Order")
                {
                    Caption = 'Prognoses to Purchase Order';
                    Image = "Report";
                    RunObject = Report "Preview Purchase";
                    ApplicationArea = All;
                }
            }
            group("Bejo Analyses")
            {
                Caption = 'Bejo Analyses';
                action("Report Quantity to Purchase")
                {
                    Caption = 'Quantity to Purchase';
                    Image = "Report";
                    RunObject = Report "Quantity to Purchase";
                    ApplicationArea = All;
                }
                action("Report Crop Statistics")
                {
                    Caption = 'Crop Statistics';
                    Image = "Report";
                    RunObject = Report "Crop Statistics";
                    ApplicationArea = All;
                }
                action("Report Item Reorder Report")
                {
                    Caption = 'Item Reorder Report';
                    Image = "Report";
                    RunObject = Report "Item Reorder Report";
                    ApplicationArea = All;
                }
                action("<Report Inventory per Unit of Measure>")
                {
                    Caption = 'Inventory per Unit of Measure';
                    Image = "Report";
                    RunObject = Report "Inventory per Unit of Measure";
                    ApplicationArea = All;
                }
                action("Report Customer - Order Lines Bejo")
                {
                    Caption = 'Customer - Order Lines Bejo';
                    Image = "Report";
                    RunObject = Report "Customer - Order Lines Bejo";
                    ApplicationArea = All;
                }
                action("Report Inventory by Lot No.")
                {
                    Caption = 'Inventory by Lot No.';
                    Image = "Report";
                    RunObject = Report "Inventory by Lot No.";
                    ApplicationArea = All;
                }
            }
        }
        area(embedding)
        {
            action("Sales Orders")
            {
                Caption = 'Sales Orders';
                Image = "Order";
                RunObject = Page "Sales Order List";
                ApplicationArea = All;
            }
            action("Shipped Not Invoiced")
            {
                Caption = 'Shipped Not Invoiced';
                RunObject = Page "Sales Order List";
                RunPageView = WHERE ("Shipped Not Invoiced" = CONST (true));
                ApplicationArea = All;
            }
            action("Completely Shipped Not Invoiced")
            {
                Caption = 'Completely Shipped Not Invoiced';
                RunObject = Page "Sales Order List";
                RunPageView = WHERE ("Completely Shipped" = CONST (true),
                                    Invoice = CONST (false));
                ApplicationArea = All;
            }
            action("Sales Quotes")
            {
                Caption = 'Sales Quotes';
                Image = Quote;
                RunObject = Page "Sales Quotes";
                ApplicationArea = All;
            }
            action("Blanket Sales Orders")
            {
                Caption = 'Blanket Sales Orders';
                RunObject = Page "Blanket Sales Orders";
                ApplicationArea = All;
            }
            action("Sales Invoices")
            {
                Caption = 'Sales Invoices';
                Image = Invoice;
                RunObject = Page "Sales Invoice List";
                ApplicationArea = All;
            }
            action("Sales Return Orders")
            {
                Caption = 'Sales Return Orders';
                Image = ReturnOrder;
                RunObject = Page "Sales Return Order List";
                ApplicationArea = All;
            }
            action("Sales Credit Memos")
            {
                Caption = 'Sales Credit Memos';
                RunObject = Page "Sales Credit Memos";
                ApplicationArea = All;
            }
            action(Customers)
            {
                Caption = 'Customers';
                Image = Customer;
                RunObject = Page "Customer List";
                ApplicationArea = All;
            }
            action("<Page Contact List>")
            {
                Caption = 'Contacts';
                Image = ContactPerson;
                RunObject = Page "Contact List";
                ApplicationArea = All;
            }
            action("Purchase Orders Preview")
            {
                Caption = 'Purchase Orders Preview';
                RunObject = Page "Purchase Orders Preview";
                ApplicationArea = All;
            }
            action("Purchase Orders")
            {
                Caption = 'Purchase Orders';
                RunObject = Page "Purchase Order List";
                ApplicationArea = All;
            }
            action("Partially Delivered")
            {
                Caption = 'Partially Delivered';
                RunObject = Page "Purchase Order List";
                RunPageView = WHERE (Status = FILTER (Released),
                                    Receive = FILTER (true),
                                    "Completely Received" = FILTER (false));
                ApplicationArea = All;
            }
            action(Items)
            {
                Caption = 'Items';
                Image = Item;
                RunObject = Page "Item List";
                ApplicationArea = All;
            }
            action(Varieties)
            {
                Caption = 'Varieties';
                Image = Item;
                RunObject = Page "Varieties List";
                ApplicationArea = All;
            }
            action(Lots)
            {
                Caption = 'Lots';
                RunObject = Page "Lot No. Information List";
                ApplicationArea = All;
            }
        }
        area(sections)
        {
            group("Posted Documents")
            {
                Caption = 'Posted Documents';
                Image = FiledPosted;
                action("Posted Sales Shipments")
                {
                    Caption = 'Posted Sales Shipments';
                    Image = PostedShipment;
                    RunObject = Page "Posted Sales Shipments";
                    ApplicationArea = All;
                }
                action("Posted Sales Invoices")
                {
                    Caption = 'Posted Sales Invoices';
                    Image = PostedOrder;
                    RunObject = Page "Posted Sales Invoices";
                    ApplicationArea = All;
                }
                action("Posted Return Receipts")
                {
                    Caption = 'Posted Return Receipts';
                    Image = PostedReturnReceipt;
                    RunObject = Page "Posted Return Receipts";
                    ApplicationArea = All;
                }
                action("Posted Sales Credit Memos")
                {
                    Caption = 'Posted Sales Credit Memos';
                    Image = PostedOrder;
                    RunObject = Page "Posted Sales Credit Memos";
                    ApplicationArea = All;
                }
                action("Posted Purchase Receipts")
                {
                    Caption = 'Posted Purchase Receipts';
                    RunObject = Page "Posted Purchase Receipts";
                    ApplicationArea = All;
                }
                action("Posted Purchase Invoices")
                {
                    Caption = 'Posted Purchase Invoices';
                    RunObject = Page "Posted Purchase Invoices";
                    ApplicationArea = All;
                }
            }
        }
        area(creation)
        {
            action("Sales &Quote")
            {
                Caption = 'Sales &Quote';
                Image = Quote;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Sales Quote";
                RunPageMode = Create;
                ApplicationArea = All;
            }
            action("Sales &Invoice")
            {
                Caption = 'Sales &Invoice';
                Image = Invoice;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Sales Invoice";
                RunPageMode = Create;
                ApplicationArea = All;
            }
            action("Sales &Order")
            {
                Caption = 'Sales &Order';
                Image = Document;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Sales Order";
                RunPageMode = Create;
                ApplicationArea = All;
            }
            action("Sales &Return Order")
            {
                Caption = 'Sales &Return Order';
                Image = ReturnOrder;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Sales Return Order";
                RunPageMode = Create;
                ApplicationArea = All;
            }
            action("Sales &Credit Memo")
            {
                Caption = 'Sales &Credit Memo';
                Image = CreditMemo;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Sales Credit Memo";
                RunPageMode = Create;
                ApplicationArea = All;
            }
        }
        area(processing)
        {
            separator(Tasks)
            {
                Caption = 'Tasks';
                IsHeader = true;
            }
            action("Sales &Journal")
            {
                Caption = 'Sales &Journal';
                Image = Journals;
                RunObject = Page "Sales Journal";
                ApplicationArea = All;
            }
            action("Sales Price &Worksheet")
            {
                Caption = 'Sales Price &Worksheet';
                Image = PriceWorksheet;
                RunObject = Page "Sales Price Worksheet";
                ApplicationArea = All;
            }
            separator(Separator42)
            {
            }
            action("Sales &Prices")
            {
                Caption = 'Sales &Prices';
                Image = SalesPrices;
                RunObject = Page "Sales Prices";
                ApplicationArea = All;
            }
            action("Sales &Line Discounts")
            {
                Caption = 'Sales &Line Discounts';
                Image = SalesLineDisc;
                RunObject = Page "Sales Line Discounts";
                ApplicationArea = All;
            }
            group("Prognoses/Allocation")
            {
                Caption = 'Prognoses/Allocation';
                Image = AnalysisView;
                action("Stock Information")
                {
                    Caption = 'Stock Information';
                    Image = Statistics;
                    RunObject = Page "Stock Information";
                    RunPageView = SORTING ("No.");
                    ApplicationArea = All;
                }
                action("<Page Monthly Prognoses>")
                {
                    Caption = 'Month Prognoses';
                    Image = PlanningWorksheet;
                    RunObject = Page "Monthly Prognoses";
                    ApplicationArea = All;
                }
                action("Year Prognoses")
                {
                    Caption = 'Year Prognoses';
                    Image = Purchasing;
                    RunObject = Page "Year Prognoses";
                    ApplicationArea = All;
                }
                action(Allocations)
                {
                    Caption = 'Allocations';
                    Image = Allocations;
                    RunObject = Page "Allocation Main";
                    RunPageView = SORTING ("No.");
                    ApplicationArea = All;
                }
                action("Market Potential")
                {
                    Caption = 'Market Potential';
                    Image = OrderPromising;
                    RunObject = Page "Market Potential";
                    ApplicationArea = All;
                }
            }
            action("Warehouse Orders")
            {
                Caption = 'Warehouse Orders';
                Image = Warehouse;
                RunObject = Page "Warehouse orders";
                ApplicationArea = All;
            }
            separator(History)
            {
                Caption = 'History';
                IsHeader = true;
            }
            action("Navi&gate")
            {
                Caption = 'Navi&gate';
                Image = Navigate;
                RunObject = Page Navigate;
                ApplicationArea = All;
            }
        }
    }
}

