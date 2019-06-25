report 50024 "Purchase - Proforma CreditMemo"
{

    DefaultLayout = RDLC;
    RDLCLayout = './RDLC/Purchase - Proforma CreditMemo.rdlc';


    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = SORTING ("Document Type", "No.");
            RequestFilterFields = "No.", "Sell-to Customer No.";
            column(Text50000; Text50000)
            {
            }
            column(CompanyAddress1; gCompanyAddress[1])
            {
            }
            column(CompanyAddress2; gCompanyAddress[2])
            {
            }
            column(CompanyAddress3; gCompanyAddress[3])
            {
            }
            column(CompanyPhone; grecCompanyInformation."Phone No.")
            {
            }
            column(CompanyEmail; grecCompanyInformation."E-Mail")
            {
            }
            column(CompanyFax; grecCompanyInformation."Fax No.")
            {
            }
            column(CompanyBank; grecCompanyInformation."Bank Name")
            {
            }
            column(CompanyBranchNo; grecCompanyInformation."Bank Branch No.")
            {
            }
            column(CompanyBankAccount; grecCompanyInformation."Bank Account No.")
            {
            }
            column(CompanyBankAccountNoCaption; grecCompanyInformation.FieldCaption("Bank Account No."))
            {
            }
            column(CompanyGiro; grecCompanyInformation."Giro No.")
            {
            }
            column(CompanyIBAN; grecCompanyInformation.IBAN)
            {
            }
            column(CompanySwifth; grecCompanyInformation."SWIFT Code")
            {
            }
            column(CompanyRegNo; grecCompanyInformation."Registration No.")
            {
            }
            column(CompanyVATNo; grecCompanyInformation."VAT Registration No.")
            {
            }
            column(PictureCompanyInfo; grecCompanyInformation.Picture)
            {
            }
            column(WebsiteCompanyInfo; grecCompanyInformation."Home Page")
            {
            }
            column(CustomerAddress1; gCustomerAddress[1])
            {
            }
            column(CustomerAddress2; gCustomerAddress[2])
            {
            }
            column(CustomerAddress3; gCustomerAddress[3])
            {
            }
            column(CustomerAddress4; gCustomerAddress[4])
            {
            }
            column(CustomerAddress5; gCustomerAddress[5])
            {
            }
            column(CustomerAddress6; gCustomerAddress[6])
            {
            }
            column(ShippToAddress1; gShiptoAddress[1])
            {
            }
            column(ShippToAddress2; gShiptoAddress[2])
            {
            }
            column(ShippToAddress3; gShiptoAddress[3])
            {
            }
            column(ShippToAddress4; gShiptoAddress[4])
            {
            }
            column(ShippToAddress5; gShiptoAddress[5])
            {
            }
            column(ShippToAddress6; gShiptoAddress[6])
            {
            }
            column(VATRegistrationNo_PurchaseHeader; "Purchase Header"."VAT Registration No.")
            {
            }
            column(BuyfromVendorNo_PurchaseHeader; "Purchase Header"."Buy-from Vendor No.")
            {
            }
            column(No_PurchaseHeader; "Purchase Header"."No.")
            {
            }
            column(PostingDate_PurchaseHeader; Format("Purchase Header"."Posting Date", 0, 0))
            {
            }
            column(DueDate_PurchaseHeader; Format("Purchase Header"."Due Date", 0, 0))
            {
            }
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document No." = FIELD ("No.");
                DataItemTableView = SORTING ("Document Type", "Document No.", "Line No.");
                column(LineNo_PurchaseLine; "Purchase Line"."Line No.")
                {
                }
                column(Type_PurchaseLine; Format("Purchase Line".Type, 0, 2))
                {
                }
                column(No_PurchaseLine; "Purchase Line"."No.")
                {
                    IncludeCaption = true;
                }
                column(Description_PurchaseLine; "Purchase Line".Description)
                {
                    IncludeCaption = true;
                }
                column(Description2_PurchaseLine; "Purchase Line"."Description 2")
                {
                }
                column(Quantity_PurchaseLine; "Purchase Line".Quantity)
                {
                    DecimalPlaces = 0 : 2;
                }
                column(UnitofMeasure_PurchaseLine; "Purchase Line"."Unit of Measure")
                {
                }
                column(QuantityBase_PurchaseLine; "Purchase Line"."Quantity (Base)")
                {
                    DecimalPlaces = 0 : 2;
                }
                column(DirectUnitCost_PurchaseLine; "Purchase Line"."Direct Unit Cost")
                {
                }
                column(Amount_PurchaseLine; "Purchase Line".Amount)
                {
                    IncludeCaption = true;
                }
                column(InvDiscountAmount_PurchaseLine; "Purchase Line"."Inv. Discount Amount")
                {
                }
                column(BoxNo_PurchaseLine; "Purchase Line"."B Box No.")
                {
                    IncludeCaption = true;
                }
                column(ExternalDocNo; gExternalDocumentNo)
                {
                }
                column(gDiscountCalculation; gDiscountCalculation)
                {
                }
                column(gDiscount; gDiscount)
                {
                }
                column(AmountIncludingVAT_PurchaseLine; "Purchase Line"."Amount Including VAT")
                {
                }
                column(LineTotal_PurchaseLine; "Purchase Line".Amount + "Purchase Line"."Inv. Discount Amount")
                {
                }
                column(LotNo_ReservationEntry; ReservationEntry."Lot No.")
                {
                }
                column(gTreated; gTreated)
                {
                }
                column(Desc_Grade; grecGrade.Description)
                {
                }
                dataitem("Purch. Comment Line"; "Purch. Comment Line")
                {
                    DataItemLink = "No." = FIELD ("Document No."), "Document Line No." = FIELD ("Line No.");
                    DataItemTableView = SORTING ("Document Type", "No.") WHERE ("Document Type" = CONST ("Credit Memo"));
                    column(LineNo_PurchCommentLine; "Purch. Comment Line"."Line No.")
                    {
                    }
                    column(Comment_PurchCommentLine; "Purch. Comment Line".Comment)
                    {
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    if grecVATPostingSetup.Get("Purchase Line"."VAT Bus. Posting Group", "Purchase Line".
                    "VAT Prod. Posting Group") then
                        if grecVATPostingSetup."VAT %" <> 0 then begin
                            grecVATAmountLine.Init;
                            grecVATAmountLine."VAT %" := grecVATPostingSetup."VAT %";
                            grecVATAmountLine."VAT Base" := "Purchase Line".Amount;
                            grecVATAmountLine."Amount Including VAT" := "Purchase Line"."Amount Including VAT";
                            grecVATAmountLine.InsertLine;
                        end;

                    grecItemUnitofMeasure.SetRange(grecItemUnitofMeasure."Item No.", "Purchase Line"."No.");
                    if grecItemUnitofMeasure.Find('-') then begin
                        grecUnitofMeasure.SetRange(grecUnitofMeasure.Code, grecItemUnitofMeasure.Code);
                        if (grecUnitofMeasure.Find('-')) and (grecUnitofMeasure."B Description for Reports" <> '') then
                            gPricePerUnit := grecUnitofMeasure."B Description for Reports";
                        grecUnitofMeasureTranslation.SetRange(grecUnitofMeasureTranslation.Code, grecItemUnitofMeasure.Code);

                        if grecItem.Get("Purchase Line"."No.") then;

                        if not grecItemExtension.Get(grecItem."B Extension", '') then
                            grecItemExtension.Init;
                        gTreated := '';
                        if (grecItemExtension.Extension < '6') and (grecItem."B Organic" = false) then
                            gTreated := grecItemExtension.Description;
                        grecUnitofMeasureTranslation.SetRange(grecUnitofMeasureTranslation."Language Code", "Purchase Header"."Language Code");
                    end;

                    gTotalNetWeight := gTotalNetWeight + ("Purchase Line"."Net Weight" * "Purchase Line".Quantity);


                    if "Inv. Discount Amount" < 0 then
                        gDiscount := Text50002;
                    if "Inv. Discount Amount" > 0 then
                        gDiscount := Text50001;

                    gDiscountCalculation := '';
                    if "Purchase Line"."Line Discount %" <> 0 then
                        gDiscountCalculation := Format(Round("Purchase Line"."Line Discount %", 0.01) * -1) + ' %';

                    GetLotNoInf();
                end;

                trigger OnPreDataItem()
                begin
                    grecVATAmountLine.DeleteAll;
                    gMoreLines := Find('+');
                    while gMoreLines and (Description = '') and ("No." = '') and (Quantity = 0) and (Amount = 0) do
                        gMoreLines := Next(-1) <> 0;
                    if not gMoreLines then
                        CurrReport.Break;
                    SetRange("Line No.", 0, "Line No.");
                    CurrReport.CreateTotals(Amount, "Amount Including VAT", "Inv. Discount Amount");
                    gTotalNetWeight := 0;
                end;
            }
            dataitem(VATCounter; "Integer")
            {
                DataItemTableView = SORTING (Number);
                column(gVATpercentage1; gVATpercentage[1])
                {
                }
                column(gVATpercentage2; gVATpercentage[2])
                {
                }
                column(gBaseVAT1; gBaseVAT[1])
                {
                }
                column(gBaseVAT2; gBaseVAT[2])
                {
                }
                column(gVATAmount1; gVATAmount[1])
                {
                }
                column(gVATAmount2; gVATAmount[2])
                {
                }
                column(TotalVAT1; gBaseVAT[1] + gVATAmount[1])
                {
                }
                column(TotalVAT2; gBaseVAT[2] + gVATAmount[2])
                {
                }
                column(TotalVATBase; grecVATAmountLine."VAT Base")
                {
                }
                column(TotalVATAmount; grecVATAmountLine."VAT Amount")
                {
                }
                column(TotalVAT; grecVATAmountLine."VAT Base" + grecVATAmountLine."VAT Amount")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    grecVATAmountLine.GetLine(Number);
                    gVATpercentage[Number] := grecVATAmountLine."VAT %";
                    gBaseVAT[Number] := grecVATAmountLine."VAT Base";
                    gVATAmount[Number] := grecVATAmountLine."VAT Amount";
                    gVATAmountIncluded[Number] := grecVATAmountLine."Amount Including VAT";

                end;

                trigger OnPreDataItem()
                begin
                    if grecVATAmountLine.Count < 1 then
                        CurrReport.Break;
                    SetRange(Number, 1, grecVATAmountLine.Count);
                    CurrReport.CreateTotals(grecVATAmountLine."VAT Base", grecVATAmountLine."VAT Amount");
                end;
            }

            trigger OnAfterGetRecord()
            begin
                if grecSalesTerms.Get("Purchase Header"."Language Code") then;

                if "No." = '' then
                    gOrderNo := ''
                else
                    gOrderNo := FieldName("No.");

                if "Your Reference" = '' then
                    gReference := ''
                else
                    gReference := FieldName("Your Reference");
                if "VAT Registration No." = '' then
                    gVATNo := ''
                else
                    gVATNo := FieldName("VAT Registration No.");

                gTotalInclVAT := StrSubstNo('Totaal %1', grecGeneralLedgerSetup."LCY Code");


                gcuFormatAddress.PurchHeaderBuyFrom(gCustomerAddress, "Purchase Header");


                if "Payment Terms Code" = '' then
                    grecPaymentTerms.Init
                else
                    grecPaymentTerms.Get("Payment Terms Code");
                if "Shipment Method Code" = '' then
                    grecShipmentMethod.Init
                else
                    grecShipmentMethod.Get("Shipment Method Code");

                gcuFormatAddress.PurchHeaderShipTo(gShiptoAddress, "Purchase Header");

                for i := 1 to ArrayLen(gShiptoAddress) do
                    if gShiptoAddress[i] <> gCustomerAddress[i] then
                        gShowShippingAddress := true;
            end;

            trigger OnPreDataItem()
            begin
                grecCompanyInformation.Get;
                grecCompanyInformation.CalcFields(Picture);
                gcuFormatAddress.Company(gCompanyAddress, grecCompanyInformation);
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
        lblPayToVendor = 'Pay-to Vendor';
        lblShipToVendor = 'Ship-to Vendor';
        lblOrderNo = 'Order No.';
        lblVendorNo = 'Vendor No.';
        lblUnit = 'Unit';
        lbltotal = 'Total';
        lblUnitPrice = 'Unit Price';
        lblAmount = 'Amount';
        lblLotNo = 'Lot No.';
        lblGrade = 'Grade';
        lblLineDisc = 'Line Disc.';
        lblSubtotal = 'Sub Total';
        lblInvDiscountAmount = 'Inv. Discount Amount';
        lblRegistrationNo = 'Registration No.';
        lblVatRegistrationNo = 'VAT Registration No.';
        lblHeaderDimensions = 'Header Dimensions';
        lblLineDimensions = 'Line Dimensions';
        lblVatNo = 'VAT No.';
        lbProformaCreditMemo = 'Proforma Credit Memo';
        lblVatPercent = '% VAT';
        lblVATAmount = 'VAT Amount';
        lblPostingDate = 'Posting Date';
        lblDueDate = 'Due Date';
        lblQuantity = 'Quantity';
    }

    trigger OnInitReport()
    begin
        grecGeneralLedgerSetup.Get;
    end;

    var
        grecSalesTerms: Record "Sales Terms";
        grecGeneralLedgerSetup: Record "General Ledger Setup";
        grecShipmentMethod: Record "Shipment Method";
        grecPaymentTerms: Record "Payment Terms";
        grecCompanyInformation: Record "Company Information";
        grecVATAmountLine: Record "VAT Amount Line" temporary;
        gcuFormatAddress: Codeunit "Format Address";
        gCustomerAddress: array[8] of Text[30];
        gShiptoAddress: array[8] of Text[50];
        gCompanyAddress: array[8] of Text[50];
        gOrderNo: Text[30];
        gVATNo: Text[30];
        gReference: Text[30];
        gTotalInclVAT: Text[50];
        gMoreLines: Boolean;
        gNoCopies: Integer;
        gNoLoop: Integer;
        gCopyText: Text[30];
        gShowShippingAddress: Boolean;
        i: Integer;
        grecItemUnitofMeasure: Record "Item Unit of Measure";
        grecUnitofMeasure: Record "Unit of Measure";
        grecUnitofMeasureTranslation: Record "Unit of Measure Translation";
        gPricePerUnit: Text[20];
        gTreated: Text[60];
        grecGrade: Record Grade;
        grecItem: Record Item;
        gAmount: Decimal;
        grecCurrencyExchangeRate: Record "Currency Exchange Rate";
        gAmountLCY: Decimal;
        grecCurrencyExchangeRate2: Record "Currency Exchange Rate";
        gVATNo2: Text[6];
        gTotalNetWeight: Decimal;
        gDiscount: Text[30];
        gExternalDocumentNo: Text[30];
        gDiscountCalculation: Text[10];
        grecVATPostingSetup: Record "VAT Posting Setup";
        gVATpercentage: array[5] of Decimal;
        gBaseVAT: array[5] of Decimal;
        gVATAmount: array[5] of Decimal;
        gVATAmountIncluded: array[5] of Decimal;
        grecItemExtension: Record "Item Extension";
        grecLotNoInformation: Record "Lot No. Information";
        gcuBejoMgt: Codeunit "Bejo Management";
        Text003: Label 'COPY';
        Text004: Label 'Proforma Credit Memo %1';
        Text005: Label 'Page %1';
        Text50000: Label 'When remitting please quote:';
        Text50001: Label 'Inv. discount';
        Text50002: Label 'Increase';
        ReservationEntry: Record "Reservation Entry";

    local procedure GetLotNoInf()
    begin

        ReservationEntry.SetRange("Source Type", 39);
        ReservationEntry.SetRange("Source Subtype", 3);
        ReservationEntry.SetRange("Source ID", "Purchase Line"."Document No.");
        ReservationEntry.SetRange("Source Ref. No.", "Purchase Line"."Line No.");
        if ReservationEntry.FindFirst then begin

            grecLotNoInformation.SetCurrentKey(grecLotNoInformation."Lot No.");
            grecLotNoInformation.SetRange(grecLotNoInformation."Lot No.", ReservationEntry."Lot No.");
            if not grecLotNoInformation.FindFirst then
                grecLotNoInformation.Init;

            if not grecGrade.Get(grecLotNoInformation."B Grade Code") then
                grecGrade.Init;

        end else begin
            grecLotNoInformation.Init;
            grecGrade.Init;
            ReservationEntry.Init;
        end;
    end;
}

