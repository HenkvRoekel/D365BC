report 50017 "Sales - OrderConfirmation Bejo"
{

    DefaultLayout = RDLC;
    RDLCLayout = './RDLC/Sales - OrderConfirmation Bejo.rdlc';

    Caption = 'Sales - Order Confirmation';

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING ("Document Type", "No.") WHERE ("Document Type" = CONST (Order));
            RequestFilterFields = "No.", "Sell-to Customer No.";
            RequestFilterHeading = 'Sales Order';
            column(Text50000; Text50000)
            {
            }
            column(ShowInternalInfo; ShowInternalInfo)
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
            column(CompanyBankAccountNo; CompanyInfo."Bank Account No.")
            {
            }
            column(CompanyIBAN; CompanyInfo.IBAN)
            {
            }
            column(CompanyIBANCaption; CompanyInfo.FieldCaption(IBAN))
            {
            }
            column(CompanyInfoGiro; CompanyInfo."Giro No.")
            {
            }
            column(CompanySwift; CompanyInfo."SWIFT Code")
            {
            }
            column(CompanySwiftCaption; CompanyInfo.FieldCaption("SWIFT Code"))
            {
            }
            column(CompanyRegistrationNo; CompanyInfo."Registration No.")
            {
            }
            column(CompanyVATRegistrationNo; CompanyInfo."VAT Registration No.")
            {
            }
            column(CompanyRegistrationNoCaption; TextRegNo)
            {
            }
            column(CompanyVATRegistrationNoCaption; CompanyInfo.FieldCaption("VAT Registration No."))
            {
            }
            column(PictureCompanyInfo; CompanyInfo.Picture)
            {
            }
            column(WebsiteCompanyInfo; CompanyInfo."Home Page")
            {
            }
            column(ShipmentDate_SalesHeader; "Sales Header"."Shipment Date")
            {
                IncludeCaption = true;
            }
            column(DueDate_SalesHeader; "Sales Header"."Due Date")
            {
                IncludeCaption = true;
            }
            column(VATRegistrationNo_SalesHeader; "Sales Header"."VAT Registration No.")
            {
                IncludeCaption = true;
            }
            column(Grossweight_SalesHeader; "Sales Header"."B Gross weight")
            {
            }
            column(Reservedweight_SalesHeader; "Sales Header"."B Reserved weight")
            {
            }
            column(Contents_SalesHeader; "Sales Header"."B Contents")
            {
                IncludeCaption = true;
            }
            column(No_SalesHeader; "Sales Header"."No.")
            {
                IncludeCaption = true;
            }
            column(BilltoCustomerNo_SalesHeader; "Sales Header"."Bill-to Customer No.")
            {
            }
            column(ProformaNo_SalesHeader; "Sales Header"."B Proforma No.")
            {
            }
            column(Name_ShippingAgent; ShippingAgent.Name)
            {
            }
            column(Code_SalesPurchPerson; SalesPurchPerson.Code)
            {
            }
            column(Descripition_ShippmingMethod; ShipmentMethod.Description)
            {
            }
            column(Description_PaymnetTerms; PaymentTerms.Description)
            {
            }
            column(TotalExcludingVATText; TotalExclVATText)
            {
            }
            column(TotalInclVATText; TotalInclVATText)
            {
            }
            column(TotalAmountInclVAT; TotalAmountInclVAT)
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
            column(InvoiceTotalAmountInclVAT; InvoiceTotalAmountInclVAT)
            {
            }
            column(TotalIncludingVATText; TotalInclVATText)
            {
            }
            column(TotalText; TotalText)
            {
            }
            column(OutputNo; OutputNo)
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING (Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING (Number) WHERE (Number = CONST (1));
                    dataitem("Sales Line"; "Sales Line")
                    {
                        DataItemLink = "Document Type" = FIELD ("Document Type"), "Document No." = FIELD ("No.");
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = SORTING ("Document Type", "Document No.", "Line No.");
                        column(LineNo_SalesLine; "Sales Line"."Line No.")
                        {
                        }
                        column(Type_SalesLine; Format("Sales Line".Type, 0, 2))
                        {
                        }
                        column(No_SalesLine; "Sales Line"."No.")
                        {
                        }
                        column(Description_SalesLine; "Sales Line".Description)
                        {
                            IncludeCaption = true;
                        }
                        column(Quantity_SalesLine; "Sales Line".Quantity)
                        {
                            IncludeCaption = true;
                        }
                        column(QuantityBase_SalesLine; Format("Sales Line"."Quantity (Base)", 0, 0))
                        {
                        }
                        column(UnitPrice_SalesLine; "Sales Line"."Unit Price")
                        {
                            IncludeCaption = true;
                        }
                        column(LineDiscountAmount_SalesLine; "Sales Line"."Line Discount Amount")
                        {
                        }
                        column(Description2_SalesLine; "Sales Line"."Description 2")
                        {
                        }
                        column(LineAmount_SalesLine; "Sales Line"."Line Amount")
                        {
                        }
                        column(UoM_SalesLine; gUnitOfMeasure."B Description for Reports")
                        {
                        }
                        column(LineText_Description; ItemLineText)
                        {
                        }
                        column(gTxtItemExtension; gTxtItemExt)
                        {
                        }
                        column(gLineDiscount; gLineDiscount)
                        {
                        }
                        column(gTxtTreatmentCode; gTxtTreatmentCode)
                        {
                        }
                        column(Description_Grade; grecGrade.Description)
                        {
                        }
                        column(BestUsedBy_LotNoInfo; grecLotNoInformation."B Best used by")
                        {
                        }
                        column(LotNo; grecLotNoInformation."Lot No.")
                        {
                        }
                        column(LotNo_ReservationEntry; ReservationEntry."Lot No.")
                        {
                        }
                        column(DescriptionForReports_TreatmentCode; grecTreatmentCode."Description Reports")
                        {
                        }
                        dataitem("Sales Comment Line"; "Sales Comment Line")
                        {
                            DataItemLink = "Document Type" = FIELD ("Document Type"), "No." = FIELD ("Document No."), "Document Line No." = FIELD ("Line No.");
                            DataItemTableView = SORTING ("Document Type", "No.", "Document Line No.", "Line No.") WHERE ("Document Type" = CONST (Order));
                            column(LineNo_SalesCommentLine; "Line No.")
                            {
                            }
                            column(Comment_SalesCommentLine; Comment)
                            {
                            }
                        }

                        trigger OnAfterGetRecord()
                        begin

                            if grecBejoSetup."BlockPrintProforma if AllocExc" then TestField("B Allocation Exceeded", false);


                            if grecItem.Get("No.") then;

                            if not grecItemExt.Get(grecItem."B Extension", "Sales Header"."Language Code") then
                                grecItemExt.Init;
                            gTxtItemExt := '';
                            if (grecItemExt.Extension < '6') then
                                gTxtItemExt := grecItemExt.Description;


                            if not gUnitOfMeasure.Get("Unit of Measure Code") then
                                gUnitOfMeasure.Init;

                            Clear(grecLotNoInformation);
                            Clear(ReservationEntry);
                            ReservationEntry.SetRange("Source Type", 37);
                            ReservationEntry.SetRange("Source Subtype", 1);
                            ReservationEntry.SetRange("Source ID", "Sales Line"."Document No.");
                            ReservationEntry.SetRange("Source Ref. No.", "Sales Line"."Line No.");
                            if ReservationEntry.FindFirst then
                                GetLotNoInfo(ReservationEntry."Lot No.");

                            gLineDiscount := '';
                            if "Line Discount %" <> 0 then
                                gLineDiscount := Format(Round("Line Discount %", 0.01) * -1) + ' %';
                        end;

                        trigger OnPreDataItem()
                        begin
                            CurrReport.CreateTotals("Line Amount", Amount, "Amount Including VAT", "Inv. Discount Amount", gNetWeight, gGrossWeight);
                        end;
                    }
                    dataitem(VATCounter; "Integer")
                    {
                        DataItemTableView = SORTING (Number);
                        column(VATAmtLineVATBase; VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmt; VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
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
                    dataitem(VATSpecificationPrint; "Integer")
                    {
                        DataItemTableView = SORTING (Number) WHERE (Number = CONST (1));
                        column(VATPercent1; "gV%"[1])
                        {
                        }
                        column(VATPercent2; "gV%"[2])
                        {
                        }
                        column(VATPercent3; "gV%"[3])
                        {
                        }
                        column(VBasis1; gVBasis[1])
                        {
                        }
                        column(VBasis2; gVBasis[2])
                        {
                        }
                        column(VBasis3; gVBasis[3])
                        {
                        }
                        column(VAmount1; gVAmount[1])
                        {
                        }
                        column(VAmount2; gVAmount[2])
                        {
                        }
                        column(VAmount3; gVAmount[3])
                        {
                        }
                        column(VATBase; gVBasis[1] + gVBasis[2] + gVBasis[3])
                        {
                        }
                        column(VATAmount; gVAmount[1] + gVAmount[2] + gVAmount[3])
                        {
                        }
                        column(TotalVATAmount; gVBasis[1] + gVBasis[2] + gVBasis[3] + gVAmount[1] + gVAmount[2] + gVAmount[3])
                        {
                        }
                        column(TotalVATAmt1; gVBasis[1] + gVAmount[1])
                        {
                        }
                        column(TotalVATAmt2; gVBasis[2] + gVAmount[2])
                        {
                        }
                        column(TotalVATAmt3; gVBasis[3] + gVAmount[3])
                        {
                        }
                    }

                    trigger OnAfterGetRecord()
                    begin
                        SetDataReport;
                    end;
                }

                trigger OnAfterGetRecord()
                var
                    SalesPost: Codeunit "Sales-Post";
                    TempSalesLine: Record "Sales Line" temporary;
                begin
                    Clear(SalesLine);
                    Clear(SalesPost);
                    VATAmountLine.DeleteAll;
                    SalesLine.DeleteAll;
                    SalesPost.GetSalesLines("Sales Header", SalesLine, 0);
                    SalesLine.CalcVATAmountLines(0, "Sales Header", SalesLine, VATAmountLine);
                    SalesLine.UpdateVATOnLines(0, "Sales Header", SalesLine, VATAmountLine);
                    VATAmount := VATAmountLine.GetTotalVATAmount;
                    VATBaseAmount := VATAmountLine.GetTotalVATBase;
                    VATDiscountAmount :=
                      VATAmountLine.GetTotalVATDiscount("Sales Header"."Currency Code", "Sales Header"."Prices Including VAT");
                    TotalAmountInclVAT := VATAmountLine.GetTotalAmountInclVAT;

                    if Number > 1 then begin
                        CopyText := Text003;
                        OutputNo += 1;
                    end;
                    CurrReport.PageNo := 1;
                end;

                trigger OnPostDataItem()
                begin
                    if Print then
                        SalesCountPrinted.Run("Sales Header");
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
                lcuSalesPost: Codeunit "Sales-Post";
            begin
                Clear(SalesLine);

                VATAmountLine.DeleteAll;
                SalesLine.DeleteAll;
                lcuSalesPost.GetSalesLines("Sales Header", SalesLine, 0);

                SalesLine.CalcVATAmountLines(0, "Sales Header", SalesLine, VATAmountLine);
                SalesLine.UpdateVATOnLines(0, "Sales Header", SalesLine, VATAmountLine);
                VATAmount := VATAmountLine.GetTotalVATAmount;
                VATBaseAmount := VATAmountLine.GetTotalVATBase;
                VATDiscountAmount := VATAmountLine.GetTotalVATDiscount("Sales Header"."Currency Code", "Sales Header"."Prices Including VAT");
                TotalAmountInclVAT := VATAmountLine.GetTotalAmountInclVAT;
                if (VATAmountLine."VAT Calculation Type" = VATAmountLine."VAT Calculation Type"::"Reverse Charge VAT") and
                    "Sales Header"."Prices Including VAT" then begin
                    VATBaseAmount := VATAmountLine.GetTotalLineAmount(false, "Sales Header"."Currency Code");
                    TotalAmountInclVAT := VATAmountLine.GetTotalLineAmount(false, "Sales Header"."Currency Code");
                end;
                CurrReport.Language := Language.GetLanguageID("Language Code");

                "Sales Header".CalcFields("B Reserved weight");
                CompanyInfo.Get;
                CompanyInfo.CalcFields(Picture);
                grecCust.Get("Bill-to Customer No.");

                if RespCenter.Get("Responsibility Center") then begin
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                end else
                    FormatAddr.Company(CompanyAddr, CompanyInfo);

                if "Salesperson Code" = '' then begin
                    Clear(SalesPurchPerson);
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
                FormatAddr.SalesHeaderBillTo(CustAddr, "Sales Header");

                if "Payment Terms Code" = '' then
                    PaymentTerms.Init
                else
                    PaymentTerms.Get("Payment Terms Code");
                if "Shipment Method Code" = '' then
                    ShipmentMethod.Init
                else
                    ShipmentMethod.Get("Shipment Method Code");

                ShowShippingAddr := FormatAddr.SalesHeaderShipTo(ShipToAddr, CustAddr, "Sales Header");

                if not ShippingAgent.Get("Sales Header"."Shipping Agent Code") then
                    ShippingAgent.Init;


                if not grecSalesTerms.Get("Language Code") then
                    grecSalesTerms.Init;


                InvoiceTotalAmountInclVAT := 0;
                SalesLine.SetRange("Document Type", "Sales Header"."Document Type");
                SalesLine.SetRange("Document No.", "No.");
                if SalesLine.FindSet then begin
                    repeat
                        InvoiceTotalAmountInclVAT += SalesLine."Amount Including VAT";
                    until SalesLine.Next = 0;
                end;
            end;

            trigger OnPreDataItem()
            begin
                Print := Print or not CurrReport.Preview;
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
        lblCreditMemoNo = 'Credit Memo No';
        lblCustomerNo = 'Customer No';
        lblShipmentMethods = 'Shipment Method';
        lblShipmentTerms = 'Shipment Terms';
        lblPaymentTerms = 'Payment Terms';
        lblNetWeight = 'Net Weight';
        lblRegistrationNo = 'Registration No';
        lblVATRegno = 'VAT Registration No';
        lblGrossWeight = 'Gross Weight';
        lblBestUsedBy = 'Best used by';
        lblOrderNo = 'Order No';
        lblVATNo = 'VAT No';
        lblPage = 'Page';
        lblProforma = 'Proforma Invoice';
        lblVATBase = 'VAT Base';
        // The label 'lblSignature' could not be exported.
        lblIssuedBy = 'Issued By:';
        lblAmount = 'Amount';
        lblLineDisc = 'Line Disc.';
        lblContents = 'Contents';
        lblInvoiceDate = 'Invoice Date';
        lblProformaNo = 'Proforma No.';
    }

    trigger OnInitReport()
    begin
        grecBejoSetup.Get;
    end;

    var
        GLSetup: Record "General Ledger Setup";
        ShipmentMethod: Record "Shipment Method";
        ShippingAgent: Record "Shipping Agent";
        PaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        VATAmountLine: Record "VAT Amount Line" temporary;
        SalesLine: Record "Sales Line" temporary;
        RespCenter: Record "Responsibility Center";
        Language: Record Language;
        FormatAddr: Codeunit "Format Address";
        SegManagement: Codeunit SegManagement;
        ArchiveManagement: Codeunit ArchiveManagement;
        SalesCountPrinted: Codeunit "Sales-Printed";
        CustAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        SalesPersonText: Text[30];
        VATNoText: Text[30];
        ReferenceText: Text[30];
        TotalText: Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        NoOfCopies: Integer;
        CopyText: Text[30];
        ShowShippingAddr: Boolean;
        i: Integer;
        ShowInternalInfo: Boolean;
        ArchiveDocument: Boolean;
        LogInteraction: Boolean;
        VATAmount: Decimal;
        VATBaseAmount: Decimal;
        VATDiscountAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        "***** Bejo Variables*****": Integer;
        gNetWeight: Decimal;
        gGrossWeight: Decimal;
        grecLotNoInformation: Record "Lot No. Information";
        grecGrade: Record Grade;
        gTxtItemExt: Text[60];
        gGerm: Text[30];
        grecCust: Record Customer;
        grecItem: Record Item;
        grecItemExt: Record "Item Extension";
        gLineDiscount: Text[30];
        "gV%": array[10] of Decimal;
        gVBasis: array[10] of Decimal;
        gVAmount: array[10] of Decimal;
        grecTreatmentCode: Record "Treatment Code";
        gTxtTreatmentCode: Text[50];
        gUnitOfMeasure: Record "Unit of Measure";
        gcuBejoMgt: Codeunit "Bejo Management";
        grecBejoSetup: Record "Bejo Setup";
        Text000: Label 'Salesperson';
        Text001: Label 'Total %1';
        Text002: Label 'Total %1 Incl. VAT';
        Text003: Label 'COPY';
        Text004: Label 'Order Confirmation %1';
        Text005: Label 'Page %1';
        Text006: Label 'Total %1 Excl. VAT';
        Text50000: Label 'When remitting please quote:';
        grecLineText: Record "Sales Comment Line";
        ItemLineText: Text[120];
        grecSalesTerms: Record "Sales Terms";
        TextRegNo: Label 'Registration No.';
        gcuNoSeriesManagement: Codeunit NoSeriesManagement;
        ReservationEntry: Record "Reservation Entry";
        "///": Integer;
        DataFixedHeader: Text;
        DataCaptionHeader: Text;
        DataHeader: Text;
        DataFooter: Text;
        NoOfLoops: Integer;
        OutputNo: Integer;
        "////": Label '';
        Text101: Label 'Tel: ';
        Text102: Label 'E-mail: ';
        Text103: Label 'Website: ';
        Text104: Label 'Page';
        Text105: Label 'When remitting please quote:';
        Text106: Label 'Bill-to Customer No.';
        Text108: Label 'Order No.';
        Text109: Label 'Invoice Date';
        Text110: Label 'Sell-to Customer';
        Text111: Label 'Total';
        Text112: Label 'Lot No.';
        Text113: Label 'Grade';
        Text114: Label 'Country of Origin';
        Text115: Label 'Line Disc.';
        Text116: Label 'Header Dimensions              ';
        Text117: Label 'Not chemically treated + HWT';
        Text118: Label 'Line Dimensions              ';
        Text119: Label 'Order Confirmation';
        Text120: Label 'Bill-to Customer';
        Text121: Label 'Order No.';
        Text401: Label 'Gross Weigtht';
        Text403: Label 'Net Weight';
        Text405: Label 'Contents';
        Text407: Label 'Shipment Method';
        Text409: Label 'Shipment Terms';
        Text411: Label 'Payment Terms';
        Text413: Label 'Payment Method';
        Text415: Label 'We draw your attention to our General Terms & Conditions of Sale and Delivery as printed at the back of uor current catalogue.';
        Text416: Label 'All sales are made subject to these Terms & Conditions of Sale and Delivery unless otherwise agreed in writing.';
        Text417: Label 'Received By:';
        Text418: Label 'Issued By:';
        Text301: Label 'Item No.';
        Text302: Label 'Description';
        Text303: Label 'Quantity';
        Text304: Label 'Unit';
        Text305: Label 'Total';
        Text306: Label 'Price';
        Text307: Label 'Amount';
        Text308: Label 'VAT %';
        Text310: Label 'Lot No.';
        Text311: Label 'Grade';
        Text313: Label 'Country of Origin';
        Text315: Label 'Line disc.';
        Print: Boolean;
        VATAmountLineSubTotal: Decimal;
        InvoiceTotalAmountInclVAT: Decimal;

    local procedure InitLogInteraction()
    begin
        LogInteraction := SegManagement.FindInteractTmplCode(4) <> '';
    end;

    local procedure GetLotNoInfo(parLotNo: Code[20])
    begin

        grecLotNoInformation.SetCurrentKey("Lot No.");
        grecLotNoInformation.SetRange("Lot No.", parLotNo);
        if not grecLotNoInformation.Find('-') then
            grecLotNoInformation.Init;

        if not grecGrade.Get(grecLotNoInformation."B Grade Code") then
            grecGrade.Init;

        if grecLotNoInformation."B Germination" <> 0 then
            gGerm := Format(grecLotNoInformation."B Germination") + ' %'
        else
            gGerm := '';



        if CopyStr(grecLotNoInformation."Item No.", 1, 2) = '68' then
            case CopyStr(grecLotNoInformation."Item No.", 6, 1) of
                '1', '2', '3', '4', '5', '6', '7':
                    grecGrade.Description := '';
            end;

        if CopyStr(grecLotNoInformation."Item No.", 1, 2) = '81' then
            case CopyStr(grecLotNoInformation."Item No.", 6, 1) of
                '5':
                    grecGrade.Description := '';
            end;

        if CopyStr(grecLotNoInformation."Item No.", 1, 2) = '84' then
            case CopyStr(grecLotNoInformation."Item No.", 6, 1) of
                '1', '4', '5':
                    grecGrade.Description := '';
            end;

        if CopyStr(grecLotNoInformation."Item No.", 1, 2) = '89' then
            case CopyStr(grecLotNoInformation."Item No.", 6, 1) of
                '1', '4', '5':
                    grecGrade.Description := '';
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
          CompanyAddr[1] + Format(Char177) +
          CompanyAddr[2] + Format(Char177) +
          CompanyAddr[3] + Format(Char177) +
          Text101 + CompanyInfo."Phone No." + Format(Char177) +
          Text102 + CompanyInfo."E-Mail" + Format(Char177) +
          Text103 + CompanyInfo."Home Page" + Format(Char177) +
          CompanyInfo."Bank Name" + Format(Char177) +
          CompanyInfo."Bank Account No." + Format(Char177) +
          CompanyInfo.FieldCaption(IBAN) + ': ' + CompanyInfo.IBAN + Format(Char177) +
          CompanyInfo.FieldCaption("SWIFT Code") + ': ' + CompanyInfo."SWIFT Code" + Format(Char177) +
          CompanyInfo.FieldCaption("Registration No.") + ': ' + CompanyInfo."Registration No." + Format(Char177) +
          CompanyInfo.FieldCaption("VAT Registration No.") + ': ' + CompanyInfo."VAT Registration No." + Format(Char177) +
          Text104 + Format(Char177) +
          ' ' + Format(Char177) +
          Text105 + Format(Char177) +
          ' '
          );
    end;

    local procedure SetDataCaptionHeader(): Text
    var
        Char177: Char;
    begin
        Char177 := 177;
        exit(
          Text301 + Format(Char177) +
          Text302 + Format(Char177) +
          Text303 + Format(Char177) +
          Text304 + Format(Char177) +
          Text305 + Format(Char177) +
          Text306 + Format(Char177) +
          Text307 + Format(Char177) +

          '' + Format(Char177) +
          Text310 + Format(Char177) +
          Text311 + Format(Char177) +
          '' + Format(Char177) +
          '' + Format(Char177) +
          '' + Format(Char177) +
          Text315 + Format(Char177) +

          ' '
          );
    end;

    local procedure SetDataHeader(): Text
    var
        Char177: Char;
    begin
        Char177 := 177;
        exit(

        Text108 + Format(Char177) +
        "Sales Header"."No." + Format(Char177) +
        Text106 + Format(Char177) +
        "Sales Header"."Bill-to Customer No." + Format(Char177) +
        Text121 + Format(Char177) +
        "Sales Header"."No." + Format(Char177) +
        Text109 + Format(Char177) +
        Format(WorkDate) + Format(Char177) +
        "Sales Header".FieldCaption("Shipment Date") + Format(Char177) +
        Format("Sales Header"."Shipment Date") + Format(Char177) +
        '' + Format(Char177) +

        Text119 + ' ' + CopyText + Format(Char177) +
        Text120 + Format(Char177) +
        CustAddr[1] + Format(Char177) +
        CustAddr[2] + Format(Char177) +
        CustAddr[3] + Format(Char177) +
        CustAddr[4] + Format(Char177) +
        CustAddr[5] + Format(Char177) +
        CustAddr[6] + Format(Char177) +
        "Sales Header".FieldCaption("VAT Registration No.") + ' ' + "Sales Header"."VAT Registration No." + Format(Char177) +

        Text110 + Format(Char177) +
        ShipToAddr[1] + Format(Char177) +
        ShipToAddr[2] + Format(Char177) +
        ShipToAddr[3] + Format(Char177) +
        ShipToAddr[4] + Format(Char177) +
        ShipToAddr[5] + Format(Char177) +
        ShipToAddr[6] + Format(Char177) +
          ' '
          );
    end;

    local procedure SetDataFooter(): Text
    var
        Char177: Char;
    begin
        Char177 := 177;
        exit(
          Text401 + Format(Char177) +
          Format("Sales Header"."B Gross weight") + Format(Char177) +
          Text403 + Format(Char177) +
          Format("Sales Header"."B Reserved weight") + Format(Char177) +
          Text405 + Format(Char177) +
          "Sales Header"."B Contents" + Format(Char177) +
          Text407 + Format(Char177) +
          '' + Format(Char177) +
          Text409 + Format(Char177) +
          '' + Format(Char177) +
          Text411 + Format(Char177) +
          PaymentTerms.Description + Format(Char177) +
          Text413 + Format(Char177) +
          "Sales Header"."Payment Method Code" + Format(Char177) +
          grecSalesTerms.Description + Format(Char177) +
          grecSalesTerms."Description 2" + Format(Char177) +
          ' '
          );
    end;

    local procedure GetUserID() Result: Text
    begin
        Result := UserId;
        while StrPos(Result, '\') > 0 do
            Result := CopyStr(Result, StrPos(Result, '\') + 1);
        exit(Result);
    end;

    local procedure GetFormattedDateTime(CurrDate: Date; CurrTime: Time): Text
    begin
        if CurrDate = 0D then
            CurrDate := Today;
        if CurrTime = 0T then
            CurrTime := Time;

        exit(
          StrSubstNo('%1, %2',
            Format(CurrDate, 0, '<Day> <Month Text> <Year4>'),
            Format(CurrTime, 0, '<Hours24>:<Minutes,2>:<Seconds,2>')));
    end;
}

