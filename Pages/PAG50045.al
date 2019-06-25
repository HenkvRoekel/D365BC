page 50045 "Item Tracking per Order"
{

    AutoSplitKey = true;
    Caption = 'Sales Order Subform';
    DelayedInsert = false;
    MultipleNewLines = true;
    RefreshOnActivate = true;
    SourceTable = "Sales Line";

    layout
    {
        area(content)
        {
            group(Control17)
            {
                ShowCaption = false;
                field("gRecSalesHdr.""No."""; gRecSalesHdr."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("gRecSalesHdr.""Sell-to Customer No."""; gRecSalesHdr."Sell-to Customer No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("gRecSalesHdr.""Sell-to Customer Name"""; gRecSalesHdr."Sell-to Customer Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("gRecSalesHdr.""External Document No."""; gRecSalesHdr."External Document No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("gRecSalesHdr.""B Order Type"""; gRecSalesHdr."B Order Type")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("gRecSalesHdr.""Posting Date"""; gRecSalesHdr."Posting Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("gRecSalesHdr.""Shipment Date"""; gRecSalesHdr."Shipment Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("gRecSalesHdr.""Customer Price Group"""; gRecSalesHdr."Customer Price Group")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            repeater(Control1)
            {
                ShowCaption = false;
                field(Type; Type)
                {
                    ApplicationArea = All;
                }
                field("No."; "No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        ShowShortcutDimCode(ShortcutDimCode);
                        NoOnAfterValidate;
                    end;
                }
                field("Document No."; "Document No.")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Description 2"; "Description 2")
                {
                    ApplicationArea = All;
                }
                field("RecArtExtensie.""Extension Code"""; RecArtExtensie."Extension Code")
                {
                    Caption = 'Description 3';
                    ApplicationArea = All;
                }
                field("B Allocation Exceeded"; "B Allocation Exceeded")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Quantity)
                {
                    BlankZero = true;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        QuantityOnAfterValidate;
                    end;
                }
                field("Shipment Date"; "Shipment Date")
                {
                    Editable = false;
                    Style = Attention;
                    StyleExpr = ShowRed;
                    ApplicationArea = All;
                }
                field("Unit Price"; "Unit Price")
                {
                    BlankZero = true;
                    ApplicationArea = All;
                }
                field("B Line type"; "B Line type")
                {
                    ApplicationArea = All;
                }
                field(Reserve; Reserve)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("B Ship-to Code"; "B Ship-to Code")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("B Lot No."; "B Lot No.")
                {
                    ApplicationArea = All;
                }
                field("B Tracking Quantity"; "B Tracking Quantity")
                {
                    BlankZero = true;
                    ApplicationArea = All;
                }
                field("Reserved Quantity"; "Reserved Quantity")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Outstanding Qty. (Base)"; "Outstanding Qty. (Base)")
                {
                    BlankZero = true;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Location Code"; "Location Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Bin Code"; "Bin Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("B Characteristic"; "B Characteristic")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Line Amount"; "Line Amount")
                {
                    BlankZero = true;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Line Discount %"; "Line Discount %")
                {
                    BlankZero = true;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Line Discount Amount"; "Line Discount Amount")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("B External Document No."; "B External Document No.")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field(PromoLand; PromoLand)
                {
                    Caption = 'Promostatus';
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        ShowShortcutDimCode(ShortcutDimCode);
                    end;
                }
                field("Qty. to Ship"; "Qty. to Ship")
                {
                    BlankZero = true;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Quantity Shipped"; "Quantity Shipped")
                {
                    BlankZero = true;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Qty. to Invoice"; "Qty. to Invoice")
                {
                    BlankZero = true;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Quantity Invoiced"; "Quantity Invoiced")
                {
                    BlankZero = true;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Allow Item Charge Assignment"; "Allow Item Charge Assignment")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Qty. to Assign"; "Qty. to Assign")
                {
                    BlankZero = true;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin
                        CurrPage.SaveRecord;
                        ShowItemChargeAssgnt;
                        UpdatePage(false);
                    end;
                }
                field("Qty. Assigned"; "Qty. Assigned")
                {
                    BlankZero = true;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin
                        CurrPage.SaveRecord;
                        ShowItemChargeAssgnt;
                        CurrPage.Update(false);
                    end;
                }
                field("Requested Delivery Date"; "Requested Delivery Date")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Promised Delivery Date"; "Promised Delivery Date")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Planned Delivery Date"; "Planned Delivery Date")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Planned Shipment Date"; "Planned Shipment Date")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shipping Agent Code"; "Shipping Agent Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shipping Agent Service Code"; "Shipping Agent Service Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shipping Time"; "Shipping Time")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Whse. Outstanding Qty. (Base)"; "Whse. Outstanding Qty. (Base)")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Outbound Whse. Handling Time"; "Outbound Whse. Handling Time")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Blanket Order No."; "Blanket Order No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Blanket Order Line No."; "Blanket Order Line No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("FA Posting Date"; "FA Posting Date")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Depr. until FA Posting Date"; "Depr. until FA Posting Date")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Depreciation Book Code"; "Depreciation Book Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Use Duplication List"; "Use Duplication List")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Duplicate in Depreciation Book"; "Duplicate in Depreciation Book")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Appl.-from Item Entry"; "Appl.-from Item Entry")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Appl.-to Item Entry"; "Appl.-to Item Entry")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("ShortcutDimCode[3]"; ShortcutDimCode[3])
                {
                    CaptionClass = '1,2,3';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        LookupShortcutDimCode(3, ShortcutDimCode[3]);
                    end;

                    trigger OnValidate()
                    begin
                        ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                    end;
                }
                field("ShortcutDimCode[4]"; ShortcutDimCode[4])
                {
                    CaptionClass = '1,2,4';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        LookupShortcutDimCode(4, ShortcutDimCode[4]);
                    end;

                    trigger OnValidate()
                    begin
                        ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                    end;
                }
                field("ShortcutDimCode[5]"; ShortcutDimCode[5])
                {
                    CaptionClass = '1,2,5';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        LookupShortcutDimCode(5, ShortcutDimCode[5]);
                    end;

                    trigger OnValidate()
                    begin
                        ValidateShortcutDimCode(5, ShortcutDimCode[5]);
                    end;
                }
                field("ShortcutDimCode[6]"; ShortcutDimCode[6])
                {
                    CaptionClass = '1,2,6';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        LookupShortcutDimCode(6, ShortcutDimCode[6]);
                    end;

                    trigger OnValidate()
                    begin
                        ValidateShortcutDimCode(6, ShortcutDimCode[6]);
                    end;
                }
                field("ShortcutDimCode[7]"; ShortcutDimCode[7])
                {
                    CaptionClass = '1,2,7';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        LookupShortcutDimCode(7, ShortcutDimCode[7]);
                    end;

                    trigger OnValidate()
                    begin
                        ValidateShortcutDimCode(7, ShortcutDimCode[7]);
                    end;
                }
            }
            group(Control3)
            {
                ShowCaption = false;
            }
            part(ItemTrackingSummarySubf; "Item Tracking Summary Subform")
            {
                SubPageLink = "B Item No." = FIELD ("No.");
                UpdatePropagation = Both;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateTrackSum(true);
    end;

    trigger OnAfterGetRecord()
    begin
        ShowShortcutDimCode(ShortcutDimCode);
        ShowLotnr;


        if not SalesHeader.Get("Document Type", "Document No.") then
            SalesHeader.Init;
        if not RecArtikel.Get("No.") then
            RecArtikel.Init;
        if not RecArtExtensie.Get(RecArtikel."B Extension", SalesHeader."Language Code") then
            RecArtExtensie.Init;

        if "Sell-to Customer No." <> '' then
            if not Customer.Get("Sell-to Customer No.") then
                Customer.Init;

        ShipmentDateOnPageat;

        ShowRed := "Shipment Date" < Today;


        if gRecSalesHdr.Get("Document Type", "No.") then;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        SelectedLineChanged := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin


        Type := xRec.Type;
        Clear(ShortcutDimCode);
        Clear(Customer);

    end;

    trigger OnOpenPage()
    begin
        OnActivatePage;
    end;

    var
        SalesHeader: Record "Sales Header";
        SalesPriceCalcMgt: Codeunit "Sales Price Calc. Mgt.";
        TransferExtendedText: Codeunit "Transfer Extended Text";
        ShortcutDimCode: array[8] of Code[20];
        RecArtExtensie: Record "Item Extension";
        RecArtikel: Record Item;
        PrevPosition: Text[1024];
        SubformActive: Boolean;
        SelectedLineChanged: Boolean;
        Customer: Record Customer;
        Mailto: Boolean;
        PromoLand: Option "0:New Bejonr.","1:No seed","2:Internal trials","3:Introduction trials","4:Promotional trials","5:Limited sales","6:Full sales","7:Over the top","8:To be discontinued","9:Gone",,,"niet aanwezig";
        ShowRed: Boolean;
        gRecSalesHdr: Record "Sales Header";
        grecReservationEntryTemp: Record "Reservation Entry" temporary;
        grecEntrySummaryTemp: Record "Entry Summary" temporary;

    procedure ApproveCalcInvDisc()
    begin
        CODEUNIT.Run(CODEUNIT::"Sales-Disc. (Yes/No)", Rec);
    end;

    procedure CalcInvDisc()
    begin
        CODEUNIT.Run(CODEUNIT::"Sales-Calc. Discount", Rec);
    end;

    procedure ExplodeBOM()
    begin
        CODEUNIT.Run(CODEUNIT::"Sales-Explode BOM", Rec);
    end;

    procedure OpenPurchOrderPage()
    var
        PurchHeader: Record "Purchase Header";
        PurchOrder: Page "Purchase Order";
    begin
        PurchHeader.SetRange("No.", "Purchase Order No.");
        PurchOrder.SetTableView(PurchHeader);
        PurchOrder.Editable := false;
        PurchOrder.Run;
    end;

    procedure OpenSpecialPurchOrderPage()
    var
        PurchHeader: Record "Purchase Header";
        PurchOrder: Page "Purchase Order";
    begin
        PurchHeader.SetRange("No.", "Special Order Purchase No.");
        PurchOrder.SetTableView(PurchHeader);
        PurchOrder.Editable := false;
        PurchOrder.Run;
    end;

    procedure InsertExtendedText(Unconditionally: Boolean)
    begin
        if TransferExtendedText.SalesCheckIfAnyExtText(Rec, Unconditionally) then begin
            CurrPage.SaveRecord;
            TransferExtendedText.InsertSalesExtText(Rec);
        end;
        if TransferExtendedText.MakeUpdate then
            UpdatePage(true);
    end;

    procedure ShowReservation()
    begin
        Find;
        Rec.ShowReservation;
    end;

    procedure ShowReservationEntries()
    begin
        Rec.ShowReservationEntries(true);
    end;

    procedure ShowDimensions()
    begin
        Rec.ShowDimensions;
    end;

    procedure ShowItemSub()
    begin
        ShowItemSub;
    end;

    procedure ShowNonstockItems()
    begin
        Rec.ShowNonstock;
    end;

    procedure OpenItemTrackingLines()
    var
        lcuSaleschargesItemTracking: Codeunit "Sales charges - Item Tracking";
    begin
        Rec.OpenItemTrackingLines;
        lcuSaleschargesItemTracking.UpdateBejoFields(Rec);
    end;

    procedure ShowTracking()
    var
        TrackingPage: Page "Order Tracking";
    begin
        TrackingPage.SetSalesLine(Rec);
        TrackingPage.RunModal;
    end;

    procedure ItemChargeAssgnt()
    begin
        Rec.ShowItemChargeAssgnt;
    end;

    procedure UpdatePage(SetSaveRecord: Boolean)
    begin
        CurrPage.Update(SetSaveRecord);

    end;

    procedure ShowPrices()
    begin
        SalesHeader.Get("Document Type", "Document No.");
        SalesPriceCalcMgt.GetSalesLinePrice(SalesHeader, Rec);
    end;

    procedure ShowLineDisc()
    begin
        SalesHeader.Get("Document Type", "Document No.");
        SalesPriceCalcMgt.GetSalesLineLineDisc(SalesHeader, Rec);
    end;

    procedure ShowLotnr()
    var
        ReservationEntry: Record "Reservation Entry";
        ObjItemTracking: Codeunit "Sales charges - Item Tracking";
    begin
        if ("B Lot No." = '') and ("B Tracking Quantity" <> 0) then begin
            if not ReservationEntry.SetCurrentKey("Source ID") then
                ReservationEntry.SetCurrentKey("Source Type");

            ReservationEntry.SetRange("Source ID", "Document No.");
            ReservationEntry.SetRange("Source Ref. No.", "Line No.");
            if ReservationEntry.Find('-') then begin
                "B Lot No." := ReservationEntry."Lot No.";

                "Bin Code" := ObjItemTracking.GetBin(ReservationEntry);
            end;
        end;
    end;

    procedure IsSubformActive(): Boolean
    begin

        exit(SubformActive);
    end;

    procedure IsSelectedLineChanged() UpdateNeeded: Boolean
    begin

        UpdateNeeded := SelectedLineChanged;
        Clear(SelectedLineChanged);
    end;

    local procedure NoOnAfterValidate()
    begin
        InsertExtendedText(false);

        CurrPage.SaveRecord;
    end;

    local procedure QuantityOnAfterValidate()
    begin
        CurrPage.Update;
    end;

    local procedure OnAfterGetCurrRecord__()
    begin
        xRec := Rec;


        if PrevPosition <> GetPosition then
            SelectedLineChanged := true;

        PrevPosition := GetPosition;

    end;

    local procedure OnDeactivatePage()
    begin
        SubformActive := false;
    end;

    local procedure OnActivatePage()
    begin
        SubformActive := true;
    end;

    local procedure ShipmentDateOnPageat()
    begin
        if "Shipment Date" < Today then;
    end;

    procedure SetOrder(var lSalesHdr: Record "Sales Header")
    begin

        gRecSalesHdr := lSalesHdr;
        FilterGroup(2);
        SetRange("Document Type", gRecSalesHdr."Document Type");
        SetRange("Document No.", lSalesHdr."No.");
        FilterGroup(0);

    end;

    procedure UpdateTrackSum(alwaysUpdate: Boolean)
    var
        TempReservEntry: Record "Reservation Entry" temporary;
        TempEntrySummary: Record "Entry Summary" temporary;
        Salescharges: Codeunit "Sales charges - Item Tracking";
        lRecReservationEntryTemp: Record "Reservation Entry" temporary;
    begin

        Salescharges.UpdateWhseTrackingSummarySlsLn(TempReservEntry, TempEntrySummary, Rec, '');
        grecReservationEntryTemp.Reset;
        grecReservationEntryTemp.DeleteAll;
        if TempReservEntry.FindFirst then repeat
                                              grecReservationEntryTemp.TransferFields(TempReservEntry);
                                              grecReservationEntryTemp.Insert;
            until TempReservEntry.Next = 0;

        grecEntrySummaryTemp.Reset;
        grecEntrySummaryTemp.DeleteAll;
        if TempEntrySummary.FindFirst then repeat
                                               grecEntrySummaryTemp.TransferFields(TempEntrySummary);
                                               grecEntrySummaryTemp.Insert;
            until TempEntrySummary.Next = 0;
        Commit;
        CurrPage.ItemTrackingSummarySubf.PAGE.SetSources(TempReservEntry, TempEntrySummary);
        TempEntrySummary.Reset;
        if TempEntrySummary.FindFirst then
            CurrPage.ItemTrackingSummarySubf.PAGE.SetRecord(TempEntrySummary);

    end;
}

