page 50022 "Stock Information sub 4"
{


    Caption = 'Stock Information sub 4';
    DataCaptionFields = "No.";
    Editable = true;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Sales Line";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("No."; "No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Description 2"; "Description 2")
                {
                    ApplicationArea = All;
                }
                field("grecItemExtension.""Extension Code"""; grecItemExtension."Extension Code")
                {
                    Caption = 'Description 3';
                    ApplicationArea = All;
                }
                field("Qty. per Unit of Measure"; "Qty. per Unit of Measure")
                {
                    Caption = 'Unit of Measure';
                    ApplicationArea = All;
                }
                field(gOpenStock; gOpenStock)
                {
                    Caption = 'Open Stock';
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field(gFutures; gFutures)
                {
                    Caption = 'Futures';
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Outstanding Quantity"; "Outstanding Quantity")
                {
                    BlankZero = true;
                    Editable = false;
                    ApplicationArea = All;
                }
                field("B Tracking Quantity"; "B Tracking Quantity")
                {
                    BlankZero = true;
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Quantity Shipped"; "Quantity Shipped")
                {
                    ApplicationArea = All;
                }
                field("Qty. Shipped Not Invoiced"; "Qty. Shipped Not Invoiced")
                {
                    ApplicationArea = All;
                }
                field(" grecReservationEntry.""Lot No."""; grecReservationEntry."Lot No.")
                {
                    Caption = 'Lot No.';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("grecLotNoInformation.""B Germination"""; grecLotNoInformation."B Germination")
                {
                    BlankZero = true;
                    Caption = 'Germination';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("grecLotNoInformation.""B Best used by"""; grecLotNoInformation."B Best used by")
                {

                    Caption = 'Best used by';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Shipment Date"; "Shipment Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Document No."; "Document No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Sell-to Customer No."; "Sell-to Customer No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("grecCustomer.Name"; grecCustomer.Name)
                {
                    Caption = 'Name';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("B External Document No."; "B External Document No.")
                {
                    ApplicationArea = All;
                }
                field("B Ship-to Code"; "B Ship-to Code")
                {
                    ApplicationArea = All;
                }
                field("B Salesperson"; "B Salesperson")
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
        gFutures := 0;
        gOpenStock := 0;
        gOpenOrder := 0;

        if not grecCustomer.Get("Sell-to Customer No.") then
            grecCustomer.Init;

        CalcFields("B Tracking Quantity");
        grecReservationEntry.Init;
        if "B Tracking Quantity" <> 0 then begin
            if not grecReservationEntry.SetCurrentKey("Source ID", "Source Ref. No.") then
                grecReservationEntry.SetCurrentKey(grecReservationEntry."Reservation Status", grecReservationEntry."Item No.");
            grecReservationEntry.SetRange(grecReservationEntry."Item No.", "No.");
            grecReservationEntry.SetRange(grecReservationEntry."Source ID", "Document No.");
            grecReservationEntry.SetRange(grecReservationEntry."Source Ref. No.", "Line No.");
            if not grecReservationEntry.FindFirst then
                grecReservationEntry.Init;
        end;

        grecItemLedgerEntry.SetCurrentKey("Lot No.");
        grecItemLedgerEntry.SetRange("Lot No.", grecReservationEntry."Lot No.");
        if not grecItemLedgerEntry.FindFirst then
            grecItemLedgerEntry.Init;

        grecLotNoInformation.SetCurrentKey("Lot No.");
        grecLotNoInformation.SetRange("Lot No.", grecReservationEntry."Lot No.");
        if not grecLotNoInformation.FindFirst then
            grecLotNoInformation.Init;

        if grecItem.Get("No.") then
            grecItem.CalcFields(Inventory, "Qty. on Sales Order");


        grecItemLedgerEntry1.SetCurrentKey("Item No.", "Variant Code", Open);
        grecItemLedgerEntry1.SetRange("Item No.", "No.");
        grecItemLedgerEntry1.SetRange("Qty. per Unit of Measure", "Qty. per Unit of Measure");
        grecItemLedgerEntry1.CalcSums("Remaining Quantity");

        if "Qty. per Unit of Measure" = 0 then
            "Qty. per Unit of Measure" := 1;
        gOpenStock := grecItemLedgerEntry1."Remaining Quantity" / "Qty. per Unit of Measure";

        grecSalesLine.SetCurrentKey("Document Type", grecSalesLine.Type, grecSalesLine."No.");
        grecSalesLine.SetRange("Document Type", grecSalesLine."Document Type"::Order);
        grecSalesLine.SetRange(Type, grecSalesLine.Type::Item);
        grecSalesLine.SetRange("No.", "No.");
        grecSalesLine.SetRange("Unit of Measure Code", "Unit of Measure Code");
        if grecSalesLine.FindSet then
            repeat
                gOpenOrder := gOpenOrder + grecSalesLine."Outstanding Quantity";
            until grecSalesLine.Next = 0;

        if gOpenStock - gOpenOrder < 0 then
            gFutures := -(gOpenStock - gOpenOrder)
        else
            gFutures := 0;

        if not grecSalesHeader.Get("Document Type", "No.") then
            grecSalesHeader.Init;
        if not grecItem.Get("No.") then
            grecItem.Init;
        if not grecItemExtension.Get(grecItem."B Extension", grecSalesHeader."Language Code") then
            grecItemExtension.Init;
    end;

    var
        grecCustomer: Record Customer;
        grecReservationEntry: Record "Reservation Entry";
        grecItem: Record Item;
        grecItemLedgerEntry: Record "Item Ledger Entry";
        gOpenStock: Decimal;
        gOpenOrder: Decimal;
        gFutures: Decimal;
        grecSalesLine: Record "Sales Line";
        grecItemLedgerEntry1: Record "Item Ledger Entry";
        grecLotNoInformation: Record "Lot No. Information";
        grecSalesHeader: Record "Sales Header";
        grecItemExtension: Record "Item Extension";
}

