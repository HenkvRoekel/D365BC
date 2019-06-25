report 50022 "Purchase - Credit Memo Bejo"
{

    DefaultLayout = RDLC;
    RDLCLayout = './RDLC/Purchase - Credit Memo Bejo.rdlc';


    dataset
    {
        dataitem("Purch. Cr. Memo Hdr."; "Purch. Cr. Memo Hdr.")
        {
            DataItemTableView = SORTING ("No.");
            RequestFilterFields = "No.", "Buy-from Vendor No.";
            column(ShowInternalInfo; ShowInternalInfo)
            {
            }
            column(Text50000; Text50000)
            {
            }
            column(CompanyAddr1; CompanyAddr[1])
            {
            }
            column(CompanyAddr2; CompanyAddr[2])
            {
            }
            column(CompanyAddr3; CompanyAddr[3])
            {
            }
            column(CompanyAddrTel; CompanyInfo."Phone No.")
            {
            }
            column(CompanyAddrFax; CompanyInfo."Fax No.")
            {
            }
            column(CompanyAddrEmail; CompanyInfo."E-Mail")
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
            column(CompanyBankAccount; CompanyInfo."Bank Account No.")
            {
            }
            column(CompanyGiro; CompanyInfo."Giro No.")
            {
            }
            column(CompanyIBAN; CompanyInfo.IBAN)
            {
            }
            column(CompanySwift; CompanyInfo."SWIFT Code")
            {
            }
            column(CompanyVATRegNo; CompanyInfo."VAT Registration No.")
            {
            }
            column(CompanyRegNo; CompanyInfo."Registration No.")
            {
            }
            column(PictureCompanyInfo; CompanyInfo.Picture)
            {
            }
            column(WebsiteCompanyInfo; CompanyInfo."Home Page")
            {
            }
            column(VendAddr1; VendAddr[1])
            {
            }
            column(VendAddr2; VendAddr[2])
            {
            }
            column(VendAddr3; VendAddr[3])
            {
            }
            column(VendAddr4; VendAddr[4])
            {
            }
            column(VendAddr5; VendAddr[5])
            {
            }
            column(VendAddr6; VendAddr[6])
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
            column(PostingDate_PurchCrMemoHdr; "Purch. Cr. Memo Hdr."."Posting Date")
            {
                IncludeCaption = true;
            }
            column(DueDate_PurchCrMemoHdr; "Purch. Cr. Memo Hdr."."Due Date")
            {
                IncludeCaption = true;
            }
            column(BuyfromVendorNo_PurchCrMemoHdr; "Purch. Cr. Memo Hdr."."Buy-from Vendor No.")
            {
            }
            column(No_PurchCrMemoHdr; "Purch. Cr. Memo Hdr."."No.")
            {
            }
            column(VATRegistrationNo_PurchCrMemoHdr; "Purch. Cr. Memo Hdr."."VAT Registration No.")
            {
            }
            column(VATBaseDiscount_PurchCrMemoHdr; "Purch. Cr. Memo Hdr."."VAT Base Discount %")
            {
            }
            column(PricesIncludingVAT_PurchCrMemoHdr; "Purch. Cr. Memo Hdr."."Prices Including VAT")
            {
            }
            column(TotalText; TotalText)
            {
            }
            column(HeaderDims; HeaderDims)
            {
            }
            column(TotalExclVATText; TotalExclVATText)
            {
            }
            column(TotalInclVATText; TotalInclVATText)
            {
            }
            dataitem("Purch. Cr. Memo Line"; "Purch. Cr. Memo Line")
            {
                DataItemLink = "Document No." = FIELD ("No.");
                DataItemTableView = SORTING ("Document No.", "Line No.");
                column(LineNo_PurchCrMemoLine; "Purch. Cr. Memo Line"."Line No.")
                {
                }
                column(Quantity_PurchCrMemoLine; "Purch. Cr. Memo Line".Quantity)
                {
                    IncludeCaption = true;
                }
                column(UnitofMeasureCode_PurchCrMemoLine; "Purch. Cr. Memo Line"."Unit of Measure Code")
                {
                }
                column(QuantityBase_PurchCrMemoLine; "Purch. Cr. Memo Line"."Quantity (Base)")
                {
                }
                column(DirectUnitCost_PurchCrMemoLine; "Purch. Cr. Memo Line"."Direct Unit Cost")
                {
                }
                column(LineAmount_PurchCrMemoLine; "Purch. Cr. Memo Line"."Line Amount")
                {
                }
                column(InvDiscountAmount_PurchCrMemoLine; -"Purch. Cr. Memo Line"."Inv. Discount Amount")
                {
                }
                column(Type_PurchCrMemoLine; "Purch. Cr. Memo Line".Type)
                {
                }
                column(No_PurchCrMemoLine; "Purch. Cr. Memo Line"."No.")
                {
                    IncludeCaption = true;
                }
                column(Description_PurchCrMemoLine; "Purch. Cr. Memo Line".Description)
                {
                    IncludeCaption = true;
                }
                column(Description2_PurchCrMemoLine; "Purch. Cr. Memo Line"."Description 2")
                {
                }
                column(Amount_PurchCrMemoLine; "Purch. Cr. Memo Line".Amount)
                {
                    IncludeCaption = true;
                }
                column(AmountIncludingVAT_PurchCrMemoLine; "Purch. Cr. Memo Line"."Amount Including VAT")
                {
                }
                column(kortingopslag; gDiscount)
                {
                }
                column(LineDims; LineDims)
                {
                }
                column(PaymentDiscountOnVAT; -("Line Amount" - "Inv. Discount Amount" - "Amount Including VAT"))
                {
                }
                column(LotNo_LotNoInformation; LotNoInformation."Lot No.")
                {
                }
                column(Description_Fraktie; grecGrade.Description)
                {
                }
                column(TxtOntsmet; gtxtTreated)
                {
                }
                dataitem("Purch. Comment Line"; "Purch. Comment Line")
                {
                    DataItemLink = "No." = FIELD ("Document No."), "Document Line No." = FIELD ("Line No.");
                    DataItemTableView = WHERE ("Document Type" = CONST ("Posted Credit Memo"));
                    column(LineNo_PurchCommentLine; "Purch. Comment Line"."Line No.")
                    {
                    }
                    column(Comment_PurchCommentLine; "Purch. Comment Line".Comment)
                    {
                    }
                }

                trigger OnAfterGetRecord()
                begin

                    if (Type = Type::"G/L Account") and (not ShowInternalInfo) then
                        "No." := '';

                    VATAmountLine.Init;
                    VATAmountLine."VAT Identifier" := "Purch. Cr. Memo Line"."VAT Identifier";

                    VATAmountLine."VAT Calculation Type" := "VAT Calculation Type";
                    VATAmountLine."Tax Group Code" := "Tax Group Code";
                    VATAmountLine."Use Tax" := "Use Tax";
                    VATAmountLine."VAT %" := "VAT %";
                    VATAmountLine."VAT Base" := Amount;
                    VATAmountLine."Amount Including VAT" := "Amount Including VAT";
                    VATAmountLine."Line Amount" := "Line Amount";
                    if "Allow Invoice Disc." then
                        VATAmountLine."Inv. Disc. Base Amount" := "Line Amount";
                    VATAmountLine."Invoice Discount Amount" := "Inv. Discount Amount";
                    VATAmountLine.InsertLine;

                    if grecItem.Get("Purch. Cr. Memo Line"."No.") then;

                    if not grecItemExt.Get(grecItem."B Extension", '') then
                        grecItemExt.Init;
                    gtxtTreated := '';
                    if (grecItemExt.Extension < '6') and (grecItem."B Organic" = false) then
                        gtxtTreated := grecItemExt.Description;


                    LineDims := '';
                    RECDefaultDimensions.SetRange(RECDefaultDimensions."No.", "Purch. Cr. Memo Line"."No.");
                    if RECDefaultDimensions.Find('-') then begin
                        repeat
                            LineDims := StrSubstNo('%1, %2 %3', LineDims, RECDefaultDimensions."Dimension Code", RECDefaultDimensions."Dimension Value Code");
                        until RECDefaultDimensions.Next = 0;
                    end;

                    GetLotNoInf();

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
                    CurrReport.CreateTotals("Line Amount", "Inv. Discount Amount", Amount, "Amount Including VAT");
                end;
            }

            trigger OnAfterGetRecord()
            begin
                GLSetup.Get;

                CurrReport.Language := Language.GetLanguageID("Language Code");
                if RespCenter.Get("Responsibility Center") then begin
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                end else begin
                    FormatAddr.Company(CompanyAddr, CompanyInfo);
                end;


                if "Purchaser Code" = '' then begin
                    Clear(SalesPurchPerson);
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
                FormatAddr.PurchCrMemoPayTo(VendAddr, "Purch. Cr. Memo Hdr.");

                if "Payment Terms Code" = '' then
                    PaymentTerms.Init
                else
                    PaymentTerms.Get("Payment Terms Code");
                if "Shipment Method Code" = '' then
                    ShipmentMethod.Init
                else
                    ShipmentMethod.Get("Shipment Method Code");

                FormatAddr.PurchCrMemoShipTo(ShipToAddr, "Purch. Cr. Memo Hdr.");

                RECDefaultDimensions.SetRange(RECDefaultDimensions."No.", "Purch. Cr. Memo Hdr."."Buy-from Vendor No.");
                if (RECDefaultDimensions.FindSet) then begin
                    HeaderDims := StrSubstNo('%1 %2', RECDefaultDimensions."Dimension Code", RECDefaultDimensions."Dimension Value Code");
                end;

            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.Get;
                CompanyInfo.CalcFields(Picture);
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
        lblPayToVendor = 'Pay-to Vendor';
        lblShipToVendor = 'Ship-to Vendor';
        lblInvoiceNo = 'Invoice No.';
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
        lblPurchaseCreditMemo = 'Purchase Credit Memo';
    }

    var
        GLSetup: Record "General Ledger Setup";
        CompanyInfo: Record "Company Information";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        VATAmountLine: Record "VAT Amount Line" temporary;
        RespCenter: Record "Responsibility Center";
        Language: Record Language;
        PurchInvCountPrinted: Codeunit "PurchCrMemo-Printed";
        FormatAddr: Codeunit "Format Address";
        SegManagement: Codeunit SegManagement;
        VendAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        PurchaserText: Text[30];
        VATNoText: Text[30];
        ReferenceText: Text[30];
        TotalText: Text[50];
        TotalInclVATText: Text[50];
        TotalExclVATText: Text[50];
        MoreLines: Boolean;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[10];
        DimText: Text[120];
        OldDimText: Text[75];
        ShowInternalInfo: Boolean;
        Continue: Boolean;
        LogInteraction: Boolean;
        ValEntCode: Text[100];
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        grecGrade: Record Grade;
        gtxtTreated: Text[60];
        Germ: Text[30];
        grecItem: Record Item;
        grecItemExt: Record "Item Extension";
        gDiscount: Text[10];
        gcuBejoMgt: Codeunit "Bejo Management";
        Text000: Label 'Purchaser';
        Text001: Label 'Total %1';
        Text002: Label 'Total %1 Incl. VAT';
        Text003: Label 'COPY';
        Text005: Label 'Page %1';
        Text006: Label 'Total %1 Excl. VAT';
        Text50000: Label 'When remitting please quote:';
        RECDefaultDimensions: Record "Default Dimension";
        HeaderDims: Text[120];
        LineDims: Text[120];
        ValueEntryRelation: Record "Value Entry Relation";
        ValueEntry: Record "Value Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
        LotNoInformation: Record "Lot No. Information";

    local procedure GetLotNoInf()
    begin

        Clear(ValueEntryRelation);
        Clear(ValueEntry);
        Clear(ItemLedgerEntry);
        Clear(LotNoInformation);
        ValEntCode := ItemTrackingMgt.ComposeRowID(DATABASE::"Purch. Cr. Memo Line",
                                                 0, "Purch. Cr. Memo Line"."Document No.", '', 0,
                                                "Purch. Cr. Memo Line"."Line No.");
        ValueEntryRelation.SetRange("Source RowId", ValEntCode);
        if ValueEntryRelation.FindFirst then begin

            if ValueEntry.Get(ValueEntryRelation."Value Entry No.") then
                if ItemLedgerEntry.Get(ValueEntry."Item Ledger Entry No.") then
                    if LotNoInformation.Get(ItemLedgerEntry."Item No.", '', ItemLedgerEntry."Lot No.") then begin

                        if not grecGrade.Get(LotNoInformation."B Grade Code") then
                            grecGrade.Init;

                        if LotNoInformation."B Germination" <> 0 then
                            Germ := Format(LotNoInformation."B Germination") + ' %'
                        else
                            Germ := '';

                    end;
        end;
    end;
}

