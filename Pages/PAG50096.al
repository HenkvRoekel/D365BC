page 50096 "Allocation Item"
{

    Caption = 'Allocation Item';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = Item;

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
                    var
                        lrecPrognosisAllocationEntry: Record "Prognosis/Allocation Entry";
                    begin
                        lrecPrognosisAllocationEntry.SetCurrentKey("Item No.");
                        lrecPrognosisAllocationEntry.SetRange("Item No.", "No.");
                        lrecPrognosisAllocationEntry.SetFilter(Allocated, '<>0');
                        PAGE.RunModal(50094, lrecPrognosisAllocationEntry);
                    end;
                }
                field("B Allocated"; "B Allocated")
                {
                    BlankZero = true;
                    DecimalPlaces = 3 : 3;
                    DrillDownPageID = "Allocation List";
                    ApplicationArea = All;
                }
                field("Sales (Qty.)"; "Sales (Qty.)")
                {
                    BlankZero = true;
                    Caption = 'Sales';
                    DecimalPlaces = 3 : 3;
                    ApplicationArea = All;
                }
                field("B Qty. to Invoice"; "B Qty. to Invoice")
                {
                    BlankZero = true;
                    Caption = 'In Sales Order';
                    DecimalPlaces = 3 : 3;
                    ApplicationArea = All;
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
                }
                field("B Prognoses"; "B Prognoses")
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
                    var
                        lrecItemLedgerEntry: Record "Item Ledger Entry";
                    begin
                        lrecItemLedgerEntry.SetCurrentKey("Entry Type", "Item No.");
                        lrecItemLedgerEntry.SetRange("Entry Type", lrecItemLedgerEntry."Entry Type"::Sale);
                        lrecItemLedgerEntry.SetRange("Item No.", "No.");
                        if grecItem.GetFilter("Date Filter") <> '' then
                            lrecItemLedgerEntry.SetRange("Posting Date", gBeginDateLY, gEndDateLY);
                        PAGE.RunModal(38, lrecItemLedgerEntry);
                    end;
                }
                field("Purchases (Qty.)"; "Purchases (Qty.)")
                {
                    BlankZero = true;
                    Caption = 'Purchases (Qty.)';
                    DecimalPlaces = 3 : 3;
                    Visible = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin

        grecPrognosisAllocationEntry.Init;
        grecPrognosisAllocationEntry.SetCurrentKey("Entry Type", "Item No.", "Unit of Measure", "Sales Date", Salesperson);
        grecPrognosisAllocationEntry.SetRange("Item No.", "No.");


        gTotalQuote := 0;
        grecPurchLine.SetCurrentKey("Document Type", Type, "No.");
        grecPurchLine.SetRange("Document Type", grecPurchLine."Document Type"::Quote);
        grecPurchLine.SetRange(Type, grecPurchLine.Type::Item);
        grecPurchLine.SetRange("No.", "No.");
        if grecPurchLine.FindSet then begin
            repeat
                gTotalQuote := gTotalQuote + grecPurchLine."Outstanding Qty. (Base)";
            until grecPurchLine.Next = 0;
        end;
        "Purchases (Qty.)" := ("Purchases (Qty.)" + gTotalQuote);


        CalcFields("Sales (Qty.)", "B Qty. to Invoice");
        if grecUOM.Get("Base Unit of Measure") then;
        if grecUOM."B Unit in Weight" = false then begin
            "Sales (Qty.)" := "Sales (Qty.)" / 1000000;

            "B Qty. to Invoice" := "B Qty. to Invoice" / 1000000;

            "Qty. on Purch. Order" := "Qty. on Purch. Order" / 1000000;
            "Purchases (Qty.)" := "Purchases (Qty.)" / 1000000;
        end else begin
            "Sales (Qty.)" := "Sales (Qty.)";
        end;


        gBeginDateLY := CalcDate('<-1Y>', grecBejoSetup."Begin Date");
        gEndDateLY := CalcDate('<-1Y>', grecBejoSetup."End Date");


        grecItem.SetRange("No.", "No.");
        grecItem.SetRange("Date Filter", gBeginDateLY, gEndDateLY);

        if grecItem.Get("No.") then
            grecItem.CalcFields(grecItem."Sales (Qty.)");
        if grecUOM."B Unit in Weight" = false then
            gInvoicedLY := grecItem."Sales (Qty.)" / 1000000
        else
            gInvoicedLY := grecItem."Sales (Qty.)";

        CalcFields("B Salesperson/cust. allocated");
        "B Allocated" := "B Salesperson/cust. allocated";

        if not grecItemExtension.Get("B Extension", '') then
            grecItemExtension.Init;
    end;

    trigger OnInit()
    begin

        grecBejoSetup.Get;

    end;

    var
        grecPrognosisAllocationEntry: Record "Prognosis/Allocation Entry";
        gInvoicedLY: Decimal;
        grecItem: Record Item;
        grecUOM: Record "Unit of Measure";
        gBeginDateLY: Date;
        gEndDateLY: Date;
        grecItemExtension: Record "Item Extension";
        grecBejoSetup: Record "Bejo Setup";
        gTotalQuote: Decimal;
        grecPurchLine: Record "Purchase Line";

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

