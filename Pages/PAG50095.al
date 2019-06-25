page 50095 "Allocation Item Consolidated"
{


    Caption = 'Allocation Item Consolidated';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = Item;
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("No."; "No.")
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
                field("B Country allocated"; "B Country allocated")
                {
                    BlankZero = true;
                    Caption = 'Allocation';
                    DecimalPlaces = 3 : 3;
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin
                        grec2Prognosis_AllocationEntry.SetCurrentKey("Item No.");

                        grec2Prognosis_AllocationEntry.SetRange("Sales Date", grecBejoSetup."Begin Date", grecBejoSetup."End Date");
                        if gItemHasAlternative
                         then grec2Prognosis_AllocationEntry.SetFilter("Item No.", '%1 | %2', Rec."No.", grecItemAlternative."No.")
                        else

                            grec2Prognosis_AllocationEntry.SetRange("Item No.", "No.");
                        grec2Prognosis_AllocationEntry.SetFilter(Allocated, '<>0');
                        PAGE.RunModal(50094, grec2Prognosis_AllocationEntry);
                    end;
                }
                field("B Allocated"; "B Allocated")
                {
                    BlankZero = true;
                    DecimalPlaces = 3 : 3;
                    DrillDownPageID = "Allocation List";
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin

                        Clear(grec2Prognosis_AllocationEntry);
                        grec2Prognosis_AllocationEntry.SetCurrentKey("Item No.");
                        grec2Prognosis_AllocationEntry.SetRange("Sales Date", grecBejoSetup."Begin Date", grecBejoSetup."End Date");
                        if gItemHasAlternative
                         then grec2Prognosis_AllocationEntry.SetFilter("Item No.", '%1 | %2', Rec."No.", grecItemAlternative."No.")
                        else
                            grec2Prognosis_AllocationEntry.SetRange("Item No.", "No.");
                        PAGE.RunModal(50094, grec2Prognosis_AllocationEntry);

                    end;
                }
                field("Sales (Qty.)"; "Sales (Qty.)")
                {
                    BlankZero = true;
                    Caption = 'Sales';
                    DecimalPlaces = 3 : 3;
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    var
                        lrecValueEntry: Record "Value Entry";
                        lformValueEntry: Page "Value Entries";
                    begin

                        lrecValueEntry.SetCurrentKey("Document Type", "Item Ledger Entry Type", "Item No.");
                        if gItemHasAlternative
                         then lrecValueEntry.SetFilter("Item No.", '%1 | %2', Rec."No.", grecItemAlternative."No.")
                        else lrecValueEntry.SetRange("Item No.", Rec."No.");
                        lrecValueEntry.SetRange("Item Ledger Entry Type", lrecValueEntry."Item Ledger Entry Type"::Sale);
                        lrecValueEntry.SetRange("Posting Date", Rec.GetRangeMin("Date Filter"), Rec.GetRangeMax("Date Filter"));
                        lformValueEntry.SetTableView(lrecValueEntry);
                        lformValueEntry.RunModal;

                    end;
                }
                field("B Qty. to Invoice"; "B Qty. to Invoice")
                {
                    BlankZero = true;
                    Caption = 'In Sales Order';
                    DecimalPlaces = 3 : 3;
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    var
                        lformSalesLine: Page "Sales Lines";
                        lrecSalesLine: Record "Sales Line";
                        lAlternativeItemNo: Record Item;
                    begin

                        if gItemHasAlternative
                         then lrecSalesLine.SetFilter("No.", '%1 | %2', Rec."No.", grecItemAlternative."No.")
                        else lrecSalesLine.SetRange("No.", Rec."No.");
                        lrecSalesLine.SetCurrentKey("Document Type", Type, "No.");
                        lrecSalesLine.SetRange("Document Type", lrecSalesLine."Document Type"::Order);
                        lrecSalesLine.SetRange(Type, grecPurchaseLine.Type::Item);

                        if grecItem."B Salespersonfilter" <> '' then lrecSalesLine.SetRange("B Salesperson", grecItem."B Salespersonfilter");
                        if grecItem."B Customerfilter" <> '' then lrecSalesLine.SetRange("Sell-to Customer No.", grecItem."B Customerfilter");
                        lrecSalesLine.SetRange("Shipment Date", Rec.GetRangeMin("Date Filter"), Rec.GetRangeMax("Date Filter"));

                        lformSalesLine.SetTableView(lrecSalesLine);
                        lformSalesLine.RunModal;

                    end;
                }
                field("""B Allocated""-""B Qty. to Invoice""-""Sales (Qty.)"""; "B Allocated" - "B Qty. to Invoice" - "Sales (Qty.)")
                {
                    BlankZero = true;
                    Caption = 'Rest';
                    DecimalPlaces = 3 : 3;
                    ApplicationArea = All;
                }
                field("Qty. on Purch. Order"; "Qty. on Purch. Order")
                {
                    BlankZero = true;
                    Caption = 'In Purch. Order';
                    DecimalPlaces = 3 : 3;
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    var
                        lrecPurchLine: Record "Purchase Line";
                        lformPurchLine: Page "Purchase Lines";
                    begin

                        if gItemHasAlternative
                         then lrecPurchLine.SetFilter("No.", '%1 | %2', Rec."No.", grecItemAlternative."No.")
                        else lrecPurchLine.SetRange("No.", Rec."No.");
                        lrecPurchLine.SetCurrentKey("Document Type", Type, "No.");
                        lrecPurchLine.SetRange("Document Type", lrecPurchLine."Document Type"::Order);
                        lrecPurchLine.SetRange(Type, grecPurchaseLine.Type::Item);

                        lrecPurchLine.SetRange("Expected Receipt Date", Rec.GetRangeMin("Date Filter"), Rec.GetRangeMax("Date Filter"));

                        lformPurchLine.SetTableView(lrecPurchLine);
                        lformPurchLine.RunModal;

                    end;
                }
                field(gPrognosis; gPrognosis)
                {
                    BlankZero = true;
                    Caption = 'Prognoses';
                    DecimalPlaces = 3 : 3;
                    ApplicationArea = All;
                }
                field(gInvoicedLY; gInvoicedLY)
                {
                    BlankZero = true;
                    Caption = 'Sales LY';
                    DecimalPlaces = 3 : 3;
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin
                        grecItemLedgerEntry.SetCurrentKey(grecItemLedgerEntry."Entry Type", grecItemLedgerEntry."Item No.");

                        if gItemHasAlternative
                         then grecItemLedgerEntry.SetFilter("Item No.", '%1 | %2', Rec."No.", grecItemAlternative."No.")
                        else

                            grecItemLedgerEntry.SetRange(grecItemLedgerEntry."Entry Type", grecItemLedgerEntry."Entry Type"::Sale);
                        grecItemLedgerEntry.SetRange(grecItemLedgerEntry."Item No.", "No.");
                        if grecItem.GetFilter("Date Filter") <> '' then
                            grecItemLedgerEntry.SetRange("Posting Date", gStartDateLY, gEndDateLY);
                        PAGE.RunModal(38, grecItemLedgerEntry);
                    end;
                }
                field("Purchases (Qty.)"; "Purchases (Qty.)")
                {
                    BlankZero = true;
                    Caption = 'Purchases (Qty.)';
                    DecimalPlaces = 3 : 3;
                    Visible = true;
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    var
                        lrecValueEntry: Record "Value Entry";
                        lformValueEntry: Page "Value Entries";
                    begin

                        lrecValueEntry.SetCurrentKey("Document Type", "Item Ledger Entry Type", "Item No.");
                        if gItemHasAlternative
                         then lrecValueEntry.SetFilter("Item No.", '%1 | %2', Rec."No.", grecItemAlternative."No.")
                        else lrecValueEntry.SetRange("Item No.", Rec."No.");
                        lrecValueEntry.SetRange("Item Ledger Entry Type", lrecValueEntry."Item Ledger Entry Type"::Purchase);
                        lrecValueEntry.SetRange("Posting Date", Rec.GetRangeMin("Date Filter"), Rec.GetRangeMax("Date Filter"));
                        lformValueEntry.SetTableView(lrecValueEntry);
                        lformValueEntry.RunModal;

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

        gAlternativeItemNo := '';
        gItemHasAlternative := false;


        if gcuBejoManagement.GetAlternativeItemNo(Rec."No.", gAlternativeItemNo) then begin

            Rec.CopyFilter("Date Filter", grecItemAlternative."Date Filter");
            if grecItemAlternative.Get(gAlternativeItemNo) then
                gItemHasAlternative := true;
        end;

        Rec.CalcFields("B Prognoses");
        gPrognosis := Rec."B Prognoses";

        if gItemHasAlternative then begin
            grecItemAlternative.CalcFields("B Prognoses");
            gPrognosis := gPrognosis + grecItemAlternative."B Prognoses";
        end;

        gTotalQuote := 0;
        grecPurchaseLine.SetCurrentKey("Document Type", grecPurchaseLine.Type, grecPurchaseLine."No.");
        grecPurchaseLine.SetRange("Document Type", grecPurchaseLine."Document Type"::Quote);
        grecPurchaseLine.SetRange(Type, grecPurchaseLine.Type::Item);
        grecPurchaseLine.SetRange("No.", "No.");
        if grecPurchaseLine.FindSet then begin
            repeat
                gTotalQuote := gTotalQuote + grecPurchaseLine."Outstanding Qty. (Base)";
            until grecPurchaseLine.Next = 0;
        end;

        if gItemHasAlternative then begin
            grecPurchaseLine.SetCurrentKey("Document Type", grecPurchaseLine.Type, grecPurchaseLine."No.");
            grecPurchaseLine.SetRange("Document Type", grecPurchaseLine."Document Type"::Quote);
            grecPurchaseLine.SetRange(Type, grecPurchaseLine.Type::Item);
            grecPurchaseLine.SetRange("No.", gAlternativeItemNo);
            if grecPurchaseLine.FindSet then begin
                repeat
                    gTotalQuote := gTotalQuote + grecPurchaseLine."Outstanding Qty. (Base)";
                until grecPurchaseLine.Next = 0;
            end;
        end;

        "Purchases (Qty.)" := ("Purchases (Qty.)" + gTotalQuote);

        CalcFields("Sales (Qty.)", "B Qty. to Invoice");
        if grecUnitofMeasure.Get("Base Unit of Measure") then;
        if grecUnitofMeasure."B Unit in Weight" = false then begin
            "Sales (Qty.)" := "Sales (Qty.)" / 1000000;
            "B Qty. to Invoice" := "B Qty. to Invoice" / 1000000;
            "Qty. on Purch. Order" := "Qty. on Purch. Order" / 1000000;
            "Purchases (Qty.)" := "Purchases (Qty.)" / 1000000;
        end else begin
            "Sales (Qty.)" := "Sales (Qty.)";
        end;

        if gItemHasAlternative then begin
            grecItemAlternative.CalcFields("Sales (Qty.)", "B Qty. to Invoice", "Qty. on Purch. Order");
            if grecUnitofMeasure.Get("Base Unit of Measure") then;
            if grecUnitofMeasure."B Unit in Weight" = false then begin
                "Sales (Qty.)" := "Sales (Qty.)" + grecItemAlternative."Sales (Qty.)" / 1000000;
                "B Qty. to Invoice" := "B Qty. to Invoice" + grecItemAlternative."B Qty. to Invoice" / 1000000;
                "Qty. on Purch. Order" := "Qty. on Purch. Order" + grecItemAlternative."Qty. on Purch. Order" / 1000000;
                "Purchases (Qty.)" := "Purchases (Qty.)" + grecItemAlternative."Purchases (Qty.)" / 1000000;
            end else begin
                "Sales (Qty.)" := "Sales (Qty.)" + grecItemAlternative."Sales (Qty.)";
            end;
        end;

        CalcFields("B Salesperson/cust. allocated");
        "B Allocated" := "B Salesperson/cust. allocated";

        if gItemHasAlternative then begin
            grecItemAlternative.CalcFields("B Salesperson/cust. allocated");
            "B Allocated" := "B Allocated" + grecItemAlternative."B Salesperson/cust. allocated";
            grecItemAlternative.CalcFields("B Country allocated");
            "B Country allocated" := "B Country allocated" + grecItemAlternative."B Country allocated";
        end;

        grecItem.SetRange(grecItem."No.", "No.");
        grecItem.SetRange("Date Filter", gStartDateLY, gEndDateLY);

        if grecItem.Get("No.") then
            grecItem.CalcFields(grecItem."Sales (Qty.)");
        if grecUnitofMeasure."B Unit in Weight" = false then
            gInvoicedLY := grecItem."Sales (Qty.)" / 1000000
        else
            gInvoicedLY := grecItem."Sales (Qty.)";

        if gItemHasAlternative then begin
            grecItemAlternative.SetRange(grecItemAlternative."No.", gAlternativeItemNo);
            grecItemAlternative.SetRange("Date Filter", gStartDateLY, gEndDateLY);

            if grecItemAlternative.Get(gAlternativeItemNo) then
                grecItemAlternative.CalcFields(grecItemAlternative."Sales (Qty.)");
            if grecUnitofMeasure."B Unit in Weight" = false then
                gInvoicedLY := gInvoicedLY + grecItemAlternative."Sales (Qty.)" / 1000000
            else
                gInvoicedLY := gInvoicedLY + grecItemAlternative."Sales (Qty.)";
        end;

        if not grecItemExtension.Get("B Extension", '') then
            grecItemExtension.Init;
    end;

    trigger OnInit()
    begin
        grecBejoSetup.Get;
    end;

    var
        gInvoicedLY: Decimal;
        grecItem: Record Item;
        grecItemLedgerEntry: Record "Item Ledger Entry";
        grecUnitofMeasure: Record "Unit of Measure";
        gStartDateLY: Date;
        gEndDateLY: Date;
        grec2Prognosis_AllocationEntry: Record "Prognosis/Allocation Entry";
        grecItemExtension: Record "Item Extension";
        grecBejoSetup: Record "Bejo Setup";
        gTotalQuote: Decimal;
        grecPurchaseLine: Record "Purchase Line";
        gInvoiced: Decimal;
        gPrognosis: Decimal;
        gcuBejoManagement: Codeunit "Bejo Management";
        gAlternativeItemNo: Code[20];
        gItemHasAlternative: Boolean;
        grecItemAlternative: Record Item;

    procedure InitTempTable(var parItem: Record Item)
    var
        lrecItem: Record Item;
        lAlternativeItemNo: Code[20];
        lrecItemAlternative: Record Item;
        bSkipThisRecord: Boolean;
        lStartDate: Date;
        lEndDate: Date;
    begin


        if parItem."B Variety" <> '' then begin
            DeleteAll(false);
            SetCurrentKey("No.");


            lrecItem.SetRange("B Variety", parItem."B Variety");
            parItem.CopyFilter("Date Filter", lrecItem."Date Filter");
            parItem.CopyFilter("B Salespersonfilter", lrecItem."B Salespersonfilter");
            parItem.CopyFilter("B Customerfilter", lrecItem."B Customerfilter");


            if lrecItem.FindSet then repeat

                                         gAlternativeItemNo := '';
                                         bSkipThisRecord := false;
                                         if gcuBejoManagement.GetAlternativeItemNo(lrecItem."No.", gAlternativeItemNo) then begin
                                             if grecItemAlternative.Get(gAlternativeItemNo) then
                                                 if lrecItem."No." > gAlternativeItemNo then
                                                     bSkipThisRecord := true;
                                         end;

                                         if not (bSkipThisRecord) then begin
                                             Rec := lrecItem;
                                             Insert;
                                         end;
                until lrecItem.Next = 0;

            CurrPage.Update(false);
        end;


        Rec.SetRange("Date Filter");
        lStartDate := parItem.GetRangeMin("Date Filter");
        lEndDate := parItem.GetRangeMax("Date Filter");
        Rec.SetFilter("Date Filter", '%1..%2', lStartDate, lEndDate);


        gStartDateLY := CalcDate('<-1Y>', lStartDate);
        gEndDateLY := CalcDate('<-1Y>', lEndDate);

    end;

    procedure ApplyFilters(DateFilterText: Text[250]; SalespersonfilterText: Text[250]; CustomerfilterText: Text[250])
    begin

        if DateFilterText <> '' then
            SetFilter("Date Filter", DateFilterText)
        else
            SetRange("Date Filter");


        if SalespersonfilterText <> '' then begin
            SetFilter("B Salespersonfilter", SalespersonfilterText);
        end else
            SetRange("B Salespersonfilter");


        if CustomerfilterText <> '' then begin
            SetFilter("B Customerfilter", CustomerfilterText);
        end else
            SetRange("B Customerfilter");
        CurrPage.Update(false);

    end;
}

