report 50010 "Pick List Bejo"
{

    DefaultLayout = RDLC;
    RDLCLayout = './RDLC/Pick List Bejo.rdlc';

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            CalcFields = "B Reserved weight";
            DataItemTableView = SORTING ("Document Type", "No.");
            RequestFilterFields = "No.";
            column(SortByLineNo; SortopOrderregel)
            {
            }
            column(CurrencyCode_SalesHeader; "Sales Header"."Currency Code")
            {
            }
            column(ShiptoCode_SalesHeader; "Sales Header"."Ship-to Code")
            {
            }
            column(BilltoCustomerNo_SalesHeader; "Sales Header"."Bill-to Customer No.")
            {
            }
            column(No_SalesHeader; "Sales Header"."No.")
            {
            }
            column(Reservedweight_SalesHeader; "Sales Header"."B Reserved weight")
            {
            }
            column(SalespersonCode_SalesHeader; "Sales Header"."Salesperson Code")
            {
                IncludeCaption = true;
            }
            column(ShipmentDate_SalesHeader; Format("Sales Header"."Shipment Date", 0, 0))
            {
            }
            column(ExternalDocumentNo_SalesHeader; "Sales Header"."External Document No.")
            {
                IncludeCaption = true;
            }
            column(ShipmentMethodCode_SalesHeader; "Sales Header"."Shipment Method Code")
            {
            }
            column(CustomerPriceGroup; grecCustomer."Customer Price Group")
            {
            }
            column(BillAddress1; gCustAddress[1])
            {
            }
            column(BillAddress2; gCustAddress[2])
            {
            }
            column(BillAddress3; gCustAddress[3])
            {
            }
            column(BillAddress4; gCustAddress[4])
            {
            }
            column(BillAddress5; gCustAddress[5])
            {
            }
            column(BillPhone; grecCustomer."Phone No.")
            {
            }
            column(ShipAddress1; gShipToAddress[1])
            {
            }
            column(ShipAddress2; gShipToAddress[2])
            {
            }
            column(ShipAddress3; gShipToAddress[3])
            {
            }
            column(ShipAddress4; gShipToAddress[4])
            {
            }
            column(ShipAddress5; gShipToAddress[5])
            {
            }
            column(ShipAddress6; gShipToAddress[6])
            {
            }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document Type" = FIELD ("Document Type"), "Document No." = FIELD ("No.");
                column(No_SalesLine; "Sales Line"."No.")
                {
                }
                column(LineNo_SalesLine; "Sales Line"."Line No.")
                {
                }
                column(UnitofMeasure_SalesLine; "Sales Line"."Unit of Measure")
                {
                }
                column(TrackingQuantity_SalesLine; "Sales Line"."B Tracking Quantity")
                {
                }
                column(QtyperUnitofMeasure_SalesLine; "Sales Line"."Qty. per Unit of Measure")
                {
                }
                column(Description_SalesLine; "Sales Line".Description)
                {
                    IncludeCaption = true;
                }
                column(Description2_SalesLine; "Sales Line"."Description 2")
                {
                    IncludeCaption = true;
                }
                column(UnitPrice_SalesLine; "Sales Line"."Unit Price")
                {
                }
                column(Quantity_SalesLine; "Sales Line".Quantity)
                {
                    IncludeCaption = true;
                }
                column(Type_SalesLine; Format("Sales Line".Type, 0, 2))
                {
                }
                column(ReservedQuantity_SalesLine; "Sales Line"."Reserved Quantity")
                {
                }
                column(VariantCode_SalesLine; "Sales Line"."Variant Code")
                {
                }
                column(BinCode_SalesLine; "Sales Line"."Bin Code")
                {
                }
                column(Reservedweight_SalesLine; "Sales Line"."B Reserved weight")
                {
                }
                column(ItemDescription; grecItem.Description)
                {
                }
                column(ItemDescription2; grecItem."Description 2")
                {
                }
                column(ShowItemSection; ShowItemSection)
                {
                }
                column(TrackingQtyPerUnitOfMeasure_SalesLine; "Sales Line"."Qty. per Unit of Measure")
                {
                }
                column(LotNO_ReservationQty; grecLotNoInformation."Lot No.")
                {
                }
                column(PartEEG; PartEEG)
                {
                }
                column(TxtOntsmet; gtxtTreated)
                {
                }
                column(FractionDescription; grecGrade.Description)
                {
                }
                column(TswinGR; grecLotNoInformation."B Tsw. in gr.")
                {
                }
                column(Germ; gGermination)
                {
                }
                dataitem("Sales Comment Line"; "Sales Comment Line")
                {
                    DataItemLink = "Document Type" = FIELD ("Document Type"), "No." = FIELD ("Document No."), "Document Line No." = FIELD ("Line No.");
                    DataItemTableView = SORTING ("Document Type", "No.");
                    column(Comment_SalesCommentLine; "Sales Comment Line".Comment)
                    {
                    }
                    column(LineNo_SalesCommentLine; "Sales Comment Line"."Line No.")
                    {
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    gReservedAmount := gReservedAmount + ("Reserved Quantity" * "Unit Price");
                    if "Sales Header"."Currency Factor" <> 0 then
                        gReservedAmountLC := gReservedAmountLC / "Sales Header"."Currency Factor"
                    else
                        gReservedAmountLC := gReservedAmount;

                    "Sales Line".CalcFields("Sales Line"."B Tracking Quantity");

                    if grecItem.Get("Sales Line"."No.") then;

                    if "Sales Line"."B Characteristic" <> 0 then
                        "Sales Line"."B External Document No." := Format("Sales Line"."B Characteristic");

                    if not grecItemExt.Get(grecItem."B Extension", "Sales Header"."Language Code") then
                        grecItemExt.Init;
                    gtxtTreated := '';
                    if (grecItemExt.Extension < '6') then
                        gtxtTreated := grecItemExt.Description;

                    GetLotDetails();
                end;

                trigger OnPreDataItem()
                begin
                    if SortopOrderregel = true then
                        "Sales Line".SetCurrentKey("Sales Line"."Document Type", "Sales Line"."Document No.", "Sales Line"."Line No.")

                    else
                        "Sales Line".SetCurrentKey("Document Type", "Document No.", "Bin Code");

                    gReservedAmount := 0;
                    gReservedAmountLC := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                grecCustomer2.Get("Bill-to Customer No.");

                gcuFormatAddress.SalesHeaderBillTo(gCustAddress, "Sales Header");
                gShowShipToAddress := gcuFormatAddress.SalesHeaderShipTo(gShipToAddress, gCustAddress, "Sales Header");

                if grecCustomer.Get("Sales Header"."Sell-to Customer No.") then;
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
                    field(SortopOrderregel; SortopOrderregel)
                    {
                        Caption = 'Sort by order line';
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            SortopOrderregel := false;
        end;
    }

    labels
    {
        lblOrderNo = 'Order No.';
        lblPage = 'Page:';
        lblBillToCustomer = 'Bill-to Customer';
        lblShipToCustomer = 'Ship-to Customer';
        lblItemno = 'Item No.';
        lblPhoneNo = 'Phone No.';
        lblPriceGroup = 'Price Group';
        lblShipmentMethod = 'Shipment Method';
        lblBox = 'Box(es)';
        lblBag = 'Bag(s)';
        lblFreightCost = 'Freight Cost';
        lblMark = 'Mark(s)';
        lblNetWeightKG = 'Net Weight';
        lblGrosWeightKG = 'Gross Weight';
        lblPallets = 'Pallets';
        lblDate = 'Date';
        lblPrice = 'Price';
        lblTWSinGR = 'Tsw. in gr.';
        lblGerm = 'Germ.';
        lblPickListBejo = 'Pick List Bejo';
        lblLotNo = 'Lot No.';
        lblUOM = 'Unit of Measure';
        lblTotal = 'Total';
        lblOK = 'Ok';
        lblPreparedBy = 'Prepared by';
        lblCheckedBy = 'Checked by';
        lblBin = 'Bin';
        lblShipmentDate = 'Shipment Date';
    }

    var
        gtxtTreated: Text[60];
        grecItem: Record Item;
        gcuFormatAddress: Codeunit "Format Address";
        gCustAddress: array[8] of Text[50];
        gShipToAddress: array[8] of Text[50];
        gShowShipToAddress: Boolean;
        i: Integer;
        SortopOrderregel: Boolean;
        grecGrade: Record Grade;
        PartEEG: Code[10];
        grecCustomer: Record Customer;
        gReservedAmount: Decimal;
        gReservedAmountLC: Decimal;
        grecLotNoInformation: Record "Lot No. Information";
        gGermination: Text[30];
        grecCustomer2: Record Customer;
        grecItemExt: Record "Item Extension";
        gcuBejoMgt: Codeunit "Bejo Management";
        ShowItemSection: Text[50];
        ReservationEntry: Record "Reservation Entry";

    local procedure GetLotDetails()
    begin

        Clear(grecLotNoInformation);
        gGermination := '';
        PartEEG := '';
        Clear(grecGrade);

        ReservationEntry.SetRange("Item No.", "Sales Line"."No.");
        ReservationEntry.SetRange("Source ID", "Sales Line"."Document No.");
        ReservationEntry.SetRange("Source Ref. No.", "Sales Line"."Line No.");
        if ReservationEntry.FindFirst then begin

            PartEEG := '';

            grecLotNoInformation.SetCurrentKey("Lot No.");
            grecLotNoInformation.SetRange("Lot No.", ReservationEntry."Lot No.");
            if not grecLotNoInformation.Find('-') then
                grecLotNoInformation.Init;

            if grecLotNoInformation."B Germination" <> 0 then
                gGermination := Format(grecLotNoInformation."B Germination") + ' %'
            else
                gGermination := '';

            if not grecGrade.Get(grecLotNoInformation."B Grade Code") then
                grecGrade.Init;

        end else begin

            PartEEG := '';
            grecLotNoInformation.Init;
            gGermination := '';
            grecGrade.Init;

        end;
    end;
}

