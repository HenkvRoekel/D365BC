report 50015 "Sales - Proforma Credit Memo"
{

    DefaultLayout = RDLC;
    RDLCLayout = './RDLC/Sales - Proforma Credit Memo.rdlc';


    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            CalcFields = "B Reserved weight";
            DataItemTableView = SORTING ("Document Type", "No.") WHERE ("Document Type" = CONST ("Credit Memo"));
            RequestFilterFields = "Document Type", "No.", "Sell-to Customer No.";
            RequestFilterHeading = 'Sales Order';
            column(ShowInternalInfo; ShowInternalInfo)
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
            column(CompanyAddressCountry; grecCountry.Name)
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
                IncludeCaption = true;
            }
            column(CompanyIBAN; CompanyInfo.IBAN)
            {
                IncludeCaption = true;
            }
            column(ComapnyVATRegNo; CompanyInfo."VAT Registration No.")
            {
                IncludeCaption = true;
            }
            column(CompanyRegNo; CompanyInfo."Registration No.")
            {
                IncludeCaption = true;
            }
            column(PictureCompanyInfo; CompanyInfo.Picture)
            {
            }
            column(WebsiteCompanyInfo; CompanyInfo."Home Page")
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
            column(No_SalesHeader; "Sales Header"."No.")
            {
                IncludeCaption = true;
            }
            column(BilltoCustomerNo_SalesHeader; "Sales Header"."Bill-to Customer No.")
            {
                IncludeCaption = true;
            }
            column(YourReference_SalesHeader; "Sales Header"."Your Reference")
            {
                IncludeCaption = true;
            }
            column(ShipmentDate_SalesHeader; "Sales Header"."Shipment Date")
            {
                IncludeCaption = true;
            }
            column(Contents_SalesHeader; "Sales Header"."B Contents")
            {
                IncludeCaption = true;
            }
            column(PackingDescription_SalesHeader; "Sales Header"."B Packing Description")
            {
                IncludeCaption = true;
            }
            column(Grossweight_SalesHeader; "Sales Header"."B Gross weight")
            {
            }
            column(Reservedweight_SalesHeader; "Sales Header"."B Reserved weight")
            {
            }
            column(PackageTrackingNo_SalesHeader; "Sales Header"."Package Tracking No.")
            {
                IncludeCaption = true;
            }
            column(VATRegistrationNo_SalesHeader; "Sales Header"."VAT Registration No.")
            {
            }
            column(PTerms_Description; PaymentTerms.Description)
            {
            }
            column(SMethodDescription; ShipmentMethod.Description)
            {
            }
            column(TotalAmountInclVAT; TotalAmountInclVAT)
            {
            }
            column(TotalText; TotalText)
            {
            }
            column(TotalInclVATText; TotalInclVATText)
            {
            }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document Type" = FIELD ("Document Type"), "Document No." = FIELD ("No.");
                DataItemTableView = SORTING ("Document Type", "Document No.", "Line No.");
                column(LineNo_SalesLine; "Sales Line"."Line No.")
                {
                }
                column(ExternalDocumentNo_SalesLine; "Sales Line"."B External Document No.")
                {
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
                }
                column(LineAmount_SalesLine; "Sales Line"."Line Amount")
                {
                }
                column(Type_SalesLine; Format("Sales Line".Type, 0, 2))
                {
                }
                column(No_SalesLine; "Sales Line"."No.")
                {
                    IncludeCaption = true;
                }
                column(Description_SalesLine; "Sales Line".Description)
                {
                    IncludeCaption = true;
                }
                column(Description2_SalesLine; "Sales Line"."Description 2")
                {
                    IncludeCaption = true;
                }
                column(UoM_SalesLine; gUnitOfMeasure."B Description for Reports")
                {
                }
                column(gTxtOntsmet; gTxtOntsmet)
                {
                }
                column(ItemLineText; ItemLineText)
                {
                }
                column(LotNo_ReservationEntry; ReservationEntry."Lot No.")
                {
                }
                column(gTestDate_ReservationEntry; gTestDate)
                {
                }
                column(gGerm_ReservationEntry; gGerm)
                {
                }
                column(Desc1_ReservationEntry; grecLotNoInformation."B Description 1")
                {
                }
                column(Description_ReservationEntry; grecGrade.Description)
                {
                }
                column(Tswingr_ReservationEntry; grecLotNoInformation."B Tsw. in gr.")
                {
                }
                column(LotNo_ItemLedgerEntry; ItemLedgerEntry."Lot No.")
                {
                }
                column(gTestDate_ItemLedgerEntry; gTestDate)
                {
                }
                column(gGerm_ItemLedgerEntry; gGerm)
                {
                }
                column(Desc1_ItemLedgerEntry; grecLotNoInformation."B Description 1")
                {
                }
                column(Description_ItemLedgerEntry; grecGrade.Description)
                {
                }
                column(Tswingr_ItemLedgerEntry; grecLotNoInformation."B Tsw. in gr.")
                {
                }
                dataitem("Sales Comment Line"; "Sales Comment Line")
                {
                    DataItemLink = "No." = FIELD ("Document No."), "Document Line No." = FIELD ("Line No.");
                    DataItemTableView = SORTING ("Document Type", "No.", "Document Line No.", "Line No.") WHERE ("Document Type" = CONST ("Credit Memo"));
                    column(LineNo_SalesCommentLine; "Line No.")
                    {
                    }
                    column(Comment_SalesCommentLine; Comment)
                    {
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    if grecItem.Get("Sales Line"."No.") then;

                    if not grecItemExt.Get(grecItem."B Extension", "Sales Header"."Language Code") then
                        grecItemExt.Init;
                    gTxtOntsmet := '';
                    if grecItem."B Organic" = false then
                        gTxtOntsmet := grecItemExt.Description;


                    if not gUnitOfMeasure.Get("Unit of Measure Code") then
                        gUnitOfMeasure.Init;

                    Clear(grecLotNoInformation);
                    Clear(ReservationEntry);
                    ReservationEntry.SetRange("Source Type", 37);
                    ReservationEntry.SetRange("Source Subtype", 3);
                    ReservationEntry.SetRange("Source ID", "Sales Line"."Document No.");
                    ReservationEntry.SetRange("Source Ref. No.", "Sales Line"."Line No.");
                    if ReservationEntry.FindFirst then
                        GetLotNoInfo(ReservationEntry."Lot No.");

                    Clear(ItemChargeAssSales);
                    Clear(ItemLedgerEntry);
                    ItemChargeAssSales.SetRange("Document Type", ItemChargeAssSales."Document Type"::"Credit Memo");
                    ItemChargeAssSales.SetRange("Document No.", "Sales Line"."Document No.");
                    ItemChargeAssSales.SetRange("Document Line No.", "Sales Line"."Line No.");
                    if ItemChargeAssSales.FindFirst then begin

                        ItemLedgerEntry.SetRange("Document Type", ItemLedgerEntry."Document Type"::"Sales Shipment");
                        ItemLedgerEntry.SetRange("Document No.", ItemChargeAssSales."Applies-to Doc. No.");
                        ItemLedgerEntry.SetRange("Document Line No.", ItemChargeAssSales."Applies-to Doc. Line No.");
                        if ItemLedgerEntry.FindFirst then
                            GetLotNoInfo(ItemLedgerEntry."Lot No.");

                    end;

                end;

                trigger OnPreDataItem()
                begin
                    CurrReport.CreateTotals("Line Amount", Amount, "Amount Including VAT", "Inv. Discount Amount", gNetWeight, gGrossWeight);
                end;
            }
            dataitem(VATCounter; "Integer")
            {
                DataItemTableView = SORTING (Number);

                trigger OnAfterGetRecord()
                begin

                    VATAmountLine.GetLine(Number);

                    "gV%"[Number] := VATAmountLine."VAT %";
                    gVBasis[Number] := VATAmountLine."VAT Base";
                    gVAmount[Number] := VATAmountLine."VAT Amount";

                end;

                trigger OnPreDataItem()
                begin

                    Clear("gV%");
                    Clear(gVBasis);
                    Clear(gVAmount);


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
                column(TotalVATAmt1; gVBasis[1] + gVAmount[1])
                {
                }
                column(TotalVATAmt2; gVBasis[2] + gVAmount[2])
                {
                }
                column(TotalVATAmt3; gVBasis[3] + gVAmount[3])
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
            }

            trigger OnAfterGetRecord()
            var
                SalesPost: Codeunit "Sales-Post";
            begin
                Clear(SalesLine);

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

                if not grecShipToAddress.Get("Sell-to Customer No.", "Ship-to Code") then
                    grecShipToAddress.Init;
                "Ship-to Contact" := '';
                if grecShipToAddress."Phone No." <> '' then begin
                    gPhone := Text50003 + ' ' + grecShipToAddress."Phone No.";
                    "Ship-to Contact" := gPhone;
                end else begin
                    "Ship-to Contact" := Text50003 + ' ' + grecCust."Phone No.";
                end;


                ShowShippingAddr := FormatAddr.SalesHeaderShipTo(ShipToAddr, CustAddr, "Sales Header");
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
        lblItemNo = 'Item No';
        lblLotNo = 'Lot No.';
        lblGrade = 'Grade';
        lblUnit = 'Unit';
        lblTotal = 'Total';
        lblPrice = 'Price';
        lblVATPercent = '% VAT';
        lblVATAmount = 'VAT Amount';
        lblShipToCustomer = 'Ship-to Customer';
        lblBillToCustomer = 'Bill-to Customer';
        lblSalesperson = 'Salesperson';
        lblCreditMemoNo = 'Credit Memo No.';
        lblCustomerNo = 'Customer No.';
        lblShipmentMethods = 'Shipment Method';
        lblShipmentTerms = 'Shipment Terms';
        lblPaymentTerms = 'Payment Terms';
        lblNetWeight = 'Net Weight';
        lblRegistrationNo = 'Registration No.';
        lblVATRegno = 'VAT Registration No.';
        lblGrossWeight = 'Gross Weight';
        lblGerm = 'Germ.';
        lblTestDate = 'Test Date';
        lblScnt = 'Scnt/Lb';
        lblPurchaseOrder = 'Purchase Order';
        lblPage = 'Page';
        lblProforma = 'Proforma Credit Memo';
        lblVATBase = 'VAT Base';
        lblAmount = 'Amount';
        lblLineDisc = 'Line Disc.';
        lblContents = 'Contents';
        lblTswInGr = 'Tsw. in gr.';
    }

    var
        GLSetup: Record "General Ledger Setup";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        VATAmountLine: Record "VAT Amount Line" temporary;
        SalesLine: Record "Sales Line" temporary;
        RespCenter: Record "Responsibility Center";
        Language: Record Language;
        SalesCountPrinted: Codeunit "Sales-Printed";
        FormatAddr: Codeunit "Format Address";
        SegManagement: Codeunit SegManagement;
        ArchiveManagement: Codeunit ArchiveManagement;
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
        DimText: Text[120];
        OldDimText: Text[75];
        ShowInternalInfo: Boolean;
        Continue: Boolean;
        ArchiveDocument: Boolean;
        LogInteraction: Boolean;
        VATAmount: Decimal;
        VATBaseAmount: Decimal;
        VATDiscountAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        "***** Bejo Variables*****": Integer;
        gNetWeight: Decimal;
        gGrossWeight: Decimal;
        grecCountry: Record "Country/Region";
        grecLotNoInformation: Record "Lot No. Information";
        grecGrade: Record Grade;
        gTxtOntsmet: Text[60];
        gGerm: Text[30];
        gTestDate: Text[30];
        grecCust: Record Customer;
        grecShipToAddress: Record "Ship-to Address";
        gPhone: Text[30];
        grecItem: Record Item;
        grecItemExt: Record "Item Extension";
        gUnitOfMeasure: Record "Unit of Measure";
        "gV%": array[10] of Decimal;
        gVBasis: array[10] of Decimal;
        gVAmount: array[10] of Decimal;
        Text000: Label 'Salesperson';
        Text001: Label 'Total %1';
        Text002: Label 'Total %1 Incl. VAT';
        Text003: Label 'COPY';
        Text004: Label 'Proforma Credit Memo %1';
        Text005: Label 'Page %1';
        Text006: Label 'Total %1 Excl. VAT';
        Text50001: Label 'Not chemically treated';
        Text50002: Label 'Treated';
        Text50003: Label 'Phone:';
        ItemLineText: Text[120];
        RECLineText: Record "Sales Comment Line";
        TextCZ007: Label 'Memorandum: ';
        TextCZ008: Label ', created ';
        ReservationEntry: Record "Reservation Entry";
        ItemChargeAssSales: Record "Item Charge Assignment (Sales)";
        ItemLedgerEntry: Record "Item Ledger Entry";

    procedure GetLotNoInfo(parLotNo: Code[20])
    begin
        // - BEJOWW5.01.012 ---
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

        gTestDate := Format(grecLotNoInformation."B Test Date", 0, '<month,2>/<year,2>');

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
}

