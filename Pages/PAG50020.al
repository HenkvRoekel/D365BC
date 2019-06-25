page 50020 "Stock Information sub 2"
{


    Caption = 'Stock Information sub 2';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "Item/Unit";
    SourceTableView = WHERE ("Unit of Measure" = FILTER (<> ''));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Item No."; "Item No.")
                {
                    ApplicationArea = All;
                }
                field("Description 2"; grecItem."Description 2")
                {
                    Caption = 'Description 2';
                    ApplicationArea = All;
                }
                field("grecItemExtension.""Extension Code"""; grecItemExtension."Extension Code")
                {
                    Caption = 'Description 3';
                    ApplicationArea = All;
                }
                field("grecItemUnitOfMeasure.""Qty. per Unit of Measure"""; grecItemUnitOfMeasure."Qty. per Unit of Measure")
                {
                    Caption = 'Unit of Measure';
                    DecimalPlaces = 0 : 4;
                    ApplicationArea = All;
                }
                field(Allocated; Allocated)
                {
                    BlankZero = true;
                    DecimalPlaces = 3 : 3;
                    DrillDownPageID = "Allocation List";
                    ApplicationArea = All;
                }
                field(Prognoses; Prognoses)
                {
                    BlankZero = true;
                    DecimalPlaces = 3 : 3;
                    ApplicationArea = All;
                }
                field("grecItemLedgerEntry.""Invoiced Quantity"""; grecItemLedgerEntry."Invoiced Quantity")
                {
                    BlankZero = true;
                    Caption = 'Purchases';
                    DecimalPlaces = 3 : 3;
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin
                        grecItemLedgerEntry1.SetCurrentKey(grecItemLedgerEntry1."Item No.");
                        grecItemLedgerEntry1.SetRange("Item No.", "Item No.");
                        grecItemLedgerEntry1.SetRange("Entry Type", grecItemLedgerEntry1."Entry Type"::Purchase);
                        grecItemLedgerEntry1.SetRange("Posting Date", grecBejoSetup."Begin Date", grecBejoSetup."End Date");
                        grecItemLedgerEntry1.SetRange("Unit of Measure Code", "Unit of Measure");
                        grecItemLedgerEntry1.SetFilter("Invoiced Quantity", '<>%1', 0);

                        if grecItemLedgerEntry1.FindFirst then begin
                            PAGE.RunModal(50025, grecItemLedgerEntry1);
                        end else begin
                            grecPurchaseLine2.Reset;
                            grecPurchaseLine2.SetCurrentKey(Type, "No.");
                            grecPurchaseLine2.SetRange(Type, grecPurchaseLine2.Type::Item);
                            grecPurchaseLine2.SetRange("No.", "Item No.");
                            grecPurchaseLine2.SetRange("Unit of Measure Code", "Unit of Measure");
                            PAGE.RunModal(50026, grecPurchaseLine2);
                        end;

                    end;
                }
                field(remainholland; grecItem."B Country allocated" - grecItemLedgerEntry."Invoiced Quantity" - grecItem."Qty. on Purch. Order")
                {
                    BlankZero = true;
                    Caption = 'Rest';
                    DecimalPlaces = 3 : 3;
                    ApplicationArea = All;
                }
                field(gTotalPreview; gTotalPreview)
                {
                    BlankZero = true;
                    Caption = 'In Preview Purch Order';
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    var
                        lrecImportPurchLine: Record "Imported Purchase Lines";
                    begin

                        lrecImportPurchLine.Reset;
                        lrecImportPurchLine.SetCurrentKey("Document Type", "Document No.", "No.");
                        lrecImportPurchLine.SetRange(Type, lrecImportPurchLine.Type::Item);
                        lrecImportPurchLine.SetRange("No.", "Item No.");
                        lrecImportPurchLine.SetRange("Unit of Measure Code", "Unit of Measure");
                        PAGE.RunModal(50078, lrecImportPurchLine);

                    end;
                }
                field(gTotalPurchase; gTotalPurchase)
                {
                    BlankZero = true;
                    Caption = 'In Purch. Order';
                    DecimalPlaces = 3 : 3;
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin
                        grecPurchaseLine1.Reset;
                        grecPurchaseLine1.SetCurrentKey("Document Type", Type, "No.");
                        grecPurchaseLine1.SetRange("Document Type", 0, 1);
                        grecPurchaseLine1.SetRange(grecPurchaseLine1.Type, grecPurchaseLine1.Type::Item);
                        grecPurchaseLine1.SetRange("No.", "Item No.");
                        grecPurchaseLine1.SetRange("Unit of Measure Code", "Unit of Measure");
                        PAGE.RunModal(56, grecPurchaseLine1);
                    end;
                }
                field(gWeek; gWeek)
                {
                    BlankZero = true;
                    Caption = 'Delivery week <=';
                    DecimalPlaces = 3 : 3;
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin
                        grecPurchaseLine1.Reset;
                        grecPurchaseLine1.SetCurrentKey("Document Type", Type, "No.");
                        grecPurchaseLine1.SetRange("Document Type", 0, 1);
                        grecPurchaseLine1.SetRange(grecPurchaseLine1.Type, grecPurchaseLine1.Type::Item);
                        grecPurchaseLine1.SetRange("No.", "Item No.");
                        grecPurchaseLine1.SetRange("Unit of Measure Code", "Unit of Measure");

                        grecPurchaseLine1.SetRange(grecPurchaseLine1."Requested Receipt Date", grecBejoSetup."Begin Date",
                                                   DWY2Date(7, gCurrentWeekNo - 1));
                        PAGE.RunModal(56, grecPurchaseLine1);
                    end;
                }
                field(gWeek1; gWeek1)
                {
                    BlankZero = true;
                    Caption = 'Delivery week 0';
                    DecimalPlaces = 3 : 3;
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin
                        grecPurchaseLine1.Reset;
                        grecPurchaseLine1.SetCurrentKey("Document Type", Type, "No.");
                        grecPurchaseLine1.SetRange("Document Type", 0, 1);
                        grecPurchaseLine1.SetRange(grecPurchaseLine1.Type, grecPurchaseLine1.Type::Item);
                        grecPurchaseLine1.SetRange("No.", "Item No.");
                        grecPurchaseLine1.SetRange("Unit of Measure Code", "Unit of Measure");
                        grecPurchaseLine1.SetRange(grecPurchaseLine1."Requested Receipt Date", DWY2Date(1, gCurrentWeekNo), DWY2Date(7, gCurrentWeekNo));
                        PAGE.RunModal(56, grecPurchaseLine1);
                    end;
                }
                field(gWeek2; gWeek2)
                {
                    BlankZero = true;
                    Caption = 'Delivery week +1';
                    DecimalPlaces = 3 : 3;
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin
                        grecPurchaseLine1.Reset;
                        grecPurchaseLine1.SetCurrentKey("Document Type", Type, "No.");
                        grecPurchaseLine1.SetRange("Document Type", 0, 1);
                        grecPurchaseLine1.SetRange(grecPurchaseLine1.Type, grecPurchaseLine1.Type::Item);
                        grecPurchaseLine1.SetRange("No.", "Item No.");
                        grecPurchaseLine1.SetRange("Unit of Measure Code", "Unit of Measure");
                        grecPurchaseLine1.SetRange(grecPurchaseLine1."Requested Receipt Date", DWY2Date(1, gCurrentWeekNo + 1), DWY2Date(7, gCurrentWeekNo + 1));
                        PAGE.RunModal(56, grecPurchaseLine1);
                    end;
                }
                field(gWeek3; gWeek3)
                {
                    BlankZero = true;
                    Caption = 'Delivery week +2';
                    DecimalPlaces = 3 : 3;
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin
                        grecPurchaseLine1.Reset;
                        grecPurchaseLine1.SetCurrentKey("Document Type", Type, "No.");
                        grecPurchaseLine1.SetRange("Document Type", 0, 1);
                        grecPurchaseLine1.SetRange(grecPurchaseLine1.Type, grecPurchaseLine1.Type::Item);
                        grecPurchaseLine1.SetRange("No.", "Item No.");
                        grecPurchaseLine1.SetRange("Unit of Measure Code", "Unit of Measure");
                        grecPurchaseLine1.SetRange(grecPurchaseLine1."Requested Receipt Date", DWY2Date(1, gCurrentWeekNo + 2), DWY2Date(7, gCurrentWeekNo + 2));
                        PAGE.RunModal(56, grecPurchaseLine1);
                    end;
                }
                field(gWeek4; gWeek4)
                {
                    BlankZero = true;
                    Caption = 'Delivery week >2';
                    DecimalPlaces = 3 : 3;
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin
                        grecPurchaseLine1.Reset;
                        grecPurchaseLine1.SetCurrentKey("Document Type", Type, "No.");
                        grecPurchaseLine1.SetRange("Document Type", 0, 1);
                        grecPurchaseLine1.SetRange(grecPurchaseLine1.Type, grecPurchaseLine1.Type::Item);
                        grecPurchaseLine1.SetRange("No.", "Item No.");
                        grecPurchaseLine1.SetRange("Unit of Measure Code", "Unit of Measure");
                        grecPurchaseLine1.SetFilter(grecPurchaseLine1."Requested Receipt Date", '>%1|%2', DWY2Date(1, gCurrentWeekNo + 3), 0D);
                        PAGE.RunModal(56, grecPurchaseLine1);
                    end;
                }
                field(gPeriodPrognose; gPeriodPrognose)
                {
                    BlankZero = true;
                    Caption = 'Rest Prognoses';
                    DecimalPlaces = 3 : 3;
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin
                        grecPrognosisAllocationEntry.Init;

                        grecPrognosisAllocationEntry.SetCurrentKey("Entry Type", "Item No.");
                        grecPrognosisAllocationEntry.SetRange("Item No.", "Item No.");
                        grecPrognosisAllocationEntry.SetRange("Unit of Measure", "Unit of Measure");

                        grecPrognosisAllocationEntry.SetRange("Sales Date", Today, grecBejoSetup."End Date");
                        PAGE.RunModal(50086, grecPrognosisAllocationEntry);
                    end;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        if grecUnitOfMeasure.Get("Unit of Measure") then;
        gWeek := 0;
        gWeek1 := 0;
        gWeek2 := 0;
        gWeek3 := 0;
        gWeek4 := 0;
        gPeriodPrognose := 0;
        gTotalPurchase := 0;
        gTotalQuote := 0;
        gTotalPreview := 0;
        grecImportPurchLine.Reset;
        grecImportPurchLine.SetCurrentKey("Document Type", "Document No.", "No.");
        grecImportPurchLine.SetRange(Type, grecImportPurchLine.Type::Item);
        grecImportPurchLine.SetRange("Purchase Order Created", false);
        grecImportPurchLine.SetRange("No.", "Item No.");
        grecImportPurchLine.SetRange("Unit of Measure Code", "Unit of Measure");
        if grecImportPurchLine.Find('-') then
            repeat
                gTotalPreview += grecImportPurchLine."Qty. to Receive (Base)";
            until grecImportPurchLine.Next = 0;

        if grecItemUnitOfMeasure.Get("Item No.", "Unit of Measure") then;
        grecPrognosisAllocationEntry1.Init;

        grecPrognosisAllocationEntry1.SetCurrentKey("Entry Type", "Item No.", "Unit of Measure");
        grecPrognosisAllocationEntry1.SetRange("Item No.", "Item No.");
        grecPrognosisAllocationEntry1.SetRange("Unit of Measure", "Unit of Measure");

        grecPrognosisAllocationEntry1.SetRange("Sales Date", Today, grecBejoSetup."End Date");
        if grecPrognosisAllocationEntry1.FindSet then
            repeat
                gPeriodPrognose := gPeriodPrognose + grecPrognosisAllocationEntry1.Prognoses;
            until grecPrognosisAllocationEntry1.Next = 0;

        grecItemLedgerEntry.Init;
        grecItemLedgerEntry.SetCurrentKey("Entry Type", "Unit of Measure Code");
        CopyFilter("Date Filter", grecItemLedgerEntry."Posting Date");
        grecItemLedgerEntry.SetRange(grecItemLedgerEntry."Entry Type", grecItemLedgerEntry."Entry Type"::Purchase);
        grecItemLedgerEntry.SetRange("Unit of Measure Code", "Unit of Measure");
        grecItemLedgerEntry.SetRange("Item No.", "Item No.");

        grecItemLedgerEntry.SetRange("Posting Date", grecBejoSetup."Begin Date", grecBejoSetup."End Date");
        grecItemLedgerEntry.CalcSums("Invoiced Quantity");

        if grecUnitOfMeasure."B Unit in Weight" = false then begin
            Allocated := Allocated * 1000000;
            Prognoses := Prognoses * 1000000;
        end;

        grecPurchaseLine.SetCurrentKey("Document Type", grecPurchaseLine.Type, grecPurchaseLine."No.");
        grecPurchaseLine.SetRange("Document Type", grecPurchaseLine."Document Type"::Order);
        grecPurchaseLine.SetRange(Type, grecPurchaseLine.Type::Item);
        grecPurchaseLine.SetRange("No.", "Item No.");
        grecPurchaseLine.SetRange("Unit of Measure Code", "Unit of Measure");
        if grecPurchaseLine.FindSet then begin
            repeat
                if grecPurchaseLine."Requested Receipt Date" <> 0D then
                    gArrangeWeekNo := Date2DWY(grecPurchaseLine."Requested Receipt Date", 2)
                else
                    gArrangeWeekNo := 52;

                if grecPurchaseLine."Requested Receipt Date" <> 0D then
                    if Date2DWY(Today, 3) < Date2DWY(grecPurchaseLine."Requested Receipt Date", 3) then
                        gArrangeWeekNo := gArrangeWeekNo + 52;

                if gArrangeWeekNo < gCurrentWeekNo then begin
                    gWeek := gWeek + grecPurchaseLine."Outstanding Qty. (Base)";
                end;
                if gArrangeWeekNo = gCurrentWeekNo then begin
                    gWeek1 := gWeek1 + grecPurchaseLine."Outstanding Qty. (Base)";
                end;
                if gArrangeWeekNo = gCurrentWeekNo + 1 then begin
                    gWeek2 := gWeek2 + grecPurchaseLine."Outstanding Qty. (Base)";
                end;
                if gArrangeWeekNo = gCurrentWeekNo + 2 then begin
                    gWeek3 := gWeek3 + grecPurchaseLine."Outstanding Qty. (Base)";
                end;
                if gArrangeWeekNo > gCurrentWeekNo + 2 then begin
                    gWeek4 := gWeek4 + grecPurchaseLine."Outstanding Qty. (Base)";
                end;
            until grecPurchaseLine.Next = 0;
        end;
        gTotalPurchase := gWeek + gWeek1 + gWeek2 + gWeek3 + gWeek4;


        grecItem.SetRange("Date Filter", grecBejoSetup."Begin Date", grecBejoSetup."End Date");
        if not grecItem.Get("Item No.") then
            grecItem.Init;
        grecItem.CalcFields("B Country allocated", "B To be allocated", "B Allocated", "Purchases (Qty.)", "Qty. on Purch. Order");

        if not grecItemExtension.Get(grecItem."B Extension", '') then
            grecItemExtension.Init;

        grecPurchaseLine2.SetCurrentKey("Document Type", grecPurchaseLine2.Type, grecPurchaseLine2."No.");
        grecPurchaseLine2.SetRange("Document Type", grecPurchaseLine2."Document Type"::Quote);
        grecPurchaseLine2.SetRange(Type, grecPurchaseLine2.Type::Item);
        grecPurchaseLine2.SetRange("No.", "Item No.");
        grecPurchaseLine2.SetRange("Unit of Measure Code", "Unit of Measure");
        if grecPurchaseLine2.FindSet then begin
            repeat
                gTotalQuote := gTotalQuote + grecPurchaseLine2."Outstanding Qty. (Base)";
            until grecPurchaseLine2.Next = 0;
        end;
        grecItemLedgerEntry."Invoiced Quantity" := (grecItemLedgerEntry."Invoiced Quantity" + gTotalQuote);


        if grecUnitOfMeasure."B Unit in Weight" = false then begin
            Allocated := Allocated / 1000000;
            Prognoses := Prognoses / 1000000;
            gTotalPurchase := gTotalPurchase / 1000000;
            gWeek := gWeek / 1000000;
            gWeek1 := gWeek1 / 1000000;
            gWeek2 := gWeek2 / 1000000;
            gWeek3 := gWeek3 / 1000000;
            gWeek4 := gWeek4 / 1000000;
            grecItem."Qty. on Purch. Order" := grecItem."Qty. on Purch. Order" / 1000000;
            grecItem."Purchases (Qty.)" := grecItem."Purchases (Qty.)" / 1000000;
            grecItemLedgerEntry."Invoiced Quantity" := grecItemLedgerEntry."Invoiced Quantity" / 1000000;
            gTotalPreview := gTotalPreview / 1000000; // BEJOWW6.00.014 RFC 25379
        end;
    end;

    trigger OnInit()
    begin
        gCurrentWeekNo := Date2DWY(Today, 2);

        grecBejoSetup.Get;
    end;

    var
        grecItemLedgerEntry: Record "Item Ledger Entry";
        grecItemLedgerEntry1: Record "Item Ledger Entry";
        grecPurchaseLine: Record "Purchase Line";
        gCurrentWeekNo: Integer;
        gArrangeWeekNo: Integer;
        gWeek: Decimal;
        gWeek1: Decimal;
        gWeek2: Decimal;
        gWeek3: Decimal;
        gWeek4: Decimal;
        grecPrognosisAllocationEntry: Record "Prognosis/Allocation Entry";
        grecPrognosisAllocationEntry1: Record "Prognosis/Allocation Entry";
        grecItemUnitOfMeasure: Record "Item Unit of Measure";
        grecPurchaseLine1: Record "Purchase Line";
        gPeriodPrognose: Decimal;
        gTotalPurchase: Decimal;
        grecUnitOfMeasure: Record "Unit of Measure";
        grecItem: Record Item;
        grecItemExtension: Record "Item Extension";
        gTotalQuote: Decimal;
        grecPurchaseLine2: Record "Purchase Line";
        grecItemUnitTemp: Record "Item/Unit" temporary;
        grecBejoSetup: Record "Bejo Setup";
        gTotalPreview: Decimal;
        grecImportPurchLine: Record "Imported Purchase Lines";

    procedure Update()
    begin
        CurrPage.Update;
    end;

    procedure SetSources(var parItemUnit: Record "Item/Unit")
    begin


        grecItemUnitTemp.Reset;
        grecItemUnitTemp.DeleteAll;

        if parItemUnit.FindSet then repeat

                                        if not FieldsEmpty(parItemUnit) then begin
                                            grecItemUnitTemp := parItemUnit;
                                            grecItemUnitTemp.Insert;
                                        end;
            until parItemUnit.Next = 0;

    end;

    procedure FieldsEmpty(var parItemUnit: Record "Item/Unit") Empty: Boolean
    var
        lOutstandingQuantity: Decimal;
        lPeriodPrognose: Decimal;
        lTotalPurchase: Decimal;
        lTotalQuote: Decimal;
        lrecPrognosisAllocationEntry: Record "Prognosis/Allocation Entry";
        lrecItemLedgerEntry: Record "Item Ledger Entry";
        lrecPurchaseLine: Record "Purchase Line";
        lrecPurchaseLine1: Record "Purchase Line";
        lrecItem: Record Item;
    begin

        Empty := false;

        with parItemUnit do begin

            CalcFields(Allocated, Prognoses, Invoiced);
            lOutstandingQuantity := 0;
            lPeriodPrognose := 0;

            lTotalQuote := 0;

            if grecItemUnitOfMeasure.Get("Item No.", "Unit of Measure") then;
            lrecPrognosisAllocationEntry.Init;

            lrecPrognosisAllocationEntry.SetCurrentKey("Entry Type", "Item No.", "Unit of Measure");
            lrecPrognosisAllocationEntry.SetRange("Item No.", "Item No.");
            lrecPrognosisAllocationEntry.SetRange("Unit of Measure", "Unit of Measure");

            lrecPrognosisAllocationEntry.SetRange("Sales Date", Today, grecBejoSetup."End Date");
            if lrecPrognosisAllocationEntry.FindSet then
                repeat
                    lPeriodPrognose := lPeriodPrognose + lrecPrognosisAllocationEntry.Prognoses;
                until (lrecPrognosisAllocationEntry.Next = 0) or (gPeriodPrognose > 0);

            lrecItemLedgerEntry.Init;
            lrecItemLedgerEntry.SetCurrentKey("Entry Type", "Unit of Measure Code");
            CopyFilter("Date Filter", lrecItemLedgerEntry."Posting Date");
            lrecItemLedgerEntry.SetRange("Entry Type", lrecItemLedgerEntry."Entry Type"::Purchase);
            lrecItemLedgerEntry.SetRange("Unit of Measure Code", "Unit of Measure");
            lrecItemLedgerEntry.SetRange("Item No.", "Item No.");

            lrecItemLedgerEntry.SetRange("Posting Date", grecBejoSetup."Begin Date", grecBejoSetup."End Date");
            lrecItemLedgerEntry.CalcSums("Invoiced Quantity");


            lrecPurchaseLine.SetCurrentKey("Document Type", lrecPurchaseLine.Type, lrecPurchaseLine."No.");
            lrecPurchaseLine.SetRange("Document Type", lrecPurchaseLine."Document Type"::Order);
            lrecPurchaseLine.SetRange(Type, lrecPurchaseLine.Type::Item);
            lrecPurchaseLine.SetRange("No.", "Item No.");
            lrecPurchaseLine.SetRange("Unit of Measure Code", "Unit of Measure");
            if lrecPurchaseLine.FindSet then begin
                repeat
                    lOutstandingQuantity := lrecPurchaseLine."Outstanding Qty. (Base)";
                until (lrecPurchaseLine.Next = 0) or (lOutstandingQuantity > 0);
            end;


            lrecItem.SetRange("Date Filter", grecBejoSetup."Begin Date", grecBejoSetup."End Date");
            if not lrecItem.Get("Item No.") then
                lrecItem.Init;
            lrecItem.CalcFields("B Country allocated", "B To be allocated", "B Allocated", "Purchases (Qty.)", "Qty. on Purch. Order");


            lrecPurchaseLine1.SetCurrentKey("Document Type", lrecPurchaseLine1.Type, lrecPurchaseLine1."No.");
            lrecPurchaseLine1.SetRange("Document Type", grecPurchaseLine2."Document Type"::Quote);
            lrecPurchaseLine1.SetRange(Type, lrecPurchaseLine1.Type::Item);
            lrecPurchaseLine1.SetRange("No.", "Item No.");
            lrecPurchaseLine1.SetRange("Unit of Measure Code", "Unit of Measure");
            if lrecPurchaseLine1.FindSet then begin
                repeat
                    lTotalQuote := lrecPurchaseLine1."Outstanding Qty. (Base)";
                until (lrecPurchaseLine1.Next = 0) or (gTotalQuote > 0);
            end;

            lrecItemLedgerEntry."Invoiced Quantity" := (lrecItemLedgerEntry."Invoiced Quantity" + lTotalQuote);


            if (lOutstandingQuantity = 0) and
               (lPeriodPrognose = 0) and
               (lTotalPurchase = 0) and
               (Allocated = 0) and
               (Prognoses = 0) and
               (Invoiced = 0) and

               (Invoiced = 0) and
               (lrecItem."Qty. on Purch. Order" = 0) and
               (lrecItemLedgerEntry."Invoiced Quantity" = 0) and
               (lrecItem."B Country allocated" = 0) and
               (lrecItem."B To be allocated" = 0) and
               (lrecItem."B Allocated" = 0) then
                Empty := true;

        end;

    end;
}

