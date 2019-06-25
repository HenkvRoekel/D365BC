report 50005 "Lot History"
{

    DefaultLayout = RDLC;
    RDLCLayout = './RDLC/Lot History.rdlc';


    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            CalcFields = "Sales Amount (Actual)", "Cost Amount (Actual)";
            DataItemTableView = SORTING ("Item No.", "Lot No.") WHERE ("Entry Type" = CONST (Sale), "Source Type" = CONST (Customer));
            RequestFilterFields = "Item No.", "Source No.", "Posting Date";
            column(LotHistory; text50000)
            {
            }
            column(CompanyName; CompanyName)
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
            column(lblDesc3; text50009)
            {
            }
            column(lblCustomerNo; text50010)
            {
            }
            column(lblShipToName; text50011)
            {
            }
            column(lblSalesPerson; text50012)
            {
            }
            column(lblAmount; text50013)
            {
            }
            column(lblPostingDate; text50014)
            {
            }
            column(lblTotal; text50015)
            {
            }
            column(lbllotNo; text50002)
            {
            }
            column(LotNo_ItemLedgerEntry; "Item Ledger Entry"."Lot No.")
            {
            }
            column(ItemNo_ItemLedgerEntry; "Item Ledger Entry"."Item No.")
            {
            }
            column(OrderNo_ItemLedgerEntry; gOrderNo)
            {
            }
            column(InvoiceNo_ValueEntry; grecValueEntry."Document No.")
            {
            }
            column(Qty; gNoOfPackages)
            {
            }
            column(UnitofMeasureCode_ItemLedgerEntry; "Item Ledger Entry"."Unit of Measure Code")
            {
            }
            column(Quantity_ItemLedgerEntry; "Item Ledger Entry".Quantity)
            {
            }
            column(Description_Item; grecItem.Description)
            {
            }
            column(Extension_ItemExtension; grecItemExtension."Extension Code")
            {
            }
            column(SourceNo_ItemLedgerEntry; "Item Ledger Entry"."Source No.")
            {
            }
            column(ShipToName_SalesPerson; gNameDesc)
            {
            }
            column(Salesperson_ItemLedgerEntry; "Item Ledger Entry"."B Salesperson")
            {
            }
            column(SalesAmountActual_ItemLedgerEntry; "Item Ledger Entry"."Sales Amount (Actual)")
            {
            }
            column(PostingDate_ItemLedgerEntry; Format("Item Ledger Entry"."Posting Date", 0, 0))
            {
            }
            column(Description2_Item; grecItem."Description 2")
            {
            }

            trigger OnAfterGetRecord()
            begin


                grecValueEntry.Init;
                grecValueEntry.SetCurrentKey("Item Ledger Entry No.");
                grecValueEntry.SetRange("Item Ledger Entry No.", "Item Ledger Entry"."Entry No.");
                grecValueEntry.SetFilter(grecValueEntry."Invoiced Quantity", '<>0');

                if not grecValueEntry.Find('-') then
                    grecValueEntry.Init;

                if not grecSalesShipmentHeader.Get("Document No.") then
                    grecSalesShipmentHeader.Init;
                if not grecSalesCrMemoHeader.Get("Document No.") then
                    grecSalesCrMemoHeader.Init;

                Clear(gNameDesc);

                if "Document Type" = "Document Type"::"Sales Shipment" then begin

                    if grecCustomer.Get("Item Ledger Entry"."Source No.") then
                        gNameDesc := grecSalesShipmentHeader."Ship-to Name";
                end else begin
                    if grecCustomer.Get("Item Ledger Entry"."Source No.") then
                        gNameDesc := grecCustomer.Name;
                end;

                gOrderNo := '';

                if "Document Type" = "Document Type"::"Sales Shipment" then

                    gOrderNo := grecSalesShipmentHeader."Order No."
                else
                    gOrderNo := grecSalesCrMemoHeader."Pre-Assigned No.";

                if "Qty. per Unit of Measure" <> 0 then
                    gNoOfPackages := Quantity / "Qty. per Unit of Measure";

                if not grecItem.Get("Item Ledger Entry"."Item No.") then
                    grecItem.Init;

                if not grecItemExtension.Get(grecItem."B Extension", '') then
                    grecItemExtension.Init;
            end;

            trigger OnPreDataItem()
            begin
                gILEFilter := CopyStr("Item Ledger Entry".GetFilters, 1, 249);
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
        grecCustomer: Record Customer;
        gNameDesc: Text[50];
        grecItem: Record Item;
        gILEFilter: Text[250];
        gNoOfPackages: Decimal;
        grecValueEntry: Record "Value Entry";
        grecSalesShipmentHeader: Record "Sales Shipment Header";
        grecSalesCrMemoHeader: Record "Sales Cr.Memo Header";
        gOrderNo: Text[30];
        grecItemExtension: Record "Item Extension";
        gcuBejoMgt: Codeunit "Bejo Management";
        text50000: Label 'Lot History';
        text50001: Label 'Item No.';
        text50002: Label 'Lot No.';
        text50003: Label 'Order No.';
        text50004: Label 'Invoice No.';
        text50005: Label 'Quantity';
        text50006: Label 'Unit of Measure';
        text50007: Label 'Quantity(Base)';
        text50008: Label 'Description';
        text50009: Label 'Descr. 3';
        text50010: Label 'Customer No.';
        text50011: Label 'Ship-to Name';
        text50012: Label 'Salesperson';
        text50013: Label 'Amount';
        text50014: Label 'Posting Date';
        text50015: Label 'Total';
        Text50050: Label 'File Name';
}

