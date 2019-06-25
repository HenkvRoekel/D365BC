report 50018 "Purchase Lines Bejo"
{

    DefaultLayout = RDLC;
    RDLCLayout = './RDLC/Purchase Lines Bejo.rdlc';


    dataset
    {
        dataitem(Vendor; Vendor)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
            column(UserId; UserId)
            {
            }
            column(CompanyName; CompanyName)
            {
            }
            column(Vendor_TableName; Vendor.TableName)
            {
            }
            column(gVendorFilter; gVendorFilter)
            {
            }
            column(No_Vendor; Vendor."No.")
            {
                IncludeCaption = true;
            }
            column(Name_Vendor; Vendor.Name)
            {
                IncludeCaption = true;
            }
            column(gTextPeriod; gTextPeriod)
            {
            }
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Pay-to Vendor No." = FIELD ("No."), "Shortcut Dimension 1 Code" = FIELD ("Global Dimension 1 Filter"), "Shortcut Dimension 2 Code" = FIELD ("Global Dimension 2 Filter");
                DataItemTableView = SORTING ("Document Type", "Pay-to Vendor No.", "Currency Code") WHERE ("Document Type" = CONST (Order), Type = CONST (Item), "Outstanding Quantity" = FILTER (<> 0));
                RequestFilterFields = "Requested Receipt Date", "No.";
                column(RequestedReceiptDate_PurchaseLine; "Purchase Line"."Requested Receipt Date")
                {
                    IncludeCaption = true;
                }
                column(No_PurchaseLine; "Purchase Line"."No.")
                {
                    IncludeCaption = true;
                }
                column(QuantityBase_PurchaseLine; "Purchase Line"."Quantity (Base)")
                {
                }
                column(OutstandingQtyBase_PurchaseLine; "Purchase Line"."Outstanding Qty. (Base)")
                {
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
                    IncludeCaption = true;
                }
                column(PurchaseOrderNo_PurchaseLine; grecPurchaseHeader."No.")
                {
                }
                column(PostingDate_PurchaseOrderLine; grecPurchaseHeader."Posting Date")
                {
                    IncludeCaption = true;
                }
                column(OrganicCheckmarkText; grecVariety.OrganicCheckmarkText)
                {
                }
                column(PurcahseQty_Item; grecItem1."Purchases (Qty.)")
                {
                }
                column(CountryAllocated_Item; grecItem."B Country allocated")
                {
                }
                column(gPurchaseLineFilter; gPurchaseLineFilter)
                {
                }
                column(UnitofMeasureCode_PurchaseLine; "Purchase Line"."Unit of Measure Code")
                {
                }

                trigger OnAfterGetRecord()
                begin

                    gNewOrder := "Document No." <> grecPurchaseHeader."No.";
                    if gNewOrder then
                        grecPurchaseHeader.Get(grecPurchaseHeader."Document Type"::Order, "Document No.");

                    if "Expected Receipt Date" <= WorkDate then
                        gQteCmdeSouffr := "Outstanding Quantity"
                    else
                        gQteCmdeSouffr := 0;
                    gMntCmdeAchat := Round("Outstanding Quantity" * Amount / Quantity);
                    gMntCmdeAchatDevSoc := gMntCmdeAchat;
                    if Vendor."Currency Code" <> '' then begin
                        if grecPurchaseHeader."Currency Factor" <> 0 then
                            gMntCmdeAchatDevSoc :=
                              Round(
                                grecCurrencyExchangeRate.ExchangeAmtFCYToLCY(
                                  WorkDate, grecPurchaseHeader."Currency Code",
                                  gMntCmdeAchatDevSoc, grecPurchaseHeader."Currency Factor"));
                        if gUseLocalCurrency then begin
                            "Direct Unit Cost" :=
                              Round(
                                grecCurrencyExchangeRate.ExchangeAmtFCYToLCY(
                                  WorkDate, grecPurchaseHeader."Currency Code",
                                  "Direct Unit Cost", grecPurchaseHeader."Currency Factor"));
                            gMntCmdeAchat := gMntCmdeAchatDevSoc;
                        end;
                    end;

                    gCurrencyCode2 := grecPurchaseHeader."Currency Code";
                    if gUseLocalCurrency then
                        gCurrencyCode2 := '';
                    grecCurrencyTotalBuffer.UpdateTotal(
                      gCurrencyCode2,
                      gMntCmdeAchat,
                      gCptr1,
                      gCptr1);


                    grecItem.SetRange(grecItem."Date Filter", grecBejoSetup."Begin Date", grecBejoSetup."End Date");
                    if not grecItem.Get("Purchase Line"."No.") then
                        grecItem.Init;
                    grecItem.CalcFields(grecItem."B Country allocated");


                    if not grecVariety.Get(grecItem."B Variety") then
                        grecVariety.Init;

                    if CopyStr(grecCompanyInformation."VAT Registration No.", 1, 2) = 'FR' then begin
                        grecItem1.SetFilter(grecItem1."Location Filter", 'LOCATION');
                    end;

                    grecItem1.SetRange(grecItem1."Date Filter", grecBejoSetup."Begin Date", grecBejoSetup."End Date");
                    if not grecItem1.Get("Purchase Line"."No.") then
                        grecItem1.Init;
                    grecItem1.CalcFields(grecItem1."Purchases (Qty.)");
                end;

                trigger OnPreDataItem()
                begin
                    CurrReport.CreateTotals(gMntCmdeAchatDevSoc, gMntCmdeAchat);
                end;
            }

            trigger OnPreDataItem()
            begin
                CurrReport.NewPagePerRecord := gPrintOnePerPage;
                CurrReport.CreateTotals(gMntCmdeAchatDevSoc);
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
                    field(gUseLocalCurrency; gUseLocalCurrency)
                    {
                        Caption = 'All Amounts are in local currency';
                        ApplicationArea = All;
                    }
                    field(gNewOrder; gNewOrder)
                    {
                        Caption = 'New page per vendor';
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
        lblPurchaseOrders = 'Purchase Orders';
        lblPurchaseOrderNo = 'Purchase Order No.';
        lblUnit = 'Unit';
        lblTotal = 'Total';
        lblOutstandingQty = 'Outstanding Qty.';
        lblInOrder = 'In Order';
        lblAlocation = 'Allocation';
    }

    trigger OnInitReport()
    begin
        grecBejoSetup.Get;
    end;

    trigger OnPreReport()
    begin



        gVendorFilter := Vendor.GetFilters;
        gPurchaseLineFilter := "Purchase Line".GetFilters;
        gTextPeriod := "Purchase Line".GetFilter("Expected Receipt Date");
        grecCompanyInformation.Get;

        grecTempExcelBuffer.DeleteAll;
        Clear(grecTempExcelBuffer);
        EnterCell(1, 1, Text50001, true, false, false);
        EnterCell(1, 2, Text50002, true, false, false);

        EnterCell(1, 3, Text50052, true, false, false);
        EnterCell(1, 4, Text50003, true, false, false);
        EnterCell(1, 5, Text50004, true, false, false);
        EnterCell(1, 6, Text50005, true, false, false);
        EnterCell(1, 7, Text50006, true, false, false);
        EnterCell(1, 8, Text50007, true, false, false);
        EnterCell(1, 9, Text50008, true, false, false);
        EnterCell(1, 10, Text50009, true, false, false);
        EnterCell(1, 11, Text50010, true, false, false);

        k := 2;
    end;

    var
        grecCurrencyExchangeRate: Record "Currency Exchange Rate";
        grecCurrencyTotalBuffer: Record "Currency Total Buffer" temporary;
        grecCurrencyTotalBuffer2: Record "Currency Total Buffer" temporary;
        grecPurchaseHeader: Record "Purchase Header";
        grecVariety: Record Varieties;
        gUseLocalCurrency: Boolean;
        gTextPeriod: Text[30];
        gPrintOnePerPage: Boolean;
        gVendorFilter: Text[250];
        gPurchaseLineFilter: Text[250];
        gQteCmdeSouffr: Decimal;
        gMntCmdeAchat: Decimal;
        gMntCmdeAchatDevSoc: Decimal;
        gNewOrder: Boolean;
        gOK: Boolean;
        gCptr1: Integer;
        gCurrencyCode2: Code[10];
        grecItem: Record Item;
        grecItem1: Record Item;
        grecCompanyInformation: Record "Company Information";
        gExportOption: Option "Don't Export","Create Workbook";
        grecTempExcelBuffer: Record "Excel Buffer" temporary;
        k: Integer;
        grecBejoSetup: Record "Bejo Setup";
        gcuBejoMgt: Codeunit "Bejo Management";
        Text50001: Label 'Requested Receipt Date';
        Text50002: Label 'No.';
        Text50003: Label 'Description';
        Text50004: Label 'Description 2';
        Text50005: Label 'Quantity';
        Text50006: Label 'Unit';
        Text50007: Label 'Total';
        Text50008: Label 'Outstanding Qty.';
        Text50009: Label 'In Order';
        Text50010: Label 'Allocation';
        Text50011: Label 'Posting Date';
        Text50012: Label 'Purchase Order No.';
        Text50051: Label 'Purchase Order Lines';
        Text50052: Label 'ORG';

    procedure __ExcelFunctions()
    begin
    end;

    procedure UpdateRequestForm()
    begin
    end;

    local procedure EnterFilterInCell(RowNo: Integer; "Filter": Text[250]; FieldName: Text[100])
    begin
        if Filter <> '' then begin
            EnterCell(RowNo, 1, FieldName, false, false, false);
            EnterCell(RowNo, 2, Filter, false, false, false);
        end;
    end;

    local procedure EnterCell(RowNo: Integer; ColumnNo: Integer; CellValue: Text[250]; Bold: Boolean; Italic: Boolean; UnderLine: Boolean)
    begin
        grecTempExcelBuffer.Init;
        grecTempExcelBuffer.Validate("Row No.", RowNo);
        grecTempExcelBuffer.Validate("Column No.", ColumnNo);
        grecTempExcelBuffer."Cell Value as Text" := CellValue;
        grecTempExcelBuffer.Formula := '';
        grecTempExcelBuffer.Bold := Bold;
        grecTempExcelBuffer.Italic := Italic;
        grecTempExcelBuffer.Underline := UnderLine;
        grecTempExcelBuffer.Insert;
    end;
}

