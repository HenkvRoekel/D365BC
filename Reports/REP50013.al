report 50013 "Sales - Credit Memo Bejo"
{

    DefaultLayout = RDLC;
    RDLCLayout = './RDLC/Sales - Credit Memo Bejo.rdlc';


    dataset
    {
        dataitem("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
        {
            DataItemTableView = SORTING ("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.";
            RequestFilterHeading = 'Posted Sales Invoice';
            column(Text50000; Text50000)
            {
            }
            column(ShowInternalInfo; ShowInternalInfo)
            {
            }
            column(PreAssignedNo_SalesCrMemoHeader; "Sales Cr.Memo Header"."Pre-Assigned No.")
            {
            }
            column(PostingDate_SalesCrMemoHeader; "Sales Cr.Memo Header"."Posting Date")
            {
                IncludeCaption = true;
            }
            column(SelltoCustomerNo_SalesCrMemoHeader; "Sales Cr.Memo Header"."Sell-to Customer No.")
            {
                IncludeCaption = true;
            }
            column(BilltoCustomerNo_SalesCrMemoHeader; "Sales Cr.Memo Header"."Bill-to Customer No.")
            {
            }
            column(No_SalesCrMemoHeader; "Sales Cr.Memo Header"."No.")
            {
                IncludeCaption = true;
            }
            column(VATRegistrationNo_SalesCrMemoHeader; "Sales Cr.Memo Header"."VAT Registration No.")
            {
            }
            column(Contents_SalesCrMemoHeader; "Sales Cr.Memo Header"."B Contents")
            {
                IncludeCaption = true;
            }
            column(SalesPersonCode; SalesPurchPerson.Code)
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
            column(CompanyBank; CompanyInfo."Bank Name")
            {
            }
            column(CompanyBankBranch; CompanyInfo."Bank Branch No.")
            {
            }
            column(CompanyBankNo; CompanyInfo."Bank Account No.")
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
            column(CompanyGiro; CompanyInfo."Giro No.")
            {
            }
            column(CompanySwift; CompanyInfo."SWIFT Code")
            {
            }
            column(CompanyIBAN; CompanyInfo.IBAN)
            {
            }
            column(ComapnyVATRegNo; CompanyInfo."VAT Registration No.")
            {
            }
            column(CompanyRegNo; CompanyInfo."Registration No.")
            {
            }
            column(CompanyVATRegNoCaption; CompanyInfo.FieldCaption("VAT Registration No."))
            {
            }
            column(CompanyRegNoCaption; TextRegNo)
            {
            }
            column(PictureCompanyInfo; CompanyInfo.Picture)
            {
            }
            column(WebsiteCompanyInfo; CompanyInfo."Home Page")
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
            column(PaymentTerms_Description; PaymentTerms.Description)
            {
            }
            column(ShipmentMethod_Description; ShipmentMethod.Description)
            {
            }
            column(SalesPersonText; SalesPersonText)
            {
            }
            column(stDescription; grecSalesTerms.Description)
            {
            }
            column(stDescription2; grecSalesTerms."Description 2")
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
            column(OutputNo; OutputNo)
            {
            }
            column(PriceInclVAT_SalesCrMemoHeader; "Prices Including VAT")
            {
            }
            column(VATBaseDiscPrc_SalesCrMemoLine; "VAT Base Discount %")
            {
            }
            column(CurrencyText; gtxCurrency)
            {
            }
            column(CurrencyBankAccount; gtxCurrencyBankAcc)
            {
            }
            column(TotalText; TotalText)
            {
            }
            column(TotalIncludingVATText; TotalInclVATText)
            {
            }
            column(InvoiceTotalAmountInclVAT; InvoiceTotalAmountInclVAT)
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING (Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING (Number) WHERE (Number = CONST (1));
                    dataitem("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
                    {
                        DataItemLink = "Document No." = FIELD ("No.");
                        DataItemLinkReference = "Sales Cr.Memo Header";
                        DataItemTableView = SORTING ("Document No.", "Line No.");
                        column(LineNo_SalesCrMemoLine; "Sales Cr.Memo Line"."Line No.")
                        {
                        }
                        column(Type_SalesCrMemoLine; Format("Sales Cr.Memo Line".Type, 0, 2))
                        {
                        }
                        column(Quantity_SalesCrMemoLine; "Sales Cr.Memo Line".Quantity)
                        {
                            IncludeCaption = true;
                        }
                        column(QuantityBase_SalesCrMemoLine; "Sales Cr.Memo Line"."Quantity (Base)")
                        {
                            DecimalPlaces = 0 : 2;
                        }
                        column(UnitPrice_SalesCrMemoLine; "Sales Cr.Memo Line"."Unit Price")
                        {
                            IncludeCaption = true;
                        }
                        column(LineAmount_SalesCrMemoLine; "Sales Cr.Memo Line".Amount)
                        {
                            IncludeCaption = true;
                        }
                        column(UnitofMeasure_SalesCrMemoLine; "Sales Cr.Memo Line"."Unit of Measure")
                        {
                        }
                        column(No_SalesCrMemoLine; "Sales Cr.Memo Line"."No.")
                        {
                        }
                        column(Description_SalesCrMemoLine; "Sales Cr.Memo Line".Description)
                        {
                            IncludeCaption = true;
                        }
                        column(Description2_SalesCrMemoLine; "Sales Cr.Memo Line"."Description 2")
                        {
                            IncludeCaption = true;
                        }
                        column(AmountIncludingVAT_SalesCrMemoLine; "Sales Cr.Memo Line"."Amount Including VAT")
                        {
                        }
                        column(UoM_SalesLine; gUnitOfMeasure."B Description for Reports")
                        {
                        }
                        column(LineDiscount_SaleCrMemoLine; LineDiscount)
                        {
                        }
                        column(PaymentDiscountOnVAT_SalesCrMemoLine; -("Line Amount" - "Inv. Discount Amount" - "Amount Including VAT"))
                        {
                        }
                        column(InvDiscountAmount_SalesCrMemoLine; "Sales Cr.Memo Line"."Inv. Discount Amount")
                        {
                        }
                        column(LineDiscountAmount_SalesCrMemoLine; "Sales Cr.Memo Line"."Line Discount Amount")
                        {
                        }
                        column(DimesionTextHeader; DimTextHeader)
                        {
                        }
                        column(DimensionTextLine; DimText)
                        {
                        }
                        column(ItemTextLine; ItemLineText)
                        {
                        }
                        column(TxtOntsmet; TxtOntsmet)
                        {
                        }
                        column(TxtOntsmettingskode; gtxtTreatment)
                        {
                        }
                        column(LotNo_LotNoInformation; LotNoInformation."Lot No.")
                        {
                        }
                        column(Bestusedby_LotNoInformation; LotNoInformation."B Best used by")
                        {
                        }
                        column(Fraktie_Description; Fraktie.Description)
                        {
                        }
                        column(NNCTotalLineAmt; NNC_TotalLineAmount)
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(NNCTotalAmtInclVat; NNC_TotalAmountInclVat)
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(NNCTotalInvDiscAmt_SalesCrMemoLine; NNC_TotalInvDiscAmount)
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(NNCTotalAmt; NNC_TotalAmount)
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(InvDiscAmt_SalesCrMemoLine; -"Inv. Discount Amount")
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(Amt_SalesCrMemoLine; Amount)
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(TotalExclVATText; TotalExclVATText)
                        {
                        }
                        column(VATAmtLineVATAmtTxt; VATAmountLine.VATAmountText)
                        {
                        }
                        column(LineAmtInvDiscAmt_SalesCrMemoLine; -("Line Amount" - "Inv. Discount Amount" - "Amount Including VAT"))
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(InvDiscAmt_SalesCrMemoLineCptn; InvDiscAmt_SalesCrMemoLineCptnLbl)
                        {
                        }
                        column(SubtotalCptn; SubtotalCptnLbl)
                        {
                        }
                        column(LineAmtInvDiscAmt_SalesCrMemoLineCptn; LineAmtInvDiscAmt_SalesCrMemoLineCptnLbl)
                        {
                        }
                        column(ExternalDocNo_SalesCrMemoLine; "Sales Cr.Memo Line"."B External Document No.")
                        {
                        }
                        dataitem("Sales Comment Line"; "Sales Comment Line")
                        {
                            DataItemLink = "No." = FIELD ("Document No."), "Document Line No." = FIELD ("Line No.");
                            DataItemTableView = SORTING ("Document Type", "No.", "Document Line No.", "Line No.") WHERE ("Document Type" = CONST ("Posted Credit Memo"));
                            column(LineNo_SalesCommentLine; "Line No.")
                            {
                            }
                            column(Comment_SalesCommentLine; Comment)
                            {
                            }
                        }

                        trigger OnAfterGetRecord()
                        begin

                            if (Type = Type::"G/L Account") and (not ShowInternalInfo) then
                                "No." := '';

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

                            Netweight := Netweight + ("Sales Cr.Memo Line"."Net Weight" * "Sales Cr.Memo Line".Quantity);
                            Grossweight := Grossweight + ("Sales Cr.Memo Line"."Gross Weight" * "Sales Cr.Memo Line".Quantity);



                            if grecItem.Get("Sales Cr.Memo Line"."No.") then;

                            if not grecItemExt.Get(grecItem."B Extension", "Sales Cr.Memo Header"."Language Code") then
                                grecItemExt.Init;
                            TxtOntsmet := '';
                            if (grecItemExt.Extension < '6') then
                                TxtOntsmet := grecItemExt.Description;


                            DimTextHeader := '';
                            RECDefaultDimension.SetRange(RECDefaultDimension."No.", "Sales Cr.Memo Line"."Sell-to Customer No.");
                            if RECDefaultDimension.FindFirst then begin
                                DimTextHeader := StrSubstNo('%1 %2', RECDefaultDimension."Dimension Code", RECDefaultDimension."Dimension Value Code");
                            end;
                            RECDefaultDimension.SetRange(RECDefaultDimension."No.", "Sales Cr.Memo Line"."B Salesperson");
                            if RECDefaultDimension.FindFirst then begin
                                DimTextHeader := StrSubstNo('%1, %2 %3', DimTextHeader, RECDefaultDimension."Dimension Code", RECDefaultDimension."Dimension Value Code");
                            end;



                            DimText := '';
                            RECDefaultDimension.SetRange(RECDefaultDimension."No.", "Sales Cr.Memo Line"."No.");
                            if (RECDefaultDimension.FindSet) then begin
                                repeat
                                    DimText += StrSubstNo('%1,  %2, ', RECDefaultDimension."Dimension Code", RECDefaultDimension."Dimension Value Code")
                                until RECDefaultDimension.Next = 0;
                            end;


                            LineDiscount := '';
                            if "Line Discount %" <> 0 then
                                LineDiscount := Format(Round("Line Discount %", 0.01) * -1) + ' %';

                            Clear(LotNoInformation);
                            ValEntCode := (ItemTrackingMgt.ComposeRowID(DATABASE::"Sales Cr.Memo Line",
                              0, "Sales Cr.Memo Line"."Document No.", '', 0, "Sales Cr.Memo Line"."Line No."));
                            ValueEntryRelation.SetRange(ValueEntryRelation."Source RowId", ValEntCode);
                            if ValueEntryRelation.FindFirst then begin

                                if ValueEntry.Get(ValueEntryRelation."Value Entry No.") then
                                    if ItemLedgerEntry.Get(ValueEntry."Item Ledger Entry No.") then begin

                                        LotNoInformation.SetRange("Item No.", ItemLedgerEntry."Item No.");
                                        LotNoInformation.SetRange("Lot No.", ItemLedgerEntry."Lot No.");
                                        if LotNoInformation.FindFirst then
                                            GetLotNoInformation()

                                    end;

                            end;

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
                            CurrReport.CreateTotals("Line Amount", Amount, "Amount Including VAT", "Inv. Discount Amount", Netweight, Grossweight);
                        end;
                    }
                    dataitem(VATCounter; "Integer")
                    {
                        DataItemTableView = SORTING (Number);
                        column(VATAmtLineVATBase; VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmt; VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineLineAmt; VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscBaseAmt; VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvoiceDiscAmt; VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATPer; VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmtLineVATIdentifier; VATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATAmtSpecificationCptn; VATAmtSpecificationCptnLbl)
                        {
                        }
                        column(VATAmtLineInvDiscBaseAmtCptn; VATAmtLineInvDiscBaseAmtCptnLbl)
                        {
                        }
                        column(VATAmtLineLineAmtCptn; VATAmtLineLineAmtCptnLbl)
                        {
                        }
                        column(VATAmtLineInvoiceDiscAmtCptn; VATAmtLineInvoiceDiscAmtCptnLbl)
                        {
                        }
                        column(VATAmountLineSubTotal; VATAmountLineSubTotal)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);
                            VATAmountLineSubTotal := VATAmountLine."VAT Base" + VATAmountLine."VAT Amount";
                        end;

                        trigger OnPreDataItem()
                        begin
                            SetRange(Number, 1, VATAmountLine.Count);
                            CurrReport.CreateTotals(
                              VATAmountLine."Line Amount", VATAmountLine."Inv. Disc. Base Amount",
                              VATAmountLine."Invoice Discount Amount", VATAmountLine."VAT Base", VATAmountLine."VAT Amount");
                        end;
                    }
                    dataitem(FooterText; "Integer")
                    {
                        DataItemTableView = SORTING (Number) WHERE (Number = CONST (1));
                        column(Netweight; Netweight)
                        {
                        }
                        column(GrossWeight; Grossweight)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            DataFooter := SetDataFooter;
                        end;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        SetDataReport;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    CurrReport.PageNo := 1;
                    if Number > 1 then begin
                        CopyText := Text003;
                        OutputNo += 1;
                    end;

                    NNC_TotalLineAmount := 0;
                    NNC_TotalAmountInclVat := 0;
                    NNC_TotalInvDiscAmount := 0;
                    NNC_TotalAmount := 0;
                end;

                trigger OnPostDataItem()
                begin
                    if not CurrReport.Preview then
                        SalesCrMemoCountPrinted.Run("Sales Cr.Memo Header");
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := Abs(NoOfCopies) + 1;
                    CopyText := '';
                    SetRange(Number, 1, NoOfLoops);
                    OutputNo := 1;
                end;
            }

            trigger OnAfterGetRecord()
            var
                SalesCrMemoLine: Record "Sales Cr.Memo Line";
            begin
                CurrReport.Language := Language.GetLanguageID("Language Code");

                if RespCenter.Get("Responsibility Center") then begin
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                end else begin
                    CompanyInfo.Get;
                    FormatAddr.Company(CompanyAddr, CompanyInfo);
                end;
                CompanyInfo.CalcFields(Picture);



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
                FormatAddr.SalesCrMemoBillTo(CustAddr, "Sales Cr.Memo Header");
                Cust.Get("Bill-to Customer No.");

                if "Payment Terms Code" = '' then
                    PaymentTerms.Init
                else
                    PaymentTerms.Get("Payment Terms Code");
                if "Shipment Method Code" = '' then
                    ShipmentMethod.Init
                else
                    ShipmentMethod.Get("Shipment Method Code");

                ShowShippingAddr := FormatAddr.SalesCrMemoShipTo(ShipToAddr, CustAddr, "Sales Cr.Memo Header");


                if not grecSalesTerms.Get("Sales Cr.Memo Header"."Language Code") then
                    grecSalesTerms.Init;

                InvoiceTotalAmountInclVAT := 0;
                SalesCrMemoLine.SetRange("Document No.", "No.");
                if SalesCrMemoLine.FindSet then begin
                    repeat
                        InvoiceTotalAmountInclVAT += SalesCrMemoLine."Amount Including VAT";
                    until SalesCrMemoLine.Next = 0;
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
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
        lblItemNo = 'Item No.';
        lblLotNo = 'Lot No.';
        lblGrade = 'Grade';
        lblUnit = 'Unit';
        lblTotal = 'Total';
        lblPrice = 'Price';
        lblHeaderDimensions = 'Header Dimensions';
        lblLineDimensions = 'Line Dimensions';
        lblVATPercent = '% VAT';
        lblVATAmount = 'VAT Amount';
        lblSubTotal = 'Subtotal';
        lblShipToCustomer = 'Ship-to Customer';
        lblBillToCustomer = 'Bill-to Customer';
        lblSalesperson = 'Salesperson';
        lblCreditMemoNo = 'Credit Memo No.';
        lblCustomerNo = 'Customer No';
        lblShipmentMethods = 'Shipment Method';
        lblShipmentTerms = 'Shipment Terms';
        lblPaymentTerms = 'Payment Terms';
        lblNetWeight = 'Net Weight';
        lblGrossWeight = 'Gross Weight';
        lblVATBase = 'VAT Base';
        lblReportCaption = 'Sales - Credit Memo';
        lblLineDisc = 'Line Disc.';
        lblPage = 'Page:';
        lblRegNo = 'Registration No.:';
        lblVATRegNo = 'VAT Registration No.:';
        lblVATDate = 'Invoice Date';
        lblOrderNo = 'Order No.';
        lblDocDate = 'Document Date';
        lblContents = 'Contents';
    }

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
        SalesCrMemoCountPrinted: Codeunit "Sales Cr. Memo-Printed";
        FormatAddr: Codeunit "Format Address";
        SegManagement: Codeunit SegManagement;
        CustAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
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
        Netweight: Decimal;
        Grossweight: Decimal;
        "V%": array[10] of Decimal;
        VBasis: array[10] of Decimal;
        VAmount: array[10] of Decimal;
        VPrint: array[10] of Boolean;
        Fraktie: Record Grade;
        TxtOntsmet: Text[60];
        ValEntCode: Text[100];
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        Germ: Text[30];
        Phone: Text[30];
        grecItem: Record Item;
        grecItemExt: Record "Item Extension";
        LineDiscount: Text[30];
        gtxtTreatment: Text[50];
        gUnitOfMeasure: Record "Unit of Measure";
        gcuBejoMgt: Codeunit "Bejo Management";
        Text000: Label 'Salesperson';
        Text001: Label 'Total Credit %1';
        Text002: Label 'Total Credit %1 Incl. VAT';
        Text003: Label 'COPY';
        Text004: Label 'Sales - Credit Memo %1';
        Text005: Label 'Page %1';
        Text006: Label 'Total Credit %1 Excl. VAT';
        Text50000: Label 'When remitting please quote:';
        DimText: Text[120];
        DimTextHeader: Text[120];
        RECDimensionValue: Record "Dimension Value";
        RECDefaultDimension: Record "Default Dimension";
        ItemLineText: Text[100];
        RECLineText: Record "Sales Comment Line";
        grecSalesTerms: Record "Sales Terms";
        Text50013: Label 'Amount ';
        Text50014: Label 'VAT Amount ';
        Text50015: Label 'Total ';
        Text50016: Label 'Rate ';
        Text50017: Label ' Kƒ; ';
        Text50018: Label ' Kƒ/EUR';
        "-LOC-": Integer;
        greBejoSetup: Record "Bejo Setup";
        greCurrencyExchangeRate: Record "Currency Exchange Rate";
        gtxCurrency: Text;
        gtxCurrencyBankAcc: Text;
        TextRegNo: Label 'Registration No.';
        TextTaxRecapitulation: Label 'VAT';
        LotNoInformation: Record "Lot No. Information";
        ValueEntryRelation: Record "Value Entry Relation";
        ValueEntry: Record "Value Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
        "//////": Integer;
        DataFixedHeader: Text;
        DataCaptionHeader: Text;
        DataHeader: Text;
        DataFooter: Text;
        OutputNo: Integer;
        NNC_TotalLineAmount: Decimal;
        NNC_TotalAmountInclVat: Decimal;
        NNC_TotalInvDiscAmount: Decimal;
        NNC_TotalAmount: Decimal;
        "////": Label '';
        Text101: Label 'Tel: ';
        Text102: Label 'E-mail: ';
        Text103: Label 'Website: ';
        Text104: Label 'Page';
        Text105: Label 'When remitting please quote:';
        Text106: Label 'Customer No.';
        Text108: Label 'Credit Memo No.';
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
        Text119: Label 'Sales Credit Memo';
        Text120: Label 'Bill-to Customer';
        Text121: Label 'Order No.';
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
        Text301: Label 'Item No.';
        Text302: Label 'Description';
        Text303: Label 'Quantity';
        Text304: Label 'Unit';
        Text305: Label 'Total';
        Text306: Label 'Price';
        Text307: Label 'Line Amount';
        Text308: Label 'VAT';
        Text310: Label 'Lot No.';
        Text311: Label 'Grade';
        Text312: Label 'External Doc. No.';
        Text313: Label 'Country of Origin';
        Text315: Label 'Line Disc.';
        InvDiscAmt_SalesCrMemoLineCptnLbl: Label 'Invoice Discount Amount';
        SubtotalCptnLbl: Label 'Subtotal';
        LineAmtInvDiscAmt_SalesCrMemoLineCptnLbl: Label 'Payment Discount on VAT';
        VATAmtLineInvDiscBaseAmtCptnLbl: Label 'Invoice Discount Base Amount';
        VATAmtLineLineAmtCptnLbl: Label 'Line Amount';
        VATAmtLineInvoiceDiscAmtCptnLbl: Label 'Invoice Discount Amount';
        VATAmountLineSubTotal: Decimal;
        InvoiceTotalAmountInclVAT: Decimal;

    procedure InitLogInteraction()
    begin
        LogInteraction := SegManagement.FindInteractTmplCode(4) <> '';
    end;

    local procedure GetLotNoInformation()
    begin

        if not Fraktie.Get(LotNoInformation."B Grade Code") then
            Fraktie.Init;

        if LotNoInformation."B Germination" <> 0 then
            Germ := Format(LotNoInformation."B Germination") + ' %'
        else
            Germ := '';

        if CopyStr(LotNoInformation."Item No.", 1, 2) = '68' then
            case CopyStr(LotNoInformation."Item No.", 6, 1) of
                '1', '2', '3', '4', '5', '6', '7':
                    Fraktie.Description := '';
            end;

        if CopyStr(LotNoInformation."Item No.", 1, 2) = '81' then
            case CopyStr(LotNoInformation."Item No.", 6, 1) of
                '5':
                    Fraktie.Description := '';
            end;

        if CopyStr(LotNoInformation."Item No.", 1, 2) = '84' then
            case CopyStr(LotNoInformation."Item No.", 6, 1) of
                '1', '4', '5':
                    Fraktie.Description := '';
            end;

        if CopyStr(LotNoInformation."Item No.", 1, 2) = '89' then
            case CopyStr(LotNoInformation."Item No.", 6, 1) of
                '1', '4', '5':
                    Fraktie.Description := '';
            end;
    end;

    local procedure "======"()
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
        BejoManagement: Codeunit "Bejo Management";
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
          CompanyInfo.FieldCaption("Registration No.") + ': ' + CompanyInfo."Registration No." + Format(Char177) +          //(9,1)
          CompanyInfo.FieldCaption("VAT Registration No.") + ': ' + CompanyInfo."VAT Registration No." + Format(Char177) +  //(10,1)
          '' + Format(Char177) +                                                                                            //(11,1)
          '' + Format(Char177) +                                                                                            //(12,1)
          Text104 + Format(Char177) +                                                                                      //(13,1)
          ' ' + Format(Char177) +                                                                                           //(14,1)
          Text50000 + Format(Char177) +                                                                                     //(15,1)
          ' '
          );
    end;

    local procedure SetDataCaptionHeader(): Text
    var
        Char177: Char;
    begin
        Char177 := 177;
        exit(
          Text301 + Format(Char177) +      //(1,3)
          Text302 + Format(Char177) +      //(2,3)
          Text303 + Format(Char177) +      //(3,3)
          Text304 + Format(Char177) +      //(4,3)
          Text305 + Format(Char177) +      //(5,3)
          Text306 + Format(Char177) +      //(6,3)
          Text307 + Format(Char177) +      //(7,3)
          '' + Format(Char177) +           //(8,3)
          Text310 + '               ' +    //(9,3)
          Text311 + Format(Char177) +      //(10,3)
          Text312 + Format(Char177) +      //(11,3) //BEJOW110.00.026 119352
          '' + Format(Char177) +           //(12,3)
          '' + Format(Char177) +           //(13,3)
          Text315 + Format(Char177) +      //(14,3)
          ' '
          );
    end;

    local procedure SetDataHeader(): Text
    var
        Char177: Char;
    begin
        Char177 := 177;
        exit(
          Text108 + Format(Char177) +                                                       //(1,2)
          "Sales Cr.Memo Header"."No." + Format(Char177) +                                  //(2,2)
          Text106 + Format(Char177) +                                                       //(3,2)
          "Sales Cr.Memo Header"."Bill-to Customer No." + Format(Char177) +                 //(4,2)
          Text121 + Format(Char177) +                                                       //(5,2)
          "Sales Cr.Memo Header"."Pre-Assigned No." + Format(Char177) +                     //(6,2)
          "Sales Cr.Memo Header".FieldCaption("Document Date") + Format(Char177) +          //(7,2)
          Format("Sales Cr.Memo Header"."Posting Date") + Format(Char177) +                 //(8,2)
          '' + Format(Char177) +                                                            //(9,2)
          '' + Format(Char177) +                                                            //(10,2)
          '' + Format(Char177) +                                                            //(11,2)
          Text119 + ' ' + CopyText + Format(Char177) +                                       //(12,2)
          Text120 + Format(Char177) +                                                       //(13,2)
          CustAddr[1] + Format(Char177) +                                                   //(14,2)
          CustAddr[2] + Format(Char177) +                                                   //(15,2)
          CustAddr[3] + Format(Char177) +                                                   //(16,2)
          CustAddr[4] + Format(Char177) +                                                   //(17,2)
          CustAddr[5] + Format(Char177) +                                                   //(18,2)
          CustAddr[6] + Format(Char177) +                                                   //(19,2)
          CompanyInfo.FieldCaption("Registration No.") + Format(Char177) +                  //(20,2)
          "Sales Cr.Memo Header".FieldCaption("VAT Registration No.") + Format(Char177) +   //(21,2)
          "Sales Cr.Memo Header"."VAT Registration No." + Format(Char177) +                 //(22,2)
          Text110 + Format(Char177) +                                                       //(23,2)
          ShipToAddr[1] + Format(Char177) +                                                 //(24,2)
          ShipToAddr[2] + Format(Char177) +                                                 //(25,2)
          ShipToAddr[3] + Format(Char177) +                                                 //(26,2)
          ShipToAddr[4] + Format(Char177) +                                                 //(27,2)
          ShipToAddr[5] + Format(Char177) +                                                 //(28,2)
          ShipToAddr[6] + Format(Char177) +                                                 //(29,2)
          "Sales Cr.Memo Header"."External Document No." + Format(Char177) +                //(30,2)
          Text312 + Format(Char177) +                                                       //(31,2)
          ' '
          );
    end;

    local procedure SetDataFooter(): Text
    var
        Char177: Char;
    begin
        Char177 := 177;
        exit(
          Text401 + Format(Char177) +                                         //(1,4)
          Format(Grossweight) + Format(Char177) +                             //(2,4)
          Text403 + Format(Char177) +                                         //(3,4)
          Format(Netweight) + Format(Char177) +                               //(4,4)
          Text405 + Format(Char177) +                                         //(5,4)
          "Sales Cr.Memo Header"."B Contents" + Format(Char177) +             //(6,4)
          '' + Format(Char177) +                                              //(7,4)
          '' + Format(Char177) +                                              //(8,4)
          Text411 + Format(Char177) +                                         //(9,4)
          PaymentTerms.Description + Format(Char177) +                        //(10,4)
          Text409 + Format(Char177) +                                         //(11,4)
          "Sales Cr.Memo Header"."Shipment Method Code" + Format(Char177) +   //(12,4)
          '' + Format(Char177) +                                              //(13,4)
          '' + Format(Char177) +                                              //(14,4)
          ' '
          );
    end;
}

