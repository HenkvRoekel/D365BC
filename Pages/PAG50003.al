page 50003 "Lot No. Information Card Bejo"
{

    Caption = 'Lot No. Information Card';
    Editable = false;
    PageType = Card;
    PopulateAllFields = true;
    SourceTable = "Lot No. Information";
    SourceTableView = SORTING ("Lot No.");

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Lot No."; "Lot No.")
                {
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("Item No."; "Item No.")
                {
                    ApplicationArea = All;
                }
                field("B Description 1"; "B Description 1")
                {
                    ApplicationArea = All;
                }
                field("B Description 2"; "B Description 2")
                {
                    ApplicationArea = All;
                }
                field("grecItem.""B Promo Status"" + ': ' + grecItem.""B Promo Status Description"""; grecItem."B Promo Status" + ': ' + grecItem."B Promo Status Description")
                {
                    Caption = 'Promo Status';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("gcuBlockingMgt.ItemBlockDescription(grecItem)"; gcuBlockingMgt.ItemBlockDescription(grecItem))
                {
                    Caption = 'Blocking Code';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Test Quality"; "Test Quality")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Certificate Number"; "Certificate Number")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Blocked; Blocked)
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure"; grecItemLedgerEntry."Unit of Measure Code")
                {
                    Caption = 'Unit of Measure';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Qty. per Unit of Measure"; grecItemLedgerEntry."Qty. per Unit of Measure")
                {
                    Caption = 'Qty. per Unit of Measure';
                    DecimalPlaces = 0 : 2;
                    Editable = false;
                    ApplicationArea = All;
                }
                field(gCountryOfOrigin; gCountryOfOrigin)
                {
                    Caption = 'Country of Origin';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(gPhytoCertificate; gPhytoCertificate)
                {
                    Caption = 'Phyto Certificate';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("grecItemExtension.Description"; grecItemExtension.Description)
                {
                    Caption = 'Item Extension';
                    ApplicationArea = All;
                }
                field("""B Treatment Code""+' ' +grecTreatmentCode.Description"; "B Treatment Code" + ' ' + grecTreatmentCode.Description)
                {
                    Caption = 'Treatment';
                    ApplicationArea = All;
                }
                field("B Tsw. in gr."; "B Tsw. in gr.")
                {
                    DecimalPlaces = 2 : 5;
                    Editable = false;
                    ApplicationArea = All;
                }
                field("""B Germination""*100"; "B Germination" * 100)
                {
                    Caption = 'Germination';
                    ExtendedDatatype = Ratio;
                    ApplicationArea = All;
                }
                field("""B Abnormals""*100"; "B Abnormals" * 100)
                {
                    Caption = 'Abnormals';
                    ExtendedDatatype = Ratio;
                    ApplicationArea = All;
                }
                field("grecGrade.Description"; grecGrade.Description)
                {
                    Caption = 'Grade';
                    ApplicationArea = All;
                }
                field("B Best used by"; "B Best used by")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("B Remark"; "B Remark")
                {
                    ApplicationArea = All;
                }
                field("B Multi Germination"; "B Multi Germination")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("B Text for SalesOrders"; "B Text for SalesOrders")
                {
                    ApplicationArea = All;
                }
            }
            group(Control1904162201)
            {
                Caption = 'Inventory';
                field(Inventory; Inventory)
                {
                    ApplicationArea = All;
                }
                field("B Tracking Quantity"; "B Tracking Quantity")
                {
                    ApplicationArea = All;
                }
                field("Expired Inventory"; "Expired Inventory")
                {
                    ApplicationArea = All;
                }
            }
            part(Control8; "Bin Contents List")
            {
                Editable = false;
                SubPageLink = "Item No." = FIELD ("Item No."),
                              "Lot No. Filter" = FIELD ("Lot No.");
                SubPageView = SORTING ("Location Code", "Item No.", "Variant Code", "Cross-Dock Bin", "Qty. per Unit of Measure", "Bin Ranking")
                              WHERE (Quantity = FILTER (<> 0));
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Lot &No.")
            {
                Caption = 'Lot &No.';
                action("Item &Tracking Entries")
                {
                    Caption = 'Item &Tracking Entries';
                    Image = ItemTrackingLedger;
                    ShortCutKey = 'Ctrl+F7';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        LocalisationCdu: Codeunit "Localisation Codeunit";
                    begin
                        LocalisationCdu.P50003_ShowItemTrackingForMasterData(0, '', "Item No.", "Variant Code", '', "Lot No.", ''); //BEJOW19.00.025
                    end;
                }
                action(Comment)
                {
                    Caption = 'Comment';
                    Image = Comment;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        LocalisationCodeunit: Codeunit "Localisation Codeunit";
                    begin
                        LocalisationCodeunit.P50003_ShowItemTrackingComments(Rec); //BEJOW18.00.025
                    end;
                }
                separator(Separator1000000020)
                {
                }
                action(History)
                {
                    Caption = 'History';
                    Image = History;
                    RunObject = Page "Item Ledger Entries";
                    RunPageLink = "Item No." = FIELD ("Item No."),
                                  "Lot No." = FIELD ("Lot No.");
                    RunPageView = SORTING ("Item No.", "Location Code", Open, "Variant Code", "Unit of Measure Code", "Lot No.", "Serial No.");
                    ApplicationArea = All;
                }
            }
            group("&Bejo")
            {
                Caption = '&Bejo';
                action("Print Lot &History")
                {
                    Caption = 'Print Lot &History';
                    Ellipsis = true;
                    Image = LotInfo;
                    RunObject = Report "Lot History";
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin

        if not grecItem.Get("Item No.") then
            grecItem.Init;

        if not grecItemLedgerEntry.SetCurrentKey("Item No.", Open) then
            grecItemLedgerEntry.SetCurrentKey("Item No.", "Variant Code", Open);
        grecItemLedgerEntry.SetRange("Item No.", "Item No.");
        grecItemLedgerEntry.SetRange(Open, true);
        grecItemLedgerEntry.SetRange("Lot No.", "Lot No.");
        if not grecItemLedgerEntry.FindFirst then
            grecItemLedgerEntry.Init;
        if not grecGrade.Get("B Grade Code") then
            grecGrade.Init;
        if not grecTreatmentCode.Get("B Treatment Code") then
            grecTreatmentCode.Init;


        if not grecItemExtension.Get(grecItem."B Extension", '') then
            grecItemExtension.Init;

        if grecItem."B Organic" then
            grecItemExtension.Description := '';

        if grecItem."B Organic" then
            grecItemExtension.Description := '';

        grecItem.CalcFields("B Promo Status");
        grecItem.CalcFields("B Promo Status Description");

        gCountryOfOrigin := '';
        gPhytoCertificate := '';
        gShipmentNotification.Reset;
        gShipmentNotification.SetRange("Lot No.", "Lot No.");
        if gShipmentNotification.FindSet then begin
            repeat
                if gCountryOfOrigin = '' then
                    gCountryOfOrigin := gShipmentNotification."Country of Origin"
                else
                    gCountryOfOrigin := gCountryOfOrigin + ', ' + gShipmentNotification."Country of Origin";
                gPhytoCertificate := gShipmentNotification."Phyto Certificate No.";
            until gShipmentNotification.Next = 0;
        end;

    end;

    trigger OnOpenPage()
    begin
        SetRange("Date Filter", 00000101D, WorkDate);
    end;

    var
        grecItem: Record Item;
        grecItemLedgerEntry: Record "Item Ledger Entry";
        grecGrade: Record Grade;
        grecTreatmentCode: Record "Treatment Code";
        grecItemExtension: Record "Item Extension";
        gcuBlockingMgt: Codeunit "Blocking Management";
        gCountryOfOrigin: Code[30];
        gPhytoCertificate: Code[20];
        gShipmentNotification: Record "Shipment Notification";
}

