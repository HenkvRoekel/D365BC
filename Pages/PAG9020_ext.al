pageextension 99020 SmallBusinessOwnerRCBTPageExt extends "Small Business Owner RC"
{


    actions
    {

        //Unsupported feature: Property Modification (Name) on ""Purchase Orders"(Action 105)".


        //Unsupported feature: Property Modification (Name) on "Items(Action 110)".

        addafter("EC Sal&es List")
        {
            group("Bejo Reports")
            {
                Caption = 'Bejo Reports';
                action("Stock List")
                {
                    Caption = 'Stock List';
                    Image = "report";
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
                    Image = "report";
                    RunObject = Report "Customer Lot History";
                    ApplicationArea = All;
                }
                action("Lot History")
                {
                    Caption = 'Lot History';
                    Image = "report";
                    RunObject = Report "Lot History";
                    ApplicationArea = All;
                }
                action("Price List Bejo")
                {
                    Caption = 'Price List Bejo';
                    Image = "report";
                    RunObject = Report "Price List Bejo";
                    ApplicationArea = All;
                }
            }
            group(Processing)
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
                    action("Changed Varieties List")
                    {
                        Caption = 'Changed Varieties List';
                        Image = "Report";
                        RunObject = Report "Change Purchase Date";
                        ApplicationArea = All;
                    }
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
                    Image = "report";
                    RunObject = Report "Inventory by Lot No.";
                    ApplicationArea = All;
                }
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
            action("Purchase Orders1")
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
            action(Items1)
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
                action("Month Prognoses")
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
        }
    }
}

