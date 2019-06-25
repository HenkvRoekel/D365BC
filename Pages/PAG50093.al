page 50093 "Allocation FactBox2"
{

    Caption = 'Variety Details';
    PageType = CardPart;
    SourceTable = Item;

    layout
    {
        area(content)
        {
            field("B Variety"; "B Variety")
            {
                Caption = 'Variety';
                Editable = false;
                ApplicationArea = All;
            }
            field(Description2; Description)
            {
                Caption = 'Description';
                Editable = false;
                ApplicationArea = All;
            }
            field(gQuantityPer2; gQuantityPer)
            {
                Caption = 'Quantity Per';
                Editable = false;
                ApplicationArea = All;
            }
            field("Search Description"; "Search Description")
            {
                Caption = 'Search Description';
                Editable = false;
                ApplicationArea = All;
            }
            group(Statistics)
            {
                group(SEEDS)
                {
                    field("gPrognosis-gPrognosisKG"; gPrognosis - gPrognosisKG)
                    {
                        BlankZero = true;
                        Caption = 'Prognoses';
                        DecimalPlaces = 3 : 3;
                        Editable = false;
                        ApplicationArea = All;
                    }
                    field("gAllocatedManual-gAllocatedManualKG"; gAllocatedManual - gAllocatedManualKG)
                    {
                        BlankZero = true;
                        Caption = 'Allocation';
                        DecimalPlaces = 3 : 3;
                        Editable = false;
                        ApplicationArea = All;
                    }
                    field("gAllocated-gAllocatedKG"; gAllocated - gAllocatedKG)
                    {
                        BlankZero = true;
                        Caption = 'Allocated';
                        DecimalPlaces = 3 : 3;
                        Editable = false;
                        ApplicationArea = All;
                    }
                }
                group(KG)
                {
                    field(gPrognosisKG; gPrognosisKG)
                    {
                        BlankZero = true;
                        Caption = 'Prognoses KG';
                        DecimalPlaces = 3 : 3;
                        Editable = false;
                        ApplicationArea = All;
                    }
                    field(gAllocatedManualKG; gAllocatedManualKG)
                    {
                        BlankZero = true;
                        Caption = 'Allocation KG';
                        DecimalPlaces = 3 : 3;
                        Editable = false;
                        ApplicationArea = All;
                    }
                    field(gAllocatedKG; gAllocatedKG)
                    {
                        BlankZero = true;
                        Caption = 'Allocated KG';
                        DecimalPlaces = 3 : 3;
                        Editable = false;
                        ApplicationArea = All;
                    }
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin

        gSearchField := "Search Description";
        gSearchNo := "No.";
        if grecUOM.Get("Base Unit of Measure") then;
        if grecUOM."B Unit in Weight" then
            gQuantityPer := text50001
        else
            gQuantityPer := text50000;

        grecPrognAllocEntry1.SetCurrentKey("Entry Type", Variety);
        grecPrognAllocEntry1.SetRange(Variety, "B Variety");
        grecPrognAllocEntry1.SetRange("Entry Type", 2, 3);
        SetRange("Date Filter", grecBejoSetup."Begin Date", grecBejoSetup."End Date");

        //

        if GetFilter("Date Filter") <> '' then
            grecPrognAllocEntry1.SetRange("Sales Date", GetRangeMin("Date Filter"), GetRangeMax("Date Filter"))
        else
            grecPrognAllocEntry1.SetRange("Sales Date");
        grecPrognAllocEntry1.CalcSums(Prognoses, Allocated, "Allocated Cust. Sales person");
        gPrognosis := grecPrognAllocEntry1.Prognoses;
        gAllocated := grecPrognAllocEntry1."Allocated Cust. Sales person";
        gAllocatedManual := grecPrognAllocEntry1.Allocated;

        gAuxVariety := "B Variety" + '000';
        grecPrognAllocEntry2.SetCurrentKey("Entry Type", "Item No.", "Unit of Measure");

        grecPrognAllocEntry2.SetRange("Item No.", gAuxVariety);
        grecPrognAllocEntry2.SetRange("Entry Type", 2, 3);
        if GetFilter("Date Filter") <> '' then
            grecPrognAllocEntry2.SetRange("Sales Date", GetRangeMin("Date Filter"), GetRangeMax("Date Filter"))
        else
            grecPrognAllocEntry2.SetRange("Sales Date");
        grecPrognAllocEntry2.CalcSums(Prognoses, Allocated, "Allocated Cust. Sales person");
        gAllocatedManualKG := grecPrognAllocEntry2.Allocated;
        gPrognosisKG := grecPrognAllocEntry2.Prognoses;
        gAllocatedKG := grecPrognAllocEntry2."Allocated Cust. Sales person";

        if not grecItemExtension.Get("B Extension", '') then
            grecItemExtension.Init;

        if GetRangeMin("Date Filter") <> 0D then begin
            gBeginLY := CalcDate('<-1Y>', GetRangeMin("Date Filter"));
            gEndLY := CalcDate('<-1Y>', GetRangeMax("Date Filter"));
        end;

        if not grecItemLedgerEntry.SetCurrentKey("Item No.", "Entry Type", "Variant Code") then
            grecItemLedgerEntry.SetCurrentKey("Entry Type", "Item No.");
        grecItemLedgerEntry.SetRange("Entry Type", grecItemLedgerEntry."Entry Type"::Sale);
        grecItemLedgerEntry.SetRange("Item No.", "No.");
        grecItemLedgerEntry.SetRange("Posting Date", gBeginLY, gEndLY);
        grecItemLedgerEntry.CalcSums("Invoiced Quantity");
        gInvoicedLY := -grecItemLedgerEntry."Invoiced Quantity";
        grecItemLedgerEntry.SetRange("Entry Type", grecItemLedgerEntry."Entry Type"::Purchase);
        grecItemLedgerEntry.CalcSums("Invoiced Quantity");

        if grecUOM.Get("Base Unit of Measure") then;
        if not grecUOM."B Unit in Weight" then begin
            "B Qty. on Purch. Quote" := "B Qty. on Purch. Quote" / 1000000;
            "Qty. on Purch. Order" := "Qty. on Purch. Order" / 1000000;
            "Purchases (Qty.)" := "Purchases (Qty.)" / 1000000;
            grecItemLedgerEntry."Invoiced Quantity" := grecItemLedgerEntry."Invoiced Quantity" / 1000000;
            "Sales (Qty.)" := "Sales (Qty.)" / 1000000;
            gInvoicedLY := gInvoicedLY / 1000000;
            "B Qty. to Invoice" := "B Qty. to Invoice" / 1000000;
        end;

        if "B Country allocated" <> 0 then begin
            "gUsed%" := Round((("Purchases (Qty.)" + "Qty. on Purch. Order" + "B Qty. on Purch. Quote") / "B Country allocated") * 100, 0.1);
            gUsed := Format("gUsed%") + '%';
        end else begin
            Clear(gUsed);
        end;
        gRestPurchase := "B Country allocated" - ("Purchases (Qty.)" + "Qty. on Purch. Order" + "B Qty. on Purch. Quote");
        CalcPrognosisNextYear;
        OnAfterGetCurrRecord;
        PromoStatusText := Format("B Promo Status");
        PromoStatusTextOnFormat(PromoStatusText);
    end;

    trigger OnOpenPage()
    begin
        grecBejoSetup.Get;
        grecCompanyInfo.Get;
        SetRange("Date Filter", grecBejoSetup."Begin Date", grecBejoSetup."End Date");
    end;

    var
        gAuxVariety: Code[10];
        gQuantityPer: Text[15];
        grecPrognAllocEntry1: Record "Prognosis/Allocation Entry";
        grecPrognAllocEntry2: Record "Prognosis/Allocation Entry";
        gPrognosis: Decimal;
        gPrognosisKG: Decimal;
        gAllocated: Decimal;
        gAllocatedKG: Decimal;
        gAllocatedManual: Decimal;
        gAllocatedManualKG: Decimal;
        grecItem: Record Item;
        grecUOM: Record "Unit of Measure";
        gSearchField: Code[35];
        gTempSearchField: Code[35];
        gSearchString: Code[35];
        grecCompanyInfo: Record "Company Information";
        gSearchNo: Code[10];
        grecItemUnit: Record "Item/Unit";
        grecItemExtension: Record "Item Extension";
        grecBejoSetup: Record "Bejo Setup";
        gBeginLY: Date;
        gEndLY: Date;
        gInvoicedLY: Decimal;
        grecItemLedgerEntry: Record "Item Ledger Entry";
        "gUsed%": Decimal;
        gUsed: Code[30];
        lcuBlockingMgt: Codeunit "Blocking Management";
        gRestPurchase: Decimal;
        [InDataSet]
        PromoStatusText: Text[1024];
        text50000: Label 'Million';
        text50001: Label 'KG';
        Text50002: Label 'Nothing found.';

    procedure CalcPrognosisNextYear()
    var
        lFromDate: Date;
        lUptoDate: Date;
    begin
        lFromDate := CalcDate('<+1Y>', GetRangeMin("Date Filter"));
        lUptoDate := CalcDate('<+1Y>', GetRangeMax("Date Filter"));
    end;

    local procedure gSearchFieldOnAfterValidate()
    begin
        gTempSearchField := gSearchField;
        gSearchString := gTempSearchField;
        if not Get(gSearchString) then begin
            SetCurrentKey("Search Description");
            SetFilter("Search Description", gSearchString + '*');
            if not FindFirst then begin
                Clear(gSearchField);
                SetRange("Search Description");
                Message(Text50002);
                exit;
            end;
            if Count >= 1 then
                if PAGE.RunModal(PAGE::"Item List", Rec) = ACTION::LookupOK then;
        end;
        SetCurrentKey("No.");
        CurrPage.Update(false);
        SetRange("Search Description");
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
    end;

    local procedure PromoStatusTextOnFormat(var Text: Text[1024])
    begin
        Text := "B DisplayPromoStatus";
    end;
}

