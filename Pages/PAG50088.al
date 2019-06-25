page 50088 "Allocation Main Subform Purch"
{

    PageType = CardPart;
    SourceTable = Item;

    layout
    {
        area(content)
        {
            field("B Country allocated"; "B Country allocated")
            {
                Caption = 'Allocation';
                DecimalPlaces = 3 : 4;
                DrillDownPageID = "Allocation List";
                Editable = false;
                ApplicationArea = All;
            }
            field("B Prognoses"; "B Prognoses")
            {
                Caption = 'Prognoses';
                DecimalPlaces = 3 : 4;
                Editable = false;
                Lookup = true;
                ApplicationArea = All;
            }
            field(ProgNextYear; ProgNextYear)
            {
                Caption = 'Prognoses Next Year';
                DecimalPlaces = 3 : 4;
                Lookup = true;
                ApplicationArea = All;

                trigger OnDrillDown()
                var
                    lFromDate: Date;
                    lUptoDate: Date;
                    lPrognosisAllocationEntry: Record "Prognosis/Allocation Entry";
                    PrognosesList: Page "Prognoses List";
                begin
                    lFromDate := CalcDate('<+1Y>', GetRangeMin("Date Filter"));
                    lUptoDate := CalcDate('<+1Y>', GetRangeMax("Date Filter"));
                    lPrognosisAllocationEntry.SetCurrentKey("Entry Type", "Item No.", "Sales Date");
                    lPrognosisAllocationEntry.SetRange("Item No.", "No.");
                    lPrognosisAllocationEntry.SetRange("Sales Date", lFromDate, lUptoDate);
                    PrognosesList.SetTableView(lPrognosisAllocationEntry);
                    Commit;
                    PrognosesList.RunModal;
                end;

                trigger OnLookup(var Text: Text): Boolean
                var
                    lFromDate: Date;
                    lUptoDate: Date;
                    lPrognosisAllocationEntry: Record "Prognosis/Allocation Entry";
                    PrognosesList: Page "Prognoses List";
                begin
                    lFromDate := CalcDate('<+1Y>', GetRangeMin("Date Filter"));
                    lUptoDate := CalcDate('<+1Y>', GetRangeMax("Date Filter"));
                    lPrognosisAllocationEntry.SetCurrentKey("Entry Type", "Item No.", "Sales Date");
                    lPrognosisAllocationEntry.SetRange("Item No.", "No.");
                    lPrognosisAllocationEntry.SetRange("Sales Date", lFromDate, lUptoDate);
                    PrognosesList.SetTableView(lPrognosisAllocationEntry);
                    Commit;
                    PrognosesList.RunModal;
                end;
            }
            field("Qty. on Purch. Order"; "Qty. on Purch. Order")
            {
                DecimalPlaces = 3 : 4;
                ApplicationArea = All;
            }
            field("Purchases (Qty.)"; "Purchases (Qty.)")
            {
                DecimalPlaces = 3 : 4;
                ApplicationArea = All;
            }
            field("B Qty. on Purch. Quote"; "B Qty. on Purch. Quote")
            {
                DecimalPlaces = 3 : 4;
                ApplicationArea = All;
            }
            field("Purchases LY"; gRestPurchase)
            {
                Caption = 'Rest to Purchase';
                DecimalPlaces = 3 : 4;
                Editable = false;
                ApplicationArea = All;
            }
            field("Purchases LY2"; grecItemLedgerEntrInvoicedQuantity)
            {
                Caption = 'Purchases LY';
                DecimalPlaces = 3 : 4;
                Editable = false;
                ApplicationArea = All;
            }
            field(Used; gUsed)
            {
                Caption = 'Used %';
                DecimalPlaces = 0 : 2;
                Editable = false;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        if grecUOM.Get("Base Unit of Measure") then;
        if not grecUOM."B Unit in Weight" then begin
            "B Qty. on Purch. Quote" := "B Qty. on Purch. Quote" / 1000000;
            "Qty. on Purch. Order" := "Qty. on Purch. Order" / 1000000;
            "Purchases (Qty.)" := "Purchases (Qty.)" / 1000000;
            "Sales (Qty.)" := "Sales (Qty.)" / 1000000;
            "B Qty. to Invoice" := "B Qty. to Invoice" / 1000000;
        end;
        "B Prognoses" := gPrognoses;
    end;

    var
        gInvoicedLY: Decimal;
        ProgNextYear: Decimal;
        gRestPurchase: Decimal;
        grecItemLedgerEntrInvoicedQuantity: Decimal;
        gUsed: Decimal;
        gPrognoses: Decimal;
        grecUOM: Record "Unit of Measure";

    procedure SetFilters(lInvoicedLY: Decimal; lProgNextYear: Decimal; lRestPurchase: Decimal; lrecItemLedgerEntrInvoicedQuantity: Decimal; lUsed: Decimal; lPrognoses: Decimal; var MainRec: Record Item)
    begin
        gInvoicedLY := lInvoicedLY;
        ProgNextYear := lProgNextYear;
        gRestPurchase := lRestPurchase;
        grecItemLedgerEntrInvoicedQuantity := lrecItemLedgerEntrInvoicedQuantity;
        gUsed := lUsed;
        gPrognoses := lPrognoses;
        CurrPage.Update(false);
        CopyFilters(MainRec);
    end;
}

