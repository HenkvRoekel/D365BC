report 50011 "Packing List Shipment Bejo"
{

    DefaultLayout = RDLC;
    RDLCLayout = './RDLC/Packing List Shipment Bejo.rdlc';

    dataset
    {
        dataitem("Sales Shipment Header"; "Sales Shipment Header")
        {
            CalcFields = "B Reserved weight";
            DataItemTableView = SORTING ("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.";
            column(Contents_SalesShipmentHeader; "Sales Shipment Header"."B Contents")
            {
                IncludeCaption = true;
            }
            column(Grossweight_SalesShipmentHeader; "Sales Shipment Header"."B Gross weight")
            {
                IncludeCaption = true;
            }
            column(Netweight_SalesShipmentHeader; "Sales Shipment Header"."B Reserved weight")
            {
            }
            column(ShipmentDate_SalesShipmentHeader; "Sales Shipment Header"."Shipment Date")
            {
                IncludeCaption = true;
            }
            column(OrderNo_SalesShipmentHeader; "Sales Shipment Header"."Order No.")
            {
                IncludeCaption = true;
            }
            column(BilltoCustomerNo_SalesShipmentHeader; "Sales Shipment Header"."Bill-to Customer No.")
            {
                IncludeCaption = true;
            }
            column(No_SalesShipmentHeader; "Sales Shipment Header"."No.")
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
            column(PaymentTerms; PaymentTerms.Description)
            {
            }
            column(ShipmentMethods; ShippingAgent.Name)
            {
            }
            column(ShipmentTerms; ShipmentMethod.Description)
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
            column(CompanyPhone; CompanyInfo."Phone No.")
            {
            }
            column(CompanyFax; CompanyInfo."Fax No.")
            {
            }
            column(CompanyEmail; CompanyInfo."E-Mail")
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
            column(CompanyGiroNo; CompanyInfo."Giro No.")
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
            column(CompanyVATRegistrationNo; CompanyInfo."VAT Registration No.")
            {
                IncludeCaption = true;
            }
            column(CompanyRegistrationNo; CompanyInfo."Registration No.")
            {
            }
            column(CompanyRegistrationNoCaption; TextRegNo)
            {
            }
            column(PictureCompanyInfo; CompanyInfo.Picture)
            {
            }
            column(WebsiteCompanyInfo; CompanyInfo."Home Page")
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
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING (Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING (Number) WHERE (Number = CONST (1));
                    dataitem("Sales Shipment Line"; "Sales Shipment Line")
                    {
                        DataItemLink = "Document No." = FIELD ("No.");
                        DataItemLinkReference = "Sales Shipment Header";
                        DataItemTableView = SORTING ("Document No.", "Line No.");
                        column(OutputNo; OutputNo)
                        {
                        }
                        column(Type_SalesShipmentLine; Format("Sales Shipment Line".Type, 0, 2))
                        {
                        }
                        column(LineNo_SalesShipmentLine; "Sales Shipment Line"."Line No.")
                        {
                        }
                        column(No_SalesShipmentLine; "Sales Shipment Line"."No.")
                        {
                        }
                        column(Description_SalesShipmentLine; "Sales Shipment Line".Description)
                        {
                            IncludeCaption = true;
                        }
                        column(Description2_SalesShipmentLine; "Sales Shipment Line"."Description 2")
                        {
                            IncludeCaption = true;
                        }
                        column(Quantity_SalesShipmentLine; "Sales Shipment Line".Quantity)
                        {
                            IncludeCaption = true;
                        }
                        column(QuantityBase_SalesShipmentLine; Format("Sales Shipment Line"."Quantity (Base)", 0, 0))
                        {
                        }
                        column(PurchaseOrderNo_SalesShipmentLine; "Sales Shipment Line"."Purchase Order No.")
                        {
                            IncludeCaption = true;
                        }
                        column(gUnitOfMeasure; gUnitofMeasure."B Description for Reports")
                        {
                        }
                        column(ItemTreated; gTreated)
                        {
                        }
                        column(Text_LineText; ItemLineText)
                        {
                        }
                        column(TreatmentCodeDescription; gTreatmentCode)
                        {
                        }
                        column(Bestusedby_LotNoInformation; LotNoInf."B Best used by")
                        {
                        }
                        column(LotNo_LotNoInformation; LotNoInf."Lot No.")
                        {
                        }
                        column(Tswingr_LotNoInformation; LotNoInf."B Tsw. in gr.")
                        {
                        }
                        column(gGermination; gGermination)
                        {
                        }
                        column(GradeDescription; grecGrade.Description)
                        {
                        }
                        column(ExternalDocumentNo_SalesShipmentLine; "Sales Shipment Line"."B External Document No.")
                        {
                        }
                        dataitem("Sales Comment Line"; "Sales Comment Line")
                        {
                            DataItemLink = "No." = FIELD ("Document No."), "Document Line No." = FIELD ("Line No.");
                            DataItemTableView = SORTING ("Document Type", "No.", "Document Line No.", "Line No.") WHERE ("Document Type" = CONST (Shipment));
                            column(LineNo_SalesCommentLine; "Line No.")
                            {
                            }
                            column(Comment_SalesCommentLine; Comment)
                            {
                            }
                        }

                        trigger OnAfterGetRecord()
                        begin

                            if not grecItem.Get("No.") then
                                grecItem.Init;


                            if not grecItemExtension.Get(grecItem."B Extension", "Sales Shipment Header"."Language Code") then
                                grecItemExtension.Init;
                            gTreated := '';
                            if (grecItemExtension.Extension < '6') then
                                gTreated := grecItemExtension.Description;

                            gUnitofMeasure."B Description for Reports" := '';

                            if not gUnitofMeasure.Get("Unit of Measure Code") then
                                gUnitofMeasure.Init;

                            Clear(LotNoInf);
                            ItemEntryRelation.SetRange("Source ID", "Sales Shipment Line"."Document No.");
                            ItemEntryRelation.SetRange("Source Ref. No.", "Sales Shipment Line"."Line No.");
                            ItemEntryRelation.SetRange("Source Type", 111);
                            if ItemEntryRelation.FindFirst then begin

                                LotNoInf.SetRange("Lot No.", ItemEntryRelation."Lot No.");
                                if LotNoInf.FindFirst then
                                    GetLotNoInformation()

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
                        CopyText := Text007;
                        OutputNo += 1;
                    end;
                    CurrReport.PageNo := 1;
                end;

                trigger OnPostDataItem()
                begin
                    if not CurrReport.Preview then
                        ShptCountPrinted.Run("Sales Shipment Header");
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := 1 + Abs(NoOfCopies);
                    CopyText := '';
                    SetRange(Number, 1, NoOfLoops);
                    OutputNo := 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CurrReport.Language := Language.GetLanguageID("Language Code");

                CompanyInfo.Get;
                CompanyInfo.CalcFields(Picture);
                grecCustomer.Get("Bill-to Customer No.");

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


                if "Payment Terms Code" = '' then
                    PaymentTerms.Init
                else
                    PaymentTerms.Get("Payment Terms Code");
                if "Shipment Method Code" = '' then
                    ShipmentMethod.Init
                else
                    ShipmentMethod.Get("Shipment Method Code");

                FormatAddr.SalesShptShipTo(ShipToAddr, "Sales Shipment Header");
                ShowShippingAddr := FormatAddr.SalesShptBillTo(CustAddr, ShipToAddr, "Sales Shipment Header");


                if not ShippingAgent.Get("Sales Shipment Header"."Shipping Agent Code") then
                    ShippingAgent.Init;


                if not CurrReport.Preview then
                    ShptCountPrinted.Run("Sales Shipment Header");


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
        lblOrderNo = 'Order No.';
        lblContents = 'Contents';
        lblNetWeight = 'Net Weight';
        lblGrossWeight = 'Gross Weight';
        lblPaymentTerms = 'Payment Terms';
        lblShipmentMethods = 'Shipment Methods';
        lblShipmentTerms = 'Shipment Terms';
        lblItemNo = 'Item No.';
        lblGrade = 'Grade';
        lblTestDateGerm = 'Test date Germ.';
        lblTestUsedBy = 'Best used by';
        lblTwsInGr = 'Tsw. in gr.';
        lblBoxNo = 'Box No.';
        lblUnit = 'Unit';
        lblQty = 'Qty.';
        lblRegistrationNo = 'Registration No.';
        lblVATRegistrationNo = 'VAT Registration No.';
        lblGerm = 'Germ.';
        lblPackingList = 'Packing List';
        lblSellToCustomer = 'Sell-to Customer';
        lblBillToCustomer = 'Bill-to Customer';
        lblTotal = 'Total';
        lblLotNo = 'Lot No.';
        lblSignature = 'Received By:';
        lblIssuedBy = 'Issued By:';
    }

    var
        GLSetup: Record "General Ledger Setup";
        ShipmentMethod: Record "Shipment Method";
        ShippingAgent: Record "Shipping Agent";
        PaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        RespCenter: Record "Responsibility Center";
        Language: Record Language;
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
        NoOfCopies: Integer;
        CopyText: Text[30];
        ShowShippingAddr: Boolean;
        i: Integer;
        ShowInternalInfo: Boolean;
        ArchiveDocument: Boolean;
        LogInteraction: Boolean;
        gTreated: Text[60];
        grecGrade: Record Grade;
        grecCustomer: Record Customer;
        gGermination: Text[30];
        grecItem: Record Item;
        grecItemExtension: Record "Item Extension";
        grecTreatmentCode: Record "Treatment Code";
        gTreatmentCode: Text[50];
        gUnitofMeasure: Record "Unit of Measure";
        gcuBejoMgt: Codeunit "Bejo Management";
        Text000: Label 'Salesperson';
        Text001: Label 'Total %1';
        Text002: Label 'Total %1 Incl. VAT';
        Text004: Label 'Packing list %1';
        Text005: Label 'Page %1';
        Text006: Label 'Total %1 Excl. VAT';
        Text007: Label 'COPY';
        ItemLineText: Text[100];
        TextRegNo: Label 'Registration No.';
        TextCZ007: Label 'Memorandum: ';
        TextCZ008: Label ', created ';
        ShptCountPrinted: Codeunit "Sales Shpt.-Printed";
        ItemEntryRelation: Record "Item Entry Relation";
        LotNoInf: Record "Lot No. Information";
        "////": Integer;
        NoOfLoops: Integer;
        OutputNo: Integer;
        DataFixedHeader: Text;
        DataCaptionHeader: Text;
        DataHeader: Text;
        DataFooter: Text;
        "//////": Label '';
        Text101: Label 'Tel: ';
        Text102: Label 'E-mail: ';
        Text103: Label 'Website: ';
        Text104: Label 'Page';
        Text105: Label 'When remitting please quote:';
        Text106: Label 'Customer No.';
        Text108: Label 'Invoice No.';
        Text109: Label 'Invoice Date';
        Text110: Label 'Bill-to Customer';
        Text111: Label 'Total';
        Text112: Label 'Lot No.';
        Text113: Label 'Grade';
        Text114: Label 'Country of Origin';
        Text115: Label 'Line Disc.';
        Text116: Label 'Header Dimensions';
        Text117: Label 'Not chemically treated + HWT';
        Text118: Label 'Line Dimensions';
        Text119: Label 'Packing List';
        Text120: Label 'Sell-to Customer';
        Text401: Label 'Gross Weight';
        Text403: Label 'Net Weight';
        Text405: Label 'Contents';
        Text407: Label 'Shipment Method';
        Text409: Label 'Shipment Terms';
        Text411: Label 'Payment Terms';
        Text413: Label 'Payment Method';
        Text414: Label 'Issued by:';
        Text415: Label 'Received by:';
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
        Text307: Label 'Amount';
        Text308: Label 'VAT %';
        Text310: Label 'Lot No.';
        Text311: Label 'Grade';
        Text313: Label 'Country of Origin';
        Text315: Label 'Line Disc.';
        Text316: Label 'Tsw. in gr.';
        Text317: Label 'Germ.';
        Text318: Label 'Best used by';
        Text319: Label '=Parameters!lblLotNo.Value + "                  " + Parameters!lblGrade.Value';
        Text320: Label 'Ext. Doc. No.';

    local procedure GetLotNoInformation()
    begin
        if not grecGrade.Get(LotNoInf."B Grade Code") then
            grecGrade.Init;

        if LotNoInf."B Germination" <> 0 then
            gGermination := Format(LotNoInf."B Germination") + ' %'
        else
            gGermination := '';

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

        if not grecTreatmentCode.Get(LotNoInf."B Treatment Code") then
            grecTreatmentCode.Init;
        gTreatmentCode := grecTreatmentCode."Description Reports";
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
          CompanyInfo.FieldCaption(IBAN) + ': ' + CompanyInfo.IBAN + Format(Char177) +                                      //(9,1)
          CompanyInfo.FieldCaption("SWIFT Code") + ': ' + CompanyInfo."SWIFT Code" + Format(Char177) +                      //(10,1)
          CompanyInfo.FieldCaption("Registration No.") + ': ' + CompanyInfo."Registration No." + Format(Char177) +          //(11,1)
          CompanyInfo.FieldCaption("VAT Registration No.") + ': ' + CompanyInfo."VAT Registration No." + Format(Char177) +  //(12,1)
          Text104 + Format(Char177) +                                                                                       //(13,1)
          ' ' + Format(Char177) +                                                                                           //(14,1)
          ' ' + Format(Char177) +                                                                                           //(15,1)
          ' '
          );
    end;

    local procedure SetDataCaptionHeader(): Text
    var
        Char177: Char;
    begin
        Char177 := 177;
        exit(
          Text301 + Format(Char177) +   //(1,3)
          Text302 + Format(Char177) +   //(2,3)
          Text303 + Format(Char177) +   //(3,3)
          Text304 + Format(Char177) +   //(4,3)
          Text305 + Format(Char177) +   //(5,3)
          Text316 + Format(Char177) +   //(6,3)
          Text317 + Format(Char177) +   //(7,3)
          '' + Format(Char177) +        //(8,3)
          Text112 + Format(Char177) +   //(9,3)
          Text113 + Format(Char177) +   //(10,3)
          Text318 + Format(Char177) +   //(11,3)
          '' + Format(Char177) +        //(12,3)
          Text320 + Format(Char177) +   //(13,3)
          '' + Format(Char177) +        //(14,3)
          '' + Format(Char177) +        //(15,3)
          ' '
          );
    end;

    local procedure SetDataHeader(): Text
    var
        Char177: Char;
    begin
        Char177 := 177;
        exit(
        "Sales Shipment Header".FieldCaption("Order No.") + Format(Char177) +             //(1,2)
        "Sales Shipment Header"."Order No." + Format(Char177) +                           //(2,2)
        "Sales Shipment Header".FieldCaption("Bill-to Customer No.") + Format(Char177) +  //(3,2)
        "Sales Shipment Header"."Bill-to Customer No." + Format(Char177) +                //(4,2)
        "Sales Shipment Header".FieldCaption("Shipment Date") + Format(Char177) +         //(5,2)
        Format("Sales Shipment Header"."Shipment Date") + Format(Char177) +               //(6,2)
        '' + Format(Char177) +                                                            //(7,2)
        '' + Format(Char177) +                                                            //(8,2)
        '' + Format(Char177) +                                                            //(9,2)
        '' + Format(Char177) +                                                            //(10,2)
          '' + Format(Char177) +                                                          //(11,2)
          Text119 + ' ' + CopyText + Format(Char177) +                                     //(12,2)
          Text120 + Format(Char177) +                                                     //(13,2)
          ShipToAddr[1] + Format(Char177) +                                               //(14,2)
          ShipToAddr[2] + Format(Char177) +                                               //(15,2)
          ShipToAddr[3] + Format(Char177) +                                               //(16,2)
          ShipToAddr[4] + Format(Char177) +                                               //(17,2)
          ShipToAddr[5] + Format(Char177) +                                               //(18,2)
          ShipToAddr[6] + Format(Char177) +                                               //(19,2)
          '' + Format(Char177) +                                                          //(20,2)
        Text110 + Format(Char177) +                                                       //(21,2)
        CustAddr[1] + Format(Char177) +                                                   //(22,2)
        CustAddr[2] + Format(Char177) +                                                   //(23,2)
        CustAddr[3] + Format(Char177) +                                                   //(24,2)
        CustAddr[4] + Format(Char177) +                                                   //(25,2)
        CustAddr[5] + Format(Char177) +                                                   //(26,2)
        CustAddr[6] + Format(Char177) +                                                   //(27,2)
        "Sales Shipment Header"."External Document No." + Format(Char177) +               //(28,2)
        Text320 + Format(Char177) +                                                       //(29,2)
        ' '
          );
    end;

    local procedure SetDataFooter(): Text
    var
        Char177: Char;
    begin
        Char177 := 177;
        exit(
          Text403 + Format(Char177) +                                             //(1,4)
          Format("Sales Shipment Header"."B Reserved weight") + Format(Char177) +  //(2,4)
          Text401 + Format(Char177) +                                             //(3,4)
          Format("Sales Shipment Header"."B Gross weight") + Format(Char177) +    //(4,4)
          Text405 + Format(Char177) +                                             //(5,4)
          "Sales Shipment Header"."B Contents" + Format(Char177) +                //(6,4)
          Text411 + Format(Char177) +                                             //(7,4)
          PaymentTerms.Description + Format(Char177) +                            //(8,4)
          '' + Format(Char177) +                                                  //(9,4)
          '' + Format(Char177) +                                                  //(10,4)
          '' + Format(Char177) +                                                  //(11,4)
          '' + Format(Char177) +                                                  //(12,4)
          Text414 + Format(Char177) +                                             //(13,4)
          Text415 + Format(Char177) +                                             //(14,4)
          ' '
          );
    end;
}

