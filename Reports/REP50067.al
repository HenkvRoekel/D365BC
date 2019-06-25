report 50067 "Item Reorder Report"
{

    DefaultLayout = RDLC;
    RDLCLayout = './RDLC/Item Reorder Report.rdlc';


    dataset
    {
        dataitem(Item; Item)
        {
            RequestFilterFields = "No.", "Item Category Code", "Safety Stock Quantity", "Global Dimension 2 Code";

            column(UserId; UserId)
            {
            }
            column(CompanyName; CompanyName)
            {
            }
            column(Filters; filters)
            {
            }
            column(DateFilter; Format(StartDate) + ' - ' + Format(EndDate))
            {
            }
            column(GlobalDimension2Code_Item; Item."Global Dimension 2 Code")
            {
                IncludeCaption = true;
            }
            column(Description2_Item; Item."Description 2")
            {
                IncludeCaption = true;
            }
            column(ItemCategoryCode_Item; Item."Item Category Code")
            {
                IncludeCaption = true;
            }
            column(Inventory_Item; Item.Inventory)
            {
                IncludeCaption = true;
            }
            column(QtyonPurchOrder_Item; Item."Qty. on Purch. Order")
            {
                IncludeCaption = true;
            }
            column(QtyonSalesOrder_Item; Item."Qty. on Sales Order")
            {
                IncludeCaption = true;
            }
            column(SafetyStockQuantity_Item; Item."Safety Stock Quantity")
            {
                IncludeCaption = true;
            }
            column(SalesQty_Item; Item."Sales (Qty.)")
            {
                IncludeCaption = true;
            }
            column(No_Item; Item."No.")
            {
                IncludeCaption = true;
            }
            column(Description_Item; Item.Description)
            {
                IncludeCaption = true;
            }
            column(ReorderQty; ReorderQty)
            {
            }
            column(AvailQty; AvailQty)
            {
            }
            column(Crop_Item; Item."B Crop")
            {
            }

            trigger OnAfterGetRecord()
            begin

                Clear(AvailQty);
                Clear(ReorderQty);

                if EndDate <> 0D then
                    Item.SetRange("Date Filter", 0D, (EndDate + 1000));
                AvailQty := Inventory + "Qty. on Purch. Order" - "Qty. on Sales Order";
                ReorderQty := "Safety Stock Quantity" - AvailQty;
                if ReorderQty < 0 then
                    ReorderQty := 0;

                if EndDate <> 0D then
                    Item.SetRange("Date Filter", StartDate, EndDate);
                CalcFields(Item."Sales (Qty.)");
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(StartDate; StartDate)
                    {
                        Caption = 'Start Date';
                        ApplicationArea = All;
                    }
                    field(EndDate; EndDate)
                    {
                        Caption = 'End Date';
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
        lblReportName = 'Item Reorder Report';
        lblSalesDateRange = 'Sales Date Range';
        lblAvailQty = 'Avail. Qty.';
        lblReorderQty = 'Reorder Qty.';
        lblToOrder = 'To Order';
        lblSalesLastMths = 'Sales Last 12 Mths (Qty.)';
    }

    trigger OnInitReport()
    begin


    end;

    trigger OnPreReport()
    begin

        if (StartDate = 0D) and (EndDate = 0D) then
            EndDate := WorkDate;

        ItemFilter := Item.GetFilters;
        filters := StrSubstNo('%1: %2', Item.TableCaption, ItemFilter);
    end;

    var
        AvailQty: Decimal;
        StartDate: Date;
        EndDate: Date;
        ItemFilter: Text[250];
        ReorderQty: Decimal;
        gcuBejoMgt: Codeunit "Bejo Management";
        filters: Text[100];
}

