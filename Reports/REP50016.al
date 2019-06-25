report 50016 "Purchase Order Bejo"
{

    DefaultLayout = RDLC;
    RDLCLayout = './RDLC/Purchase Order Bejo.rdlc';


    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = SORTING ("Document Type", "No.") WHERE ("Document Type" = CONST (Order));
            RequestFilterFields = "No.", "Buy-from Vendor No.";
            RequestFilterHeading = 'Purchase Order';
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
            column(CompanyAddress5; CompanyAddr[5])
            {
            }
            column(BuyFromAddr1; BuyFromAddr[1])
            {
            }
            column(BuyFromAddr2; BuyFromAddr[2])
            {
            }
            column(BuyFromAddr3; BuyFromAddr[3])
            {
            }
            column(BuyFromAddr4; BuyFromAddr[4])
            {
            }
            column(BuyFromAddr5; BuyFromAddr[5])
            {
            }
            column(SellToCustNo_PurchHeader; "Purchase Header"."Sell-to Customer No.")
            {
            }
            column(ShiptoAddressCaption; ShiptoAddressCaptionLbl)
            {
            }
            column(SellToCustNo_PurchHeaderCaption; "Purchase Header".FieldCaption("Sell-to Customer No."))
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
            column(ShipToAddr7; ShipToAddr[7])
            {
            }
            column(ShipToAddr8; ShipToAddr[8])
            {
            }
            column(PostingDescription_PurchaseHeader; "Purchase Header"."Posting Description")
            {
            }
            column(BuyfromVendorNo_PurchaseHeader; "Purchase Header"."Buy-from Vendor No.")
            {
            }
            column(No_PurchaseHeader; "Purchase Header"."No.")
            {
                IncludeCaption = true;
            }
            column(DocumentDate_PurchaseHeader; "Purchase Header"."Document Date")
            {
            }
            column(OrderAddressCode_PurchaseHeader; "Purchase Header"."Order Address Code")
            {
                IncludeCaption = true;
            }
            column(HeaderDims; HeaderDims)
            {
            }
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document Type" = FIELD ("Document Type"), "Document No." = FIELD ("No.");
                DataItemTableView = SORTING ("Document Type", "Document No.", "Line No.");
                column(LineNo_PurchaseLine; "Purchase Line"."Line No.")
                {
                }
                column(UnitofMeasure_PurchaseLine; "Purchase Line"."Unit of Measure")
                {
                }
                column(Description2_PurchaseLine; "Purchase Line"."Description 2")
                {
                }
                column(Quantity_PurchaseLine; "Purchase Line".Quantity)
                {
                    IncludeCaption = true;
                }
                column(No_PurchaseLine; "Purchase Line"."No.")
                {
                    IncludeCaption = true;
                }
                column(Description_PurchaseLine; "Purchase Line".Description)
                {
                    IncludeCaption = true;
                }
                column(RequestedReceiptDate_PurchaseLine; Format("Purchase Line"."Requested Receipt Date", 0, 0))
                {
                }
                column(ItemLineText; ItemLineText)
                {
                }
                column(Type_PurchaseLine; "Purchase Line".Type)
                {
                }
                column(TxtOntsmet; TxtOntsmet)
                {
                }
                column(TxtMonster; TxtMonster)
                {
                }
                column(TxtBudget; TxtBudget)
                {
                }
                dataitem("Purch. Comment Line"; "Purch. Comment Line")
                {
                    DataItemLink = "No." = FIELD ("Document No."), "Document Line No." = FIELD ("Line No.");
                    DataItemTableView = SORTING ("Document Type", "No.", "Document Line No.", "Line No.") WHERE ("Document Type" = CONST (Order));
                    column(LineNo_PurchCommentLine; "Line No.")
                    {
                    }
                    column(Comment_PurchCommentLine; Comment)
                    {
                    }
                }

                trigger OnAfterGetRecord()
                var
                    Item: Record Item;
                    ItemExtension: Record "Item Extension";
                begin


                    Clear(Item);
                    Clear(ItemExtension);
                    TxtOntsmet := '';
                    if "Purchase Line".Type = "Purchase Line".Type::Item then begin
                        if not Item.Get("No.") then
                            Clear(Item);
                        if not ItemExtension.Get(Item."B Extension", "Purchase Header"."Language Code") then
                            Clear(ItemExtension);
                        TxtOntsmet := ItemExtension.Description;
                    end;


                    TxtBudget := '';
                    if "Purchase Line"."B Allocation exceeded" = true then
                        TxtBudget := Text50000;

                    TxtMonster := '';
                    if "Purchase Line"."B Line type" > 0 then
                        TxtMonster := Format("Purchase Line"."B Line type");


                    ItemLineText := '';
                    RECLineText.Reset;
                    RECLineText.SetRange(RECLineText."No.", "Purchase Line"."Document No.");
                    RECLineText.SetRange(RECLineText."Line No.", "Purchase Line"."Line No.");
                    if RECLineText.Find('-') then begin
                        ItemLineText := RECLineText.Comment;
                    end;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CurrReport.Language := Language.GetLanguageID("Language Code");

                CompanyInfo.Get;

                if RespCenter.Get("Responsibility Center") then begin
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                end else
                    FormatAddr.Company(CompanyAddr, CompanyInfo);


                if "Purchaser Code" = '' then begin
                    SalesPurchPerson.Init;
                    PurchaserText := '';
                end else begin
                    SalesPurchPerson.Get("Purchaser Code");
                    PurchaserText := Text000
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

                FormatAddr.PurchHeaderBuyFrom(BuyFromAddr, "Purchase Header");
                if ("Purchase Header"."Buy-from Vendor No." <> "Purchase Header"."Pay-to Vendor No.") then
                    FormatAddr.PurchHeaderPayTo(VendAddr, "Purchase Header");
                if "Payment Terms Code" = '' then
                    PaymentTerms.Init
                else
                    PaymentTerms.Get("Payment Terms Code");
                if "Shipment Method Code" = '' then
                    ShipmentMethod.Init
                else
                    ShipmentMethod.Get("Shipment Method Code");

                FormatAddr.PurchHeaderShipTo(ShipToAddr, "Purchase Header");

                RECDefaultDimensions.SetRange(RECDefaultDimensions."No.", "Purchase Header"."Buy-from Vendor No.");
                if (RECDefaultDimensions.FindSet) then begin
                    HeaderDims := StrSubstNo('%1 %2', RECDefaultDimensions."Dimension Code", RECDefaultDimensions."Dimension Value Code");
                end
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
        lblOrderNo = 'Order No.';
        lblPurchaseOrder = 'Purchase Order';
        lblPage = 'Page:';
        lblHeaderDimensions = 'Header Dimensions';
        lblLineDimension = 'Line Dimension';
        lblUnit = 'Unit';
        lblVendorNo = 'Vendor No.';
        lblRequestDate = 'Requested Receipt Date';
    }

    var
        GLSetup: Record "General Ledger Setup";
        CompanyInfo: Record "Company Information";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        VATAmountLine: Record "VAT Amount Line" temporary;
        PurchLine: Record "Purchase Line" temporary;
        RespCenter: Record "Responsibility Center";
        Language: Record Language;
        PurchCountPrinted: Codeunit "Purch.Header-Printed";
        FormatAddr: Codeunit "Format Address";
        PurchPost: Codeunit "Purch.-Post";
        ArchiveManagement: Codeunit ArchiveManagement;
        SegManagement: Codeunit SegManagement;
        VendAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        BuyFromAddr: array[8] of Text[50];
        PurchaserText: Text[30];
        VATNoText: Text[30];
        ReferenceText: Text[30];
        TotalText: Text[50];
        TotalInclVATText: Text[50];
        TotalExclVATText: Text[50];
        MoreLines: Boolean;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
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
        TxtOntsmet: Text[60];
        TxtBudget: Text[30];
        TxtMonster: Text[30];
        gcuBejoMgt: Codeunit "Bejo Management";
        Text000: Label 'Purchaser';
        Text001: Label 'Total %1';
        Text002: Label 'Total %1 Incl. VAT';
        Text003: Label 'COPY';
        Text005: Label 'Page %1';
        Text006: Label 'Total %1 Excl. VAT';
        Text50000: Label 'Allocation exceeded';
        RECLineText: Record "Purch. Comment Line";
        ItemLineText: Text[120];
        RECDefaultDimensions: Record "Default Dimension";
        HeaderDims: Text[120];
        ShiptoAddressCaptionLbl: Label 'Ship-to Address';
}

