report 50007 "Packing List Bejo"
{

    DefaultLayout = RDLC;
    RDLCLayout = './RDLC/Packing List Bejo.rdlc';


    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            CalcFields = "B Reserved weight";
            DataItemTableView = SORTING ("Document Type", "No.") WHERE ("Document Type" = CONST (Order));
            RequestFilterFields = "No.", "Sell-to Customer No.";
            RequestFilterHeading = 'Sales Order';

            column(No_SalesHeader; "Sales Header"."No.")
            {
            }
            column(BilltoCustomerNo_SalesHeader; "Sales Header"."Bill-to Customer No.")
            {
                IncludeCaption = true;
            }
            column(ShipmentDate_SalesHeader; "Sales Header"."Shipment Date")
            {
                IncludeCaption = true;
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
            column(CompanyCountry; Country.Name)
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
            column(ShipToAddr7; ShipToAddr[6])
            {
            }
            column(YourReference_SalesHeader; "Sales Header"."Your Reference")
            {
            }
            column(PackingDescription_SalesHeader; "Sales Header"."B Packing Description")
            {
                IncludeCaption = true;
            }
            column(Contents_SalesHeader; "Sales Header"."B Contents")
            {
                IncludeCaption = true;
            }
            column(PackageTrackingNo_SalesHeader; "Sales Header"."Package Tracking No.")
            {
                IncludeCaption = true;
            }
            column(VATRegistrationNo_SalesHeader; "Sales Header"."VAT Registration No.")
            {
            }
            column(PaymentTerms; PaymentTerms.Description)
            {
            }
            column(ShipmentMethods; ShipmentMethod.Description)
            {
            }
            column(SalespersonName; SalesPurchPerson.Name)
            {
            }
            column(Grossweight_SalesHeader; "Sales Header"."B Gross weight")
            {
            }
            column(Reservedweight_SalesHeader; "Sales Header"."B Reserved weight")
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
                    dataitem("Sales Line"; "Sales Line")
                    {
                        DataItemLink = "Document Type" = FIELD ("Document Type"), "Document No." = FIELD ("No.");
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = SORTING ("Document Type", "Document No.", "Line No.");
                        column(OutputNo; OutputNo)
                        {
                        }
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
                        column(Description2_SalesLine; "Sales Line"."Description 2")
                        {
                        }
                        column(Quantity_SalesLine; "Sales Line".Quantity)
                        {
                        }
                        column(ExternalDocumentNo_SalesLine; "Sales Line"."B External Document No.")
                        {
                        }
                        column(gUnitOfMeasure; gUnitOfMeasure."B Description for Reports")
                        {
                        }
                        column(QuantityBase_SalesLine; Format("Sales Line"."Quantity (Base)", 0, 0))
                        {
                        }
                        column(BoxNo_SalesLine; "Sales Line"."B Box No.")
                        {
                        }
                        column(Text_LineText; gItemLineText)
                        {
                        }
                        column(PurchaseOrderNo_SalesLine; "Sales Line"."Purchase Order No.")
                        {
                            IncludeCaption = true;
                        }
                        column(LotNo_ReservationEntry; ReservationEntry."Lot No.")
                        {
                        }
                        column(Desc_Fraktie; grecGrade.Description)
                        {
                        }
                        column(TestDate_LotNo; LotNoInfo."B Test Date")
                        {
                        }
                        column(Germ; gGermination)
                        {
                        }
                        column(BestUsedBy_LotNo; LotNoInfo."B Best used by")
                        {
                        }
                        column(Tsw_LotNo; LotNoInfo."B Tsw. in gr.")
                        {
                        }
                        column(TxtOntsmet; gtxtTreated)
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

                            if (Type = Type::Item) and (Quantity = 0) then begin
                                CurrReport.Skip;
                                exit;
                            end;


                            if grecItem.Get("Sales Line"."No.") then;

                            if not grecItemExt.Get(grecItem."B Extension", "Sales Header"."Language Code") then
                                grecItemExt.Init;
                            gtxtTreated := '';
                            if (grecItemExt.Extension < '6') then
                                gtxtTreated := grecItemExt.Description;



                            gUnitOfMeasure."B Description for Reports" := '';

                            if not gUnitOfMeasure.Get("Unit of Measure Code") then
                                gUnitOfMeasure.Init;

                            Clear(LotNoInfo);
                            Clear(ReservationEntry);
                            ReservationEntry.SetRange("Source Type", 37);
                            ReservationEntry.SetRange("Source Subtype", 1);
                            ReservationEntry.SetRange("Source ID", "Sales Line"."Document No.");
                            ReservationEntry.SetRange("Source Ref. No.", "Sales Line"."Line No.");
                            if ReservationEntry.FindFirst then
                                GetLotNoInfo();

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
            begin

                CurrReport.Language := Language.GetLanguageID("Language Code");

                CompanyInfo.Get;
                grecCustomer.Get("Bill-to Customer No.");

                if RespCenter.Get("Responsibility Center") then begin
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                end else
                    FormatAddr.Company(CompanyAddr, CompanyInfo);

                CompanyInfo.CalcFields(Picture);

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


                if not "Ship-toAddress".Get("Sell-to Customer No.", "Ship-to Code") then
                    "Ship-toAddress".Init;
                "Ship-to Contact" := '';
                if "Ship-toAddress"."Phone No." <> '' then begin

                    "Ship-to Contact" := CopyStr(Text50003 + ' ' + "Ship-toAddress"."Phone No.", 1, 30);

                end else begin

                    "Ship-to Contact" := CopyStr(Text50003 + ' ' + grecCustomer."Phone No.", 30);


                    ShowShippingAddr := FormatAddr.SalesHeaderShipTo(ShipToAddr, CustAddr, "Sales Header");

                    if not SalesTerms.Get("Sales Header"."Language Code") then
                        SalesTerms.Init;
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
        lblReferences = 'References';
        lblContents = 'Contents';
        lblPackingDescription = 'Packing Description';
        lblPackageTrackingNo = 'Package Tracking No.';
        lblPaymentTerms = 'Payment Terms';
        lblShipmentMethods = 'Shipment Methods';
        lblShipmentTerms = 'Shipment Terms';
        lblItemNo = 'Item No.';
        lblGrade = 'Grade';
        lblTestDateGerm = 'Test date    Germ.';
        lblTestUsedBy = 'Best used by';
        lblTwsInGr = 'Tsw. in gr.';
        lblBoxNo = 'Box No.';
        lblUnit = 'Unit';
        lblQty = 'Qty.';
        lblPurchaseOrder = 'Purchase Order';
        lblRegistrationNo = 'Registration No.';
        lblVATRegistrationNo = 'VAT Registration No.';
        lblGerm = 'Germ.';
        lblPackingList = 'Packing List';
        lblSellToCustomer = 'Sell-to Customer';
        lblBillToCustomer = 'Bill-to Customer';
        lblTotal = 'Total';
        lblLotNo = 'Lot No.';
        lblNetWeight = 'Net weight';
        lblGrossWeight = 'Gross weight';
        lblSignature = 'Received By:';
        lblIssuedBy = 'Issued By:';
        lblPage = 'Page';
    }

    trigger OnInitReport()
    begin
        GLSetup.Get;
        CompanyInfo.Get();
        // CompanyInfo.CALCFIELDS(Picture);
    end;

    var
        GLSetup: Record "General Ledger Setup";
        ShipmentMethod: Record "Shipment Method";
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
        TotalInclVATText: Text[50];
        TotalExclVATText: Text[50];
        NoOfCopies: Integer;
        CopyText: Text[30];
        ShowShippingAddr: Boolean;
        i: Integer;
        ShowInternalInfo: Boolean;
        ArchiveDocument: Boolean;
        LogInteraction: Boolean;
        Country: Record "Country/Region";
        LotNoInfo: Record "Lot No. Information";
        gtxtTreated: Text[30];
        grecGrade: Record Grade;
        grecCustomer: Record Customer;
        gGermination: Text[30];
        "Ship-toAddress": Record "Ship-to Address";
        grecItem: Record Item;
        grecItemExt: Record "Item Extension";
        gUnitOfMeasure: Record "Unit of Measure";
        gcuBejoMgt: Codeunit "Bejo Management";
        Text000: Label 'Salesperson';
        Text001: Label 'Total %1';
        Text002: Label 'Total %1 Incl. VAT';
        Text003: Label 'COPY';
        Text004: Label 'Packing list %1';
        Text005: Label 'Page %1';
        Text006: Label 'Total %1 Excl. VAT';
        Text007: Label 'Contents';
        Text008: Label 'Packing Description';
        Text009: Label 'Package Tracking No.';
        Text010: Label 'Order No.';
        Text011: Label 'Item No.';
        Text012: Label 'Grade';
        Text50003: Label 'Phone:';
        Text013: Label 'Test Date Germ.';
        Text014: Label 'Best used by';
        Text015: Label 'Tsw. in gr.';
        Text016: Label 'Box No.';
        Text017: Label 'Unit';
        Text018: Label 'Quantity';
        Text019: Label 'Purchase Order';
        Text020: Label 'Payment Terms';
        Text021: Label 'Shipment Method';
        Text022: Label 'Shipment Terms';
        gItemLineText: Text[100];
        Text023: Label 'Packing List';
        TextCZ007: Label 'Memorandum: ';
        TextCZ008: Label ', created ';
        TextRegNo: Label 'Registration No.';
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
        Text116: Label 'Header Dimensions';
        Text117: Label 'Not chemically treated + HWT';
        Text118: Label 'Line Dimensions';
        Text119: Label 'Bill-to Customer';
        Text401: Label 'Gross Weight';
        Text403: Label 'Net Weight';
        Text405: Label 'Contents';
        Text407: Label 'Shipment Method';
        Text409: Label 'Shipment Terms';
        Text411: Label 'Payment Terms';
        Text413: Label 'Payment Method';
        Text415: Label 'We draw your attention to our General Terms & Conditions of Sale and Delivery as printed at the back of uor current catalogue.';
        Text416: Label 'All sales are made subject to these Terms & Conditions of Sale and Delivery unless otherwise agreed in writing.';
        SalesTerms: Record "Sales Terms";
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
        Text315: Label 'Line Disc.';
        Text316: Label 'Tsw. in gr.';
        Text317: Label 'Germ.';
        Text318: Label 'Best used by';
        Text319: Label 'Ext. Doc. No.';

    local procedure GetLotNoInfo()
    begin
        LotNoInfo.SetCurrentKey("Lot No.");
        LotNoInfo.SetRange("Lot No.", ReservationEntry."Lot No.");
        if not LotNoInfo.FindFirst then
            LotNoInfo.Init;

        if not grecGrade.Get(LotNoInfo."B Grade Code") then
            grecGrade.Init;

        if LotNoInfo."B Germination" <> 0 then
            gGermination := Format(LotNoInfo."B Germination") + ' %'
        else
            gGermination := '';

        if CopyStr(LotNoInfo."Item No.", 1, 2) = '68' then
            case CopyStr(LotNoInfo."Item No.", 6, 1) of
                '1', '2', '3', '4', '5', '6', '7':
                    grecGrade.Description := '';
            end;

        if CopyStr(LotNoInfo."Item No.", 1, 2) = '81' then
            case CopyStr(LotNoInfo."Item No.", 6, 1) of
                '5':
                    grecGrade.Description := '';
            end;

        if CopyStr(LotNoInfo."Item No.", 1, 2) = '84' then
            case CopyStr(LotNoInfo."Item No.", 6, 1) of
                '1', '4', '5':
                    grecGrade.Description := '';
            end;

        if CopyStr(LotNoInfo."Item No.", 1, 2) = '89' then
            case CopyStr(LotNoInfo."Item No.", 6, 1) of
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
          CompanyAddr[1] + Format(Char177) +                                                                                  //(1,1)
          CompanyAddr[2] + Format(Char177) +                                                                                  //(2,1)
          CompanyAddr[3] + Format(Char177) +                                                                                  //(3,1)
          Text101 + CompanyInfo."Phone No." + Format(Char177) +                                                               //(4,1)
          Text102 + CompanyInfo."E-Mail" + Format(Char177) +                                                                  //(5,1)
          Text103 + CompanyInfo."Home Page" + Format(Char177) +                                                               //(6,1)
          CompanyInfo."Bank Name" + Format(Char177) +                                                                         //(7,1)
          CompanyInfo."Bank Account No." + Format(Char177) +                                                                  //(8,1)
          CompanyInfo.FieldCaption(IBAN) + ': ' + CompanyInfo.IBAN + Format(Char177) +                                        //(9,1)
          CompanyInfo.FieldCaption("SWIFT Code") + ': ' + CompanyInfo."SWIFT Code" + Format(Char177) +                        //(10,1)
          CompanyInfo.FieldCaption("Registration No.") + ': ' + CompanyInfo."Registration No." + Format(Char177) +            //(11,1)
          CompanyInfo.FieldCaption("VAT Registration No.") + ': ' + CompanyInfo."VAT Registration No." + Format(Char177) +    //(12,1)
          Text104 + Format(Char177) +                                                                                         //(13,1)
          ' ' + Format(Char177) +                                                                                             //(14,1)
          ' ' + Format(Char177) +                                                                                             //(15,1)
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
          Text316 + Format(Char177) +     //(6,3)
          Text317 + Format(Char177) +     //(7,3)
          '' + Format(Char177) +          //(8,3)
          Text112 + Format(Char177) +     //(9,3)
          Text113 + Format(Char177) +     //(10,3)
          Text318 + Format(Char177) +     //(11,3)
          '' + Format(Char177) +          //(12,3)
          Text319 + Format(Char177) +     //(13,3)
          '' + Format(Char177) +          //(14,3)
          '' + Format(Char177) +          //(15,3)
          ' '
          );
    end;

    local procedure SetDataHeader(): Text
    var
        Char177: Char;
    begin
        Char177 := 177;
        exit(
        Text108 + Format(Char177) +                                         //(1,2)
        "Sales Header"."No." + Format(Char177) +                            //(2,2)
        Text106 + Format(Char177) +                                         //(3,2)
        "Sales Header"."Bill-to Customer No." + Format(Char177) +           //(4,2)
        "Sales Header".FieldCaption("Shipment Date") + Format(Char177) +    //(5,2)
        Format("Sales Header"."Shipment Date") + Format(Char177) +          //(6,2)
        ' ' + Format(Char177) +                                            //(7,2)
        ' ' + Format(Char177) +                                            //(8,2)
        ' ' + Format(Char177) +                                             //(9,2)
        ' ' + Format(Char177) +                                             //(10,2)
        ' ' + Format(Char177) +                                             //(11,2)
        Text023 + ' ' + CopyText + Format(Char177) +                         //(12,2)
        Text119 + Format(Char177) +                                         //(13,2)
        CustAddr[1] + Format(Char177) +                                     //(14,2)
        CustAddr[2] + Format(Char177) +                                     //(15,2)
        CustAddr[3] + Format(Char177) +                                     //(16,2)
        CustAddr[4] + Format(Char177) +                                     //(17,2)
        CustAddr[5] + Format(Char177) +                                     //(18,2)
        ' ' + Format(Char177) +                                             //(19,2)
        Text110 + Format(Char177) +                                         //(20,2)
        ShipToAddr[1] + Format(Char177) +                                   //(21,2)
        ShipToAddr[2] + Format(Char177) +                                   //(22,2)
        ShipToAddr[3] + Format(Char177) +                                   //(23,2)
        ShipToAddr[4] + Format(Char177) +                                   //(24,2)
        ShipToAddr[5] + Format(Char177) +                                   //(25,2)
        ShipToAddr[6] + Format(Char177) +                                  //(26,2)
        "Sales Header"."External Document No." + Format(Char177) +          //(27,2)
        Text319 + Format(Char177) +                                         //(28,2)
          ' '
          );
    end;

    local procedure SetDataFooter(): Text
    var
        Char177: Char;
    begin
        Char177 := 177;
        exit(
          Text403 + Format(Char177) +                                       //(1,4)
          Format("Sales Header"."B Reserved weight") + Format(Char177) +     //(2,4)
          Text401 + Format(Char177) +                                       //(3,4)
          Format("Sales Header"."B Gross weight") + Format(Char177) +       //(4,4)
          Text405 + Format(Char177) +                                       //(5,4)
          "Sales Header"."B Contents" + Format(Char177) +                   //(6,4)
          Text411 + Format(Char177) +                                       //(7,4)
          PaymentTerms.Description + Format(Char177) +                      //(8,4)
          ' ' + Format(Char177) +                                           //(9,4)
          ' ' + Format(Char177) +                                           //(10,4)
          ' ' + Format(Char177) +                                           //(11,4)
          ' ' + Format(Char177) +                                           //(12,4)
          ' ' + Format(Char177) +                                           //(13,4)
          ' ' + Format(Char177) +                                           //(14,4)
          Text417 + Format(Char177) +                                       //(15,4)
          Text418 + Format(Char177) +                                       //(16,4)
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

    local procedure DocumentCaption(): Text[250]
    begin

        exit(Text004);
    end;
}

