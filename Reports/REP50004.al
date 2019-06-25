report 50004 "Customer Lot History"
{

    DefaultLayout = RDLC;
    RDLCLayout = './RDLC/Customer Lot History.rdlc';

    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING ("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
            column(CustomerLotHistory; text50000)
            {
            }
            column(CompanyName; CompanyName)
            {
            }
            column(CustomerFilter; gCustomerFilter)
            {
            }
            column(ArtPostFilter; gILEFilter)
            {
            }
            column(UserId; UserId)
            {
            }

            column(lblItemNo; text50001)
            {
            }
            column(lblOrderNo; text50003)
            {
            }
            column(lblInvoiceNo; text50004)
            {
            }
            column(lblQty; text50005)
            {
            }
            column(lblUoM; text50006)
            {
            }
            column(lblDescription; text50008)
            {
            }
            column(lblQtyBase; text50007)
            {
            }
            column(lblCustomer; text50009)
            {
            }
            column(lblShipToName; text50010)
            {
            }
            column(lblSalesPerson; text50011)
            {
            }
            column(lblAmount; text50012)
            {
            }
            column(lblPostingDate; text50013)
            {
            }
            column(lbLlotNo; text50002)
            {
            }
            column(lblTotal; text50014)
            {
            }
            column(No_Customer; Customer."No.")
            {
            }
            column(Name_Customer; Customer.Name)
            {
            }
            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                CalcFields = "Sales Amount (Actual)";
                DataItemLink = "Source No." = FIELD ("No.");
                DataItemTableView = SORTING ("Entry Type", "Source No.", "Item No.", "Lot No.") WHERE ("Entry Type" = CONST (Sale));
                RequestFilterFields = "Posting Date", "Location Code", "B Salesperson";
                column(LotNo_ItemLedgerEntry; "Item Ledger Entry"."Lot No.")
                {
                }
                column(Quantity_ItemLedgerEntry; -"Item Ledger Entry".Quantity)
                {
                }
                column(UnitofMeasureCode_ItemLedgerEntry; "Item Ledger Entry"."Unit of Measure Code")
                {
                }
                column(SalesAmountActual_ItemLedgerEntry; "Item Ledger Entry"."Sales Amount (Actual)")
                {
                }
                column(ItemNo_ItemLedgerEntry; "Item Ledger Entry"."Item No.")
                {
                }
                column(PostingDate_ItemLedgerEntry; Format("Item Ledger Entry"."Posting Date", 0, 0))
                {
                }
                column(Salesperson_ItemLedgerEntry; "Item Ledger Entry"."B Salesperson")
                {
                }
                column(Description_Item; grecItem.Description)
                {
                }
                column(ItemExtension_Item; grecItemExt."Extension Code")
                {
                }
                column(Qty; -gNoOfPackages)
                {
                }
                column(InvoiceNo_ValueEntry; grecValueEntry."Document No.")
                {
                }
                column(OrderNo_ItemLedgerEntry; gOrderNo)
                {
                }
                column(ShipToName_SalesPerson; gNameDesc)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if not grecSalesShipmentHeader.Get("Document No.") then
                        grecSalesShipmentHeader.Init;
                    if not grecSalesCrMemoHeader.Get("Document No.") then
                        grecSalesCrMemoHeader.Init;

                    gOrderNo := '';
                    // - BEJOWW5.01.007 ---
                    if "Document Type" = "Document Type"::"Sales Shipment" then
                        // IF "Item Ledger Entry".Positive = FALSE THEN
                        // + BEJOWW5.01.007 +++
                        gOrderNo := grecSalesShipmentHeader."Order No."
                    else
                        gOrderNo := grecSalesCrMemoHeader."Pre-Assigned No.";

                    grecValueEntry.Init;
                    grecValueEntry.SetCurrentKey("Item Ledger Entry No.");
                    grecValueEntry.SetRange("Item Ledger Entry No.", "Item Ledger Entry"."Entry No.");
                    // - BEJOWW5.0.007 ---
                    grecValueEntry.SetFilter(grecValueEntry."Invoiced Quantity", '<>0');
                    // + BEJOWW5.0.007 +++
                    if not grecValueEntry.Find('-') then
                        grecValueEntry.Init;

                    if "Qty. per Unit of Measure" <> 0 then
                        gNoOfPackages := Quantity / "Qty. per Unit of Measure";

                    if grecItem.Get("Item Ledger Entry"."Item No.") then;
                    if not grecItemExt.Get(grecItem."B Extension", '') then
                        grecItemExt.Init;


                    gNameDesc := '';
                    if "Item Ledger Entry"."Entry Type" = "Item Ledger Entry"."Entry Type"::Sale then
                        // - BEJOWW5.01.007 ---
                        //  IF "Item Ledger Entry".Positive = FALSE THEN BEGIN
                        if "Document Type" = "Document Type"::"Sales Shipment" then begin
                            // + BEJOWW5.01.007 +++
                            if grecCustomer.Get("Item Ledger Entry"."Source No.") then
                                gNameDesc := grecSalesShipmentHeader."Ship-to Name";
                        end else begin
                            if grecCustomer.Get("Item Ledger Entry"."Source No.") then
                                gNameDesc := grecCustomer.Name;
                        end;
                    if "Item Ledger Entry"."Entry Type" = "Item Ledger Entry"."Entry Type"::Purchase then
                        if grecVendor.Get("Item Ledger Entry"."Source No.") then
                            gNameDesc := grecVendor.Name;
                end;

                trigger OnPreDataItem()
                begin
                    gILEFilter := CopyStr("Item Ledger Entry".GetFilters, 1, 249);  // BEJOW18.00.018 PB    90952
                    CurrReport.CreateTotals(gNoOfPackages);
                end;
            }

            trigger OnPreDataItem()
            begin
                gCustomerFilter := CopyStr(Customer.GetFilters, 1, 249); // BEJOW18.00.018 PB    90952
                CurrReport.CreateTotals("Item Ledger Entry"."Sales Amount (Actual)");
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        grecSalesShipmentHeader: Record "Sales Shipment Header";
        grecSalesCrMemoHeader: Record "Sales Cr.Memo Header";
        gOrderNo: Text[30];
        grecValueEntry: Record "Value Entry";
        gNoOfPackages: Decimal;
        grecItem: Record Item;
        grecCustomer: Record Customer;
        grecVendor: Record Vendor;
        gNameDesc: Text[50];
        gCustomerFilter: Text[250];
        gILEFilter: Text[250];
        grecItemExt: Record "Item Extension";
        ShowLotInTotal: Boolean;
        gcuBejoMgt: Codeunit "Bejo Management";
        text50000: Label 'Customer Lot History';
        text50001: Label 'Item No';
        text50002: Label 'Lot No.';
        text50003: Label 'Order No.';
        text50004: Label 'Invoice No.';
        text50005: Label 'Quantity';
        text50006: Label 'Unit of Measure';
        text50007: Label 'Quantity(Base)';
        text50008: Label 'Description';
        text50009: Label 'Cust.';
        text50010: Label 'Ship-to Name';
        text50011: Label 'Salesperson';
        text50012: Label 'Amount';
        text50013: Label 'Posting Date';
        text50014: Label 'Total';
        Text50050: Label 'File Name';
}

