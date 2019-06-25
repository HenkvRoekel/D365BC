codeunit 50001 "Bejo Trade Add-On Events"
{

    Permissions = TableData "Item Ledger Entry" = rm,
                  TableData "Value Entry" = rm;
    SingleInstance = true;

    trigger OnRun()
    begin
    end;

    var
        gCurrentItemJnlRecord: Record "Item Journal Line";

    [EventSubscriber(ObjectType::Codeunit, 12, 'OnAfterInsertGlobalGLEntry', '', false, false)]
    local procedure C12_OnAfterInsertGlobalGLEntry(var GLEntry: Record "G/L Entry")
    begin
        if GLEntry."Posting Date" = ClosingDate(GLEntry."Posting Date") then begin
            GLEntry."B Is Closing Entry" := true;
            GLEntry.Modify;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 22, 'OnAfterInitItemLedgEntry', '', false, false)]
    local procedure CU22_OnAfterInitItemLedgEntry(var NewItemLedgEntry: Record "Item Ledger Entry"; ItemJournalLine: Record "Item Journal Line")
    begin
        fnSetBejoILEUnitInWghtAndTreatment(NewItemLedgEntry);
        fnSetBejoILEFieldValues(NewItemLedgEntry, ItemJournalLine);
    end;

    [EventSubscriber(ObjectType::Codeunit, 22, 'OnBeforeInsertValueEntry', '', false, false)]
    local procedure CU22_OnBeforeInsertValueEntry(var ValueEntry: Record "Value Entry"; ItemJournalLine: Record "Item Journal Line")
    var
        lrecILE: Record "Item Ledger Entry";
    begin
        if lrecILE.Get(ValueEntry."Item Ledger Entry No.") then begin
            fnSetBejoVEFieldValues(ValueEntry, ItemJournalLine, lrecILE);
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnBeforePostSalesDoc', '', false, false)]
    local procedure CU80_OnBeforePostSalesDoc(var SalesHeader: Record "Sales Header")
    var
        lrecBejoSetup: Record "Bejo Setup";
        lcuBejoMgt: Codeunit "Bejo Management";
        lrecSalesLine: Record "Sales Line";
    begin
        with SalesHeader do begin
            lrecSalesLine.Reset;
            lrecSalesLine.SetRange("Document Type", "Document Type");
            lrecSalesLine.SetRange("Document No.", "No.");
            if lrecSalesLine.FindSet then
                repeat
                    case lrecSalesLine.Type of
                        lrecSalesLine.Type::"G/L Account":
                            begin
                                if (lrecSalesLine."No." <> '') and not lrecSalesLine."System-Created Entry" then begin
                                    fnCheckReasonCode(lrecSalesLine);
                                end;
                            end;

                        lrecSalesLine.Type::Item:
                            begin
                                if lrecSalesLine.IsCreditDocType then begin
                                    fnCheckCreateProgAllocRec("Sell-to Customer No.", "Salesperson Code", lrecSalesLine."No.");
                                end
                                else begin
                                    fnCheckCreateProgAllocRec("Sell-to Customer No.", "Salesperson Code", lrecSalesLine."No.");
                                    fnCheckReasonCode(lrecSalesLine);
                                    fnBlockAllocationExceeded(lrecSalesLine);
                                end;
                            end;
                    end;
                until lrecSalesLine.Next = 0;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnAfterPostSalesDoc', '', false, false)]
    local procedure CU80_OnAfterPostSalesDoc(var SalesHeader: Record "Sales Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; SalesShptHdrNo: Code[20]; RetRcpHdrNo: Code[20]; SalesInvHdrNo: Code[20]; SalesCrMemoHdrNo: Code[20])
    var
        lrecBejoSetup: Record "Bejo Setup";
        lcuBejoMgt: Codeunit "Bejo Management";
        lrecSalesLine: Record "Sales Line";
        lrecItemJnlLineTemp: Record "Item Journal Line" temporary;
        lrecSalesShptHeader: Record "Sales Shipment Header";
        lrecSalesShptLine: Record "Sales Shipment Line";
        [SecurityFiltering(SecurityFilter::Filtered)]
        lrecSalesInvHeader: Record "Sales Invoice Header";
        [SecurityFiltering(SecurityFilter::Filtered)]
        lrecSalesInvLine: Record "Sales Invoice Line";
        [SecurityFiltering(SecurityFilter::Filtered)]
        lrecReturnRcptHeader: Record "Return Receipt Header";
        [SecurityFiltering(SecurityFilter::Filtered)]
        lrecReturnRcptLine: Record "Return Receipt Line";
        [SecurityFiltering(SecurityFilter::Filtered)]
        lrecSalesCrMemoHeader: Record "Sales Cr.Memo Header";
        [SecurityFiltering(SecurityFilter::Filtered)]
        lrecSalesCrMemoLine: Record "Sales Cr.Memo Line";
        lShip: Boolean;
        lInvoice: Boolean;
        lReceive: Boolean;
        lEverythingInvoiced: Boolean;
    begin

        if SalesShptHdrNo <> '' then begin
            if lrecSalesShptHeader.Get(SalesShptHdrNo) then begin
                lrecSalesShptLine.SetRange("Document No.", SalesShptHdrNo);
                lrecSalesShptLine.SetRange(Type, lrecSalesShptLine.Type::Item);
                if lrecSalesShptLine.FindSet(false, false) then
                    repeat

                        lrecItemJnlLineTemp."Document No." := SalesShptHdrNo;
                        lrecItemJnlLineTemp."Document Line No." := lrecSalesShptLine."Line No.";
                        lrecItemJnlLineTemp.Description := lrecSalesShptLine.Description;
                        lrecItemJnlLineTemp."B Line type" := lrecSalesShptLine."B Line type";
                        lrecItemJnlLineTemp."Item No." := lrecSalesShptLine."No.";
                        lrecItemJnlLineTemp."B Characteristic" := lrecSalesShptLine."B Characteristic";
                        lrecItemJnlLineTemp."Salespers./Purch. Code" := lrecSalesShptLine."B Salesperson";
                        lrecItemJnlLineTemp."External Document No." := lrecSalesShptLine."B External Document No.";

                        fnSetEntryBejoFieldValues(lrecItemJnlLineTemp);
                    until lrecSalesShptLine.Next = 0;
            end;
        end;

        if RetRcpHdrNo <> '' then begin
            if lrecReturnRcptHeader.Get(RetRcpHdrNo) then begin
                lrecReturnRcptLine.SetRange("Document No.", RetRcpHdrNo);
                lrecReturnRcptLine.SetRange(Type, lrecReturnRcptLine.Type::Item);
                if lrecReturnRcptLine.FindSet(false, false) then
                    repeat

                        lrecItemJnlLineTemp."Document No." := RetRcpHdrNo;
                        lrecItemJnlLineTemp."Document Line No." := lrecReturnRcptLine."Line No.";
                        lrecItemJnlLineTemp.Description := lrecReturnRcptLine.Description;
                        lrecItemJnlLineTemp."Item No." := lrecReturnRcptLine."No.";

                        fnSetEntryBejoFieldValues(lrecItemJnlLineTemp);
                    until lrecReturnRcptLine.Next = 0;
            end;
        end;

        if SalesInvHdrNo <> '' then begin
            if lrecSalesInvHeader.Get(SalesInvHdrNo) then begin
                lrecSalesInvLine.SetRange("Document No.", SalesInvHdrNo);
                lrecSalesInvLine.SetRange(Type, lrecSalesInvLine.Type::Item);
                if lrecSalesInvLine.FindSet(false, false) then
                    repeat

                        lrecItemJnlLineTemp."Document No." := SalesInvHdrNo;
                        lrecItemJnlLineTemp."Document Line No." := lrecSalesInvLine."Line No.";
                        lrecItemJnlLineTemp.Description := lrecSalesInvLine.Description;
                        lrecItemJnlLineTemp."B Line type" := lrecSalesInvLine."B Line type";
                        lrecItemJnlLineTemp."Item No." := lrecSalesInvLine."No.";
                        lrecItemJnlLineTemp."B Characteristic" := lrecSalesInvLine."B Characteristic";
                        lrecItemJnlLineTemp."Salespers./Purch. Code" := lrecSalesInvLine."B Salesperson";
                        lrecItemJnlLineTemp."External Document No." := lrecSalesInvLine."B External Document No.";

                        fnSetEntryBejoFieldValues(lrecItemJnlLineTemp);
                    until lrecSalesInvLine.Next = 0;
            end;
        end;

        if SalesCrMemoHdrNo <> '' then begin
            if lrecSalesCrMemoHeader.Get(SalesInvHdrNo) then begin
                lrecSalesCrMemoLine.SetRange("Document No.", SalesInvHdrNo);
                lrecSalesCrMemoLine.SetRange(Type, lrecSalesCrMemoLine.Type::Item);
                if lrecSalesCrMemoLine.FindSet(false, false) then
                    repeat

                        lrecItemJnlLineTemp."Document No." := SalesInvHdrNo;
                        lrecItemJnlLineTemp."Document Line No." := lrecSalesCrMemoLine."Line No.";
                        lrecItemJnlLineTemp.Description := lrecSalesCrMemoLine.Description;
                        lrecItemJnlLineTemp."B Line type" := lrecSalesCrMemoLine."B Line type";
                        lrecItemJnlLineTemp."Item No." := lrecSalesCrMemoLine."No.";
                        lrecItemJnlLineTemp."B Characteristic" := lrecSalesCrMemoLine."B Characteristic";
                        lrecItemJnlLineTemp."Salespers./Purch. Code" := lrecSalesCrMemoLine."B Salesperson";
                        lrecItemJnlLineTemp."External Document No." := lrecSalesCrMemoLine."B External Document No.";

                        fnSetEntryBejoFieldValues(lrecItemJnlLineTemp);
                    until lrecSalesCrMemoLine.Next = 0;
            end;
        end;


        lrecBejoSetup.Get;
        //if lrecBejoSetup."Mail Shipping" then
        //    lcuBejoMgt.SendMailAtShipping(SalesHeader);

        lEverythingInvoiced := true;
        fnSetShipInvoiceReceiveFlags(SalesHeader, lShip, lInvoice, lReceive);

        lrecSalesLine.SetRange("Document Type", SalesHeader."Document Type");
        lrecSalesLine.SetRange("Document No.", SalesHeader."No.");
        if lrecSalesLine.FindSet then
            repeat

                if lrecSalesLine."Qty. to Invoice" + lrecSalesLine."Quantity Invoiced" <> lrecSalesLine.Quantity then
                    lEverythingInvoiced := false;

                if (lrecSalesLine."Document Type" in [lrecSalesLine."Document Type"::Order, lrecSalesLine."Document Type"::"Return Order"]) and
                   (not lEverythingInvoiced) then begin
                    if lrecSalesLine.FindSet then
                        repeat
                            if lrecSalesLine.Quantity <> 0 then begin
                                fnUpdateBlanketOrderLine(lrecSalesLine, lShip, lReceive, lInvoice);
                            end;
                        until lrecSalesLine.Next = 0;

                end else begin
                    lrecSalesLine.SetFilter("Blanket Order Line No.", '<>0');
                    if lrecSalesLine.FindSet then
                        repeat
                            fnUpdateBlanketOrderLine(lrecSalesLine, lShip, lReceive, lInvoice);
                        until lrecSalesLine.Next = 0;
                end;

                lEverythingInvoiced := true;
            until lrecSalesLine.Next = 0;
    end;

    [EventSubscriber(ObjectType::Codeunit, 90, 'OnAfterPostPurchaseDoc', '', false, false)]
    local procedure CU90_OnAfterPostPurchaseDoc(var PurchaseHeader: Record "Purchase Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; PurchRcpHdrNo: Code[20]; RetShptHdrNo: Code[20]; PurchInvHdrNo: Code[20]; PurchCrMemoHdrNo: Code[20])
    var
        PurchInvLine: Record "Purch. Inv. Line";
        ItemUnit: Record "Item/Unit";
    begin

        if PurchInvHdrNo <> '' then begin

            PurchInvLine.SetRange("Document No.", PurchInvHdrNo);
            PurchInvLine.SetRange(Type, PurchInvLine.Type::Item);
            PurchInvLine.SetFilter("No.", '<>%1', '');
            if PurchInvLine.FindSet then
                repeat
                    if (PurchInvLine."No." > '00000000') and (PurchInvLine."No." < '90999999') then begin
                        ItemUnit.Init;
                        ItemUnit."Item No." := PurchInvLine."No.";
                        ItemUnit."Unit of Measure" := PurchInvLine."Unit of Measure Code";
                        ItemUnit.Variety := CopyStr(ItemUnit."Item No.", 1, 5);
                        if ItemUnit.Insert then;
                    end;
                until PurchInvLine.Next = 0;

        end;
    end;

    [EventSubscriber(ObjectType::Table, 27, 'OnAfterDeleteEvent', '', false, false)]
    local procedure T27_OnAfterDelete(var Rec: Record Item; RunTrigger: Boolean)
    var
        lrecItemUnit: Record "Item/Unit";
    begin
        if RunTrigger then begin
            lrecItemUnit.SetRange("Item No.", Rec."No.");
            lrecItemUnit.DeleteAll;
        end;
    end;

    [EventSubscriber(ObjectType::Table, 27, 'OnAfterValidateEvent', 'No.', false, false)]
    local procedure T27_OnAfterValidate_No(var Rec: Record Item; var xRec: Record Item; CurrFieldNo: Integer)
    var
        lrecVariety: Record Varieties;
    begin
        with Rec do begin
            case CurrFieldNo of

                FieldNo("No."):
                    begin
                        "B Variety" := CopyStr("No.", 1, 5);
                        "B Product Type" := CopyStr("No.", 6, 2);
                        Validate("B Extension", CopyStr("No.", 8, 1));
                        "B Crop" := CopyStr("No.", 1, 2);
                        if StrLen("No.") >= 3 then
                            "B Crop Extension" := CopyStr("No.", StrLen("No.") - 2, 3);

                        if "B Variety" <> xRec."B Variety" then begin
                            lrecVariety.SetRange("No.", "B Variety");
                            lrecVariety."No." := "B Variety";
                            lrecVariety.Description := Description;
                            if not lrecVariety.Insert then;
                        end;

                    end;

            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, 27, 'OnAfterValidateEvent', 'Description', false, false)]
    local procedure T27_OnAfterValidate_Description(var Rec: Record Item; var xRec: Record Item; CurrFieldNo: Integer)
    var
        lrecVariety: Record Varieties;
    begin
        with Rec do begin
            case CurrFieldNo of

                FieldNo(Description):
                    begin
                        if Description <> xRec.Description then begin
                            if lrecVariety.Get("B Variety") then begin
                                if lrecVariety.Description = '' then begin
                                    lrecVariety.Description := Description;
                                    lrecVariety.Modify;
                                end;
                            end;
                        end;
                    end;

            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, 27, 'OnAfterValidateEvent', 'Base Unit of Measure', false, false)]
    local procedure T27_OnAfterValidate_BaseUOM(var Rec: Record Item; var xRec: Record Item; CurrFieldNo: Integer)
    var
        lrecVariety: Record Varieties;
    begin
        with Rec do begin
            case CurrFieldNo of

                FieldNo("Base Unit of Measure"):
                    begin
                        "Sales Unit of Measure" := xRec."Base Unit of Measure";
                        "Purch. Unit of Measure" := xRec."Base Unit of Measure";
                    end;

            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, 36, 'OnBeforeValidateEvent', 'Sell-to Customer No.', false, false)]
    local procedure T36_OnBeforeValidate_SellToCustomerNo(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer)
    begin
    end;

    [EventSubscriber(ObjectType::Table, 36, 'OnAfterValidateEvent', 'Sell-to Customer No.', false, false)]
    local procedure T36_OnAfterValidate_SellToCustomerNo(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer)
    var
        lrecShipToAddr: Record "Ship-to Address";
        lrecCommentLine: Record "Comment Line";
    begin
        with Rec do begin

            lrecShipToAddr.SetRange("Customer No.", "Sell-to Customer No.");
            lrecShipToAddr.SetRange(lrecShipToAddr."B Default", true);
            if lrecShipToAddr.FindFirst then
                Validate("Ship-to Code", lrecShipToAddr.Code)
            else
                Validate("Ship-to Code", '');

            lrecCommentLine.SetRange("Table Name", lrecCommentLine."Table Name"::Customer);
            lrecCommentLine.SetRange("No.", "Sell-to Customer No.");
            lrecCommentLine.SetRange("B Comment Type", 0);
            if lrecCommentLine.FindFirst and GuiAllowed then
                PAGE.Run(PAGE::"Comment Sheet", lrecCommentLine);

        end;
    end;

    [EventSubscriber(ObjectType::Table, 36, 'OnAfterValidateEvent', 'Ship-to Code', false, false)]
    local procedure T36_OnAfterValidate_ShiptoCode(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer)
    var
        lrecShipToAddr: Record "Ship-to Address";
        lrecCommentLine: Record "Comment Line";
    begin
        with Rec do begin
            case CurrFieldNo of

                FieldNo("Ship-to Code"):
                    begin
                        fnSetSalesLineShipToCode(Rec, xRec)
                    end;

            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, 36, 'OnAfterValidateEvent', 'Salesperson Code', false, false)]
    local procedure T36_OnAfterValidate_SalespersonCode(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer)
    var
        lrecShipToAddr: Record "Ship-to Address";
        lrecCommentLine: Record "Comment Line";
    begin
        with Rec do begin
            case CurrFieldNo of

                FieldNo("Salesperson Code"):
                    begin
                        fnSetSalesLineSalesPersonCode(Rec, xRec)
                    end;

            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, 36, 'OnAfterValidateEvent', 'B OrderStatus', false, false)]
    local procedure T36_OnAfterValidate_OrderStatus(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer)
    var
        lrecShipToAddr: Record "Ship-to Address";
        lrecCommentLine: Record "Comment Line";
    begin
        with Rec do begin
            case CurrFieldNo of

                FieldNo("B OrderStatus"):
                    begin
                        fnCheckOrderstatusReserved(Rec, true);
                    end;

            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, 36, 'OnAfterValidateEvent', 'Shipment Date', false, false)]
    local procedure T36_OnAfterValidate_ShipmentDate(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer)
    var
        SalesLine: Record "Sales Line";
        BEJOMgt: Codeunit "Bejo Management";
    begin
        with Rec do begin

            if Rec."Document Type" = Rec."Document Type"::Order then begin

                case CurrFieldNo of

                    FieldNo("Shipment Date"):
                        begin
                            SalesLine.SetRange("Document Type", "Document Type");
                            SalesLine.SetRange("Document No.", "No.");
                            SalesLine.SetRange(Type, SalesLine.Type::Item);
                            if SalesLine.FindSet then
                                repeat
                                    BEJOMgt.SalesCheckAllocation(SalesLine);
                                    SalesLine.Modify;
                                until SalesLine.Next = 0;
                        end;

                end;
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, 37, 'OnAfterModifyEvent', '', false, false)]
    local procedure T37_OnAfterModify(var Rec: Record "Sales Line"; var xRec: Record "Sales Line"; RunTrigger: Boolean)
    var
        lcuSaleschargesItemTracking: Codeunit "Sales charges - Item Tracking";
    begin
        if RunTrigger then begin
            if (Rec."B Lot No." = xRec."B Lot No.") or (xRec."B Lot No." = '') then begin
                lcuSaleschargesItemTracking.UpdateBejoFields(Rec);
                Rec.Modify(false);
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, 37, 'OnBeforeValidateEvent', 'Quantity', false, false)]
    local procedure T37_OnBeforeValidate_Quantity(var Rec: Record "Sales Line"; var xRec: Record "Sales Line"; CurrFieldNo: Integer)
    var
        Text50023: Label 'Attention: Item Tracking exists for this Sales Line!';
        lrecSalesHeader: Record "Sales Header";
        lrecCurrency: Record Currency;
    begin
        with Rec do begin
            case CurrFieldNo of

                FieldNo(Quantity):
                    begin
                        fnGetSalesHeader(Rec, lrecSalesHeader, lrecCurrency);
                        lrecSalesHeader.TestField(Status, lrecSalesHeader.Status::Open);
                        if ("B Tracking Quantity" <> 0) then
                            Error(Text50023)
                    end;

            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, 37, 'OnBeforeValidateEvent', 'Unit of Measure Code', false, false)]
    local procedure T37_OnBeforeValidate_UOMCode(var Rec: Record "Sales Line"; var xRec: Record "Sales Line"; CurrFieldNo: Integer)
    var
        Text50023: Label 'Attention: Item Tracking exists for this Sales Line!';
        lrecSalesHeader: Record "Sales Header";
        lrecCurrency: Record Currency;
    begin
        with Rec do begin
            case CurrFieldNo of

                FieldNo("Unit of Measure Code"):
                    begin

                        fnGetSalesHeader(Rec, lrecSalesHeader, lrecCurrency);
                        lrecSalesHeader.TestField(Status, lrecSalesHeader.Status::Open);
                        TestField("B Tracking Quantity", 0);
                    end;

            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, 37, 'OnBeforeValidateEvent', 'Unit Price', false, false)]
    local procedure T37_OnBeforeValidate_UnitPrice(var Rec: Record "Sales Line"; var xRec: Record "Sales Line"; CurrFieldNo: Integer)
    begin
        with Rec do begin
            if "B Line type" <> "B Line type"::Normal then
                "Unit Price" := 0;
        end;
    end;

    [EventSubscriber(ObjectType::Table, 37, 'OnAfterValidateEvent', 'No.', false, false)]
    local procedure T37_OnAfterValidate_No(var Rec: Record "Sales Line"; var xRec: Record "Sales Line"; CurrFieldNo: Integer)
    var
        lrecCurrency: Record Currency;
        lrecSalesHeader: Record "Sales Header";
        lrecItem: Record Item;
        lcuInternalPromoStatusMgt: Codeunit "Internal Promo Status Mgt.";
        lcuSaleschargesItemTracking: Codeunit "Sales charges - Item Tracking";
        lcuBejoMgt: Codeunit "Bejo Management";
    begin
        with Rec do begin
            case CurrFieldNo of

                FieldNo("No."):
                    begin
                        fnGetSalesHeader(Rec, lrecSalesHeader, lrecCurrency);

                        "B Line type" := lrecSalesHeader."B Order Type";
                        "B External Document No." := lrecSalesHeader."External Document No.";
                        "B Characteristic" := lrecSalesHeader."B Characteristic";
                        "B Salesperson" := lrecSalesHeader."Salesperson Code";
                        "B Variety" := CopyStr("No.", 1, 5);
                        "B Reason Code" := lrecSalesHeader."Reason Code";
                        "B Ship-to Code" := lrecSalesHeader."Ship-to Code";

                        case Type of
                            Type::Item:
                                begin
                                    fnGetItem(Rec, lrecItem);
                                    if lrecItem."B Location Code" <> '' then
                                        "Location Code" := lrecItem."B Location Code";

                                    lcuInternalPromoStatusMgt.CheckSalesLine(Rec);
                                end;
                        end;
                    end;

                FieldNo(Quantity):
                    begin
                        lcuSaleschargesItemTracking.UpdateBejoFields(Rec);
                        if ("Document Type" = "Document Type"::Order) and ("Outstanding Quantity" <> 0) then
                            lcuBejoMgt.SalesCheckAllocation(Rec);
                    end;

                else begin
                        fnGetSalesHeader(Rec, lrecSalesHeader, lrecCurrency);

                        "B Line type" := lrecSalesHeader."B Order Type";
                        "B External Document No." := lrecSalesHeader."External Document No.";
                        "B Characteristic" := lrecSalesHeader."B Characteristic";
                        "B Salesperson" := lrecSalesHeader."Salesperson Code";
                        "B Variety" := CopyStr("No.", 1, 5);
                        "B Reason Code" := lrecSalesHeader."Reason Code";
                        "B Ship-to Code" := lrecSalesHeader."Ship-to Code";
                    end;
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, 37, 'OnAfterValidateEvent', 'Quantity', false, false)]
    local procedure T37_OnAfterValidate_Quantity(var Rec: Record "Sales Line"; var xRec: Record "Sales Line"; CurrFieldNo: Integer)
    var
        lrecCurrency: Record Currency;
        lrecSalesHeader: Record "Sales Header";
        lrecItem: Record Item;
        lcuInternalPromoStatusMgt: Codeunit "Internal Promo Status Mgt.";
        lcuSaleschargesItemTracking: Codeunit "Sales charges - Item Tracking";
        lcuBejoMgt: Codeunit "Bejo Management";
    begin
        with Rec do begin
            case CurrFieldNo of

                FieldNo("No."):
                    begin
                        fnGetSalesHeader(Rec, lrecSalesHeader, lrecCurrency);

                        "B Line type" := lrecSalesHeader."B Order Type";
                        "B External Document No." := lrecSalesHeader."External Document No.";
                        "B Characteristic" := lrecSalesHeader."B Characteristic";
                        "B Salesperson" := lrecSalesHeader."Salesperson Code";
                        "B Variety" := CopyStr("No.", 1, 5);
                        "B Reason Code" := lrecSalesHeader."Reason Code";
                        "B Ship-to Code" := lrecSalesHeader."Ship-to Code";

                        case Type of
                            Type::Item:
                                begin
                                    fnGetItem(Rec, lrecItem);
                                    if lrecItem."B Location Code" <> '' then
                                        "Location Code" := lrecItem."B Location Code";

                                    lcuInternalPromoStatusMgt.CheckSalesLine(Rec);
                                end;
                        end;
                    end;

                FieldNo(Quantity):
                    begin
                        lcuSaleschargesItemTracking.UpdateBejoFields(Rec);
                        if ("Document Type" = "Document Type"::Order) and ("Outstanding Quantity" <> 0) then
                            lcuBejoMgt.SalesCheckAllocation(Rec);
                    end;

            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, 37, 'OnAfterValidateEvent', 'Unit of Measure Code', false, false)]
    local procedure T37_OnAfterValidate_UOMCode(var Rec: Record "Sales Line"; var xRec: Record "Sales Line"; CurrFieldNo: Integer)
    var
        lrecCurrency: Record Currency;
        lrecSalesHeader: Record "Sales Header";
        lrecItem: Record Item;
        lcuInternalPromoStatusMgt: Codeunit "Internal Promo Status Mgt.";
        lcuSaleschargesItemTracking: Codeunit "Sales charges - Item Tracking";
        lcuBejoMgt: Codeunit "Bejo Management";
    begin
        with Rec do begin
            case CurrFieldNo of

                FieldNo("Unit of Measure Code"):
                    begin
                        lcuSaleschargesItemTracking.UpdateBejoFields(Rec);
                        if ("Document Type" = "Document Type"::Order) and ("Outstanding Quantity" <> 0) then
                            lcuBejoMgt.SalesCheckAllocation(Rec);
                    end;

            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, 37, 'OnAfterValidateEvent', 'B Lot No.', false, false)]
    local procedure T37_OnAfterValidate_LotNo(var Rec: Record "Sales Line"; var xRec: Record "Sales Line"; CurrFieldNo: Integer)
    var
        lrecLotNoInfo: Record "Lot No. Information";
        lcuBejoMngt: Codeunit "Bejo Management";
        Text50009: Label 'Lot  %1 does not exist for item %2!';
        Text50011: Label 'Lot %1 is blocked!';
        Text50012: Label 'Item tracking stopped!';
        Text50023: Label 'Attention: Item Tracking exists for this Sales Line!';
        Text50050: Label 'Remove Lot No. %1?';
        lrecItem: Record Item;
        lrecSalesSetup: Record "Sales & Receivables Setup";
        Text50022: Label 'Not (enough) available, use standard item tracking!';
        lcuSaleschargesItemTracking: Codeunit "Sales charges - Item Tracking";
        tempReservEntry: Record "Reservation Entry" temporary;
        tempEntrySummary: Record "Entry Summary" temporary;
        itemTrackingSummaryForm: Page "Item Tracking Summary";
    begin
        with Rec do begin
            "Variant Code" := '';
            TestField(Quantity);


            if (xRec."B Lot No." = "B Lot No.") then
                exit;
            if (xRec."B Lot No." <> "B Lot No.") and
                (xRec."B Lot No." <> '') and
                ("B Lot No." <> '') then
                Error(Text50023);

            if (xRec."B Lot No." <> '') and ("B Lot No." = '') then
                if not Confirm(Text50050, false, xRec."B Lot No.") then
                    exit

                else
                    "B AvailableQty" := 0;

            if lrecLotNoInfo.Get("No.", '', "B Lot No.") then begin
                if lrecLotNoInfo.Blocked then
                    Error(Text50011, "B Lot No.");
            end else begin
                if lrecItem.Get("No.") then
                    if "B Lot No." <> '' then
                        Error(Text50009, "B Lot No.", "No.");
            end;

            lrecLotNoInfo.Reset();
            if ("Document Type" = "Document Type"::"Credit Memo") then begin
                lrecSalesSetup.Get;
                if lrecLotNoInfo.Get("No.", '', "B Lot No.") then begin
                    lrecLotNoInfo.SetRange("Location Filter", "Location Code");
                    lrecLotNoInfo.CalcFields(lrecLotNoInfo.Inventory);
                    if lrecLotNoInfo.Inventory = 0 then begin
                        Clear("B Lot No.");
                        Message(Text50022);
                        exit;
                    end;
                end;
            end;

            if ("B AvailableQty" = 0) and ("B Lot No." <> '') then begin
                lcuSaleschargesItemTracking.UpdateWhseTrackingSummarySlsLn(tempReservEntry, tempEntrySummary, Rec, "B Lot No.");
                if tempEntrySummary.Count = 1 then begin
                    tempEntrySummary.Find('-');
                end else begin
                    itemTrackingSummaryForm.SetSources(tempReservEntry, tempEntrySummary);
                    itemTrackingSummaryForm.LookupMode(true);
                    itemTrackingSummaryForm.SetRecord(tempEntrySummary);
                    if itemTrackingSummaryForm.RunModal = ACTION::LookupOK then
                        itemTrackingSummaryForm.GetRecord(tempEntrySummary)
                    else
                        Error(Text50012);
                end;
                lcuSaleschargesItemTracking.CheckUnitofMeasureCode(tempEntrySummary."B Unit of Measure Code", Rec);
                tempEntrySummary.TestField("B Item No.");
                "B AvailableQty" := tempEntrySummary."B Tot Available Quantity(UofM)";
                if "B AvailableQty" > 0 then
                    Validate("Bin Code", tempEntrySummary."B Bin Code");
            end;

            lcuSaleschargesItemTracking.UpdateReservEntrySlsLn(Rec, "B AvailableQty");
            lcuSaleschargesItemTracking.UpdateBejoFields(Rec);

        end;

        lrecLotNoInfo.Reset();
        if lrecLotNoInfo.Get(Rec."No.", '', Rec."B Lot No.") then
            if lrecLotNoInfo."B Text for SalesOrders" <> '' then
                lcuBejoMngt.FillLotTextForSales(Rec, lrecLotNoInfo."B Text for SalesOrders");
    end;

    [EventSubscriber(ObjectType::Table, 37, 'OnAfterValidateEvent', 'B Line type', false, false)]
    local procedure T37_OnAfterValidate_Line_Type(var Rec: Record "Sales Line"; var xRec: Record "Sales Line"; CurrFieldNo: Integer)
    begin
        with Rec do begin
            case CurrFieldNo of

                FieldNo(Rec."B Line type"):
                    begin
                        if "B Line type" <> "B Line type"::Normal then
                            Validate("Unit Price", 0);
                    end;

            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, 39, 'OnAfterValidateEvent', 'No.', false, false)]
    local procedure T39_OnAfterValidate_No(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; CurrFieldNo: Integer)
    var
        lcuBlockingMgt: Codeunit "Blocking Management";
        lrecPurchHeader: Record "Purchase Header";
        lrecCurrency: Record Currency;
        lcuBejoMgt: Codeunit "Bejo Management";
        lrecItemUnit: Record "Item/Unit";
    begin
        with Rec do begin
            case CurrFieldNo of

                FieldNo("No."):
                    begin
                        fnGetPurchHeader(Rec, lrecPurchHeader, lrecCurrency);

                        lrecPurchHeader.TestField("Buy-from Vendor No.");
                        "B Variety" := CopyStr("No.", 1, 5);
                        "B Reason Code" := lrecPurchHeader."Reason Code";

                        case Type of
                            Type::Item:
                                begin
                                    if ("Document Type" = "Document Type"::Order) then begin
                                        TestField("Requested Receipt Date");
                                        lcuBlockingMgt.CheckPurchaseLine(Rec);
                                    end;
                                end;
                        end;
                    end;

            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, 39, 'OnAfterValidateEvent', 'Quantity', false, false)]
    local procedure T39_OnAfterValidate_Quantity(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; CurrFieldNo: Integer)
    var
        lcuBlockingMgt: Codeunit "Blocking Management";
        lrecPurchHeader: Record "Purchase Header";
        lrecCurrency: Record Currency;
        lcuBejoMgt: Codeunit "Bejo Management";
        lrecItemUnit: Record "Item/Unit";
    begin
        with Rec do begin
            case CurrFieldNo of

                FieldNo(Quantity):
                    begin
                        if ("Document Type" = "Document Type"::Order) and (Type = Type::Item) then begin
                            if Rec."B SkipAllocationCheck" then lcuBejoMgt.SkipAllocationCheckMessages;
                            lcuBejoMgt.PurchCheckAllocation(Rec);
                        end;
                    end;

            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, 39, 'OnAfterValidateEvent', 'Unit of Measure Code', false, false)]
    local procedure T39_OnAfterValidate_UOMCode(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; CurrFieldNo: Integer)
    var
        lcuBlockingMgt: Codeunit "Blocking Management";
        lrecPurchHeader: Record "Purchase Header";
        lrecCurrency: Record Currency;
        lcuBejoMgt: Codeunit "Bejo Management";
        lrecItemUnit: Record "Item/Unit";
    begin
        with Rec do begin
            case CurrFieldNo of

                FieldNo("Unit of Measure Code"):
                    begin
                        if (Type = Type::Item) then lrecItemUnit.CreateItemUnit("No.", "Unit of Measure Code");

                        lcuBlockingMgt.CheckPurchaseLine(Rec);

                        if ("Document Type" = "Document Type"::Order) and (Type = Type::Item) then begin
                            if Rec."B SkipAllocationCheck" then lcuBejoMgt.SkipAllocationCheckMessages;
                            lcuBejoMgt.PurchCheckAllocation(Rec);
                        end;
                    end;

            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, 83, 'OnBeforeValidateEvent', 'Quantity', false, false)]
    local procedure T83_OnBeforeValidate_Quantity(var Rec: Record "Item Journal Line"; var xRec: Record "Item Journal Line"; CurrFieldNo: Integer)
    var
        Text50023: Label 'Attention: Item Tracking exists for this Line!';
        lcuSaleschargesItemTracking: Codeunit "Sales charges - Item Tracking";
        lcuBejoMgt: Codeunit "Bejo Management";
        lpItemTrackingSummary: Page "Item Tracking Summary";
        Text50011: Label 'Lot %1 is blocked!';
        Text50012: Label 'Item tracking stopped!';
        Text50050: Label 'Remove Lot No. %1?';
        lrecLotNoInfo: Record "Lot No. Information";
        lrecTempEntrySummary: Record "Entry Summary" temporary;
        lrecTempReservEntry: Record "Reservation Entry" temporary;
        lLookUpLotNoAvailQty: Decimal;
    begin
        with Rec do begin
            case CurrFieldNo of

                FieldNo(Quantity):
                    begin
                        if ("Lot No." <> '') and not ("Phys. Inventory") then
                            Error(Text50023);
                    end;

            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, 83, 'OnBeforeValidateEvent', 'Lot No.', false, false)]
    local procedure T83_OnBeforeValidate_LotNo(var Rec: Record "Item Journal Line"; var xRec: Record "Item Journal Line"; CurrFieldNo: Integer)
    var
        Text50023: Label 'Attention: Item Tracking exists for this Line!';
        lcuSaleschargesItemTracking: Codeunit "Sales charges - Item Tracking";
        lcuBejoMgt: Codeunit "Bejo Management";
        lpItemTrackingSummary: Page "Item Tracking Summary";
        Text50011: Label 'Lot %1 is blocked!';
        Text50012: Label 'Item tracking stopped!';
        Text50050: Label 'Remove Lot No. %1?';
        lrecLotNoInfo: Record "Lot No. Information";
        lrecTempEntrySummary: Record "Entry Summary" temporary;
        lrecTempReservEntry: Record "Reservation Entry" temporary;
        lLookUpLotNoAvailQty: Decimal;
    begin
        with Rec do begin

            "Variant Code" := '';
            TestField(Quantity);

            if (xRec."Lot No." = "Lot No.") then
                exit;

            if (xRec."Lot No." <> "Lot No.") and
                (xRec."Lot No." <> '') and ("Lot No." <> '') then
                Error(Text50023);

            if (xRec."Lot No." <> '') and ("Lot No." = '') then
                if not Confirm(Text50050, false, xRec."Lot No.") then
                    exit;

            if lrecLotNoInfo.Get("No.", '', "Lot No.") then
                if lrecLotNoInfo.Blocked then
                    Error(Text50011, "Lot No.");

            lLookUpLotNoAvailQty := Rec."B LookUpLotNoAvailQty";

            if (lLookUpLotNoAvailQty = 0) and ("Lot No." <> '') then begin
                lcuSaleschargesItemTracking.UpdateWhseTrackingSummaryItmJn(lrecTempReservEntry, lrecTempEntrySummary, Rec, "Lot No.");

                if (lrecTempEntrySummary.Count = 1) or ("B Scanning") then begin
                    lrecTempEntrySummary.Find('-');
                end
                else begin
                    lpItemTrackingSummary.SetSources(lrecTempReservEntry, lrecTempEntrySummary);
                    lpItemTrackingSummary.LookupMode(true);
                    lpItemTrackingSummary.SetRecord(lrecTempEntrySummary);
                    if lpItemTrackingSummary.RunModal = ACTION::LookupOK then
                        lpItemTrackingSummary.GetRecord(lrecTempEntrySummary)
                    else
                        Error(Text50012);
                end;

                lcuSaleschargesItemTracking.CheckUnitofMeasureCodeItmJn(lrecTempEntrySummary."B Unit of Measure Code", Rec);

                lrecTempEntrySummary.TestField("B Item No.");
                lLookUpLotNoAvailQty := lrecTempEntrySummary."B Tot Available Quantity(UofM)";
                if lLookUpLotNoAvailQty > 0 then
                    Validate("Bin Code", lrecTempEntrySummary."B Bin Code");
            end;

            if "Entry Type" = "Entry Type"::Transfer then begin
                "New Location Code" := '';
                "New Bin Code" := '';
                "New Lot No." := '';
            end;

            lcuSaleschargesItemTracking.UpdateReservEntryItmJn(Rec, lLookUpLotNoAvailQty);

        end;
    end;

    [EventSubscriber(ObjectType::Table, 97, 'OnAfterInsertEvent', '', false, false)]
    local procedure T97_OnAfterInsert(var Rec: Record "Comment Line"; RunTrigger: Boolean)
    begin
        if RunTrigger then begin
            with Rec do begin
                "B Creation Date" := Today;
                "B User-ID" := UserId;
                Modify(false);
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, 97, 'OnAfterModifyEvent', '', false, false)]
    local procedure T97_OnAfterModify(var Rec: Record "Comment Line"; var xRec: Record "Comment Line"; RunTrigger: Boolean)
    begin
        if RunTrigger then begin
            with Rec do begin
                "B Last Date Modified" := Today;
                "B User-ID" := UserId;
                Modify(false);
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, 97, 'OnAfterValidateEvent', 'No.', false, false)]
    local procedure T97_OnAfterValidate_No(var Rec: Record "Comment Line"; var xRec: Record "Comment Line"; CurrFieldNo: Integer)
    begin
        with Rec do begin

            if "Table Name" = "Table Name"::Item then
                "B Variety" := CopyStr("No.", 1, 5);
        end;
    end;

    [EventSubscriber(ObjectType::Table, 97, 'OnAfterValidateEvent', 'Code', false, false)]
    local procedure T97_OnAfterValidate_Code(var Rec: Record "Comment Line"; var xRec: Record "Comment Line"; CurrFieldNo: Integer)
    var
        lrecItemUnitOfMeasure: Record "Item Unit of Measure";
        Txt50000: Label 'Please select a valid ''Unit Of Measure code'' for this item.';
    begin
        with Rec do begin
            case CurrFieldNo of

                FieldNo(Code):
                    begin
                        if "B Comment Type" = "B Comment Type"::Salesperson then begin

                            lrecItemUnitOfMeasure.SetFilter("Item No.", "No.");
                            lrecItemUnitOfMeasure.SetFilter(Code, Code);
                            if not lrecItemUnitOfMeasure.FindFirst then
                                Message(Txt50000);
                        end;
                    end;

            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, 336, 'OnAfterValidateEvent', 'Lot No.', false, false)]
    local procedure T336_OnAfterValidate_LotNo(var Rec: Record "Tracking Specification"; var xRec: Record "Tracking Specification"; CurrFieldNo: Integer)
    var
        Text50000: Label 'Lot No. %1 doesn''t exist for %2!';
        lrecLotNoInformation: Record "Lot No. Information";
    begin
        with Rec do begin
            case CurrFieldNo of

                FieldNo("Lot No."):
                    begin
                        if not lrecLotNoInformation.Get("Item No.", '', "Lot No.") then
                            Message(Text50000, "Lot No.", "Item No.");
                    end;

            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, 6505, 'OnAfterInsertEvent', '', false, false)]
    local procedure T6505_OnAfterInsert(var Rec: Record "Lot No. Information"; RunTrigger: Boolean)
    begin
        if RunTrigger then begin
            with Rec do begin
                "B Variety" := CopyStr("Item No.", 1, 5);
                Modify(false);
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, 50018, 'OnAfterDeleteEvent', '', false, false)]
    local procedure T50018_OnAfterDelete(var Rec: Record "Prognosis/Allocation Entry"; RunTrigger: Boolean)
    var
        lrecBejoSetup: Record "Bejo Setup";
        lcuBejoMgt: Codeunit "Bejo Management";
    begin

        //if RunTrigger then begin
        //   if lrecBejoSetup."Mail Allocation Change" then
        //        lcuBejoMgt.SendMailAtAllocating(Rec, Rec);
        //end;
    end;

    [EventSubscriber(ObjectType::Table, 50019, 'OnAfterValidateEvent', 'Prognoses', false, false)]
    local procedure T50019_OnAfterValidate_Prognoses(var Rec: Record "Item/Unit"; var xRec: Record "Item/Unit"; CurrFieldNo: Integer)
    var
        BejoSetup: Record "Bejo Setup";
        BlockingMgt: Codeunit "Blocking Management";
    begin

        BejoSetup.Get;

        if (BejoSetup."Variety Blocking") and (Rec.Prognoses <> 0) then
            BlockingMgt.CheckItemUnit(Rec);

    end;

    [EventSubscriber(ObjectType::Page, 30, 'OnOpenPageEvent', '', false, false)]
    local procedure P30_OnOpenPage(var Rec: Record Item)
    var
        lrecBejoSetup: Record "Bejo Setup";
    begin
        with Rec do begin
            if lrecBejoSetup.Get then;
            if lrecBejoSetup."Default LocationFilter on Item" <> ''
                 then
                SetFilter("Location Filter", lrecBejoSetup."Default LocationFilter on Item");

            lrecBejoSetup.TestField("Begin Date");
            lrecBejoSetup.TestField("End Date");
            FilterGroup(100);
            SetRange("B Current Season filter", lrecBejoSetup."Begin Date", lrecBejoSetup."End Date");
            SetRange("B Last Season filter", CalcDate('<-1Y>', lrecBejoSetup."Begin Date"), CalcDate('<-1Y>', lrecBejoSetup."End Date"));
            FilterGroup(0);
        end;
    end;

    [EventSubscriber(ObjectType::Page, 30, 'OnAfterGetRecordEvent', '', false, false)]
    local procedure P30_OnAfterGetRecord(var Rec: Record Item)
    var
        lrecVariety: Record Varieties;
        lcuBlockingMgt: Codeunit "Blocking Management";
        lrecItemExtension: Record "Item Extension";
    begin
        with Rec do begin
            CalcFields("B Promo Status");
            if "B Promo Status" <> '' then begin
                CalcFields("B Promo Status Description");
                "B DisplayPromoStatus" := "B Promo Status" + ': ' + "B Promo Status Description";
            end;

            if lrecVariety.Get("B Variety") then begin
                "B VarietySalesComment" := lrecVariety."Sales Comment";
                "B VarietyDateToBeDiscontinued" := lrecVariety."Date to be discontinued";
            end;

            if "B Organic" = true then begin
                "B ItemExtensionDescription" := '';
            end
            else begin
                if lrecItemExtension.Get("B Extension", '') then begin
                    "B ItemExtensionDescription" := lrecItemExtension.Description;
                end;
            end;

            "B ItemBlockDescription" := lcuBlockingMgt.ItemBlockDescription(Rec);

        end;
    end;

    [EventSubscriber(ObjectType::Page, 31, 'OnAfterGetRecordEvent', '', false, false)]
    local procedure P31_OnAfterGetRecord(var Rec: Record Item)
    var
        lrecVariety: Record Varieties;
        lcuBlockingMgt: Codeunit "Blocking Management";
        lrecItemExtension: Record "Item Extension";
    begin
        with Rec do begin
            CalcFields("B Promo Status");
            if "B Promo Status" <> '' then begin
                CalcFields("B Promo Status Description");
                "B DisplayPromoStatus" := "B Promo Status" + ': ' + "B Promo Status Description";
            end;

            if lrecVariety.Get("B Variety") then begin
                "B VarietySalesComment" := lrecVariety."Sales Comment";
                "B VarietyDateToBeDiscontinued" := lrecVariety."Date to be discontinued";
            end;

            if "B Organic" = true then begin
                "B ItemExtensionDescription" := '';
            end
            else begin
                if lrecItemExtension.Get("B Extension", '') then begin
                    "B ItemExtensionDescription" := lrecItemExtension.Description;
                end;
            end;

            "B ItemBlockDescription" := lcuBlockingMgt.ItemBlockDescription(Rec);

        end;
    end;

    [EventSubscriber(ObjectType::Page, 31, 'OnOpenPageEvent', '', false, false)]
    local procedure P31_OnOpenPage(var Rec: Record Item)
    var
        lrecBejoSetup: Record "Bejo Setup";
    begin

        with Rec do begin
            if lrecBejoSetup.Get then;

            if lrecBejoSetup."Default LocationFilter on Item" <> '' then
                SetFilter("Location Filter", lrecBejoSetup."Default LocationFilter on Item");


            if (lrecBejoSetup."Begin Date" <> 0D) and (lrecBejoSetup."End Date" <> 0D) then
                SetFilter("Date Filter", '%1..%2', lrecBejoSetup."Begin Date", lrecBejoSetup."End Date");


        end;
    end;

    [EventSubscriber(ObjectType::Page, 42, 'OnAfterGetRecordEvent', '', false, false)]
    local procedure P42_OnAfterGetRecord(var Rec: Record "Sales Header")
    begin
        with Rec do begin
            fnCheckOrderstatusReserved(Rec, false);
            "B PrepayUnpaidAmount" := fnGetPrepayUnpaidAmount(Rec);
        end;
    end;

    [EventSubscriber(ObjectType::Page, 42, 'OnClosePageEvent', '', false, false)]
    local procedure P42_OnClosePage(var Rec: Record "Sales Header")
    begin
        with Rec do begin
            fnCheckOrderstatusReserved(Rec, false);

        end;
    end;

    procedure P42_OnAfterAction_50057(var Rec: Record "Sales Header")
    var
        lpItemTrackingOrder: Page "Item Tracking per Order";
    begin
        lpItemTrackingOrder.SetOrder(Rec);
        lpItemTrackingOrder.RunModal;
    end;

    procedure P42_OnAfterAction_50069(var Rec: Record "Sales Header")
    var
        BEJOMgt: Codeunit "Bejo Management";
    begin

        BEJOMgt.PrintPickList(Rec);

    end;

    procedure P42_OnAfterAction_50071(var Rec: Record "Sales Header")
    var
        BEJOMgt: Codeunit "Bejo Management";
    begin

        BEJOMgt.PrintPackingList(Rec);

    end;

    procedure P42_OnAfterAction_50085(var Rec: Record "Sales Header")
    begin
        REPORT.RunModal(50005, true, false);
    end;

    procedure P42_OnAfterAction_50088(var Rec: Record "Sales Header")
    begin
        CODEUNIT.Run(50002, Rec);
    end;

    procedure P42_OnAfterAction_50090(var Rec: Record "Sales Header")
    var
        lcuSalesChargesItemTracking: Codeunit "Sales charges - Item Tracking";
    begin
        lcuSalesChargesItemTracking.AddSpecialCharges(Rec);
    end;

    procedure P42_OnAfterAction_50091(var Rec: Record "Sales Header")
    var
        BEJOMgt: Codeunit "Bejo Management";
    begin

        BEJOMgt.PrintProformaInvoice(Rec);

    end;

    procedure P42_OnAfterAction_50093(var Rec: Record "Sales Header")
    var
        lrptMergeOrders: Report "Merge Orders";
    begin
        Rec.SetRange("Document Type", Rec."Document Type");
        Rec.SetRange("Sell-to Customer No.", Rec."Sell-to Customer No.");
        Rec.SetRange("Location Code", Rec."Location Code");
        Rec.SetFilter("B Characteristic", '<%1', 1);
        Rec.SetRange("Ship-to Code", Rec."Ship-to Code");
        lrptMergeOrders.SetCustomerNo(Rec."Sell-to Customer No.");
        lrptMergeOrders.SetTableView(Rec);
        lrptMergeOrders.RunModal;
    end;

    procedure P42_OnAfterAction_50096(var Rec: Record "Sales Header")
    var
        lSalesLine: Record "Sales Line";
        Text50007: Label 'Orderstatus must be 2. Reserved for order %1 to release to warehouse!';
        Text50009: Label 'First delete empty Sales Line %1, before you can release the Sales Order!';
        Text50005: Label 'Attention: There is no Item tracking for item %1, order %3 %2!';
        Text50010: Label 'Order Status of "4. In Warehouse" or "5. Warehouse Ready", shoud be set by the warehouse.  Continue?';
        Text50011: Label 'Click OK or press Enter to continue.';
        lrecBejoSetup: Record "Bejo Setup";
        lcuPrepaymentMgt: Codeunit "Prepayment Mgt.";
        Text001: Label 'Do you want to change %1 in all related records in the warehouse?';
        Text002: Label 'The update has been interrupted to respect the warning.';
    begin
        if Rec."B OrderStatus" > Rec."B OrderStatus"::"2.Reserved" then
            Error(Text50007, Rec."No.");

        lSalesLine.SetRange("Document Type", lSalesLine."Document Type");
        lSalesLine.SetRange("Document No.", lSalesLine."No.");
        lSalesLine.SetRange(lSalesLine.Type, lSalesLine.Type::Item);
        if lSalesLine.Find('-') then
            repeat
                lSalesLine.CalcFields("B Tracking Quantity");
                if lSalesLine."No." = '' then
                    Error(Text50009, lSalesLine."Line No.");
                if lSalesLine."B Tracking Quantity" = 0 then
                    Error(Text50005, lSalesLine."No.", lSalesLine."Line No.", lSalesLine."Document No.");
            until lSalesLine.Next = 0;

        if (Rec."B Characteristic" = Rec."B Characteristic"::"Price correction")
            or (Rec."B Characteristic" = Rec."B Characteristic"::"Stock revaluation") then
            Rec.Validate("B OrderStatus", Rec."B OrderStatus"::"5.Ready Warehouse")
        else
            Rec.Validate("B OrderStatus", Rec."B OrderStatus"::"3.Released");

        if Rec."B OrderStatus" >= Rec."B OrderStatus"::"3.Released" then begin
            if lrecBejoSetup.Get then
                if lrecBejoSetup."Enforce NAV SO Status" then
                    Rec.TestField(Status, Rec.Status::Released);
            if lcuPrepaymentMgt.TestSalesPrepayment(Rec) then
                Error(StrSubstNo(Text001, Rec."Document Type", Rec."No."))
            else
                if lcuPrepaymentMgt.TestSalesPayment(Rec) then
                    Error(StrSubstNo(Text002, Rec."Document Type", Rec."No."));
        end;
        if Rec."B OrderStatus" > Rec."B OrderStatus"::"3.Released" then
            if not (Confirm(Text50010)) then
                Error(Text50011);

        Rec.Modify;
    end;

    procedure P44_OnAfterAction_50025(var Rec: Record "Sales Header")
    var
        lrecSalesHeader: Record "Sales Header";
        BEJOMgt: Codeunit "Bejo Management";
    begin

        BEJOMgt.PrintProformaSlsCreditMemo(Rec);

    end;

    //[EventSubscriber(ObjectType::Page, 516, 'OnAfterActionEvent', 'Action6500', false, false)]
    //local procedure P516_OnAfterAction_6500(var Rec: Record "Sales Line")
    //var
    //    lcuSaleschargesItemTracking: Codeunit "Sales charges - Item Tracking";
    //begin
    //    lcuSaleschargesItemTracking.UpdateBejoFields(Rec);
    //end;

    [EventSubscriber(ObjectType::Page, 46, 'OnAfterGetRecordEvent', '', false, false)]
    local procedure P46_OnAfterGetRecord(var Rec: Record "Sales Line")
    var
        lrecItem: Record Item;
        lrecSalesHeader: Record "Sales Header";
        lrecCurrency: Record Currency;
        lrecItemExtension: Record "Item Extension";
    begin
        if lrecItem.Get(Rec."No.") then begin
            fnGetSalesHeader(Rec, lrecSalesHeader, lrecCurrency);
            if lrecItemExtension.Get(lrecItem."B Extension", lrecSalesHeader."Language Code") then begin
                Rec."B ItemExtensionCode" := lrecItemExtension."Extension Code";
            end;
        end;
    end;

    //[EventSubscriber(ObjectType::Page, 46, 'OnAfterValidateEvent', 'B Lot No.', false, false)]
    //local procedure P46_OnAfterValidate_LotNo(var Rec: Record "Sales Line"; var xRec: Record "Sales Line")
    //begin
    //end;

    [EventSubscriber(ObjectType::Page, 46, 'OnAfterActionEvent', 'ItemTrackingLines', false, false)]
    local procedure P46_OnAfterAction_6500(var Rec: Record "Sales Line")
    var
        lcuSaleschargesItemTracking: Codeunit "Sales charges - Item Tracking";
    begin
        lcuSaleschargesItemTracking.UpdateBejoFields(Rec);
    end;

    //[EventSubscriber(ObjectType::Page, 47, 'OnAfterActionEvent', 'Action1905987604', false, false)]
    //local procedure P47_OnAfterAction_6500(var Rec: Record "Sales Line")
    //var
    //    lcuSaleschargesItemTracking: Codeunit "Sales charges - Item Tracking";
    //begin
    //    lcuSaleschargesItemTracking.UpdateBejoFields(Rec);
    //end;

    procedure P50_OnAfterAction_50035(var Rec: Record "Purchase Header")
    var
        lcuBejoMngt: Codeunit "Bejo Management";
    begin
        //    lcuBejoMngt.CreatePurchaseOrderXML(Rec."No.");
    end;

    procedure P50_OnAfterAction_50037(var Rec: Record "Purchase Header")
    var
        lrecPurchaseLine: Record "Purchase Line";
        lrptDeleteOriginalPurchLine: Report "Delete Original Purchase Line";
    begin
        lrecPurchaseLine.SetRange(lrecPurchaseLine."Document No.", Rec."No.");
        lrptDeleteOriginalPurchLine.SetTableView(lrecPurchaseLine);
        lrptDeleteOriginalPurchLine.RunModal;
    end;

    procedure P52_OnAfterAction_50023(var Rec: Record "Purchase Header")
    var
        BEJOMgt: Codeunit "Bejo Management";
    begin

        BEJOMgt.PrintProformaPurCreditMemo(Rec);

    end;

    procedure P52_OnAfterAction_50025(var Rec: Record "Purchase Header")
    begin
        Rec.SetRange("No.", Rec."No.");
        REPORT.RunModal(50020, true, false, Rec);
    end;

    procedure P52_OnAfterAction_50027(var Rec: Record "Purchase Header")
    var
        lcuBejoMngt: Codeunit "Bejo Management";
    begin
        //    lcuBejoMngt.CreatePurchaseCreditMemoXML(Rec."No.");
    end;

    procedure P52_OnAfterAction_50031(var Rec: Record "Purchase Header")
    var
        lcuBejoMngt: Codeunit "Bejo Management";
    begin
        Rec.SetRange("No.", Rec."No.");
        REPORT.RunModal(50058, false, false, Rec);
    end;

    [EventSubscriber(ObjectType::Page, 54, 'OnAfterGetRecordEvent', '', false, false)]
    local procedure P54_OnAfterGetRecord(var Rec: Record "Purchase Line")
    var
        lrecItem: Record Item;
        lrecPurchHeader: Record "Purchase Header";
        lrecCurrency: Record Currency;
        lrecItemExtension: Record "Item Extension";
        lrecReservationEntry: Record "Reservation Entry";
    begin
        if lrecItem.Get(Rec."No.") then begin
            fnGetPurchHeader(Rec, lrecPurchHeader, lrecCurrency);
            if lrecItemExtension.Get(lrecItem."B Extension", lrecPurchHeader."Language Code") then begin
                Rec."B ItemExtensionCode" := lrecItemExtension."Extension Code";
            end;
        end;


        if not lrecReservationEntry.SetCurrentKey("Source ID", "Source Ref. No.") then
            lrecReservationEntry.SetCurrentKey("Source Type", "Source Subtype", "Source ID");

        lrecReservationEntry.SetRange("Source ID", Rec."Document No.");
        lrecReservationEntry.SetRange("Source Ref. No.", Rec."Line No.");
        lrecReservationEntry.SetRange("Source Type", 39);
        if lrecReservationEntry.FindFirst then
            Rec."B ReservEntryLotNo" := lrecReservationEntry."Lot No.";

    end;

    //[EventSubscriber(ObjectType::Page, 95, 'OnAfterActionEvent', 'Action1905987604', false, false)]
    //local procedure P95_OnAfterAction_6500(var Rec: Record "Sales Line")
    //var
    //    lcuSaleschargesItemTracking: Codeunit "Sales charges - Item Tracking";
    //begin
    //    lcuSaleschargesItemTracking.UpdateBejoFields(Rec);
    //end;

    [EventSubscriber(ObjectType::Page, 96, 'OnAfterGetRecordEvent', '', false, false)]
    local procedure P96_OnAfterGetRecord(var Rec: Record "Sales Line")
    var
        lrecReservationEntry: Record "Reservation Entry";
    begin
        if not lrecReservationEntry.SetCurrentKey("Source ID", "Source Ref. No.") then
            lrecReservationEntry.SetCurrentKey("Source Type", "Source Subtype", "Source ID");

        lrecReservationEntry.SetRange("Source ID", Rec."Document No.");
        lrecReservationEntry.SetRange("Source Ref. No.", Rec."Line No.");
        lrecReservationEntry.SetRange("Source Type", 39);
        if lrecReservationEntry.FindFirst then
            Rec."B ReservEntryLotNo" := lrecReservationEntry."Lot No.";
    end;

    [EventSubscriber(ObjectType::Page, 96, 'OnAfterActionEvent', 'ItemTrackingLines', false, false)]
    local procedure P96_OnAfterAction_6500(var Rec: Record "Sales Line")
    var
        lcuSaleschargesItemTracking: Codeunit "Sales charges - Item Tracking";
    begin
        lcuSaleschargesItemTracking.UpdateBejoFields(Rec);
    end;

    [EventSubscriber(ObjectType::Page, 98, 'OnAfterGetRecordEvent', '', false, false)]
    local procedure P98_OnAfterGetRecord(var Rec: Record "Purchase Line")
    var
        lrecItem: Record Item;
        lrecPurchHeader: Record "Purchase Header";
        lrecCurrency: Record Currency;
        lrecItemExtension: Record "Item Extension";
        lrecReservationEntry: Record "Reservation Entry";
    begin
        if not lrecReservationEntry.SetCurrentKey("Source ID", "Source Ref. No.") then
            lrecReservationEntry.SetCurrentKey("Source Type", "Source Subtype", "Source ID");

        lrecReservationEntry.SetRange("Source ID", Rec."Document No.");
        lrecReservationEntry.SetRange("Source Ref. No.", Rec."Line No.");
        lrecReservationEntry.SetRange("Source Type", 39);
        if lrecReservationEntry.FindFirst then
            Rec."B ReservEntryLotNo" := lrecReservationEntry."Lot No.";

        if lrecItem.Get(Rec."No.") then begin
            fnGetPurchHeader(Rec, lrecPurchHeader, lrecCurrency);
            if lrecItemExtension.Get(lrecItem."B Extension", lrecPurchHeader."Language Code") then begin
                Rec."B ItemExtensionCode" := lrecItemExtension."Extension Code";
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Page, 392, 'OnAfterGetCurrRecordEvent', '', false, false)]
    local procedure P392_OnAfterGetCurrentRecord(var Rec: Record "Item Journal Line")
    begin
        SetCurrentItemJnlRecord(Rec);
    end;


    procedure P392_OnAfterAction_50007(var Rec: Record "Item Journal Line")
    var
        lcuBejoMngt: Codeunit "Bejo Management";
    begin
        //    lcuBejoMngt.ProcessEOSS(Rec."Posting Date", Rec."Document No.");
    end;

    procedure P392_OnAfterAction_50011(var Rec: Record "Item Journal Line")
    var
        lcuBejoMngt: Codeunit "Bejo Management";
    begin
        //    lcuBejoMngt.ExportEOSS(Rec."Posting Date", Rec."Document No.");
    end;

    [EventSubscriber(ObjectType::Page, 6631, 'OnAfterActionEvent', 'ItemTrackingLines', false, false)]
    local procedure P6631_OnAfterAction_6500(var Rec: Record "Sales Line")
    var
        lcuSaleschargesItemTracking: Codeunit "Sales charges - Item Tracking";
    begin
        lcuSaleschargesItemTracking.UpdateBejoFields(Rec);
    end;

    [EventSubscriber(ObjectType::Page, 6500, 'OnAfterGetRecordEvent', '', false, false)]
    local procedure P6500_OnAfterGetRecord(var Rec: Record "Entry Summary")
    var
        lrecLotNoInformation: Record "Lot No. Information";
        lrecItemLedgerEntry: Record "Item Ledger Entry";
        CalculatedTBT1: Date;
        CalculatedTBT2: Date;
        DatePageula1: Code[10];
        DatePageula2: Code[10];
        BEJOSetup: Record "Bejo Setup";
    begin
        with Rec do begin

            lrecLotNoInformation.SetCurrentKey("Lot No.");
            lrecLotNoInformation.SetRange("Lot No.", "Lot No.");
            if lrecLotNoInformation.FindFirst then begin
                "B Treatment Code" := lrecLotNoInformation."B Treatment Code";
                "B Tsw. in gr." := lrecLotNoInformation."B Tsw. in gr.";
                "B Line type" := lrecLotNoInformation."B Line type";
                "B Germination" := lrecLotNoInformation."B Germination";
                "B Abnormals" := lrecLotNoInformation."B Abnormals";
                "B Grade Code" := lrecLotNoInformation."B Grade Code";
                "B Remark" := lrecLotNoInformation."B Remark";
                "B Best used by" := lrecLotNoInformation."B Best used by";
                "B Blocked" := lrecLotNoInformation.Blocked;


                BEJOSetup.Get();
                "B Best used by Style" := 'Standard'; //normal
                DatePageula1 := BEJOSetup."Best Used By in Red";
                CalculatedTBT1 := CalcDate(DatePageula1, Today);
                DatePageula2 := BEJOSetup."Best Used By in Blue";
                CalculatedTBT2 := CalcDate(DatePageula2, Today);
                if ("B Best used by" <> 0D) and ("B Best used by" < CalculatedTBT2) then
                    "B Best used by Style" := 'StandardAccent';//blue color
                if ("B Best used by" <> 0D) and ("B Best used by" < CalculatedTBT1) then
                    "B Best used by Style" := 'Attention';//red color


                lrecItemLedgerEntry.SetCurrentKey("Item No.", "Variant Code", Open);
                lrecItemLedgerEntry.SetRange("Item No.", "B Item No.");
                lrecItemLedgerEntry.SetRange(Open, true);
                lrecItemLedgerEntry.SetRange("Lot No.", "Lot No.");
                if lrecItemLedgerEntry.FindLast then begin
                    "B Unit of Measure Code" := lrecItemLedgerEntry."Unit of Measure Code";
                    "B Qty. per Unit of Measure" := lrecItemLedgerEntry."Qty. per Unit of Measure";
                end;

            end;

        end;
    end;

    [EventSubscriber(ObjectType::Page, 6505, 'OnAfterGetRecordEvent', '', false, false)]
    local procedure P6505_OnAfterGetRecord(var Rec: Record "Lot No. Information")
    var
        lrecItem: Record Item;
        lrecItemLedgerEntry: Record "Item Ledger Entry";
        lrecShipmentNotification: Record "Shipment Notification";
        lResult120: Text[120];
        lResult110: Text[110];
        lrecTreatmentCode: Record "Treatment Code";
        lrecGrade: Record Grade;
    begin
        with Rec do begin
            if lrecItem.Get(Rec."Item No.") then begin
                "B ItemExtensionDescription" := lrecItem."B ItemExtensionDescription";
            end;

            lrecItemLedgerEntry.SetCurrentKey("Item No.", "Variant Code", Open);
            lrecItemLedgerEntry.SetRange("Item No.", "Item No.");
            lrecItemLedgerEntry.SetRange(Open, true);
            lrecItemLedgerEntry.SetRange("Lot No.", "Lot No.");
            if lrecItemLedgerEntry.FindFirst then begin
                "B ILEUnitOfMeasureCode" := lrecItemLedgerEntry."Unit of Measure Code";
                "B ILEUnitQtyPerOfMeasure" := lrecItemLedgerEntry."Qty. per Unit of Measure";
            end;

            lrecShipmentNotification.SetRange("Lot No.", "Lot No.");
            if lrecShipmentNotification.FindSet(false, false) then begin
                repeat
                    if lResult120 = '' then
                        lResult120 := lrecShipmentNotification."Country of Origin"
                    else
                        if MaxStrLen(lResult120) > (StrLen(lResult120) + StrLen(lrecShipmentNotification."Country of Origin") + 2) then begin
                            lResult120 := lResult120 + ', ' + lrecShipmentNotification."Country of Origin";
                        end;
                until lrecShipmentNotification.Next = 0;
                "B CountryOfOrigin" := lResult120;
            end;

            lrecShipmentNotification.SetRange("Lot No.", "Lot No.");
            if lrecShipmentNotification.FindSet(false, false) then begin
                repeat
                    if lResult110 = '' then
                        lResult110 := lrecShipmentNotification."Phyto Certificate No."
                    else
                        if MaxStrLen(lResult110) > (StrLen(lResult110) + StrLen(lrecShipmentNotification."Phyto Certificate No.") + 2) then begin
                            lResult110 := lResult110 + ', ' + lrecShipmentNotification."Phyto Certificate No.";
                            ;
                        end;
                until lrecShipmentNotification.Next = 0;
                "B PhytoCertificate" := lResult110;
            end;

            if lrecTreatmentCode.Get("B Treatment Code") then begin
                "B TreatmentDescription" := lrecTreatmentCode.Description;
            end;

            if lrecGrade.Get("B Grade Code") then begin
                "B GradeDescription" := lrecGrade.Description;
            end;
        end;
    end;

    procedure P6505_OnAfterAction_50055(var Rec: Record "Lot No. Information")
    begin

        REPORT.RunModal(50060, true, true, Rec);
    end;

    procedure P6505_OnAfterAction_50057(var Rec: Record "Lot No. Information")
    var
        lrecItemLedgerEntry: Record "Item Ledger Entry";
    begin

        lrecItemLedgerEntry.SetRange("Lot No.", Rec."Lot No.");
        REPORT.RunModal(50005, true, true, lrecItemLedgerEntry);
    end;

    [EventSubscriber(ObjectType::Page, 6510, 'OnClosePageEvent', '', false, false)]
    local procedure P6510_OnClosePage(var Rec: Record "Tracking Specification")
    begin
        fnUpdateBejoFieldsItmJnl(Rec);
    end;

    [EventSubscriber(ObjectType::Codeunit, 414, 'OnBeforeReleaseSalesDoc', '', false, false)]
    local procedure C414_OnBeforeReleaseSalesDoc(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean)
    begin

        CheckSalesPrice(SalesHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnBeforePostSalesDoc', '', false, false)]
    local procedure C80_OnBeforePostSalesDoc(var SalesHeader: Record "Sales Header")
    begin

        CheckSalesPrice(SalesHeader);
    end;

    local procedure fnSetBejoILEFieldValues(var parItemLedgEntry: Record "Item Ledger Entry"; aItemJnlLine: Record "Item Journal Line")
    begin
        parItemLedgEntry.Description := aItemJnlLine.Description;

        parItemLedgEntry."B Variety" := CopyStr(aItemJnlLine."Item No.", 1, 5);
        parItemLedgEntry."B Comment" := aItemJnlLine."B Comment";

        parItemLedgEntry."B Salesperson" := aItemJnlLine."Salespers./Purch. Code";
    end;

    local procedure fnSetEntryBejoFieldValues(var aItemJnlLineTemp: Record "Item Journal Line" temporary)
    var
        lrecItemLedgerEntry: Record "Item Ledger Entry";
        lrecValueEntry: Record "Value Entry";
    begin
        lrecValueEntry.SetCurrentKey("Item Ledger Entry No.", "Document No.", "Document Line No.");

        lrecItemLedgerEntry.SetRange("Document No.", aItemJnlLineTemp."Document No.");
        lrecItemLedgerEntry.SetRange("Document Line No.", aItemJnlLineTemp."Document Line No.");
        if lrecItemLedgerEntry.FindSet(true, false) then
            repeat
                lrecItemLedgerEntry.Description := aItemJnlLineTemp.Description;
                lrecItemLedgerEntry."B Line type" := aItemJnlLineTemp."B Line type";
                lrecItemLedgerEntry."B Variety" := CopyStr(aItemJnlLineTemp."Item No.", 1, 5);
                lrecItemLedgerEntry."B Comment" := aItemJnlLineTemp."B Comment";
                lrecItemLedgerEntry."B Characteristic" := aItemJnlLineTemp."B Characteristic";
                lrecItemLedgerEntry."B Salesperson" := aItemJnlLineTemp."Salespers./Purch. Code";

                lrecItemLedgerEntry.Modify(false);
            until lrecItemLedgerEntry.Next = 0;


        lrecValueEntry.SetRange("Document No.", aItemJnlLineTemp."Document No.");
        lrecValueEntry.SetRange("Document Line No.", aItemJnlLineTemp."Document Line No.");
        if lrecValueEntry.FindSet(true, false) then
            repeat
                lrecValueEntry.Description := aItemJnlLineTemp.Description;
                lrecValueEntry."B Line type" := aItemJnlLineTemp."B Line type";
                lrecValueEntry."B Characteristic" := aItemJnlLineTemp."B Characteristic";

                lrecValueEntry."B Unit in Weight" := lrecItemLedgerEntry."B Unit in Weight";
                lrecValueEntry."B Treatment Code" := lrecItemLedgerEntry."B Treatment Code";
                lrecValueEntry.Modify(false);
            until lrecValueEntry.Next = 0;
    end;

    local procedure fnSetBejoILEUnitInWghtAndTreatment(var parItemLedgerEntry: Record "Item Ledger Entry")
    var
        lrecUnitOfMeasure: Record "Unit of Measure";
        lrecLotNoInfo: Record "Lot No. Information";
    begin
        with parItemLedgerEntry do begin
            if lrecUnitOfMeasure.Get("Unit of Measure Code") then
                "B Unit in Weight" := lrecUnitOfMeasure."B Unit in Weight"
            else
                "B Unit in Weight" := false;
            if lrecLotNoInfo.Get("Item No.", "Variant Code", "Lot No.") then
                "B Treatment Code" := lrecLotNoInfo."B Treatment Code"
            else
                "B Treatment Code" := '';
        end;
    end;

    local procedure fnSetBejoVEFieldValues(var parValueEntry: Record "Value Entry"; aItemJnlLine: Record "Item Journal Line"; aItemLedgEntry: Record "Item Ledger Entry")
    begin
        parValueEntry."B Unit in Weight" := aItemLedgEntry."B Unit in Weight";
        parValueEntry."B Treatment Code" := aItemLedgEntry."B Treatment Code";
    end;

    local procedure fnMarketPotentialCapClassTransl(Language: Integer; CaptionExpr: Text[80]) Result: Text[80]
    var
        TextInTime: Label 'in %1 yrs';
        TextHA: Label '(ha)';
        TextMIOperHA: Label '(mio/ha)';
        TextMIO: Label '(mio)';
        TextPerMIO: Label '(per mio)';
        TextOld: Label '(old)';
        TextNew: Label '(new)';
        "Text50030--1": Label 'Market Share (%)';
        "Text50030--2": Label 'Market Share (%)';
        "Text50030-100-0": Label 'Acreage';
        "Text50030-100-1": Label 'Total acreage';
        "Text50030-110-0": Label 'Sowing ratio';
        "Text50030-110-1": Label 'Total seed volume';
        "Text50030-120-0": Label 'Seed value';
        lrecBejoSetup: Record "Bejo Setup";
        lBaseCaption: Text[80];
        lUnitCaption: Text[80];
        lTextInTimeCaption: Text[80];
        lOldNewCaption: Text[80];
        lBaseCaptionExpr: Text[80];
        lUnitCaptionExpr: Text[80];
        lOldNewCaptionExpr: Text[80];
        lCommaPos: Integer;
        "Text50030-120-1": Label 'Total seed value';
        "Text50030-200-0": Label 'Acreage';
        "Text50030-200-1": Label 'Total acreage';
        "Text50030-210-0": Label 'Sowing ratio';
        "Text50030-210-1": Label 'Total seed volume';
        "Text50030-220-0": Label 'Seed value';
        "Text50030-220-1": Label 'Total seed value';
    begin

        lrecBejoSetup.Get;
        lCommaPos := StrPos(CaptionExpr, ',');
        if (lCommaPos > 0) and (lCommaPos <= MaxStrLen(lBaseCaptionExpr)) then begin
            lBaseCaptionExpr := CopyStr(CaptionExpr, 1, lCommaPos - 1);
            lUnitCaptionExpr := CopyStr(CaptionExpr, lCommaPos + 1, MaxStrLen(lUnitCaptionExpr));
        end else begin
            lBaseCaptionExpr := CopyStr(CaptionExpr, 1, MaxStrLen(lUnitCaptionExpr));
            lUnitCaptionExpr := '0,0';
        end;
        lCommaPos := StrPos(lUnitCaptionExpr, ',');
        if lCommaPos > 0 then begin
            lOldNewCaptionExpr := CopyStr(lUnitCaptionExpr, lCommaPos + 1);
            lUnitCaptionExpr := CopyStr(lUnitCaptionExpr, 1, lCommaPos - 1);
        end else begin
            lOldNewCaptionExpr := '0';
        end;
        lTextInTimeCaption := CopyStr(StrSubstNo(TextInTime, lrecBejoSetup."Years for Market Potential"), 1, MaxStrLen(lTextInTimeCaption));
        case lBaseCaptionExpr of
            '100':
                begin
                    if lUnitCaptionExpr = '1' then
                        lBaseCaption := "Text50030-100-1"
                    else
                        lBaseCaption := "Text50030-100-0";
                    lUnitCaption := TextHA;
                    lTextInTimeCaption := '';
                end;
            '110':
                begin
                    if lUnitCaptionExpr = '1' then begin
                        lBaseCaption := "Text50030-110-1";
                        lUnitCaption := TextMIO;
                    end else begin
                        lBaseCaption := "Text50030-110-0";
                        lUnitCaption := TextMIOperHA;
                    end;
                    lTextInTimeCaption := '';
                end;
            '120':
                begin
                    if lUnitCaptionExpr = '1' then begin
                        lBaseCaption := "Text50030-120-1";
                        lUnitCaption := '';
                    end else begin
                        lBaseCaption := "Text50030-120-0";
                        lUnitCaption := TextPerMIO;
                    end;
                    lTextInTimeCaption := '';
                end;
            '200':
                begin
                    if lUnitCaptionExpr = '1' then
                        lBaseCaption := "Text50030-200-1"
                    else
                        lBaseCaption := "Text50030-200-0";
                    lUnitCaption := TextHA;
                end;
            '210':
                begin
                    if lUnitCaptionExpr = '1' then begin
                        lBaseCaption := "Text50030-210-1";
                        lUnitCaption := TextMIO;
                    end else begin
                        lBaseCaption := "Text50030-210-0";
                        lUnitCaption := TextMIOperHA;
                    end;
                end;
            '220':
                begin
                    if lUnitCaptionExpr = '1' then begin
                        lBaseCaption := "Text50030-220-1";
                        lUnitCaption := ''
                    end else begin
                        lBaseCaption := "Text50030-220-0";
                        lUnitCaption := TextPerMIO;
                    end;
                end;
            '-1':
                begin
                    lBaseCaption := "Text50030--1";
                    lUnitCaption := '';
                    lTextInTimeCaption := '';
                end;
            '-2':
                begin
                    lBaseCaption := "Text50030--2";
                    lUnitCaption := '';
                end;
            else
                lBaseCaption := CaptionExpr;
        end;
        case lOldNewCaptionExpr of
            '1':
                lOldNewCaption := TextOld;
            '2':
                lOldNewCaption := TextNew;
            else
                lOldNewCaption := '';
        end;
        Result := lBaseCaption;
        if lTextInTimeCaption <> '' then
            Result := CopyStr(Result + ' ' + lTextInTimeCaption, 1, MaxStrLen(Result));
        if lUnitCaption <> '' then
            Result := CopyStr(Result + ' ' + lUnitCaption, 1, MaxStrLen(Result));
        if lOldNewCaption <> '' then
            Result := CopyStr(Result + ' ' + lOldNewCaption, 1, MaxStrLen(Result));

    end;

    local procedure fnMktPotCapClassTransl2(Language: Integer; CaptionExpr: Text[80]) Result: Text[80]
    var
        lrecVariety: Record Varieties;
        lCommaPos: Integer;
        lCropCode: Code[20];
        lCropTypeCode: Code[20];
    begin

        lCommaPos := StrPos(CaptionExpr, ',');
        if (lCommaPos > 0) and (lCommaPos <= MaxStrLen(lCropCode)) then begin
            lCropCode := CopyStr(CaptionExpr, 1, lCommaPos - 1);
            lCropTypeCode := CopyStr(CaptionExpr, lCommaPos + 1, MaxStrLen(lCropTypeCode));
        end else begin
            lCropCode := CopyStr(CaptionExpr, 1, MaxStrLen(lCropCode));
            lCropTypeCode := '';
        end;
        lrecVariety.SetCurrentKey("Crop Variant Code", "Crop Type Code");
        lrecVariety.SetRange("Crop Variant Code", lCropCode);
        if lCropTypeCode <> '' then
            lrecVariety.SetRange("Crop Type Code", lCropTypeCode);
        if not lrecVariety.FindFirst then begin
            lrecVariety.Init;
            lrecVariety."Crop Variant Description" := lCropCode;
            lrecVariety."Crop Type Description" := lCropTypeCode;
        end;
        if lCropTypeCode = '' then
            Result := lrecVariety."Crop Variant Description"
        else
            Result := CopyStr(StrSubstNo('%1 %2', lrecVariety."Crop Variant Description", lrecVariety."Crop Type Description"),
                            1, MaxStrLen(Result));
    end;

    local procedure fnSetSalesLineShipToCode(var Rec: Record "Sales Header"; var xRec: Record "Sales Header")
    var
        lrecSalesLine: Record "Sales Line";
    begin

        with Rec do begin
            if ("Document Type" = "Document Type"::Order) and
               (xRec."Ship-to Code" <> "Ship-to Code")
            then begin
                lrecSalesLine.SetRange("Document Type", lrecSalesLine."Document Type"::Order);
                lrecSalesLine.SetRange("Document No.", "No.");
                if lrecSalesLine.FindSet(true, false) then
                    repeat
                        lrecSalesLine.Validate("B Ship-to Code", "Ship-to Code");
                        lrecSalesLine.Modify;
                    until lrecSalesLine.Next = 0;
            end;
        end;
    end;

    local procedure fnSetSalesLineSalesPersonCode(var Rec: Record "Sales Header"; var xRec: Record "Sales Header")
    var
        lrecSalesLine: Record "Sales Line";
    begin

        with Rec do begin
            if ("Document Type" = "Document Type"::Order) and
               (xRec."Salesperson Code" <> "Salesperson Code")
            then begin
                lrecSalesLine.SetRange("Document Type", lrecSalesLine."Document Type"::Order);
                lrecSalesLine.SetRange("Document No.", "No.");
                if lrecSalesLine.FindSet(true, false) then
                    repeat
                        lrecSalesLine.Validate("B Salesperson", "Salesperson Code");
                        lrecSalesLine.Modify;
                    until lrecSalesLine.Next = 0;
            end
        end;
    end;

    local procedure fnGetSalesHeader(var parSalesLine: Record "Sales Line"; var parSalesHeader: Record "Sales Header"; var parCurrency: Record Currency)
    begin
        with parSalesLine do begin
            TestField("Document No.");
            if ("Document Type" <> parSalesHeader."Document Type") or ("Document No." <> parSalesHeader."No.") then begin
                parSalesHeader.Get("Document Type", "Document No.");
                if parSalesHeader."Currency Code" = '' then
                    parCurrency.InitRoundingPrecision
                else begin
                    parSalesHeader.TestField("Currency Factor");
                    parCurrency.Get(parSalesHeader."Currency Code");
                    parCurrency.TestField("Amount Rounding Precision");
                end;
            end;
        end;
    end;

    local procedure fnGetItem(var parSalesLine: Record "Sales Line"; var parItem: Record Item)
    begin
        with parSalesLine do begin
            TestField("No.");
            parItem.Get("No.");
        end;
    end;

    local procedure fnGetPurchHeader(var parPurchLine: Record "Purchase Line"; var parPurchHeader: Record "Purchase Header"; var parCurrency: Record Currency)
    begin
        with parPurchLine do begin
            TestField("Document No.");
            if ("Document Type" <> parPurchHeader."Document Type") or ("Document No." <> parPurchHeader."No.") then begin
                parPurchHeader.Get("Document Type", "Document No.");
                if parPurchHeader."Currency Code" = '' then
                    parCurrency.InitRoundingPrecision
                else begin
                    parPurchHeader.TestField("Currency Factor");
                    parCurrency.Get(parPurchHeader."Currency Code");
                    parCurrency.TestField("Amount Rounding Precision");
                end;
            end;
        end;
    end;

    local procedure fnUpdateBejoFieldsItmJnl(var parTrackingSpecification: Record "Tracking Specification")
    var
        lrecItemJnl: Record "Item Journal Line";
    begin
        with parTrackingSpecification do begin
            lrecItemJnl.SetRange("Journal Template Name", "Source ID");
            lrecItemJnl.SetRange("Journal Batch Name", "Source Batch Name");
            lrecItemJnl.SetRange("Line No.", "Source Ref. No.");
            if lrecItemJnl.FindFirst then begin
                lrecItemJnl."Lot No." := "Lot No.";
                lrecItemJnl.Modify;
            end;
        end;
    end;

    local procedure fnSetShipInvoiceReceiveFlags(var SalesHeader: Record "Sales Header"; var Ship: Boolean; var Invoice: Boolean; var Receive: Boolean)
    begin
        case SalesHeader."Document Type" of
            SalesHeader."Document Type"::Order:
                SalesHeader.Receive := false;
            SalesHeader."Document Type"::Invoice:
                begin
                    SalesHeader.Ship := true;
                    SalesHeader.Invoice := true;
                    SalesHeader.Receive := false;
                end;
            SalesHeader."Document Type"::"Return Order":
                SalesHeader.Ship := false;
            SalesHeader."Document Type"::"Credit Memo":
                begin
                    SalesHeader.Ship := false;
                    SalesHeader.Invoice := true;
                    SalesHeader.Receive := true;
                end;
        end;
    end;

    local procedure fnUpdateBlanketOrderLine(SalesLine: Record "Sales Line"; Ship: Boolean; Receive: Boolean; Invoice: Boolean)
    var
        BlanketOrderSalesLine: Record "Sales Line";
        xBlanketOrderSalesLine: Record "Sales Line";
        ModifyLine: Boolean;
        Sign: Decimal;
    begin
        if (SalesLine."Blanket Order No." <> '') and (SalesLine."Blanket Order Line No." <> 0) and
           ((Ship and (SalesLine."Qty. to Ship" <> 0)) or
            (Receive and (SalesLine."Return Qty. to Receive" <> 0)) or
            (Invoice and (SalesLine."Qty. to Invoice" <> 0)))
        then begin
            if BlanketOrderSalesLine.Get(
                 BlanketOrderSalesLine."Document Type"::"Blanket Order", SalesLine."Blanket Order No.",
                 SalesLine."Blanket Order Line No.")
            then begin

                ModifyLine := false;
                if Ship and (SalesLine."Shipment No." = '') then begin
                    ModifyLine := true;
                end;

                if Receive and (SalesLine."Return Receipt No." = '') then begin
                    ModifyLine := true;
                end;

                if Invoice then begin
                    ModifyLine := true;
                end;

                if ModifyLine then begin
                    BlanketOrderSalesLine."Qty. to Invoice" := 0;
                    BlanketOrderSalesLine."Qty. to Ship" := 0;
                    BlanketOrderSalesLine."Qty. to Invoice (Base)" := 0;
                    BlanketOrderSalesLine."Qty. to Ship (Base)" := 0;
                    BlanketOrderSalesLine.Modify;
                end;
            end;
        end;
    end;

    procedure fnGetPrepayUnpaidAmount(var pRec: Record "Sales Header"): Decimal
    var
        lrecSalesInvoiceHeader: Record "Sales Invoice Header";
        lrecCustLedgerEntry: Record "Cust. Ledger Entry";
        lrecSalesCrMemoHeader: Record "Sales Cr.Memo Header";
        lPrepayUnpaidAmount: Decimal;
    begin
        with pRec do begin

            lPrepayUnpaidAmount := 0;

            lrecSalesInvoiceHeader.SetCurrentKey("Prepayment Order No.", "Prepayment Invoice");
            lrecSalesInvoiceHeader.SetRange("Prepayment Order No.", "No.");
            if lrecSalesInvoiceHeader.FindFirst then
                repeat
                    lrecCustLedgerEntry.SetCurrentKey("Document No.", "Document Type", "Customer No.");
                    lrecCustLedgerEntry.SetRange("Document Type", lrecCustLedgerEntry."Document Type"::Invoice);
                    lrecCustLedgerEntry.SetRange("Document No.", lrecSalesInvoiceHeader."No.");
                    lrecCustLedgerEntry.SetRange("Customer No.", lrecSalesInvoiceHeader."Bill-to Customer No.");
                    if lrecCustLedgerEntry.FindFirst then begin
                        lrecCustLedgerEntry.CalcFields("Remaining Amount");
                        lPrepayUnpaidAmount += lrecCustLedgerEntry."Remaining Amount";
                    end;
                until lrecSalesInvoiceHeader.Next = 0;

            lrecSalesCrMemoHeader.SetCurrentKey("Prepayment Order No.");
            lrecSalesCrMemoHeader.SetRange("Prepayment Order No.", "No.");
            if lrecSalesCrMemoHeader.FindFirst then
                repeat
                    lrecCustLedgerEntry.SetCurrentKey("Document No.", "Document Type", "Customer No.");
                    lrecCustLedgerEntry.SetRange("Document Type", lrecCustLedgerEntry."Document Type"::"Credit Memo");
                    lrecCustLedgerEntry.SetRange("Document No.", lrecSalesCrMemoHeader."No.");
                    lrecCustLedgerEntry.SetRange("Customer No.", lrecSalesCrMemoHeader."Bill-to Customer No.");
                    if lrecCustLedgerEntry.FindFirst then begin
                        lrecCustLedgerEntry.CalcFields("Remaining Amount");
                        lPrepayUnpaidAmount += lrecCustLedgerEntry."Remaining Amount";
                    end;
                until lrecSalesCrMemoHeader.Next = 0;

            exit(lPrepayUnpaidAmount);

        end;
    end;

    procedure fnCheckOrderstatusReserved(var pRec: Record "Sales Header"; DoModify: Boolean)
    var
        lrecSalesLine: Record "Sales Line";
        lrecItem: Record Item;
        lrecItemTrackingCode: Record "Item Tracking Code";
        lAllReserved: Boolean;
        lrecbejosetup: Record "Bejo Setup";
    begin
        with pRec do begin

            lrecbejosetup.FindFirst;

            if ("Document Type" = "Document Type"::Order)
             and (lrecbejosetup."Validate Lot when OrderStaus=2")
             then begin
                if "B OrderStatus" in ["B OrderStatus"::"1.Entered", "B OrderStatus"::"2.Reserved"] then begin
                    lrecSalesLine.SetRange("Document Type", "Document Type");
                    lrecSalesLine.SetRange("Document No.", "No.");
                    lrecSalesLine.SetRange(Type, lrecSalesLine.Type::Item);
                    if lrecSalesLine.IsEmpty then
                        fnSetOrderstatusReserved(pRec, "B OrderStatus"::"1.Entered", DoModify)
                    else begin
                        lrecSalesLine.SetFilter("B Lot No.", '%1', '');
                        if lrecSalesLine.IsEmpty then
                            fnSetOrderstatusReserved(pRec, "B OrderStatus"::"2.Reserved", DoModify)
                        else begin
                            lrecSalesLine.FindSet;
                            repeat
                                lAllReserved := false;
                                if lrecItem.Get(lrecSalesLine."No.") then begin
                                    if lrecItemTrackingCode.Get(lrecItem."Item Tracking Code") then
                                        lAllReserved := not (lrecItemTrackingCode."Lot Specific Tracking")
                                    else
                                        lAllReserved := true;
                                end;
                            until (lrecSalesLine.Next = 0) or not lAllReserved;

                            if lAllReserved then
                                fnSetOrderstatusReserved(pRec, "B OrderStatus"::"2.Reserved", DoModify)
                            else
                                fnSetOrderstatusReserved(pRec, "B OrderStatus"::"1.Entered", DoModify);
                        end;
                    end;
                end;
            end;

        end;
    end;

    local procedure fnSetOrderstatusReserved(var pRec: Record "Sales Header"; NewOrderStatus: Option "0","1","2","3","4","5","6","7","8","9"; DoModify: Boolean)
    begin
        with pRec do begin

            if "B OrderStatus" <> NewOrderStatus then begin
                "B OrderStatus" := NewOrderStatus;
                if DoModify then
                    Modify;
            end;

        end;
    end;

    local procedure fnCheckCreateProgAllocRec(parCustNo: Code[20]; parSalesperson: Code[10]; parItemNo: Code[20])
    var
        lrecBejoSetup: Record "Bejo Setup";
        lrecProgAllocEntry: Record "Prognosis/Allocation Entry";
    begin

        lrecBejoSetup.Get;

        if lrecBejoSetup."SO Post Alloc Rec Auto-Create" > 0 then
            with lrecProgAllocEntry do begin
                SetCurrentKey("Entry Type", "Item No.", Salesperson, Customer, "Unit of Measure", "Sales Date");
                SetRange("Entry Type", "Entry Type"::Allocation);
                SetRange("Item No.", parItemNo);
                SetRange(Salesperson, parSalesperson);
                if lrecBejoSetup."SO Post Alloc Rec Auto-Create" > 1 then
                    SetRange(Customer, parCustNo);
                SetRange("Sales Date", lrecBejoSetup."End Date");
                if FindFirst then
                    exit;

                Reset;
                "Entry Type" := "Entry Type"::Allocation;
                "Item No." := parItemNo;
                Salesperson := parSalesperson;
                if lrecBejoSetup."SO Post Alloc Rec Auto-Create" > 1 then
                    Customer := parCustNo;
                "Sales Date" := lrecBejoSetup."End Date";
                Variety := CopyStr("Item No.", 1, 5);
                "Begin Date" := lrecBejoSetup."Begin Date";
                "User-ID" := UserId;
                "Date Modified" := Today;
                Description := 'SO Posting Auto-Created';
                Insert(true);
            end;

    end;

    local procedure fnCheckReasonCode(SalesLine: Record "Sales Line")
    var
        lrecBejoSetup: Record "Bejo Setup";
        lCheckIt: Boolean;
    begin

        lrecBejoSetup.Get;

        if lrecBejoSetup."Enforce SO Reason Code" > 0 then begin
            lCheckIt := false;
            case lrecBejoSetup."Enforce SO Reason Code" of
                lrecBejoSetup."Enforce SO Reason Code"::Item:
                    if SalesLine.Type = SalesLine.Type::Item then
                        lCheckIt := true;
                lrecBejoSetup."Enforce SO Reason Code"::"G/L Acct":
                    if SalesLine.Type = SalesLine.Type::"G/L Account" then
                        lCheckIt := true;
                lrecBejoSetup."Enforce SO Reason Code"::"Item and G/L Acct":
                    if (SalesLine.Type = SalesLine.Type::"G/L Account") or (SalesLine.Type = SalesLine.Type::Item) then
                        lCheckIt := true;
            end;
            if lCheckIt then
                SalesLine.TestField("B Reason Code");
        end;

    end;

    local procedure fnBlockAllocationExceeded(SalesLine: Record "Sales Line")
    var
        lrecBejoSetup: Record "Bejo Setup";
    begin

        lrecBejoSetup.Get;

        if lrecBejoSetup."BlockPostSales if AllocExceed" then
            SalesLine.TestField("B Allocation Exceeded", false);

    end;

    procedure GetCurrentItemJnlRecord(var parItemJnlRecord: Record "Item Journal Line")
    begin
        parItemJnlRecord := gCurrentItemJnlRecord;
    end;

    local procedure SetCurrentItemJnlRecord(var parItemJnlRecord: Record "Item Journal Line")
    begin
        gCurrentItemJnlRecord := parItemJnlRecord;
    end;

    //[EventSubscriber(ObjectType::Table, 50008, 'BejoMgt_GetDomainUserSID', '', false, false)]
    //local procedure BejoMgtGetDomainUserSID(var parUserSID: Text[119])
    //var
    //    lcuBejoManagement: Codeunit "Bejo Management";
    //begin
    //    lcuBejoManagement.GetDomainUserSID(parUserSID);
    //end;

    [EventSubscriber(ObjectType::Table, 50018, 'SendMailAtAllocating', '', false, false)]
    local procedure SendMailAtAllocating(Rec: Record "Prognosis/Allocation Entry"; xRec: Record "Prognosis/Allocation Entry"; Leftover: Decimal; Item: Record Item)
    var
        BejoSetup: Record "Bejo Setup";
        lcuBejoMgt: Codeunit "Bejo Management";
    begin
        if (not Item.Blocked) and (Leftover >= 0) then begin
            BejoSetup.Get;
            //if BejoSetup."Mail Allocation Change" then
            //    lcuBejoMgt.SendMailAtAllocating(Rec, xRec);
        end;
    end;

    [EventSubscriber(ObjectType::Table, 50026, 'CalcPrognosis', '', false, false)]
    local procedure CalcPrognosis(Rec: Record "Market Potential"; var Result: Decimal)
    var
        lFromDate: Date;
        lToDate: Date;
        lcduMarketPotentialMgt: Codeunit "Market Potential Mgt.";
    begin
        lFromDate := DMY2Date(1, 9, Rec.Year);
        lToDate := DMY2Date(31, 8, Rec.Year + 1);
        Result := lcduMarketPotentialMgt.CalcPrognosis(Rec."Crop Variant Code", Rec."Crop Type", lFromDate, lToDate);
    end;

    [EventSubscriber(ObjectType::Table, 37, 'SalesLineLotNoLookup', '', false, false)]
    procedure SalesLineLotNoLookup(var Rec: Record "Sales Line")
    var
        SaleschargesItemTracking: Codeunit "Sales charges - Item Tracking";
    begin
        SaleschargesItemTracking.LotNoLookup(Rec);
    end;

    [EventSubscriber(ObjectType::Table, 83, 'LotNoLookupItmJn', '', false, false)]
    procedure LotNoLookupItmJn(var Rec: Record "Item Journal Line")
    var
        tempReservEntry: Record "Reservation Entry" temporary;
        tempEntrySummary: Record "Entry Summary" temporary;
        itemTrackingSummaryForm: Page "Item Tracking Summary";
        SaleschargesItemTracking: Codeunit "Sales charges - Item Tracking";
    begin
        SaleschargesItemTracking.LotNoLookupItmJn(Rec);
    end;

    local procedure CheckSalesPrice(SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
        ItemLedgerEntry: Record "Item Ledger Entry";
        Item: Record Item;
        BEJOSetup: Record "Bejo Setup";
        ctxBlock: Label 'The Sales Price for Item %1 is less then the Cost of Goods.';
        ctxWarning: Label 'The Sales Price for Item %1 is less then the Cost of Goods, Continue?';
    begin

        BEJOSetup.Get();
        if BEJOSetup."Sales Line Check Price" <> BEJOSetup."Sales Line Check Price"::" " then begin

            SalesLine.SetRange("Document Type", SalesHeader."Document Type");
            SalesLine.SetRange("Document No.", SalesHeader."No.");
            SalesLine.SetRange(Type, SalesLine.Type::Item);
            if SalesLine.FindSet then
                repeat

                    if Item.Get(SalesLine."No.") then
                        if SalesLine."Location Code" <> BEJOSetup."Sample Location" then
                            if SalesLine."Gen. Prod. Posting Group" = Item."Gen. Prod. Posting Group" then begin

                                Clear(ItemLedgerEntry);
                                ItemLedgerEntry.SetRange("Item No.", SalesLine."No.");
                                ItemLedgerEntry.SetRange("Location Code", SalesLine."Location Code");
                                ItemLedgerEntry.SetRange("Lot No.", SalesLine."B Lot No.");
                                ItemLedgerEntry.SetRange(Open, true);
                                ItemLedgerEntry.SetFilter(Quantity, '<>%1', 0);
                                if ItemLedgerEntry.FindFirst then begin
                                    ItemLedgerEntry.CalcFields("Cost Amount (Expected)", "Cost Amount (Actual)");
                                    if SalesLine."Unit Price" <= (ItemLedgerEntry."Cost Amount (Expected)" +
                                                                 ItemLedgerEntry."Cost Amount (Actual)") *
                                                                 ItemLedgerEntry."Qty. per Unit of Measure" / ItemLedgerEntry.Quantity then begin

                                        if BEJOSetup."Sales Line Check Price" = BEJOSetup."Sales Line Check Price"::Block then
                                            Error(ctxBlock, SalesLine."No.");

                                        if BEJOSetup."Sales Line Check Price" = BEJOSetup."Sales Line Check Price"::Warning then
                                            if not Confirm(ctxWarning, true, SalesLine."No.") then
                                                Error('');

                                    end;
                                end;
                            end;

                until SalesLine.Next = 0;

        end;
    end;
}

