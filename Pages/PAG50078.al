page 50078 "Purchase Orders Preview"
{

    AutoSplitKey = true;
    Caption = 'Purchase Orders Preview';
    InsertAllowed = true;
    PageType = List;
    SourceTable = "Imported Purchase Lines";
    SourceTableView = SORTING ("Document Type", "Document No.", "Line No.")
                      WHERE ("Purchase Order Created" = CONST (false));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Document Type"; "Document Type")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Document No."; "Document No.")
                {
                    ApplicationArea = All;
                }
                field("Line No."; "Line No.")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Customer No. BejoNL"; "Customer No. BejoNL")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Type; Type)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("No."; "No.")
                {
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
                field("grecItemExtension.""Extension Code"""; grecItemExtension."Extension Code")
                {
                    Caption = 'Description 3';
                    ApplicationArea = All;
                }
                field("grecVarieties.DisplayPromoStatus"; grecVarieties.DisplayPromoStatus)
                {
                    Caption = 'Promo Status';
                    ApplicationArea = All;
                }
                field(ImpPurchaseLineBlockDescr; gcuBlockingMgt.ImpPurchaseLineBlockDescr(Rec))
                {
                    Caption = 'Blocking Code';
                    ApplicationArea = All;
                }
                field("Line type"; "Line type")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; "Location Code")
                {
                    ApplicationArea = All;
                }
                field("Bin Code"; "Bin Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Box No."; "Box No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("External Document No."; "External Document No.")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Qty. per Unit of Measure"; "Qty. per Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field("Requested Receipt Date"; "Requested Receipt Date")
                {
                    ApplicationArea = All;
                }
                field("Qty. to Receive"; "Qty. to Receive")
                {
                    ApplicationArea = All;
                }
                field("Qty. to Receive (Base)"; "Qty. to Receive (Base)")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Original Prognoses"; "Original Prognoses")
                {
                    ApplicationArea = All;
                }
                field(Prognoses; grecItem."B Prognoses")
                {
                    BlankZero = true;
                    Caption = 'Prognoses Season';
                    DecimalPlaces = 0 : 4;
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Comment; Comment)
                {
                    ApplicationArea = All;
                }
                field("Allocation exceeded"; "Allocation exceeded")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Order Address Code"; "Order Address Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Best used by"; "Best used by")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Purchase Order Created"; "Purchase Order Created")
                {
                    Caption = 'Sales line created';
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field(gDeficit; gDeficit)
                {
                    BlankZero = true;
                    Caption = 'Deficit';
                    DecimalPlaces = 0 : 4;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field(gUsed; gUsed)
                {
                    Caption = '% Used';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("grecItem.""B Country allocated"""; grecItem."B Country allocated")
                {
                    BlankZero = true;
                    Caption = 'Allocation';
                    DecimalPlaces = 0 : 4;
                    Editable = false;
                    ApplicationArea = All;
                }
                field("grecItem.""Purchases (Qty.)"""; grecItem."Purchases (Qty.)")
                {
                    BlankZero = true;
                    Caption = 'Purchases';
                    DecimalPlaces = 0 : 4;
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin

                        DrilldownField(grecItem.FieldNo("Purchases (Qty.)"));

                    end;
                }
                field("grecItemLY.""Purchases (Qty.)"""; grecItemLY."Purchases (Qty.)")
                {
                    BlankZero = true;
                    Caption = 'Purchases LY';
                    DecimalPlaces = 0 : 4;
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin
                        DrilldownField(-grecItem.FieldNo("Purchases (Qty.)"));

                    end;
                }
                field("grecItem.""Qty. on Purch. Order"""; grecItem."Qty. on Purch. Order")
                {
                    BlankZero = true;
                    Caption = 'In Purchase Order';
                    DecimalPlaces = 0 : 4;
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin

                        DrilldownField(grecItem.FieldNo("Qty. on Purch. Order"));

                    end;
                }
                field("grecItem.""Qty. on Sales Order"""; grecItem."Qty. on Sales Order")
                {
                    BlankZero = true;
                    Caption = 'In Sales Order';
                    DecimalPlaces = 0 : 4;
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin

                        DrilldownField(grecItem.FieldNo("Qty. on Sales Order"));

                    end;
                }
                field(gDisp; gDisp)
                {
                    BlankZero = true;
                    Caption = 'Available stock';
                    DecimalPlaces = 0 : 2;
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin

                        DrilldownField(grecItem.FieldNo(Inventory) - grecItem.FieldNo("Reserved Qty. on Inventory"));

                    end;
                }
                field(gDate1; gDate1)
                {
                    Caption = 'Date';
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field(gExternalComment; gExternalComment)
                {
                    BlankZero = true;
                    Caption = 'Ext. com.';
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin

                        grecCommentLine."B Show" := grecCommentLine."B Show"::External;
                        DrilldownField(grecCommentLine."B Show");

                    end;
                }
                field(gInternalComment; gInternalComment)
                {
                    BlankZero = true;
                    Caption = 'Int. com.';
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin

                        grecCommentLine."B Show" := grecCommentLine."B Show"::Internal;
                        DrilldownField(grecCommentLine."B Show");

                    end;
                }
                field("Lot No."; "Lot No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("grecItem.""Sales (Qty.)"""; grecItem."Sales (Qty.)")
                {
                    Caption = 'Sales';
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin

                        DrilldownField(grecItem.FieldNo("Sales (Qty.)"));

                    end;
                }
                field("grecItemLY.""Sales (Qty.)"""; grecItemLY."Sales (Qty.)")
                {
                    Caption = 'Sales LY';
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin

                        DrilldownField(-grecItem.FieldNo("Sales (Qty.)"));

                    end;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Import Invoice Bejo NL")
                {
                    Caption = 'Import Invoice Bejo NL';
                    Ellipsis = true;
                    Image = ICPartner;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    //RunObject = Page "Import Invoice Bejo NL";
                    //RunPageMode = View;
                }
                action("Stock information")
                {
                    Caption = 'Stock information';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        FncStock(grecImportedPurchaseLines);
                    end;
                }
                action(Allocations)
                {
                    Caption = 'Allocations';
                    Image = Allocations;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        FncAllocations(grecImportedPurchaseLines);
                    end;
                }
                action("Create Order")
                {
                    Caption = 'Create Order';
                    Image = CreateDocument;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        CreateOrder();
                    end;
                }
                action("Update Original POs")
                {
                    Caption = 'Update Original POs';
                    Image = UpdateShipment;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Report "Update Original Orders";
                    ApplicationArea = All;
                }
                action("Prognoses to Order")
                {
                    Caption = 'Prognoses to Order';
                    Image = CopyDocument;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Report "Preview Purchase";
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        lUnitofMeasure: Record "Unit of Measure";
    begin
        gDeficit := 0;
        gDisp := 0;
        gDate1 := 0D;
        gUsed := '';
        gUsedPercentage := 0;


        ImportedPurchLines.Init;
        ImportedPurchLines.SetCurrentKey("Document Type", "Document No.", "No.");
        ImportedPurchLines.SetRange("Document Type", "Document Type");
        ImportedPurchLines.SetRange("Document No.", "Document No.");
        ImportedPurchLines.SetRange("No.", "No.");
        ImportedPurchLines.CalcSums("Qty. to Receive (Base)");



        if grecItem.Get("No.") then begin
            grecItem.SetRange("B Packingfilter", "Unit of Measure Code");

            grecItem.SetRange("Date Filter", grecBejoSetup."Begin Date", grecBejoSetup."End Date");
            grecItem.CalcFields(Inventory, "Reserved Qty. on Inventory", "Purchases (Qty.)", "Sales (Qty.)", "B Country allocated",
                               "Qty. on Purch. Order", "B Prognoses", "Qty. on Sales Order", "B Qty. on Purch. Quote");
        end;

        grecItemLY.SetRange("Date Filter", CalcDate('<-1Y>', grecBejoSetup."Begin Date"),
                         CalcDate('<-1Y>', grecBejoSetup."End Date"));
        if not grecItemLY.Get("No.") then
            grecItemLY.Init;
        grecItemLY.CalcFields("Sales (Qty.)", "Purchases (Qty.)");


        if lUnitofMeasure.Get(grecItem."Base Unit of Measure") then;

        if not lUnitofMeasure."B Unit in Weight" then begin
            gDeficit := (grecItem."B Country allocated" - ((grecItem."Purchases (Qty.)" + grecItem."Qty. on Purch. Order" +
                       grecItem."B Qty. on Purch. Quote" + ImportedPurchLines."Qty. to Receive (Base)") / 1000000));


        end else begin

            gDeficit := (grecItem."B Country allocated" - ((grecItem."Purchases (Qty.)" + grecItem."Qty. on Purch. Order" +
                       grecItem."B Qty. on Purch. Quote" + ImportedPurchLines."Qty. to Receive (Base)")));

        end;

        if gDeficit >= 0 then begin
            gDeficit := 0;
            "Allocation exceeded" := false;
        end else begin
            "Allocation exceeded" := true;
        end;


        if grecItem."B Country allocated" <> 0 then begin
            if not lUnitofMeasure."B Unit in Weight" then begin
                gUsedPercentage := Round((((grecItem."Purchases (Qty.)" + grecItem."Qty. on Purch. Order" + grecItem."B Qty. on Purch. Quote" +
                ImportedPurchLines."Qty. to Receive (Base)") / 1000000) / grecItem."B Country allocated") * 100, 0.1);
                gUsed := Format(gUsedPercentage) + '%';
            end else begin
                gUsedPercentage := Round(((grecItem."Purchases (Qty.)" + grecItem."Qty. on Purch. Order" + grecItem."B Qty. on Purch. Quote" +
                ImportedPurchLines."Qty. to Receive (Base)") / grecItem."B Country allocated") * 100, 0.1);
                gUsed := Format(gUsedPercentage) + '%';
            end;
        end;


        grecCommentLine.SetFilter("B End Date", '>=%1', Today);
        grecCommentLine.SetRange("Table Name", grecCommentLine."Table Name"::Item);
        grecCommentLine.SetRange("No.", "No.");
        grecCommentLine.SetRange("B Show", grecCommentLine."B Show"::Internal);


        gInternalComment := not grecCommentLine.IsEmpty;
        grecCommentLine.SetRange("B Show", grecCommentLine."B Show"::External);
        gExternalComment := not grecCommentLine.IsEmpty;


        gDisp := grecItem.Inventory - grecItem."Reserved Qty. on Inventory";

        if not grecItem2.Get("No.") then
            grecItem2.Init;
        if not grecItemExtension.Get(grecItem2."B Extension", '') then
            grecItemExtension.Init;
        if not grecVarieties.Get(Variety) then
            grecVarieties.Init;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec := xRec;
        "Document Type" := "Document Type"::Order;
        "Line No." := "Line No." + 1000;
        "No." := '';
        "Qty. to Receive" := 0;
        "Direct Unit Cost" := 0;
        Amount := 0;
        "Qty. per Unit of Measure" := 0;
        "Unit of Measure Code" := '';
        Description := '';
        "Description 2" := '';
        "Allocation exceeded" := false;
        "Qty. to Receive (Base)" := 0;
        gUsed := '';
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Document Type" := "Document Type"::Order;
        gUsed := '';
    end;

    trigger OnOpenPage()
    begin

        grecBejoSetup.Get;

    end;

    var
        grecImportedPurchaseLines: Record "Imported Purchase Lines";
        grecCompanyInformation: Record "Company Information";
        gDeficit: Decimal;
        gExternalComment: Boolean;
        gInternalComment: Boolean;
        grecItem: Record Item;
        gDate1: Date;
        gDisp: Decimal;
        grecItem2: Record Item;
        grecItemExtension: Record "Item Extension";
        grecItemLY: Record Item;
        grecVarieties: Record Varieties;
        grecBejoSetup: Record "Bejo Setup";
        gUsed: Code[30];
        gUsedPercentage: Decimal;
        gcuBlockingMgt: Codeunit "Blocking Management";
        grecCommentLine: Record "Comment Line";
        ImportedPurchLines: Record "Imported Purchase Lines";

    procedure FncStock("Record": Record "Imported Purchase Lines")
    var
        RecVariety: Record Varieties;
    begin

        if RecVariety.Get(Variety) then begin
            PAGE.RunModal(PAGE::"Stock Information", RecVariety);
        end;

    end;

    procedure FncAllocations("Record": Record "Imported Purchase Lines")
    begin
        grecItem.SetRange(grecItem."No.", "No.");
        if grecItem.Get("No.") then begin
            PAGE.RunModal(PAGE::"Allocation Main", grecItem);
        end;
    end;

    procedure CreateOrder()
    begin

        grecCompanyInformation.Get;

        grecImportedPurchaseLines.SetRange("Document No.", "Document No.");
        grecImportedPurchaseLines.SetRange("Customer No. BejoNL", "Customer No. BejoNL");

        REPORT.Run(REPORT::"Create Purchase Order", true, true, grecImportedPurchaseLines);

    end;

    procedure DrilldownField(lFieldno: Integer)
    var
        lrecItemLedgEntry: Record "Item Ledger Entry";
        lrecValueEntry: Record "Value Entry";
        lrecPurchLine: Record "Purchase Line";
        lrecSalesLine: Record "Sales Line";
    begin
        case true of
            lFieldno = grecItem.FieldNo("Sales (Qty.)"):
                begin
                    lrecValueEntry.SetCurrentKey(
                      "Source No.", "Item No.", "Item Ledger Entry Type", "Posting Date", "Salespers./Purch. Code",
                      "B Line type", "Global Dimension 1 Code", "Location Code");
                    lrecValueEntry.SetRange("Item No.", "No.");
                    lrecValueEntry.SetRange("Posting Date", grecBejoSetup."Begin Date", grecBejoSetup."End Date");
                    lrecValueEntry.SetRange("Item Ledger Entry Type", lrecItemLedgEntry."Entry Type"::Sale);
                    PAGE.Run(PAGE::"Value Entries", lrecValueEntry);
                end;
            lFieldno = -grecItemLY.FieldNo("Sales (Qty.)"):
                begin
                    lrecValueEntry.SetCurrentKey(
                      "Source No.", "Item No.", "Item Ledger Entry Type", "Posting Date", "Salespers./Purch. Code",
                      "B Line type", "Global Dimension 1 Code", "Location Code");
                    lrecValueEntry.SetRange("Item No.", "No.");
                    lrecValueEntry.SetRange("Posting Date",
                       CalcDate('<-1Y>', grecBejoSetup."Begin Date"),
                       CalcDate('<-1Y>', grecBejoSetup."End Date"));
                    lrecValueEntry.SetRange("Item Ledger Entry Type", lrecItemLedgEntry."Entry Type"::Sale);
                    PAGE.Run(PAGE::"Value Entries", lrecValueEntry);
                end;
            lFieldno = grecItem.FieldNo("Purchases (Qty.)"):
                begin
                    lrecItemLedgEntry.SetCurrentKey("Item No.", "Entry Type", "Variant Code", "Drop Shipment", "Location Code", "Posting Date");
                    lrecItemLedgEntry.SetRange("Item No.", "No.");
                    lrecItemLedgEntry.SetRange("Posting Date", grecBejoSetup."Begin Date", grecBejoSetup."End Date");
                    lrecItemLedgEntry.SetRange("Entry Type", lrecItemLedgEntry."Entry Type"::Purchase);
                    PAGE.Run(PAGE::"Item Ledger Entries", lrecItemLedgEntry);
                end;
            lFieldno = -grecItemLY.FieldNo("Purchases (Qty.)"):
                begin
                    lrecItemLedgEntry.SetCurrentKey("Item No.", "Entry Type", "Variant Code", "Drop Shipment", "Location Code", "Posting Date");
                    lrecItemLedgEntry.SetRange("Item No.", "No.");
                    lrecItemLedgEntry.SetRange("Posting Date", grecBejoSetup."Begin Date", grecBejoSetup."End Date");
                    lrecItemLedgEntry.SetRange("Posting Date",
                      CalcDate('<-1Y>', grecBejoSetup."Begin Date"),
                      CalcDate('<-1Y>', grecBejoSetup."End Date"));
                    lrecItemLedgEntry.SetRange("Entry Type", lrecItemLedgEntry."Entry Type"::Purchase);
                    PAGE.Run(PAGE::"Item Ledger Entries", lrecItemLedgEntry);
                end;
            lFieldno = grecItem.FieldNo("Qty. on Purch. Order"):
                begin
                    lrecPurchLine.SetCurrentKey("Variant Code", "Drop Shipment", "Location Code", "No.", Type,
                      "Document Type", "Requested Receipt Date", "Unit of Measure Code");
                    lrecPurchLine.SetRange("No.", "No.");
                    lrecPurchLine.SetRange(Type, lrecPurchLine.Type::Item);
                    lrecPurchLine.SetRange("Requested Receipt Date", grecBejoSetup."Begin Date", grecBejoSetup."End Date");
                    PAGE.Run(PAGE::"Purchase Order Subform", lrecPurchLine);
                end;
            lFieldno = grecItem.FieldNo("Qty. on Sales Order"):
                begin
                    lrecSalesLine.SetCurrentKey("Document Type", Type, "No.");
                    lrecSalesLine.SetRange("No.", "No.");
                    lrecSalesLine.SetRange(Type, lrecSalesLine.Type::Item);
                    lrecSalesLine.SetRange("Shipment Date", grecBejoSetup."Begin Date", grecBejoSetup."End Date");
                    PAGE.Run(PAGE::"Sales Order Subform", lrecSalesLine);
                end;
            lFieldno = grecItem.FieldNo(Inventory) - grecItem.FieldNo("Reserved Qty. on Inventory"):
                begin
                    lrecItemLedgEntry.SetCurrentKey("Item No.", Open, "Variant Code", Positive, "Location Code", "Posting Date");
                    lrecItemLedgEntry.SetRange("Item No.", "No.");
                    lrecItemLedgEntry.SetRange(Open, true);
                    PAGE.RunModal(PAGE::"Item Ledger Entries", lrecItemLedgEntry);
                end;
            lFieldno = grecCommentLine."B Show"::Internal,
            lFieldno = grecCommentLine."B Show"::External:
                begin
                    grecCommentLine.SetRange("B Show", lFieldno);
                    PAGE.Run(PAGE::"Comment Sheet Bejo", grecCommentLine);
                end;
        end;
    end;
}

