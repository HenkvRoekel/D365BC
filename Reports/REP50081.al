report 50081 "Customer - Order Lines Bejo"
{

    DefaultLayout = RDLC;
    RDLCLayout = './RDLC/Customer - Order Lines Bejo.rdlc';


    dataset
    {
        dataitem(Customer; Customer)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
            column(SalesLineFilter; SalesLineFilter)
            {
            }
            column(CustFilter; CustFilter)
            {
            }
            column(PrintAmountsInLCY; PrintAmountsInLCY)
            {
            }
            column(NewOrder; NewOrder)
            {
            }
            column(PrintOnlyOnePerPage; PrintOnlyOnePerPage)
            {
            }
            column(UserId; UserId)
            {
            }
            column(CompanyName; CompanyName)
            {
            }
            column(ShipmentDateText; StrSubstNo(text50000, PeriodText))
            {
            }
            column(Choice; Choice)
            {
            }
            column(CustomerFilter; Customer.TableCaption + ': ' + CustFilter)
            {
            }
            column(SalesLineFilterText; StrSubstNo(text50001, SalesLineFilter))
            {
            }
            column(No_Customer; Customer."No.")
            {
            }
            column(Name_Customer; Customer.Name)
            {
            }
            dataitem("Sales Line"; "Sales Line")
            {
                CalcFields = "B Tracking Quantity";
                DataItemLink = "Bill-to Customer No." = FIELD ("No."), "Shortcut Dimension 1 Code" = FIELD ("Global Dimension 1 Filter"), "Shortcut Dimension 2 Code" = FIELD ("Global Dimension 2 Filter");
                DataItemTableView = SORTING ("Document Type", "Bill-to Customer No.", "Currency Code") WHERE ("Document Type" = CONST (Order), Type = CONST (Item), Quantity = FILTER (<> 0));
                RequestFilterFields = "Shipment Date";
                RequestFilterHeading = 'Sales Order Line';
                column(No_SalesHeader; SalesHeader."No.")
                {
                }
                column(OrderDate_SalesHeader; Format(SalesHeader."Order Date", 0, 0))
                {
                }
                column(ExternalDocumentNo_SalesLine; "Sales Line"."B External Document No.")
                {
                    IncludeCaption = true;
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
                }
                column(LotNo_SalesLine; "Sales Line"."B Lot No.")
                {
                }
                column(OutstandingQuantity_SalesLine; "Sales Line"."Outstanding Quantity")
                {
                }
                column(TrackingQuantity_SalesLine; "Sales Line"."B Tracking Quantity")
                {
                    IncludeCaption = true;
                }
                column(QtyShippedNotInvoiced_SalesLine; "Sales Line"."Qty. Shipped Not Invoiced")
                {
                    IncludeCaption = true;
                }
                column(UnitofMeasure_SalesLine; "Sales Line"."Unit of Measure")
                {
                    IncludeCaption = true;
                }
                column(OutstandingQtyBase_SalesLine; "Sales Line"."Outstanding Qty. (Base)")
                {
                }
                column(ShipmentDate_SalesLine; Format("Sales Line"."Shipment Date", 0, 0))
                {
                }
                column(ExtensionCode_ArtikelExtension; "Artikel extensie"."Extension Code")
                {
                }
                column(OrganicCheckmarkText; grecVariety.OrganicCheckmarkText)
                {
                }
                column(BestUsedBy_LotNo; Format("Lot No. Information"."B Best used by", 0, 0))
                {
                }

                trigger OnAfterGetRecord()
                begin

                    NewOrder := "Document No." <> SalesHeader."No.";
                    if NewOrder then
                        SalesHeader.Get(1, "Document No.");
                    if "Shipment Date" <= WorkDate then
                        BackOrderQty := "Outstanding Quantity"
                    else
                        BackOrderQty := 0;
                    SalesOrderAmount := Round("Outstanding Quantity" * Amount / Quantity);
                    SalesOrderAmountLCY := SalesOrderAmount;
                    if SalesHeader."Currency Code" <> '' then begin
                        if SalesHeader."Currency Factor" <> 0 then
                            SalesOrderAmountLCY :=
                              Round(
                                CurrExchRate.ExchangeAmtFCYToLCY(
                                  WorkDate, SalesHeader."Currency Code",
                                  SalesOrderAmountLCY, SalesHeader."Currency Factor"));
                        if PrintAmountsInLCY then begin
                            "Unit Price" :=
                              Round(
                                CurrExchRate.ExchangeAmtFCYToLCY(
                                  WorkDate, SalesHeader."Currency Code",
                                  "Unit Price", SalesHeader."Currency Factor"));
                            SalesOrderAmount := SalesOrderAmountLCY;
                        end;
                    end;

                    CurrencyCode2 := SalesHeader."Currency Code";
                    if PrintAmountsInLCY then
                        CurrencyCode2 := '';
                    CurrencyTotalBuffer.UpdateTotal(
                      CurrencyCode2,
                      SalesOrderAmount,
                      Counter1,
                      Counter1);


                    if not "Reservation Entry".SetCurrentKey("Source ID", "Source Ref. No.", "Source Type", "Source Subtype") then // BEJOWW5.0.001
                        "Reservation Entry".SetCurrentKey("Source Type", "Source Subtype", "Source ID");
                    "Reservation Entry".SetRange("Source Type", 37);
                    "Reservation Entry".SetRange("Source Subtype", 1);
                    "Reservation Entry".SetRange("Source ID", "Document No.");
                    "Reservation Entry".SetRange("Source Ref. No.", "Line No.");
                    if not "Reservation Entry".Find('-') then
                        "Reservation Entry".Init;

                    "Lot No. Information".SetCurrentKey("Lot No.");
                    "Lot No. Information".SetRange("Lot No.", "Reservation Entry"."Lot No.");
                    if not "Lot No. Information".Find('-') then
                        "Lot No. Information".Init;

                    if Recartikel.Get("No.") then;
                    if not "Artikel extensie".Get(Recartikel."B Extension", SalesHeader."Language Code") then
                        "Artikel extensie".Init;


                    if not grecVariety.Get(Recartikel."B Variety") then
                        grecVariety.Init;



                end;

                trigger OnPreDataItem()
                begin

                    case Choice of
                        Choice::"With Item Tracking":
                            begin
                                "Sales Line".SetFilter("B Tracking Quantity", '<>0');
                            end;
                        Choice::"No Item Tracking":
                            begin
                                "Sales Line".SetRange("B Tracking Quantity", 0);
                                "Sales Line".SetFilter("Outstanding Qty. (Base)", '<>0');
                            end;
                        Choice::"Shipped not Invoiced":
                            begin
                                "Sales Line".SetFilter("Qty. Shipped Not Invd. (Base)", '<>0');
                            end;
                    end;

                    CurrReport.CreateTotals(SalesOrderAmountLCY, SalesOrderAmount);
                end;
            }

            trigger OnPreDataItem()
            begin

                CurrReport.NewPagePerRecord := PrintOnlyOnePerPage;
                CurrReport.CreateTotals(SalesOrderAmountLCY);
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
                    field(PrintOnlyOnePerPage; PrintOnlyOnePerPage)
                    {
                        Caption = 'New Page per Customer';
                        ApplicationArea = All;
                    }
                    field(Choice; Choice)
                    {
                        Caption = 'View';
                        OptionCaption = 'All Lines,With Item Tracking,No Item Tracking,Shipped not Invoiced';
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
        lblReportName = 'Customer - Order Lines';
        lblORG = 'ORG';
        lblOrderNo = 'Order No.';
        lblExternalDocNo = 'External Document No.';
        lblBestUsedBy = 'Best Used By';
        lblQty = 'Quantity';
        lblTotal = 'Total';
        lblExtensionCode = 'Extension Code';
        lblShipmentDate = 'Shipment Date';
    }

    trigger OnInitReport()
    begin


    end;

    trigger OnPreReport()
    begin

        CustFilter := Customer.GetFilters;
        SalesLineFilter := "Sales Line".GetFilters;
        PeriodText := "Sales Line".GetFilter("Shipment Date");
    end;

    var
        CurrExchRate: Record "Currency Exchange Rate";
        CurrencyTotalBuffer: Record "Currency Total Buffer" temporary;
        CurrencyTotalBuffer2: Record "Currency Total Buffer" temporary;
        SalesHeader: Record "Sales Header";
        CustFilter: Text[250];
        SalesLineFilter: Text[250];
        SalesOrderAmount: Decimal;
        SalesOrderAmountLCY: Decimal;
        PrintAmountsInLCY: Boolean;
        PeriodText: Text[30];
        PrintOnlyOnePerPage: Boolean;
        BackOrderQty: Decimal;
        NewOrder: Boolean;
        OK: Boolean;
        Counter1: Integer;
        CurrencyCode2: Code[10];
        "Reservation Entry": Record "Reservation Entry";
        "Lot No. Information": Record "Lot No. Information";
        Choice: Option "All Lines","With Item Tracking","No Item Tracking","Shipped not Invoiced";
        k: Integer;
        prtexcel: Boolean;
        Recartikel: Record Item;
        "Artikel extensie": Record "Item Extension";
        gcuBejoMgt: Codeunit "Bejo Management";
        FileName: Text[250];
        BejoSetup: Record "Bejo Setup";
        grecVariety: Record Varieties;
        text50000: Label 'Shipment Date: %1';
        text50001: Label 'Sales Order Line: %1';
        text50002: Label 'Customer Order Lines';
        text50003: Label 'Item No.';
        text50004: Label 'Description';
        text50005: Label 'Descr. 3';
        text50006: Label 'Best used by';
        text50007: Label 'Quantity';
        text50008: Label 'Tracking Qty.';
        text50009: Label 'Shipped Qty.';
        text50010: Label 'Unit';
        text50011: Label 'Quantity(Base)';
        text50012: Label 'Shipment Date';
        text50013: Label 'Order No.';
        text50014: Label 'Ext. Doc. No.';
        text50015: Label 'ORG';
        text50016: Label 'Treatment';
}

