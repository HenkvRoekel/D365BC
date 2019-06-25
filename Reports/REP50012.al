report 50012 "Sales - Invoice Bejo"
{

    DefaultLayout = RDLC;
    RDLCLayout = './RDLC/Sales - Invoice Bejo.rdlc';

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING ("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.";
            column(ReportCaption; ReportCaption)
            {
            }
            column(ShowInternalInfo; ShowInternalInfo)
            {
            }
            column(Text50000; Text50000)
            {
            }
            column(ReportId; '')
            {
            }
            column(CustomerAddress1; CustAddr[1])
            {
            }
            column(CustomerAddress2; CustAddr[2])
            {
            }
            column(CustomerAddress3; CustAddr[3])
            {
            }
            column(CustomerAddress4; CustAddr[4])
            {
            }
            column(CustomerAddress5; CustAddr[5])
            {
            }
            column(CustomerAddress6; CustAddr[6])
            {
            }
            column(ShipToAddr1; ShipToAddr[1])
            {
            }
            column(ShipToAddr2; ShipToAddr[2])
            {
            }
            column(ShipToAddr3; ShipToAddr[3])
            {
            }
            column(ShipToAddr4; ShipToAddr[4])
            {
            }
            column(ShipToAddr5; ShipToAddr[5])
            {
            }
            column(ShipToAddr6; ShipToAddr[6])
            {
            }
            column(CompanyAddress1; CompanyAddr[1])
            {
            }
            column(CompanyAddress2; CompanyAddr[2])
            {
            }
            column(CompanyAddress3; CompanyAddr[3])
            {
            }
            column(CompanyAddress4; CompanyAddr[4])
            {
            }
            column(CompanyPhone; CompanyInfo."Phone No.")
            {
            }
            column(CompanyFax; CompanyInfo."Fax No.")
            {
            }
            column(CompanyEmail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyPhone2; CompanyInfo."Phone No. 2")
            {
            }
            column(CompanyBank; CompanyInfo."Bank Name")
            {
            }
            column(CompanyBranchNo; CompanyInfo."Bank Branch No.")
            {
            }
            column(CompanyBranchNoCaption; CompanyInfo.FieldCaption("Bank Branch No."))
            {
            }
            column(CompanyBankAccountNo; CompanyInfo."Bank Account No.")
            {
            }
            column(CompanyBankAccountNoCaption; CompanyInfo.FieldCaption("Bank Account No."))
            {
            }
            column(CompanyIBAN; CompanyInfo.IBAN)
            {
            }
            column(CompanyIBANCaption; CompanyInfo.FieldCaption(IBAN))
            {
            }
            column(CompanySwift; CompanyInfo."SWIFT Code")
            {
            }
            column(CompanySwiftCaption; CompanyInfo.FieldCaption("SWIFT Code"))
            {
            }
            column(PictureCompanyInfo; CompanyInfo.Picture)
            {
            }
            column(WebsiteCompanyInfo; CompanyInfo."Home Page")
            {
            }
            column(CompanyRegistrationNo; CompanyInfo."Registration No.")
            {
            }
            column(CompanyVATRegistrationNo; CompanyInfo."VAT Registration No.")
            {
            }
            column(CompanyVATRegistrationNoCaption; CompanyInfo.FieldCaption("VAT Registration No."))
            {
            }
            column(CompanyRegistrationNoCaption; TextRegNo)
            {
            }
            column(gVATNo; gVatNo)
            {
            }
            column(CustomerVATNo; Cust."VAT Registration No.")
            {
            }
            column(OrderNo_SalesInvoiceHeader; "Sales Invoice Header"."Order No.")
            {
                IncludeCaption = true;
            }
            column(DueDate_SalesInvoiceHeader; "Sales Invoice Header"."Due Date")
            {
                IncludeCaption = true;
            }
            column(SalespersonCode_SalesInvoiceHeader; "Sales Invoice Header"."Salesperson Code")
            {
            }
            column(ShipmentDate_SalesInvoiceHeader; "Sales Invoice Header"."Shipment Date")
            {
                IncludeCaption = true;
            }
            column(PostingDate_SalesInvoiceHeader; "Sales Invoice Header"."Posting Date")
            {
                IncludeCaption = true;
            }
            column(BilltoCustomerNo_SalesInvoiceHeader; "Sales Invoice Header"."Bill-to Customer No.")
            {
            }
            column(No_SalesInvoiceHeader; "Sales Invoice Header"."No.")
            {
            }
            column(Grossweight_SalesInvoiceHeader; "Sales Invoice Header"."B Gross weight")
            {
                IncludeCaption = true;
            }
            column(Netweight_SalesInvoiceHeader; "Sales Invoice Header"."B Reserved weight")
            {
            }
            column(Contents_SalesInvoiceHeader; "Sales Invoice Header"."B Contents")
            {
                IncludeCaption = true;
            }
            column(VATRegistrationNo_SalesInvoiceHeader; "Sales Invoice Header"."VAT Registration No.")
            {
            }
            column(PaymentTerms; PaymentTerms.Description)
            {
            }
            column(PaymentMethod; "Sales Invoice Header"."Payment Method Code")
            {
            }
            column(stDescription; grecSalesTerms.Description)
            {
            }
            column(stDescription2; grecSalesTerms."Description 2")
            {
            }
            column(stDescription3; grecSalesTerms."Description 3")
            {
            }
            column(stDescription4; grecSalesTerms."Description 4")
            {
            }
            column(stDescription5; grecSalesTerms."Description 5")
            {
            }
            column(stDescription6; grecSalesTerms."Description 6")
            {
            }
            column(OutputNo; OutputNo)
            {
            }
            column(DataString_FixedHeader; DataFixedHeader)
            {
            }
            column(DataString_Header; DataHeader)
            {
            }
            column(DataString_CaptionHeader; DataCaptionHeader)
            {
            }
            column(DataString_Footer; DataFooter)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(InvoiceTotalAmountInclVAT; InvoiceTotalAmountInclVAT)
            {
            }
            column(TotalText; TotalText)
            {
            }
            column(TotalIncludingVATText; TotalInclVATText)
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING (Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING (Number) WHERE (Number = CONST (1));
                    dataitem("Sales Invoice Line"; "Sales Invoice Line")
                    {
                        DataItemLink = "Document No." = FIELD ("No.");
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = SORTING ("Document No.", "Line No.");
                        column(LineNo_SalesInvoiceLine; "Sales Invoice Line"."Line No.")
                        {
                        }
                        column(TaxRecapitulationCaption; TaxRecapitulationCaption)
                        {
                        }
                        column(Type_SalesInvoiceLine; Format("Sales Invoice Line".Type, 0, 2))
                        {
                        }
                        column(Quantity_SalesInvoiceLine; "Sales Invoice Line".Quantity)
                        {
                            IncludeCaption = true;
                        }
                        column(QuantityBase_SalesInvoiceLine; Format("Sales Invoice Line"."Quantity (Base)", 0, 0))
                        {
                        }
                        column(ExternalDocumentNo_SalesInvoiceLine; "Sales Invoice Line"."B External Document No.")
                        {
                            IncludeCaption = true;
                        }
                        column(UnitPrice_SalesInvoiceLine; "Sales Invoice Line"."Unit Price")
                        {
                            IncludeCaption = true;
                        }
                        column(Amount_SalesInvoiceLine; "Sales Invoice Line".Amount)
                        {
                            IncludeCaption = true;
                        }
                        column(Description_SalesInvoiceLine; "Sales Invoice Line".Description)
                        {
                            IncludeCaption = true;
                        }
                        column(Description2_SalesInvoiceLine; "Sales Invoice Line"."Description 2")
                        {
                            IncludeCaption = true;
                        }
                        column(No_SalesInvoiceLine; "Sales Invoice Line"."No.")
                        {
                        }
                        column(AmountIncludingVAT_SalesInvoiceLine; "Sales Invoice Line"."Amount Including VAT")
                        {
                        }
                        column(UoM_SalesLine; gUnitOfMeasure."B Description for Reports")
                        {
                        }
                        column(DimesionTextHeader; gDimTextHeader)
                        {
                        }
                        column(DimensionTextLine; gDimText)
                        {
                        }
                        column(gTextTreated; gTextTreated)
                        {
                        }
                        column(gTextPer; gTextPer)
                        {
                        }
                        column(PricePerQty_Crops; grecCrops."Price per Qty.")
                        {
                        }
                        column(gPricePer; gPricePer)
                        {
                        }
                        column(LineDiscount; LineDiscount)
                        {
                        }
                        column(gDiscountSurcharge; gDiscountSurcharge)
                        {
                        }
                        column(InvDiscountAmount_SalesInvoiceLine; -"Sales Invoice Line"."Inv. Discount Amount")
                        {
                        }
                        column(ItemTextLine; gItemLineText)
                        {
                        }
                        column(gTreatmentCode; gTreatmentCode)
                        {
                        }
                        column(VAT_SalesInvoiceLine; "Sales Invoice Line"."VAT %")
                        {
                        }
                        column(VAT_SalesInvoiceLineCaption; "Sales Invoice Line".FieldCaption("VAT %"))
                        {
                        }
                        column(GradeDescription; grecGrade.Description)
                        {
                        }
                        column(CountryOfOrigine; gCountryOforigin)
                        {
                        }
                        column(PhytoCertificate; gPhytoCertificate)
                        {
                        }
                        column(LotNo_LotNoInformation; LotNoInf."Lot No.")
                        {
                        }
                        column(Test_Date; Testdate)
                        {
                        }
                        column(Germination; LotNoInf."B Germination")
                        {
                        }
                        column(gtxTreatmentText; gtxTreatmentText)
                        {
                        }
                        column(ExternalDocNo_SalesInvoiceLine; "Sales Invoice Line"."B External Document No.")
                        {
                        }
                        dataitem("Sales Comment Line"; "Sales Comment Line")
                        {
                            DataItemLink = "No." = FIELD ("Document No."), "Document Line No." = FIELD ("Line No.");
                            DataItemTableView = SORTING ("Document Type", "No.", "Document Line No.", "Line No.") WHERE ("Document Type" = CONST ("Posted Invoice"));
                            column(LineNoSalesCommentLine; "Sales Comment Line"."Line No.")
                            {
                            }
                            column(CommentSalesCommentLine; "Sales Comment Line".Comment)
                            {
                            }

                            trigger OnPreDataItem()
                            var
                                SalesCommentLine: Record "Sales Comment Line";
                            begin
                                SalesCommentLine.SetRange("Document Type", SalesCommentLine."Document Type"::"Posted Invoice");
                                SalesCommentLine.SetRange("No.", "Sales Invoice Line"."Document No.");
                                SalesCommentLine.SetRange("Document Line No.", "Sales Invoice Line"."Line No.");
                                if SalesCommentLine.IsEmpty then
                                    CurrReport.Break;
                            end;
                        }

                        trigger OnAfterGetRecord()
                        var
                            lUnitofMeasure: Record "Unit of Measure";
                        begin
                            if (Type = Type::"G/L Account") and (not ShowInternalInfo) then
                                "No." := '';
                            if (Type = Type::Item) and (Quantity = 0) then
                                CurrReport.Skip;

                            VATAmountLine.Init;
                            VATAmountLine."VAT Identifier" := "VAT Identifier";
                            VATAmountLine."VAT Calculation Type" := "VAT Calculation Type";
                            VATAmountLine."Tax Group Code" := "Tax Group Code";
                            VATAmountLine."VAT %" := "VAT %";
                            VATAmountLine."VAT Base" := Amount;
                            VATAmountLine."Amount Including VAT" := "Amount Including VAT";
                            VATAmountLine."Line Amount" := "Line Amount";

                            if "Allow Invoice Disc." then
                                VATAmountLine."Inv. Disc. Base Amount" := "Line Amount";
                            VATAmountLine."Invoice Discount Amount" := "Inv. Discount Amount";
                            VATAmountLine.InsertLine;

                            if grecItem.Get("Sales Invoice Line"."No.") then;

                            if Type = Type::Item then begin
                                gTextPer := Text50007;
                                if not grecCrops.Get(CopyStr("Sales Invoice Line"."No.", 1, 2)) then
                                    grecCrops.Init;
                                if ("Qty. per Unit of Measure" <> 0) and (grecCrops."Price per Qty." <> 0) then
                                    gPricePer := "Unit Price" / "Qty. per Unit of Measure" * grecCrops."Price per Qty.";
                                lUnitofMeasure.Get(grecItem."Base Unit of Measure");
                                if lUnitofMeasure."B Unit in Weight" then begin

                                    gPricePer := "Unit Price" / "Qty. per Unit of Measure";
                                    grecCrops."Price per Qty." := 1;
                                end;
                                if (CopyStr("Sales Invoice Line"."No.", 1, 2) >= '51') and (CopyStr("Sales Invoice Line"."No.", 1, 2) <= '57') then begin
                                    if "Sales Invoice Line"."Qty. per Unit of Measure" = 10000 then begin
                                        gPricePer := 0;
                                        grecCrops."Price per Qty." := 0;
                                        gTextPer := '';
                                    end;
                                end;
                            end;

                            if not grecItemExt.Get(grecItem."B Extension", "Sales Invoice Header"."Language Code") then
                                grecItemExt.Init;
                            gTextTreated := '';
                            if (grecItemExt.Extension < '6') then
                                gTextTreated := grecItemExt.Description;
                            if (grecItemExt.Extension = '5') then
                                gTextTreated := TextNCB;

                            Clear(LotNoInf);


                            InvRowID := gcuItemTrackingMgt.ComposeRowID(113, 0, "Sales Invoice Line"."Document No.", '', 0, "Sales Invoice Line"."Line No.");
                            ValueEntryRelation.SetCurrentKey("Source RowId");
                            ValueEntryRelation.SetRange("Source RowId", InvRowID);
                            if ValueEntryRelation.FindFirst then begin

                                if ValueEntry.Get(ValueEntryRelation."Value Entry No.") then
                                    if ItemLedgerEntry.Get(ValueEntry."Item Ledger Entry No.") then begin

                                        LotNoInf.SetRange("Item No.", ItemLedgerEntry."Item No.");
                                        LotNoInf.SetRange("Lot No.", ItemLedgerEntry."Lot No.");
                                        if LotNoInf.FindFirst then
                                            GetLotNoInformation();

                                    end;

                            end;

                            gDimTextHeader := '';
                            gRECDefaultDimension.SetRange(gRECDefaultDimension."No.", "Sales Invoice Line"."Sell-to Customer No.");
                            if gRECDefaultDimension.FindFirst then begin
                                gDimTextHeader := StrSubstNo('%1 %2', gRECDefaultDimension."Dimension Code", gRECDefaultDimension."Dimension Value Code");
                            end;
                            gRECDefaultDimension.SetRange(gRECDefaultDimension."No.", "Sales Invoice Line"."B Salesperson");
                            if gRECDefaultDimension.FindFirst then begin
                                gDimTextHeader := StrSubstNo('%1, %2 %3', gDimTextHeader, gRECDefaultDimension."Dimension Code", gRECDefaultDimension."Dimension Value Code");
                            end;


                            gDimText := '';
                            gRECDefaultDimension.SetRange(gRECDefaultDimension."No.", "Sales Invoice Line"."No.");
                            if (gRECDefaultDimension.FindSet) then begin
                                repeat
                                    gDimText += StrSubstNo('%1 %2, ', gRECDefaultDimension."Dimension Code", gRECDefaultDimension."Dimension Value Code")
                                until gRECDefaultDimension.Next = 0;
                            end;


                            if "Sales Invoice Line"."Inv. Discount Amount" < 0 then
                                gDiscountSurcharge := Text50005;
                            if "Inv. Discount Amount" > 0 then
                                gDiscountSurcharge := Text50006;



                            LineDiscount := '';
                            if "Sales Invoice Line"."Line Discount %" <> 0 then
                                LineDiscount := Format(Round("Sales Invoice Line"."Line Discount %", 0.01) * -1) + ' %';


                            if not gUnitOfMeasure.Get("Unit of Measure Code") then
                                gUnitOfMeasure.Init;

                        end;

                        trigger OnPreDataItem()
                        begin
                            VATAmountLine.DeleteAll;
                            MoreLines := Find('+');
                            while MoreLines and (Description = '') and ("No." = '') and (Quantity = 0) and (Amount = 0) do
                                MoreLines := Next(-1) <> 0;
                            if not MoreLines then
                                CurrReport.Break;
                            SetRange("Line No.", 0, "Line No.");
                            CurrReport.CreateTotals("Line Amount", Amount, "Amount Including VAT", "Inv. Discount Amount");
                        end;
                    }
                    dataitem(VATCounter; "Integer")
                    {
                        DataItemTableView = SORTING (Number);
                        column(VATAmtLineVATBase; VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmt; VATAmountLine."VAT Amount")
                        {
                        }
                        column(VATAmtLineVATPer; VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmtLineVATIdentifier; VATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATAmountLineSubTotal; VATAmountLineSubTotal)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin

                            VATAmountLine.GetLine(Number);


                            "V%"[Number] := VATAmountLine."VAT %";
                            VBasis[Number] := VATAmountLine."VAT Base";
                            VAmount[Number] := VATAmountLine."VAT Amount";


                            VATAmountLineSubTotal := VATAmountLine."VAT Base" + VATAmountLine."VAT Amount";
                        end;

                        trigger OnPreDataItem()
                        begin

                            Clear("V%");
                            Clear(VBasis);
                            Clear(VAmount);
                            Clear(VPrint);


                            SetRange(Number, 1, VATAmountLine.Count);
                            CurrReport.CreateTotals(
                              VATAmountLine."Line Amount", VATAmountLine."Inv. Disc. Base Amount",
                              VATAmountLine."Invoice Discount Amount", VATAmountLine."VAT Base", VATAmountLine."VAT Amount");
                        end;
                    }
                    dataitem(VATSpecificationPrint; "Integer")
                    {
                        DataItemTableView = SORTING (Number) WHERE (Number = CONST (1));
                        column(VATPercent1; "V%"[1])
                        {
                        }
                        column(VATPercent2; "V%"[2])
                        {
                        }
                        column(VATPercent3; "V%"[3])
                        {
                        }
                        column(VBasis1; VBasis[1])
                        {
                        }
                        column(VBasis2; VBasis[2])
                        {
                        }
                        column(VBasis3; VBasis[3])
                        {
                        }
                        column(VAmount1; VAmount[1])
                        {
                        }
                        column(VAmount2; VAmount[2])
                        {
                        }
                        column(VAmount3; VAmount[3])
                        {
                        }
                        column(TotalVATAmt1; VBasis[1] + VAmount[1])
                        {
                        }
                        column(TotalVATAmt2; VBasis[2] + VAmount[2])
                        {
                        }
                        column(TotalVATAmt3; VBasis[3] + VAmount[3])
                        {
                        }
                        column(VATBase; VBasis[1] + VBasis[2] + VBasis[3])
                        {
                        }
                        column(VATAmount; VAmount[1] + VAmount[2] + VAmount[3])
                        {
                        }
                        column(TotalVATAmount; VBasis[1] + VBasis[2] + VBasis[3] + VAmount[1] + VAmount[2] + VAmount[3])
                        {
                        }
                        column(CurrencyText; gtxCurrency)
                        {
                        }
                        column(CurrencyBankAccount; gtxCurrencyBankAcc)
                        {
                        }

                        trigger OnAfterGetRecord()
                        var
                            ldeVatAmount: Decimal;
                            ldeVatBase: Decimal;
                        begin
                            gtxCurrency := '';
                            gtxCurrencyBankAcc := '';

                            if "Sales Invoice Header"."Currency Code" = 'EUR' then begin
                                greBejoSetup.Get;
                                if not greCurrencyExchangeRate.Get("Sales Invoice Header"."Currency Code", greBejoSetup."Begin Date") then
                                    greCurrencyExchangeRate.Init;

                                ldeVatBase := VBasis[1] + VBasis[2] + VBasis[3];
                                ldeVatBase := Round(ldeVatBase * greCurrencyExchangeRate."Relational Exch. Rate Amount", 0.01);

                                ldeVatAmount := VAmount[1] + VAmount[2] + VAmount[3];
                                ldeVatAmount := Round(ldeVatAmount * greCurrencyExchangeRate."Relational Exch. Rate Amount", 0.01);


                            end;
                        end;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        SetDataReport;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    if Number > 1 then begin
                        CopyText := Text003;
                        OutputNo += 1;
                    end;
                    CurrReport.PageNo := 1;
                    ClearVariables;
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := Abs(NoOfCopies) + Cust."Invoice Copies" + 1;
                    if NoOfLoops <= 0 then
                        NoOfLoops := 1;
                    CopyText := '';
                    SetRange(Number, 1, NoOfLoops);
                    OutputNo := 1;
                end;
            }

            trigger OnAfterGetRecord()
            var
                lblItemNo: Integer;
                SalesInvoiceLine: Record "Sales Invoice Line";
            begin
                CurrReport.Language := Language.GetLanguageID("Language Code");


                if grecSalesTerms.Get("Language Code") then;

                if RespCenter.Get("Responsibility Center") then begin
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                end else begin
                    CompanyInfo.Get;
                    FormatAddr.Company(CompanyAddr, CompanyInfo);
                end;
                CompanyInfo.CalcFields(Picture);

                if "Order No." = '' then
                    OrderNoText := ''
                else
                    OrderNoText := FieldCaption("Order No.");
                if "Salesperson Code" = '' then begin
                    SalesPurchPerson.Init;
                    SalesPersonText := '';
                end else begin
                    SalesPurchPerson.Get("Salesperson Code");
                    SalesPersonText := Text000;
                end;
                if "Your Reference" = '' then
                    ReferenceText := ''
                else
                    ReferenceText := FieldCaption("Your Reference");
                if "VAT Registration No." = '' then
                    VATNoText := ''
                else
                    VATNoText := FieldCaption("VAT Registration No.");

                GLSetup.Get;
                if "Currency Code" = '' then begin
                    GLSetup.TestField("LCY Code");
                    TotalText := StrSubstNo(Text001, GLSetup."LCY Code");
                    TotalInclVATText := StrSubstNo(Text002, GLSetup."LCY Code");
                    TotalExclVATText := StrSubstNo(Text006, GLSetup."LCY Code");
                end else begin
                    TotalText := StrSubstNo(Text001, "Currency Code");
                    TotalInclVATText := StrSubstNo(Text002, "Currency Code");
                    TotalExclVATText := StrSubstNo(Text006, "Currency Code");
                end;

                FormatAddr.SalesInvBillTo(CustAddr, "Sales Invoice Header");
                Cust.Get("Bill-to Customer No.");

                if "Payment Terms Code" = '' then
                    PaymentTerms.Init
                else
                    PaymentTerms.Get("Sales Invoice Header"."Payment Terms Code");

                if "Shipment Method Code" = '' then
                    ShipmentMethod.Init
                else
                    ShipmentMethod.Get("Sales Invoice Header"."Shipment Method Code");

                ShowShippingAddr := FormatAddr.SalesInvShipTo(ShipToAddr, CustAddr, "Sales Invoice Header");

                if not Country.Get(CompanyInfo."Country/Region Code") then
                    Country.Init;
                if not grecSalesTerms.Get("Sales Invoice Header"."Language Code") then
                    grecSalesTerms.Init;
                if not "Shipping Agent".Get("Shipping Agent Code") then
                    "Shipping Agent".Init;


                if DueDate <> 0D then
                    "Sales Invoice Header"."Due Date" := DueDate;

                if PaymTerms = false then
                    PaymentTerms.Description := '';


                if not CurrReport.Preview then
                    SalesInvCountPrinted.Run("Sales Invoice Header");


                InvoiceTotalAmountInclVAT := 0;
                SalesInvoiceLine.SetRange("Document No.", "No.");
                if SalesInvoiceLine.FindSet then begin
                    repeat
                        InvoiceTotalAmountInclVAT += SalesInvoiceLine."Amount Including VAT";
                    until SalesInvoiceLine.Next = 0;
                end;
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
                    field(NoOfCopies; NoOfCopies)
                    {
                        Caption = 'No. of Copies';
                        ApplicationArea = All;
                    }
                    field(ShowInternalInfo; ShowInternalInfo)
                    {
                        Caption = 'Show Internal Info';
                        ApplicationArea = All;
                    }
                    field(DueDate; DueDate)
                    {
                        Caption = 'Due Date';
                        ApplicationArea = All;
                    }
                    field(PaymTerms; PaymTerms)
                    {
                        Caption = 'Payment Terms';
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
            DueDate := 0D;
            PaymTerms := true;
        end;
    }

    labels
    {
        lblItemNo = 'Item No.';
        lblPhytoCertificate = 'Phyto Certificate';
        lblLotNo = 'Lot No.';
        lblGrade = 'Grade';
        lblCountryOfOrigin = 'Country of Origin';
        lblUnit = 'Unit';
        lblTotal = 'Total';
        lblPurchaseOrder = 'Purch. Order';
        lblPrice = 'Price';
        lblHeaderDimensions = 'Header Dimensions';
        lblLineDimensions = 'Line Dimensions';
        lblVATPercent = '% VAT';
        lblVATAmount = 'VAT Amount';
        lblSubTotal = 'Subtotal';
        lblShipToCustomer = 'Ship-to Customer';
        lblBillToCustomer = 'Bill-to Customer';
        lblSalesperson = 'Salesperson';
        lblInvoiceNo = 'Invoice No.';
        lblCustomerNo = 'Customer No.';
        lblShipmentMethods = 'Shipment Method';
        lblShipmentTerms = 'Shipment Terms';
        lblPaymentTerms = 'Payment Terms';
        lblNetWeight = 'Net Weight';
        lblPaymentMethod = 'Payment Method';
        lblReportCaption = 'Sales - Invoice';
        lblLineDisc = 'Line Disc.';
        lblPage = 'Page:';
        lblRegNo = 'Registration No.:';
        lblVATRegNo = 'VAT Registration No.:';
        lblVATDate = 'Invoice Date';
        lblVATBase = 'VAT Base';
        lblIssuedBy = 'Issued By:';
    }

    trigger OnPreReport()
    begin
        if not IsaCopy then
            ReportCaption := SalesInvoice
        else
            ReportCaption := SalesInvoiceCopy;
    end;

    var
        GLSetup: Record "General Ledger Setup";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        Cust: Record Customer;
        VATAmountLine: Record "VAT Amount Line" temporary;
        RespCenter: Record "Responsibility Center";
        Language: Record Language;
        SalesInvCountPrinted: Codeunit "Sales Inv.-Printed";
        FormatAddr: Codeunit "Format Address";
        SegManagement: Codeunit SegManagement;
        CustAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        OrderNoText: Text[30];
        SalesPersonText: Text[30];
        VATNoText: Text[30];
        ReferenceText: Text[30];
        TotalText: Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        MoreLines: Boolean;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        ShowShippingAddr: Boolean;
        i: Integer;
        OldDimText: Text[75];
        ShowInternalInfo: Boolean;
        Continue: Boolean;
        LogInteraction: Boolean;
        grecSalesTerms: Record "Sales Terms";
        "V%": array[10] of Decimal;
        VBasis: array[10] of Decimal;
        VAmount: array[10] of Decimal;
        VPrint: array[10] of Boolean;
        grecGrade: Record Grade;
        gTextTreated: Text[60];
        gcuItemTrackingMgt: Codeunit "Item Tracking Management";
        Country: Record "Country/Region";
        Germ: Text[30];
        Phone: Text[30];
        grecCrops: Record Crops;
        grecItem: Record Item;
        grecItemExt: Record "Item Extension";
        LineDiscount: Text[30];
        gDiscountSurcharge: Text[30];
        DueDate: Date;
        PaymTerms: Boolean;
        VatAmount: Decimal;
        gPricePer: Decimal;
        gTextPer: Text[10];
        ValueEntryRelation: Record "Value Entry Relation";
        InvRowID: Text[100];
        gVatNo: Text[10];
        "Shipping Agent": Record "Shipping Agent";
        grecTreatmentCode: Record "Treatment Code";
        gTreatmentCode: Text[50];
        gUnitOfMeasure: Record "Unit of Measure";
        gPhytoCertificate: Code[20];
        gCountryOforigin: Code[20];
        gShipmentNotification: Record "Shipment Notification";
        gCustomer: Record Customer;
        Text000: Label 'Salesperson';
        Text001: Label 'Total %1';
        Text002: Label 'Total %1 Incl. VAT';
        Text003: Label 'COPY';
        Text004: Label 'Sales - Invoice %1';
        Text005: Label 'Page %1';
        Text006: Label 'Total %1 Excl. VAT';
        Text50000: Label 'When remitting please quote:';
        Text50005: Label 'Discount';
        Text50006: Label 'Invoice Discount';
        gDimText: Text[120];
        gDimTextHeader: Text[120];
        gRECDefaultDimension: Record "Default Dimension";
        gItemLineText: Text[100];
        gRECLineText: Record "Sales Comment Line";
        TextNCB: Label 'Not chemically treated + HWT';
        Testdate: Text[30];
        "-LOC-": Integer;
        greTreatmentCode: Record "Treatment Code";
        gtxTreatmentText: Text;
        greBejoSetup: Record "Bejo Setup";
        greCurrencyExchangeRate: Record "Currency Exchange Rate";
        Text50013: Label 'Amount ';
        Text50014: Label 'VAT Amount ';
        Text50015: Label 'Total ';
        Text50016: Label 'Rate ';
        gtxCurrency: Text;
        gtxCurrencyBankAcc: Text;
        TextRegNo: Label 'Registration No.';
        Text50007: Label 'per';
        Text50017: Label ' Kƒ; ';
        Text50018: Label ' Kƒ/EUR';
        TaxRecapitulationCaption: Label 'VAT';
        IsaCopy: Boolean;
        SalesInvoice: Label 'Sales Invoice';
        SalesInvoiceCopy: Label 'Sales Invoice COPY';
        ReportCaption: Text;
        ValueEntry: Record "Value Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
        LotNoInf: Record "Lot No. Information";
        "//new vars": Integer;
        OutputNo: Integer;
        DataFixedHeader: Text;
        DataCaptionHeader: Text;
        DataHeader: Text;
        DataFooter: Text;
        "////": Label '';
        Text101: Label 'Tel: ';
        Text102: Label 'E-mail: ';
        Text103: Label 'Website: ';
        Text104: Label 'Page';
        Text105: Label 'When remitting please quote:';
        Text106: Label 'Customer No.';
        Text108: Label 'Invoice No.';
        Text109: Label 'Invoice Date';
        Text110: Label 'Ship-to Customer';
        Text111: Label 'Total';
        Text112: Label 'Lot No.';
        Text113: Label 'Grade';
        Text114: Label 'Country of Origin';
        Text115: Label 'Line Disc.';
        Text116: Label 'Header Dimensions';
        Text117: Label 'Not chemically treated + HWT';
        Text118: Label 'Line Dimensions';
        Text119: Label 'Sales Invoice';
        Text120: Label 'Bill-to Customer';
        Text401: Label 'Gross Weight';
        Text403: Label 'Net Weight';
        Text405: Label 'Contents';
        Text407: Label 'Shipment Method';
        Text409: Label 'Shipment Terms';
        Text411: Label 'Payment Terms';
        Text413: Label 'Payment Method';
        VATAmtSpecificationCptnLbl: Label 'VAT Amount Specification';
        InvDiscBaseAmtCaptionLbl: Label 'Invoice Discount Base Amount';
        LineAmtCaptionLbl: Label 'Line Amount';
        VATPercentageCaptionLbl: Label 'VAT %';
        TotalCaptionLbl: Label 'Total';
        VATBaseCaptionLbl: Label 'VAT Base';
        VATAmtCaptionLbl: Label 'VAT Amount';
        VATIdentifierCaptionLbl: Label 'VAT Identifier';
        InvDiscountAmtCaptionLbl: Label 'Invoice Discount Amount';
        SubtotalCaptionLbl: Label 'Subtotal';
        LineAmtAfterInvDiscCptnLbl: Label 'Payment Discount on VAT';
        VATAmountLineSubTotal: Decimal;
        InvoiceTotalAmountInclVAT: Decimal;
        Text301: Label 'Item No.';
        Text302: Label 'Description';
        Text303: Label 'Quantity';
        Text304: Label 'Unit';
        Text305: Label 'Total';
        Text306: Label 'Unit Price';
        Text307: Label 'Amount';
        Text308: Label 'VAT %';
        Text310: Label 'Lot No.';
        Text311: Label 'Grade';
        Text313: Label 'Country of Origin';
        Text315: Label 'Line Disc.';
        Text316: Label 'Tsw. in gr.';
        Text317: Label 'Germ.';
        Text318: Label 'Best used by';
        Text312: Label 'External Doc. No.';

    procedure InitLogInteraction()
    begin
        LogInteraction := SegManagement.FindInteractTmplCode(4) <> '';
    end;

    procedure SetParameters(TheShowInternalInfo: Boolean; TheDueDate: Date; ThePaymTerms: Boolean; TheIsaCopy: Boolean)
    begin
        ShowInternalInfo := TheShowInternalInfo;
        DueDate := TheDueDate;
        PaymTerms := ThePaymTerms;
        IsaCopy := TheIsaCopy;
    end;

    local procedure GetLotNoInformation()
    begin

        gCountryOforigin := '';
        gPhytoCertificate := '';
        if gCustomer.Get("Sales Invoice Header"."Bill-to Customer No.") then begin
            if gCustomer."B Country of Origin and PhytoC" then begin
                gShipmentNotification.Reset;
                gShipmentNotification.SetRange("Lot No.", LotNoInf."Lot No.");
                if gShipmentNotification.FindSet then begin
                    repeat
                        if gCountryOforigin = '' then
                            gCountryOforigin := gShipmentNotification."Country of Origin"
                        else
                            gCountryOforigin := gCountryOforigin + ', ' + gShipmentNotification."Country of Origin";
                        gPhytoCertificate := gShipmentNotification."Phyto Certificate No.";
                    until gShipmentNotification.Next = 0;
                end;
            end;
        end;


        if not grecGrade.Get(LotNoInf."B Grade Code") then
            grecGrade.Init;

        if LotNoInf."B Germination" <> 0 then
            Germ := Format(LotNoInf."B Germination") + ' %'
        else
            Germ := '';

        if CopyStr(LotNoInf."Item No.", 1, 2) = '68' then
            case CopyStr(LotNoInf."Item No.", 6, 1) of
                '1', '2', '3', '4', '5', '6', '7':
                    grecGrade.Description := '';
            end;

        if CopyStr(LotNoInf."Item No.", 1, 2) = '81' then
            case CopyStr(LotNoInf."Item No.", 6, 1) of
                '5':
                    grecGrade.Description := '';
            end;

        if CopyStr(LotNoInf."Item No.", 1, 2) = '84' then
            case CopyStr(LotNoInf."Item No.", 6, 1) of
                '1', '4', '5':
                    grecGrade.Description := '';
            end;

        if CopyStr(LotNoInf."Item No.", 1, 2) = '89' then
            case CopyStr(LotNoInf."Item No.", 6, 1) of
                '1', '4', '5':
                    grecGrade.Description := '';
            end;


        gtxTreatmentText := '';
        if greTreatmentCode.Get(LotNoInf."B Treatment Code") then
            gtxTreatmentText := greTreatmentCode."Description Reports";

    end;

    local procedure "===New functions"()
    begin
    end;

    local procedure SetDataReport()
    var
        ColumnNo: Integer;
    begin
        DataFixedHeader := SetDataFixedHeader;
        DataHeader := SetDataHeader;
        DataCaptionHeader := SetDataCaptionHeader;
        DataFooter := SetDataFooter;
    end;

    local procedure SetDataFixedHeader(): Text
    var
        Char177: Char;
    begin
        Char177 := 177;
        exit(
          CompanyAddr[1] + Format(Char177) +                                                                                //(1,1)
          CompanyAddr[2] + Format(Char177) +                                                                                //(2,1)
          CompanyAddr[3] + Format(Char177) +                                                                                //(3,1)
          Text101 + CompanyInfo."Phone No." + Format(Char177) +                                                             //(4,1)
          Text102 + CompanyInfo."E-Mail" + Format(Char177) +                                                                //(5,1)
          Text103 + CompanyInfo."Home Page" + Format(Char177) +                                                             //(6,1)
          CompanyInfo."Bank Name" + Format(Char177) +                                                                       //(7,1)
          CompanyInfo."Bank Account No." + Format(Char177) +                                                                //(8,1)
          CompanyInfo.FieldCaption(IBAN) + ': ' + CompanyInfo.IBAN + Format(Char177) +                                      //(9,1)
          CompanyInfo.FieldCaption("SWIFT Code") + ': ' + CompanyInfo."SWIFT Code" + Format(Char177) +                      //(10,1)
          CompanyInfo.FieldCaption("Registration No.") + ': ' + CompanyInfo."Registration No." + Format(Char177) +          //(11,1)
          CompanyInfo.FieldCaption("VAT Registration No.") + ': ' + CompanyInfo."VAT Registration No." + Format(Char177) +  //(12,1)
          Text104 + Format(Char177) +                                                                                      //(13,1)
          '' + Format(Char177) +                                                                                            //(14,1)
          Text105 + Format(Char177) +                                                                                       //(15,1)
          ' '
          );
    end;

    local procedure SetDataCaptionHeader(): Text
    var
        Char177: Char;
    begin
        Char177 := 177;
        exit(
          Text301 + Format(Char177) +     //(1,3)
          Text302 + Format(Char177) +     //(2,3)
          Text303 + Format(Char177) +     //(3,3)
          Text304 + Format(Char177) +     //(4,3)
          Text305 + Format(Char177) +     //(5,3)
          Text306 + Format(Char177) +     //(6,3)
          Text307 + Format(Char177) +     //(7,3)
          Text308 + Format(Char177) +     //(8,3)
          '' + Format(Char177) +          //(9,3)
          Text112 + Format(Char177) +     //(10,3)
          Text113 + Format(Char177) +     //(11,3)
          Text318 + Format(Char177) +     //(12,3)
          '' + Format(Char177) +          //(13,3)
          Text312 + Format(Char177) +     //(14,3)
          Text315 + Format(Char177) +     //(15,3)
          '' + Format(Char177) +          //(16,3)
          ' '
          );
    end;

    local procedure SetDataHeader(): Text
    var
        Char177: Char;
    begin
        Char177 := 177;
        exit(
        Text108 + Format(Char177) +                                                     //(1,2)
        "Sales Invoice Header"."No." + Format(Char177) +                                //(2,2)
        Text106 + Format(Char177) +                                                     //(3,2)
        "Sales Invoice Header"."Bill-to Customer No." + Format(Char177) +               //(4,2)
        "Sales Invoice Header".FieldCaption("Order No.") + Format(Char177) +            //(5,2)
        "Sales Invoice Header"."Order No." + Format(Char177) +                          //(6,2)
        "Sales Invoice Header".FieldCaption("Posting Date") + Format(Char177) +         //(7,2)
        Format("Sales Invoice Header"."Posting Date") + Format(Char177) +               //(8,2)
        "Sales Invoice Header".FieldCaption("Due Date") + Format(Char177) +             //(9,2)
        Format("Sales Invoice Header"."Due Date") + Format(Char177) +                   //(10,2)
        Text109 + Format(Char177) +                                                     //(11,2)
        Text119 + ' ' + CopyText + Format(Char177) +                                     //(12,2)
        Text120 + Format(Char177) +                                                     //(13,2)
        CustAddr[1] + Format(Char177) +                                                 //(14,2)
        CustAddr[2] + Format(Char177) +                                                 //(15,2)
        CustAddr[3] + Format(Char177) +                                                 //(16,2)
        CustAddr[4] + Format(Char177) +                                                 //(17,2)
        CompanyInfo.FieldCaption("Registration No.") + Format(Char177) +                //(18,2)
        "Sales Invoice Header".FieldCaption("VAT Registration No.") + Format(Char177) + //(19,2)
        "Sales Invoice Header"."VAT Registration No." + Format(Char177) +               //(20,2)
        Text110 + Format(Char177) +                                                     //(21,2)
        ShipToAddr[1] + Format(Char177) +                                               //(22,2)
        ShipToAddr[2] + Format(Char177) +                                               //(23,2)
        ShipToAddr[3] + Format(Char177) +                                               //(24,2)
        ShipToAddr[4] + Format(Char177) +                                               //(25,2)
        ShipToAddr[5] + Format(Char177) +                                               //(26,2)
        "Sales Invoice Header"."External Document No." + Format(Char177) +              //(27,2)
        Text312 + Format(Char177) +                                                     //(28,2)
        ' '
          );
    end;

    local procedure SetDataFooter(): Text
    var
        Char177: Char;
    begin
        Char177 := 177;
        exit(
          Text401 + Format(Char177) +                                                 //(1,4)
          Format("Sales Invoice Header"."B Gross weight") + Format(Char177) +         //(2,4)
          Text403 + Format(Char177) +                                                 //(3,4)
          Format("Sales Invoice Header"."B Reserved weight") + Format(Char177) +       //(4,4)
          Text405 + Format(Char177) +                                                 //(5,4)
          "Sales Invoice Header"."B Contents" + Format(Char177) +                     //(6,4)
          Text407 + Format(Char177) +                                                 //(7,4)
          '' + Format(Char177) +                                                      //(8,4)
          Text409 + Format(Char177) +                                                 //(9,4)
          '' + Format(Char177) +                                                      //(10,4)
          Text411 + Format(Char177) +                                                 //(11,4)
          PaymentTerms.Description + Format(Char177) +                                //(12,4)
          Text413 + Format(Char177) +                                                 //(13,4)
          "Sales Invoice Header"."Payment Method Code" + Format(Char177) +            //(14,4)
          grecSalesTerms.Description + Format(Char177) +                              //(15,4)
          grecSalesTerms."Description 2" + Format(Char177) +                          //(16,4)
          ' '
          );
    end;

    local procedure ClearVariables()
    begin
        Clear("V%");
        Clear(VAmount);
        Clear(VBasis);
        Clear(gtxCurrency);
        Clear(gtxCurrencyBankAcc);
        Clear(VATAmountLineSubTotal);
    end;
}

