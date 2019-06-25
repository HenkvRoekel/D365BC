report 50020 "Return Shipment Bejo"
{

    DefaultLayout = RDLC;
    RDLCLayout = './RDLC/Return Shipment Bejo.rdlc';


    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = SORTING ("Document Type", "No.") WHERE ("Document Type" = CONST ("Credit Memo"));
            RequestFilterFields = "No.", "Buy-from Vendor No.";
            column(OrderLeverancAdr1; gOrderSupplierAddress[1])
            {
            }
            column(OrderLeverancAdr2; gOrderSupplierAddress[2])
            {
            }
            column(OrderLeverancAdr3; gOrderSupplierAddress[3])
            {
            }
            column(OrderLeverancAdr4; gOrderSupplierAddress[4])
            {
            }
            column(BedrijfsAdres1; gCompanyAddress[1])
            {
            }
            column(BedrijfsAdres2; gCompanyAddress[2])
            {
            }
            column(BedrijfsAdres3; gCompanyAddress[3])
            {
            }
            column(BedrijfsAdres4; gCompanyAddress[4])
            {
            }
            column(DocumentDate_PurchaseHeader; "Purchase Header"."Document Date")
            {
            }
            column(BuyfromVendorNo_PurchaseHeader; "Purchase Header"."Buy-from Vendor No.")
            {
            }
            column(No_PurchaseHeader; "Purchase Header"."No.")
            {
                IncludeCaption = true;
            }
            column(PostingDate_PurchaseHeader; "Purchase Header"."Posting Date")
            {
                IncludeCaption = true;
            }
            column(PostingDescription_PurchaseHeader; "Purchase Header"."Posting Description")
            {
                IncludeCaption = true;
            }
            column(Opm1; gRemark[1])
            {
            }
            column(Opm2; gRemark[2])
            {
            }
            column(Opm3; gRemark[3])
            {
            }
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document Type" = FIELD ("Document Type"), "Document No." = FIELD ("No.");
                DataItemTableView = SORTING ("Document Type", "Document No.", "Line No.");
                column(LineNo_PurchaseLine; "Purchase Line"."Line No.")
                {
                }
                column(Type_PurchaseLine; "Purchase Line".Type)
                {
                }
                column(No_PurchaseLine; "Purchase Line"."No.")
                {
                }
                column(Description_PurchaseLine; "Purchase Line".Description)
                {
                    IncludeCaption = true;
                }
                column(Description2_PurchaseLine; "Purchase Line"."Description 2")
                {
                }
                column(UnitofMeasure_PurchaseLine; "Purchase Line"."Unit of Measure")
                {
                }
                column(Quantity_PurchaseLine; "Purchase Line".Quantity)
                {
                    IncludeCaption = true;
                }
                column(BoxNo_PurchaseLine; "Purchase Line"."B Box No.")
                {
                }
                column(fraktie; gGrade)
                {
                }
                column(LotNo_ReservationEntry; grecReservationEntry."Entry No.")
                {
                }
                column(BestUsedBy_LotNo; grecLotNoInformation."B Best used by")
                {
                }
                column(TxtOntsmet; gTreated)
                {
                }
                dataitem("Purch. Comment Line"; "Purch. Comment Line")
                {
                    DataItemLink = "No." = FIELD ("Document No."), "Document Line No." = FIELD ("Line No.");
                    DataItemTableView = WHERE ("Document Type" = CONST ("Credit Memo"));
                    column(LineNo_PurchCommentLine; "Purch. Comment Line"."Line No.")
                    {
                    }
                    column(Comment_PurchCommentLine; "Purch. Comment Line".Comment)
                    {
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    if grecItem.Get("Purchase Line"."No.") then;

                    if not grecReservationEntry.SetCurrentKey("Source ID", "Source Ref. No.") then // BEJOWW5.0.001
                        grecReservationEntry.SetCurrentKey("Source Type", "Source Subtype", "Source ID");

                    grecReservationEntry.SetRange("Source ID", "Purchase Line"."Document No.");
                    grecReservationEntry.SetRange("Source Ref. No.", "Purchase Line"."Line No.");
                    if not grecReservationEntry.Find('-') then
                        grecReservationEntry.Init;

                    if not grecItemExtension.Get(grecItem."B Extension", '') then
                        grecItemExtension.Init;
                    gTreated := '';
                    if (grecItemExtension.Extension > '0') and (grecItemExtension.Extension < '6') then
                        gTreated := grecItemExtension.Description;

                    grecLotNoInformation.SetCurrentKey("Lot No.");
                    grecLotNoInformation.SetRange("Lot No.", grecReservationEntry."Lot No.");
                    if not grecLotNoInformation.Find('-') then
                        grecLotNoInformation.Init;

                    if not grecGrade.Get(grecLotNoInformation."B Grade Code") then
                        grecGrade.Init;

                    gGrade := '';
                    if grecLotNoInformation."B Grade Code" <> 0 then
                        gGrade := grecGrade.Description;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                if "Purchaser Code" = '' then begin
                    grecSalesPerson.Init;
                    gPurchaserText := '';
                end else begin
                    grecSalesPerson.Get("Purchaser Code");
                    gPurchaserText := 'Purchaser'
                end;

                if "Your Reference" = '' then
                    gReferalText := ''
                else
                    gReferalText := FieldName("Your Reference");

                if "VAT Registration No." = '' then
                    gVATNoText := ''
                else
                    gVATNoText := FieldName("VAT Registration No.");

                if "Currency Code" = '' then begin
                    grecGLSetup.TestField("LCY Code");
                    gTotalText := StrSubstNo('Totaal %1', grecGLSetup."LCY Code");
                    gTotalTextInclVATText := StrSubstNo('Total %1 incl. VAT', grecGLSetup."LCY Code");
                end else begin
                    gTotalText := StrSubstNo('Totaal %1', "Currency Code");
                    gTotalTextInclVATText := StrSubstNo('Total %1 incl. VAT', "Currency Code");
                end;

                gcuFormatAddress.PurchHeaderBuyFrom(gOrderSupplierAddress, "Purchase Header");
                if ("Purchase Header"."Buy-from Vendor No." <> "Purchase Header"."Pay-to Vendor No.") then
                    gcuFormatAddress.PurchHeaderPayTo(gSupplierAddress, "Purchase Header");
                if "Payment Terms Code" = '' then
                    grecPaymentTerms.Init
                else
                    grecPaymentTerms.Get("Payment Terms Code");
                if "Shipment Method Code" = '' then
                    grecShipmentMethod.Init
                else
                    grecShipmentMethod.Get("Shipment Method Code");

                gcuFormatAddress.PurchHeaderShipTo(gDeliveryAddress, "Purchase Header");

                grecPurchCommentLine.SetRange("Document Type", grecPurchCommentLine."Document Type"::"Credit Memo");
                grecPurchCommentLine.SetRange("No.", "Purchase Header"."No.");
                if grecPurchCommentLine.Find('-') then
                    repeat
                        gCounter += 1;
                        gRemark[gCounter] := grecPurchCommentLine.Comment;
                    until (grecPurchCommentLine.Next = 0) or (gCounter = 3);
            end;

            trigger OnPreDataItem()
            begin
                grecCompanyInfo.Get;
                gcuFormatAddress.Company(gCompanyAddress, grecCompanyInfo);
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
        lblReturnShipments = 'Return Shipments';
        lblNo = 'No';
        lblItemNo = 'Item No';
        lblUnit = 'Unit';
        lblBuyFormVendor = 'Buy from Vendor';
        lblBestUsedBy = 'Best used by';
    }

    trigger OnInitReport()
    begin
        grecGLSetup.Get;
    end;

    var
        grecGrade: Record Grade;
        grecGLSetup: Record "General Ledger Setup";
        grecCompanyInfo: Record "Company Information";
        grecShipmentMethod: Record "Shipment Method";
        grecPaymentTerms: Record "Payment Terms";
        grecSalesPerson: Record "Salesperson/Purchaser";
        gcuFormatAddress: Codeunit "Format Address";
        gSupplierAddress: array[8] of Text[50];
        gDeliveryAddress: array[8] of Text[50];
        gCompanyAddress: array[8] of Text[50];
        gOrderSupplierAddress: array[8] of Text[50];
        gPurchaserText: Text[30];
        gVATNoText: Text[30];
        gReferalText: Text[30];
        gTotalText: Text[50];
        gTotalTextInclVATText: Text[50];
        gTreated: Text[60];
        gGrade: Text[30];
        gRemark: array[3] of Text[80];
        grecPurchCommentLine: Record "Purch. Comment Line";
        gCounter: Integer;
        grecItem: Record Item;
        grecItemExtension: Record "Item Extension";
        grecReservationEntry: Record "Reservation Entry";
        grecLotNoInformation: Record "Lot No. Information";
        gcuBejoMgt: Codeunit "Bejo Management";
        Text50000: Label 'COPY';
}

