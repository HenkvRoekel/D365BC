report 50061 "Merge Orders"
{

    Caption = 'Merge Orders';
    Permissions = TableData "Reservation Entry" = rimd;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING ("Document Type", "Sell-to Customer No.", "No.") WHERE ("Document Type" = CONST (Order), "B OrderStatus" = FILTER ("1.Entered" .. "2.Reserved"));
            MaxIteration = 1;
            RequestFilterFields = "No.", "Document Type", "Sell-to Customer No.", "Location Code", "Ship-to Code";
            dataitem(SalesLine2; "Sales Line")
            {
                DataItemLink = "Document Type" = FIELD ("Document Type"), "Sell-to Customer No." = FIELD ("Sell-to Customer No.");
                DataItemTableView = SORTING ("Document Type", "Sell-to Customer No.", "Document No.", "Line No.") WHERE ("Document Type" = CONST (Order), "B Tracking Quantity" = FILTER (<> 0), Type = CONST (Item));
                RequestFilterFields = "Line No.";
                dataitem("Dimension Set Entry"; "Dimension Set Entry")
                {
                    DataItemLink = "Dimension Set ID" = FIELD ("Dimension Set ID");
                    DataItemTableView = SORTING ("Dimension Set ID", "Dimension Code");

                    trigger OnAfterGetRecord()
                    begin

                    end;
                }

                trigger OnAfterGetRecord()
                var
                    TheSalesHeader: Record "Sales Header";
                begin

                    if TheSalesHeader.Get(SalesLine2."Document Type", SalesLine2."Document No.") then
                        if not (TheSalesHeader."B OrderStatus" in [TheSalesHeader."B OrderStatus"::"1.Entered", TheSalesHeader."B OrderStatus"::"2.Reserved"]) then
                            CurrReport.Skip;


                    if gCreateNew then begin
                        if "Document No." <> grecSaleslineNew."Document No." then begin
                            SalesLineInsert(grecSalesheaderNew."Document Type", grecSalesheaderNew."No.");
                        end else begin
                            CurrReport.Skip;
                        end;

                    end else begin
                        if "Document No." <> grecSaleslineNew."Document No." then begin
                            if ("Document No." <> gSalesHeaderNo) and (gSalesHeaderNo <> '') then begin
                                SalesLineInsert(gOrderType, gSalesHeaderNo);
                            end else begin
                                CurrReport.Skip;
                            end;
                        end else begin
                            CurrReport.Skip;
                        end;
                    end;
                end;

                trigger OnPostDataItem()
                var
                    lrecSalesOrderLine: Record "Sales Line";
                begin
                    if grecSaleslineNew."Document No." <> '' then begin
                        lrecSalesOrderLine.Reset;
                        lrecSalesOrderLine.SetRange("Document Type", grecSaleslineNew."Document Type");
                        lrecSalesOrderLine.SetRange("Document No.", grecSaleslineNew."Document No.");
                        if lrecSalesOrderLine.FindSet(true) then
                            repeat
                                if (lrecSalesOrderLine.Type = lrecSalesOrderLine.Type::Item) and (lrecSalesOrderLine."No." <> '') then begin
                                    if gCUTransferExtendedText.SalesCheckIfAnyExtText(lrecSalesOrderLine, true) then
                                        gCUTransferExtendedText.InsertSalesExtText(lrecSalesOrderLine);
                                    if gCUTransferExtendedText.MakeUpdate then;
                                end;

                                FillSalesText(lrecSalesOrderLine);

                            until lrecSalesOrderLine.Next = 0;
                    end;
                end;

                trigger OnPreDataItem()
                begin
                    if "Sales Header".GetFilter("No.") <> '' then
                        "Sales Header".CopyFilter("No.", SalesLine2."Document No.");

                    if "Sales Header".GetFilter("Ship-to Code") <> '' then
                        "Sales Header".CopyFilter("Ship-to Code", SalesLine2."B Ship-to Code");

                    if "Sales Header".GetFilter("B Characteristic") <> '' then
                        "Sales Header".CopyFilter("B Characteristic", SalesLine2."B Characteristic");
                end;
            }
            dataitem(SalesHeaderWithoutLine; "Sales Header")
            {
                DataItemLink = "Document Type" = FIELD ("Document Type"), "Sell-to Customer No." = FIELD ("Sell-to Customer No.");
                DataItemTableView = SORTING ("Document Type", "Sell-to Customer No.", "No.");

                trigger OnAfterGetRecord()
                var
                    lrecSaleslineFindFirst: Record "Sales Line";
                begin
                    if gCreateNew then begin
                        if "No." <> grecSalesheaderNew."No." then begin
                            lrecSaleslineFindFirst.Reset;
                            lrecSaleslineFindFirst.SetCurrentKey("Document Type", "Sell-to Customer No.", "Document No.", "Line No.");
                            lrecSaleslineFindFirst.SetRange("Document Type", "Document Type");
                            lrecSaleslineFindFirst.SetRange("Sell-to Customer No.", "Sell-to Customer No.");
                            lrecSaleslineFindFirst.SetRange("Document No.", "No.");
                            if not lrecSaleslineFindFirst.FindFirst then
                                Delete(true);
                        end;
                    end else begin
                        if "No." <> gSalesHeaderNo then begin
                            lrecSaleslineFindFirst.Reset;
                            lrecSaleslineFindFirst.SetCurrentKey("Document Type", "Sell-to Customer No.", "Document No.", "Line No.");
                            lrecSaleslineFindFirst.SetRange("Document Type", "Document Type");
                            lrecSaleslineFindFirst.SetRange("Sell-to Customer No.", "Sell-to Customer No.");
                            lrecSaleslineFindFirst.SetRange("Document No.", "No.");
                            if not lrecSaleslineFindFirst.FindFirst then
                                Delete(true);
                        end;
                    end;
                end;
            }

            trigger OnAfterGetRecord()
            begin


                if gSalesHeaderNo = '' then begin
                    grecSalesLine.Reset;
                    grecSalesLine.SetCurrentKey("Document Type", "Sell-to Customer No.", "Document No.", "Line No.");
                    grecSalesLine.SetRange("Document Type", "Document Type");
                    grecSalesLine.SetRange("Sell-to Customer No.", "Sell-to Customer No.");

                    if GetFilter("No.") <> '' then
                        "Sales Header".CopyFilter("No.", grecSalesLine."Document No.");

                    grecSalesLine.SetRange(Type, grecSalesLine.Type::Item);

                    grecSalesLine.SetFilter("B Tracking Quantity", '<>0');
                    if GetFilter("Ship-to Code") <> '' then
                        "Sales Header".CopyFilter("Ship-to Code", grecSalesLine."B Ship-to Code");
                    if GetFilter("B Characteristic") <> '' then
                        "Sales Header".CopyFilter("B Characteristic", grecSalesLine."B Characteristic");

                    if grecSalesLine.FindFirst then begin
                        SalesHeaderInsert(grecSalesLine);
                    end
                    else begin
                        Error(text50007 + '\%1', grecSalesLine.GetFilters);
                    end;

                end
                else begin
                    gCreateNew := false;
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
                    field(gOrderType; gOrderType)
                    {
                        Caption = 'Document Type';
                        Editable = false;
                        OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
                        ApplicationArea = All;
                    }
                    field(gSalesHeaderNo; gSalesHeaderNo)
                    {
                        Caption = 'No.';
                        Editable = true;
                        ApplicationArea = All;

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            fnFindSalesHeader;
                        end;
                    }
                    field(gCustomerNo; gCustomerNo)
                    {
                        Caption = 'Customer No.';
                        Editable = false;
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
            gOrderType := gOrderType::Order;
        end;
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        fnShowEndMessage;
    end;

    trigger OnPreReport()
    begin
        fnCheckFilters;
    end;

    var
        grecSalesheaderNew: Record "Sales Header";
        grecSalesLine: Record "Sales Line";
        grecSaleslineNew: Record "Sales Line";
        gCreateNew: Boolean;
        gGoodSalesLineFound: Boolean;
        gOrderType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        gSalesHeaderNo: Code[20];
        gCustomerNo: Code[20];
        text50001: Label 'You must enter the Document Type.';
        text50002: Label 'You must enter the Customer No.';
        text50004: Label 'You can only filter on one Customer No.';
        text50005: Label 'Customer No. %1 on the options tab must be the same as the filter customer no. %2.';
        text50006: Label 'No Sales Order could be found with the applied filters.';
        text50007: Label 'No order lines with item tracking could be found with the applied filters.';
        text50008: Label 'No order lines with item tracking could be found for customer %1.';
        text50009: Label 'Order lines with item tracking were found for customer %1. \These order lines have been moved to the new sales order %2.';
        gCUTransferExtendedText: Codeunit "Transfer Extended Text";
        text50010: Label 'ERROR: Ship-To Code Filter must be filled in';

    procedure fnFindSalesHeader()
    var
        lrecSalesHeader: Record "Sales Header";
    begin
        case gOrderType of
            gOrderType::Quote:
                begin
                    if gSalesHeaderNo = '' then begin
                        if gCustomerNo = '' then begin
                            lrecSalesHeader.SetCurrentKey("Document Type", "Sell-to Customer No.", "No.");
                            lrecSalesHeader.SetRange("Document Type", gOrderType::Quote);
                            if PAGE.RunModal(PAGE::"Sales List", lrecSalesHeader) = ACTION::LookupOK then begin
                                gSalesHeaderNo := lrecSalesHeader."No.";
                                gCustomerNo := lrecSalesHeader."Sell-to Customer No.";
                            end;
                        end else begin
                            lrecSalesHeader.SetCurrentKey("Document Type", "Sell-to Customer No.", "No.");
                            lrecSalesHeader.SetRange("Document Type", gOrderType::Quote);
                            lrecSalesHeader.SetRange("Sell-to Customer No.", gCustomerNo);
                            if PAGE.RunModal(PAGE::"Sales List", lrecSalesHeader) = ACTION::LookupOK then begin
                                gSalesHeaderNo := lrecSalesHeader."No.";
                                gCustomerNo := lrecSalesHeader."Sell-to Customer No.";
                            end;
                        end;
                    end else begin
                        if gCustomerNo = '' then begin
                            lrecSalesHeader.SetCurrentKey("Document Type", "No.");
                            lrecSalesHeader.SetRange("Document Type", gOrderType::Quote);
                            lrecSalesHeader.SetRange("No.", gSalesHeaderNo);
                            if lrecSalesHeader.Find('-') then begin
                                lrecSalesHeader.SetRange("No.");
                                if PAGE.RunModal(PAGE::"Sales List", lrecSalesHeader) = ACTION::LookupOK then begin
                                    gSalesHeaderNo := lrecSalesHeader."No.";
                                    gCustomerNo := lrecSalesHeader."Sell-to Customer No.";
                                end;
                            end;
                        end else begin
                            lrecSalesHeader.SetCurrentKey("Document Type", "Sell-to Customer No.", "No.");
                            lrecSalesHeader.SetRange("Document Type", gOrderType::Quote);
                            lrecSalesHeader.SetRange("Sell-to Customer No.", gCustomerNo);
                            lrecSalesHeader.SetRange("No.", gSalesHeaderNo);
                            if lrecSalesHeader.Find('-') then begin
                                lrecSalesHeader.SetRange("No.");
                                if PAGE.RunModal(PAGE::"Sales List", lrecSalesHeader) = ACTION::LookupOK then begin
                                    gSalesHeaderNo := lrecSalesHeader."No.";
                                    gCustomerNo := lrecSalesHeader."Sell-to Customer No.";
                                end;
                            end;
                        end;
                    end;
                end;

            gOrderType::Order:
                begin
                    if gSalesHeaderNo = '' then begin
                        if gCustomerNo = '' then begin
                            lrecSalesHeader.SetCurrentKey("Document Type", "Sell-to Customer No.", "No.");
                            lrecSalesHeader.SetRange("Document Type", gOrderType::Order);
                            if PAGE.RunModal(PAGE::"Sales List", lrecSalesHeader) = ACTION::LookupOK then begin
                                gSalesHeaderNo := lrecSalesHeader."No.";
                                gCustomerNo := lrecSalesHeader."Sell-to Customer No.";
                            end;
                        end else begin
                            lrecSalesHeader.SetCurrentKey("Document Type", "Sell-to Customer No.", "No.");
                            lrecSalesHeader.SetRange("Document Type", gOrderType::Order);
                            lrecSalesHeader.SetRange("Sell-to Customer No.", gCustomerNo);
                            if PAGE.RunModal(PAGE::"Sales List", lrecSalesHeader) = ACTION::LookupOK then begin
                                gSalesHeaderNo := lrecSalesHeader."No.";
                                gCustomerNo := lrecSalesHeader."Sell-to Customer No.";
                            end;
                        end;
                    end else begin
                        if gCustomerNo = '' then begin
                            lrecSalesHeader.SetCurrentKey("Document Type", "No.");
                            lrecSalesHeader.SetRange("Document Type", gOrderType::Order);
                            lrecSalesHeader.SetRange("No.", gSalesHeaderNo);
                            if lrecSalesHeader.Find('-') then begin
                                lrecSalesHeader.SetRange("No.");
                                if PAGE.RunModal(PAGE::"Sales List", lrecSalesHeader) = ACTION::LookupOK then begin
                                    gSalesHeaderNo := lrecSalesHeader."No.";
                                    gCustomerNo := lrecSalesHeader."Sell-to Customer No.";
                                end;
                            end;
                        end else begin
                            lrecSalesHeader.SetCurrentKey("Document Type", "Sell-to Customer No.", "No.");
                            lrecSalesHeader.SetRange("Document Type", gOrderType::Order);
                            lrecSalesHeader.SetRange("Sell-to Customer No.", gCustomerNo);
                            lrecSalesHeader.SetRange("No.", gSalesHeaderNo);
                            if lrecSalesHeader.Find('-') then begin
                                lrecSalesHeader.SetRange("No.");
                                if PAGE.RunModal(PAGE::"Sales List", lrecSalesHeader) = ACTION::LookupOK then begin
                                    gSalesHeaderNo := lrecSalesHeader."No.";
                                    gCustomerNo := lrecSalesHeader."Sell-to Customer No.";
                                end;
                            end;
                        end;
                    end;
                end;

            gOrderType::Invoice:
                begin
                    if gSalesHeaderNo = '' then begin
                        if gCustomerNo = '' then begin
                            lrecSalesHeader.SetCurrentKey("Document Type", "Sell-to Customer No.", "No.");
                            lrecSalesHeader.SetRange("Document Type", gOrderType::Invoice);
                            if PAGE.RunModal(PAGE::"Sales List", lrecSalesHeader) = ACTION::LookupOK then begin
                                gSalesHeaderNo := lrecSalesHeader."No.";
                                gCustomerNo := lrecSalesHeader."Sell-to Customer No.";
                            end;
                        end else begin
                            lrecSalesHeader.SetCurrentKey("Document Type", "Sell-to Customer No.", "No.");
                            lrecSalesHeader.SetRange("Document Type", gOrderType::Invoice);
                            lrecSalesHeader.SetRange("Sell-to Customer No.", gCustomerNo);
                            if PAGE.RunModal(PAGE::"Sales List", lrecSalesHeader) = ACTION::LookupOK then begin
                                gSalesHeaderNo := lrecSalesHeader."No.";
                                gCustomerNo := lrecSalesHeader."Sell-to Customer No.";
                            end;
                        end;
                    end else begin
                        if gCustomerNo = '' then begin
                            lrecSalesHeader.SetCurrentKey("Document Type", "No.");
                            lrecSalesHeader.SetRange("Document Type", gOrderType::Invoice);
                            lrecSalesHeader.SetRange("No.", gSalesHeaderNo);
                            if lrecSalesHeader.Find('-') then begin
                                lrecSalesHeader.SetRange("No.");
                                if PAGE.RunModal(PAGE::"Sales List", lrecSalesHeader) = ACTION::LookupOK then begin
                                    gSalesHeaderNo := lrecSalesHeader."No.";
                                    gCustomerNo := lrecSalesHeader."Sell-to Customer No.";
                                end;
                            end;
                        end else begin
                            lrecSalesHeader.SetCurrentKey("Document Type", "Sell-to Customer No.", "No.");
                            lrecSalesHeader.SetRange("Document Type", gOrderType::Invoice);
                            lrecSalesHeader.SetRange("Sell-to Customer No.", gCustomerNo);
                            lrecSalesHeader.SetRange("No.", gSalesHeaderNo);
                            if lrecSalesHeader.Find('-') then begin
                                lrecSalesHeader.SetRange("No.");
                                if PAGE.RunModal(PAGE::"Sales List", lrecSalesHeader) = ACTION::LookupOK then begin
                                    gSalesHeaderNo := lrecSalesHeader."No.";
                                    gCustomerNo := lrecSalesHeader."Sell-to Customer No.";
                                end;
                            end;
                        end;
                    end;
                end;

            gOrderType::"Credit Memo":
                begin
                    if gSalesHeaderNo = '' then begin
                        if gCustomerNo = '' then begin
                            lrecSalesHeader.SetCurrentKey("Document Type", "Sell-to Customer No.", "No.");
                            lrecSalesHeader.SetRange("Document Type", gOrderType::"Credit Memo");
                            if PAGE.RunModal(PAGE::"Sales List", lrecSalesHeader) = ACTION::LookupOK then begin
                                gSalesHeaderNo := lrecSalesHeader."No.";
                                gCustomerNo := lrecSalesHeader."Sell-to Customer No.";
                            end;
                        end else begin
                            lrecSalesHeader.SetCurrentKey("Document Type", "Sell-to Customer No.", "No.");
                            lrecSalesHeader.SetRange("Document Type", gOrderType::"Credit Memo");
                            lrecSalesHeader.SetRange("Sell-to Customer No.", gCustomerNo);
                            if PAGE.RunModal(PAGE::"Sales List", lrecSalesHeader) = ACTION::LookupOK then begin
                                gSalesHeaderNo := lrecSalesHeader."No.";
                                gCustomerNo := lrecSalesHeader."Sell-to Customer No.";
                            end;
                        end;
                    end else begin
                        if gCustomerNo = '' then begin
                            lrecSalesHeader.SetCurrentKey("Document Type", "No.");
                            lrecSalesHeader.SetRange("Document Type", gOrderType::"Credit Memo");
                            lrecSalesHeader.SetRange("No.", gSalesHeaderNo);
                            if lrecSalesHeader.Find('-') then begin
                                lrecSalesHeader.SetRange("No.");
                                if PAGE.RunModal(PAGE::"Sales List", lrecSalesHeader) = ACTION::LookupOK then begin
                                    gSalesHeaderNo := lrecSalesHeader."No.";
                                    gCustomerNo := lrecSalesHeader."Sell-to Customer No.";
                                end;
                            end;
                        end else begin
                            lrecSalesHeader.SetCurrentKey("Document Type", "Sell-to Customer No.", "No.");
                            lrecSalesHeader.SetRange("Document Type", gOrderType::"Credit Memo");
                            lrecSalesHeader.SetRange("Sell-to Customer No.", gCustomerNo);
                            lrecSalesHeader.SetRange("No.", gSalesHeaderNo);
                            if lrecSalesHeader.Find('-') then begin
                                lrecSalesHeader.SetRange("No.");
                                if PAGE.RunModal(PAGE::"Sales List", lrecSalesHeader) = ACTION::LookupOK then begin
                                    gSalesHeaderNo := lrecSalesHeader."No.";
                                    gCustomerNo := lrecSalesHeader."Sell-to Customer No.";
                                end;
                            end;
                        end;
                    end;
                end;

            gOrderType::"Blanket Order":
                begin
                    if gSalesHeaderNo = '' then begin
                        if gCustomerNo = '' then begin
                            lrecSalesHeader.SetCurrentKey("Document Type", "Sell-to Customer No.", "No.");
                            lrecSalesHeader.SetRange("Document Type", gOrderType::"Blanket Order");
                            if PAGE.RunModal(PAGE::"Sales List", lrecSalesHeader) = ACTION::LookupOK then begin
                                gSalesHeaderNo := lrecSalesHeader."No.";
                                gCustomerNo := lrecSalesHeader."Sell-to Customer No.";
                            end;
                        end else begin
                            lrecSalesHeader.SetCurrentKey("Document Type", "Sell-to Customer No.", "No.");
                            lrecSalesHeader.SetRange("Document Type", gOrderType::"Blanket Order");
                            lrecSalesHeader.SetRange("Sell-to Customer No.", gCustomerNo);
                            if PAGE.RunModal(PAGE::"Sales List", lrecSalesHeader) = ACTION::LookupOK then begin
                                gSalesHeaderNo := lrecSalesHeader."No.";
                                gCustomerNo := lrecSalesHeader."Sell-to Customer No.";
                            end;
                        end;
                    end else begin
                        if gCustomerNo = '' then begin
                            lrecSalesHeader.SetCurrentKey("Document Type", "No.");
                            lrecSalesHeader.SetRange("Document Type", gOrderType::"Blanket Order");
                            lrecSalesHeader.SetRange("No.", gSalesHeaderNo);
                            if lrecSalesHeader.Find('-') then begin
                                lrecSalesHeader.SetRange("No.");
                                if PAGE.RunModal(PAGE::"Sales List", lrecSalesHeader) = ACTION::LookupOK then begin
                                    gSalesHeaderNo := lrecSalesHeader."No.";
                                    gCustomerNo := lrecSalesHeader."Sell-to Customer No.";
                                end;
                            end;
                        end else begin
                            lrecSalesHeader.SetCurrentKey("Document Type", "Sell-to Customer No.", "No.");
                            lrecSalesHeader.SetRange("Document Type", gOrderType::"Blanket Order");
                            lrecSalesHeader.SetRange("Sell-to Customer No.", gCustomerNo);
                            lrecSalesHeader.SetRange("No.", gSalesHeaderNo);
                            if lrecSalesHeader.Find('-') then begin
                                lrecSalesHeader.SetRange("No.");
                                if PAGE.RunModal(PAGE::"Sales List", lrecSalesHeader) = ACTION::LookupOK then begin
                                    gSalesHeaderNo := lrecSalesHeader."No.";
                                    gCustomerNo := lrecSalesHeader."Sell-to Customer No.";
                                end;
                            end;
                        end;
                    end;
                end;
        end;
    end;

    procedure fnCheckFilters()
    var
        lrecShipAddress: Record "Ship-to Address";
    begin
        if "Sales Header".GetFilter("Document Type") = '' then
            Error(text50001);

        if "Sales Header".GetFilter("Sell-to Customer No.") = '' then
            Error(text50002);


        if "Sales Header".GetRangeMin("Sell-to Customer No.") <> "Sales Header".GetRangeMax("Sell-to Customer No.") then
            Error(text50004);

        if gCustomerNo <> "Sales Header".GetFilter("Sell-to Customer No.") then
            Error(text50005, gCustomerNo, "Sales Header".GetFilter("Sell-to Customer No."));

        if "Sales Header".GetFilter("Sales Header"."Ship-to Code") = '' then begin
            if "Sales Header".GetFilter("Sales Header"."Sell-to Customer No.") <> '' then begin
                lrecShipAddress.SetRange("Customer No.", "Sales Header".GetFilter("Sell-to Customer No."));
                if lrecShipAddress.FindFirst then Error(text50010);
            end;
        end;
    end;

    procedure fnShowEndMessage()
    begin
        if "Sales Header".GetFilter("No.") = '' then begin
            if gSalesHeaderNo = '' then begin
                if gCreateNew and gGoodSalesLineFound then
                    Message(text50009, "Sales Header".GetFilter("Sell-to Customer No."), grecSalesheaderNew."No.");
                if gCreateNew and (not gGoodSalesLineFound) then
                    Message(text50008, "Sales Header".GetFilter("Sell-to Customer No."));
                if (not gCreateNew) and (not gGoodSalesLineFound) then
                    Message(text50008, "Sales Header".GetFilter("Sell-to Customer No."));
            end else begin
                if (not gCreateNew) and gGoodSalesLineFound then
                    Message(text50009, "Sales Header".GetFilter("Sell-to Customer No."), gSalesHeaderNo);
                if (not gCreateNew) and (not gGoodSalesLineFound) then
                    Message(text50008, "Sales Header".GetFilter("Sell-to Customer No."));
            end;
        end else begin
            if gSalesHeaderNo = '' then begin
                if gCreateNew and gGoodSalesLineFound then
                    Message(text50009, "Sales Header".GetFilter("Sell-to Customer No."), grecSalesheaderNew."No.");
                if gCreateNew and (not gGoodSalesLineFound) then
                    Message(text50008, "Sales Header".GetFilter("Sell-to Customer No."));
                if (not gCreateNew) and (not gGoodSalesLineFound) then
                    Message(text50008, "Sales Header".GetFilter("Sell-to Customer No."));
            end else begin
                if (not gCreateNew) and gGoodSalesLineFound then
                    Message(text50009, "Sales Header".GetFilter("Sell-to Customer No."), gSalesHeaderNo);
                if (not gCreateNew) and (not gGoodSalesLineFound) then
                    Message(text50008, "Sales Header".GetFilter("Sell-to Customer No."));
            end;
        end;
    end;

    procedure LookupCustomerNo()
    var
        KlantRec: Record Customer;
    begin
        if gCustomerNo <> '' then begin
            KlantRec.SetRange("No.", gCustomerNo);
            if KlantRec.Find('-') then begin
                KlantRec.SetRange("No.");
                if PAGE.RunModal(PAGE::"Customer List", KlantRec) = ACTION::LookupOK then begin
                    if KlantRec."No." <> gCustomerNo then begin
                        gCustomerNo := KlantRec."No.";
                        gCustomerNo := '';
                    end else
                        gCustomerNo := KlantRec."No.";
                end;
            end;
        end else begin
            if PAGE.RunModal(PAGE::"Customer List", KlantRec) = ACTION::LookupOK then begin
                gCustomerNo := KlantRec."No.";
            end;
        end;
    end;

    procedure SetCustomerNo(CustNo: Code[20])
    begin
        gCustomerNo := CustNo;
    end;

    procedure DeleteTextLines(var precSalesLine: Record "Sales Line")
    var
        lrecSalesLine: Record "Sales Line";
    begin
        lrecSalesLine.Reset;
        lrecSalesLine.SetRange("Document Type", precSalesLine."Document Type");
        lrecSalesLine.SetRange("Document No.", precSalesLine."Document No.");
        lrecSalesLine.SetRange("Attached to Line No.", precSalesLine."Line No.");
        if lrecSalesLine.FindSet(true) then
            lrecSalesLine.DeleteAll;
    end;

    procedure FillSalesText(var lrecSalesLine: Record "Sales Line")
    var
        lrecLotNoInfo: Record "Lot No. Information";
        lcuBejoMngt: Codeunit "Bejo Management";
    begin
        if lrecLotNoInfo.Get(lrecSalesLine."No.", '', lrecSalesLine."B Lot No.") then
            if lrecLotNoInfo."B Text for SalesOrders" <> '' then
                lcuBejoMngt.FillLotTextForSales(lrecSalesLine, lrecLotNoInfo."B Text for SalesOrders");
    end;

    local procedure SalesHeaderInsert(aSalesLine: Record "Sales Line")
    var
        lrecSalesheaderFind: Record "Sales Header";
        lrecSalesHdrRemarkFind: Record "Sales Comment Line";
        lrecSalesHdrRemarkNew: Record "Sales Comment Line";
    begin
        gGoodSalesLineFound := true;
        lrecSalesheaderFind.Reset;
        lrecSalesheaderFind.SetCurrentKey("Document Type", "Sell-to Customer No.", "No.");
        lrecSalesheaderFind.SetRange("Document Type", aSalesLine."Document Type");
        lrecSalesheaderFind.SetRange("Sell-to Customer No.", aSalesLine."Sell-to Customer No.");
        lrecSalesheaderFind.SetRange("No.", aSalesLine."Document No.");
        if lrecSalesheaderFind.FindFirst then begin
            Clear(grecSalesheaderNew);
            grecSalesheaderNew := lrecSalesheaderFind;
            grecSalesheaderNew."Posting Date" := 0D;
            grecSalesheaderNew."Document Date" := 0D;
            grecSalesheaderNew."Shipment Date" := 0D;
            grecSalesheaderNew."Order Date" := 0D;
            grecSalesheaderNew."Due Date" := 0D;
            grecSalesheaderNew."Shipping No." := '';
            grecSalesheaderNew."Posting No." := '';
            grecSalesheaderNew."Last Shipping No." := '';
            grecSalesheaderNew."Last Posting No." := '';
            grecSalesheaderNew."No." := '';

            grecSalesheaderNew.Insert(true);

            grecSalesheaderNew.Validate("Sell-to Customer No.", lrecSalesheaderFind."Sell-to Customer No.");

            grecSalesheaderNew.Validate("Posting Date", Today);
            grecSalesheaderNew.Validate("Payment Terms Code");
            grecSalesheaderNew.Validate("Ship-to Code", lrecSalesheaderFind."Ship-to Code");
            grecSalesheaderNew.Modify;

            gCreateNew := true;


            lrecSalesHdrRemarkFind.Reset;
            lrecSalesHdrRemarkFind.SetRange("Document Type", lrecSalesheaderFind."Document Type");
            lrecSalesHdrRemarkFind.SetRange("No.", lrecSalesheaderFind."No.");
            lrecSalesHdrRemarkFind.SetRange("Document Line No.", 0);
            if lrecSalesHdrRemarkFind.Find('-') then
                repeat
                    Clear(lrecSalesHdrRemarkNew);
                    lrecSalesHdrRemarkNew := lrecSalesHdrRemarkFind;
                    lrecSalesHdrRemarkNew."Document Type" := grecSalesheaderNew."Document Type";
                    lrecSalesHdrRemarkNew."No." := grecSalesheaderNew."No.";
                    lrecSalesHdrRemarkNew.Date := Today;
                    lrecSalesHdrRemarkNew.Insert;
                until lrecSalesHdrRemarkFind.Next = 0;


        end else
            Error(text50006 + '\%1', lrecSalesheaderFind.GetFilters);
    end;

    local procedure SalesLineInsert(aOrdertype: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"; aSalesHeaderNo: Code[20])
    var
        lrecReservationEntry: Record "Reservation Entry";
        lrecSaleslineFindLast: Record "Sales Line";
        lrecLotNoInfo: Record "Lot No. Information";
        lcuBejoManagement: Codeunit "Bejo Management";
        lrecSalesLineRemarkFind: Record "Sales Comment Line";
        lrecSalesLineRemarkNew: Record "Sales Comment Line";
    begin
        grecSaleslineNew := SalesLine2;
        grecSaleslineNew."Document Type" := aOrdertype;
        grecSaleslineNew."Document No." := aSalesHeaderNo;

        lrecSaleslineFindLast.Reset;
        lrecSaleslineFindLast.SetRange("Document Type", aOrdertype);
        lrecSaleslineFindLast.SetRange("Document No.", aSalesHeaderNo);
        if lrecSaleslineFindLast.FindLast then
            grecSaleslineNew."Line No." := lrecSaleslineFindLast."Line No." + 10000
        else
            grecSaleslineNew."Line No." := 10000;

        grecSaleslineNew.Validate("B Lot No.", SalesLine2."B Lot No.");
        grecSaleslineNew.Insert;


        lrecSalesLineRemarkFind.Reset;
        lrecSalesLineRemarkFind.SetRange("Document Type", SalesLine2."Document Type");
        lrecSalesLineRemarkFind.SetRange("No.", SalesLine2."Document No.");
        lrecSalesLineRemarkFind.SetRange("Document Line No.", SalesLine2."Line No.");
        if lrecSalesLineRemarkFind.Find('-') then
            repeat
                Clear(lrecSalesLineRemarkNew);
                lrecSalesLineRemarkNew := lrecSalesLineRemarkFind;
                lrecSalesLineRemarkNew."Document Type" := grecSaleslineNew."Document Type";
                lrecSalesLineRemarkNew."No." := grecSaleslineNew."Document No.";
                lrecSalesLineRemarkNew."Document Line No." := grecSaleslineNew."Line No.";
                lrecSalesLineRemarkNew.Date := Today;
                lrecSalesLineRemarkNew.Insert;
            until lrecSalesLineRemarkFind.Next = 0;

        grecSaleslineNew.UpdateAmounts;
        if (grecSaleslineNew."Document Type" = grecSaleslineNew."Document Type"::Order)
            and (grecSaleslineNew."Outstanding Quantity" <> 0) then
            lcuBejoManagement.SalesCheckAllocation(grecSaleslineNew);

        DeleteTextLines(SalesLine2);
        SalesLine2.Delete;
        gGoodSalesLineFound := true;

        lrecReservationEntry.Reset;
        if not lrecReservationEntry.SetCurrentKey("Source ID", "Source Ref. No.", "Source Type", "Source Subtype") then
            lrecReservationEntry.SetCurrentKey("Source Type", "Source Subtype", "Source ID");

        lrecReservationEntry.SetRange("Source Subtype", SalesLine2."Document Type");
        lrecReservationEntry.SetRange("Source ID", SalesLine2."Document No.");
        lrecReservationEntry.SetRange("Source Ref. No.", SalesLine2."Line No.");

        if lrecReservationEntry.FindFirst then begin
            lrecReservationEntry."Source ID" := grecSaleslineNew."Document No.";
            lrecReservationEntry."Source Ref. No." := grecSaleslineNew."Line No.";
            lrecReservationEntry.Modify;
        end;
    end;
}

