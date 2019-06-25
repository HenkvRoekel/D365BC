page 50069 "Allocation Salesperson"
{

    AutoSplitKey = false;
    Caption = 'Allocation Salesperson';
    DelayedInsert = true;
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = ListPart;
    SourceTable = "Prognosis/Allocation Entry";
    SourceTableView = SORTING ("Entry Type", "Item No.", "Sales Date", Salesperson)
                      WHERE ("Entry Type" = FILTER (<> Prognoses),
                            "Secundary Allocation" = CONST (false));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field(Salesperson; Salesperson)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        SalespersonOnAfterValidate;
                    end;
                }
                field(Customer; Customer)
                {
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CustomerOnAfterValidate;
                    end;
                }
                field(gSalesPersonPerCustPrognosis; gSalesPersonPerCustPrognosis)
                {
                    BlankZero = true;
                    Caption = 'Prognoses';
                    DecimalPlaces = 3 : 4;
                    DrillDownPageID = "Prognoses List";
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    var
                        lrecPrognosisAllocationEntry: Record "Prognosis/Allocation Entry";
                    begin

                        lrecPrognosisAllocationEntry.SetRange("Item No.", "Item No.");
                        lrecPrognosisAllocationEntry.SetRange("Sales Date", GetRangeMin("Date filter"), GetRangeMax("Date filter"));
                        lrecPrognosisAllocationEntry.SetRange("Entry Type", "Entry Type"::Prognoses);
                        lrecPrognosisAllocationEntry.SetRange(Salesperson, Salesperson);

                        lrecPrognosisAllocationEntry.SetRange(Customer, Customer);


                        PAGE.RunModal(50086, lrecPrognosisAllocationEntry);
                    end;
                }
                field("Salesperson Allocation"; "Salesperson Allocation")
                {
                    BlankZero = true;
                    Caption = 'Allocation';
                    DecimalPlaces = 3 : 4;
                    DrillDownPageID = "Allocation List";
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field(gAllocatedCustSalesperson; gAllocatedCustSalesperson)
                {
                    BlankZero = true;
                    Caption = 'Allocated';
                    DecimalPlaces = 3 : 4;
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin

                        DrillDownSalespersCustAlloc;

                    end;

                    trigger OnValidate()
                    var
                        BejoManagement: Codeunit "Bejo Management";
                    begin

                        AddSalespersCustAllocation;


                        BejoManagement.AllocationCheckSales(Rec, gAllocatedCustSalesperson);

                        gAllocatedCustSalespersonOnAft;
                    end;
                }
                field("In Sales Order"; "In Sales Order")
                {
                    BlankZero = true;
                    DecimalPlaces = 3 : 4;
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    var
                        lrecSalesLineTemp: Record "Sales Line" temporary;
                        lrecSalesLine: Record "Sales Line";
                        lrecPrognosisAllocationEntry: Record "Prognosis/Allocation Entry";
                    begin
                        if not lrecSalesLine.SetCurrentKey(Type, "No.") then
                            lrecSalesLine.SetCurrentKey("Document Type", Type, "B Line type", "No.");

                        lrecSalesLine.SetRange("Document Type", lrecSalesLine."Document Type"::Order);
                        lrecSalesLine.SetRange(Type, lrecSalesLineTemp.Type::Item);
                        lrecSalesLine.SetRange("No.", "Item No.");
                        lrecSalesLine.SetRange("Shipment Date", GetRangeMin("Date filter"), GetRangeMax("Date filter"));

                        if Salesperson <> '' then
                            lrecSalesLine.SetRange("B Salesperson", Salesperson);

                        if Customer <> '' then
                            lrecSalesLine.SetRange("Sell-to Customer No.", Customer);


                        if Customer = '' then begin
                            lrecPrognosisAllocationEntry.SetRange("Item No.", "Item No.");
                            lrecPrognosisAllocationEntry.SetRange(Salesperson, Salesperson);
                            lrecPrognosisAllocationEntry.SetRange("Begin Date", GetRangeMin("Date filter"), GetRangeMax("Date filter"));
                            if lrecSalesLine.FindSet then begin
                                repeat
                                    lrecPrognosisAllocationEntry.SetRange(Customer, lrecSalesLine."Sell-to Customer No.");
                                    if not (lrecPrognosisAllocationEntry.FindFirst) then begin
                                        lrecSalesLineTemp := lrecSalesLine;
                                        lrecSalesLineTemp.Insert;
                                    end;
                                until lrecSalesLine.Next = 0;
                            end;
                            PAGE.RunModal(50066, lrecSalesLineTemp);
                        end else
                            PAGE.RunModal(50066, lrecSalesLine);
                    end;
                }
                field(gInventory; gInventory)
                {
                    BlankZero = true;
                    Caption = 'Inventory';
                    DecimalPlaces = 3 : 4;
                    Editable = false;
                    ApplicationArea = All;
                }
                field(gInvoiced; gInvoiced)
                {
                    BlankZero = true;
                    Caption = 'Sales';
                    DecimalPlaces = 3 : 4;
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    var
                        lrecItemLedgerEntry: Record "Item Ledger Entry";
                        lrecItemLedgerEntryTemp: Record "Item Ledger Entry" temporary;
                    begin
                        lrecItemLedgerEntry.SetCurrentKey("Entry Type", "Item No.");
                        lrecItemLedgerEntry.SetRange("Entry Type", lrecItemLedgerEntry."Entry Type"::Sale);
                        lrecItemLedgerEntry.SetRange("Posting Date", GetRangeMin("Date filter"), GetRangeMax("Date filter"));
                        lrecItemLedgerEntry.SetRange("Item No.", "Item No.");

                        if Salesperson <> '' then
                            lrecItemLedgerEntry.SetRange("B Salesperson", Salesperson);
                        if Customer <> '' then
                            lrecItemLedgerEntry.SetRange("Source No.", Customer);


                        if Customer = '' then begin
                            grecPrognosisAllocationEntry.CopyFilters(Rec);
                            if lrecItemLedgerEntry.FindSet then begin
                                repeat
                                    grecPrognosisAllocationEntry.SetRange(Customer, lrecItemLedgerEntry."Source No.");
                                    if not (grecPrognosisAllocationEntry.FindFirst) then begin
                                        lrecItemLedgerEntryTemp := lrecItemLedgerEntry;
                                        lrecItemLedgerEntryTemp.Insert;
                                    end;
                                until lrecItemLedgerEntry.Next = 0;
                            end;
                            PAGE.RunModal(50068, lrecItemLedgerEntryTemp);
                        end else
                            PAGE.RunModal(50068, lrecItemLedgerEntry);
                    end;
                }
                field("gAllocatedCustSalesperson-gInvoiced-""In Sales Order"""; gAllocatedCustSalesperson - gInvoiced - "In Sales Order")
                {
                    BlankZero = true;
                    Caption = 'Rest to sell';
                    DecimalPlaces = 3 : 4;
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Prognosis Remark"; "Prognosis Remark")
                {
                    ApplicationArea = All;
                }
                field("Country Prognose"; gCountryPrognosis)
                {
                    BlankZero = true;
                    Caption = 'Country Prognose';
                    DecimalPlaces = 0 : 3;
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field(gInvoicedLY; gInvoicedLY)
                {
                    BlankZero = true;
                    Caption = 'Sales LY';
                    DecimalPlaces = 3 : 4;
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    var
                        lrecItemLedgerEntry: Record "Item Ledger Entry";
                        lrecItemLedgerEntryTemp: Record "Item Ledger Entry" temporary;
                    begin
                        lrecItemLedgerEntry.SetCurrentKey("Entry Type", "Item No.");
                        lrecItemLedgerEntry.SetRange("Entry Type", lrecItemLedgerEntry."Entry Type"::Sale);
                        lrecItemLedgerEntry.SetRange("Posting Date", gStartLY, gEndLY);
                        lrecItemLedgerEntry.SetRange("Item No.", "Item No.");

                        if Salesperson <> '' then
                            lrecItemLedgerEntry.SetRange("B Salesperson", Salesperson);
                        if Customer <> '' then
                            lrecItemLedgerEntry.SetRange("Source No.", Customer);


                        if Customer = '' then begin
                            grecPrognosisAllocationEntry.SetRange("Item No.", "Item No.");
                            grecPrognosisAllocationEntry.SetRange(Salesperson, Salesperson);
                            grecPrognosisAllocationEntry.SetRange("Begin Date", GetRangeMin("Date filter"), GetRangeMax("Date filter"));
                            if lrecItemLedgerEntry.FindSet then begin
                                repeat
                                    grecPrognosisAllocationEntry.SetRange(Customer, lrecItemLedgerEntry."Source No.");
                                    if not (grecPrognosisAllocationEntry.FindFirst) then begin
                                        lrecItemLedgerEntryTemp := lrecItemLedgerEntry;
                                        lrecItemLedgerEntryTemp.Insert;
                                    end;
                                until lrecItemLedgerEntry.Next = 0;
                            end;
                            PAGE.RunModal(50068, lrecItemLedgerEntryTemp);
                        end else
                            PAGE.RunModal(50068, lrecItemLedgerEntry);
                    end;
                }
                field("Last Date Modified"; "Last Date Modified")
                {
                    Editable = false;
                    Visible = true;
                    ApplicationArea = All;
                }
                field(GetLastUserID; GetLastUserID1)
                {
                    Caption = 'Last User-ID Modified';
                    Editable = false;
                    Visible = true;
                    ApplicationArea = All;
                }
                field("Begin Date"; "Begin Date")
                {
                    Editable = false;
                    MultiLine = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Sales Date"; "Sales Date")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field(gPrognosisNextYear; gPrognosisNextYear)
                {
                    BlankZero = true;
                    Caption = 'Prognosis Next Year';
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin

                        DrillDownPrognosisNextYear;

                    end;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    var
        lUnitofMeasure: Record "Unit of Measure";
        lPreviousCustomer: Code[10];
    begin

        gInvoiced := 0;
        gVarietyInOrder := 0;
        gVarietyInOrderKg := 0;
        gCountryPrognosis := 0;
        gInvoicedLY := 0;
        gReserved := false;
        gSalesPersonPerCustPrognosis := 0;
        gInventory := 0;


        GetInventorySetup;


        gStartCY := GetRangeMin("Date filter");
        gEndCY := GetRangeMax("Date filter");
        gStartLY := CalcDate('<-1Y>', gStartCY);
        gEndLY := CalcDate('<-1Y>', gEndCY);

        if grecUnitOfMeasure.Get("Unit of Measure") then;

        grecPrognosisAllocationEntry.Reset;
        grecPrognosisAllocationEntry.SetCurrentKey("Entry Type", "Item No.", "Unit of Measure", "Sales Date", Salesperson);
        grecPrognosisAllocationEntry.SetRange(grecPrognosisAllocationEntry."Item No.", "Item No.");
        grecPrognosisAllocationEntry.SetRange("Sales Date", gStartCY, gEndCY);
        grecPrognosisAllocationEntry.CalcSums(grecPrognosisAllocationEntry.Prognoses); // BEJOWW5.0.007

        gCountryPrognosis := grecPrognosisAllocationEntry.Prognoses;

        grecPrognosisAllocationEntry.SetRange(Customer, Customer);
        grecPrognosisAllocationEntry.SetRange(Salesperson, Salesperson);

        grecPrognosisAllocationEntry.CalcSums(Prognoses);

        gSalesPersonPerCustPrognosis := grecPrognosisAllocationEntry.Prognoses;

        CalcPrognosisNextYear;

        CalcInvoiced;

        if grecItem.Get("Item No.") then;
        grecItem.SetRange("Date Filter", gStartCY, gEndCY);

        if Salesperson <> '' then
            grecItem.SetRange("B Salespersonfilter", Salesperson)
        else
            grecItem.SetRange("B Salespersonfilter");

        if Customer <> '' then
            grecItem.SetRange("B Customerfilter", Customer)
        else
            grecItem.SetRange("B Customerfilter");

        grecItem.CalcFields("B Qty. to Invoice", "B Remaining Quantity");
        gInSalesOrder := grecItem."B Qty. to Invoice";


        if Customer = '' then begin
            grecPrognosisAllocationEntry.Reset;
            grecPrognosisAllocationEntry.SetCurrentKey("Entry Type", "Item No.", "Sales Date", Salesperson, Customer, "Unit of Measure");
            grecPrognosisAllocationEntry.SetRange("Entry Type", grecPrognosisAllocationEntry."Entry Type"::Allocation);
            grecPrognosisAllocationEntry.SetRange("Item No.", "Item No.");
            grecPrognosisAllocationEntry.SetRange("Sales Date", gStartCY, gEndCY);
            grecPrognosisAllocationEntry.SetRange(Salesperson, Salesperson);
            grecPrognosisAllocationEntry.SetFilter(Customer, '<>%1', '');
            if grecPrognosisAllocationEntry.FindSet then begin
                repeat
                    grecItem.SetRange("B Customerfilter", grecPrognosisAllocationEntry.Customer);
                    grecItem.CalcFields("B Qty. to Invoice");
                    if lPreviousCustomer <> grecPrognosisAllocationEntry.Customer then
                        gInSalesOrder := gInSalesOrder - grecItem."B Qty. to Invoice";
                    lPreviousCustomer := grecPrognosisAllocationEntry.Customer;
                until grecPrognosisAllocationEntry.Next = 0;
            end;
        end;

        gInventory := grecItem."B Remaining Quantity";

        if lUnitofMeasure.Get(grecItem."Base Unit of Measure") then;

        if not lUnitofMeasure."B Unit in Weight" then begin
            gInvoiced := gInvoiced / 1000000;
            gInventory := grecItem."B Remaining Quantity" / 1000000;
            gInSalesOrder := gInSalesOrder / 1000000;
            gInvoicedLY := gInvoicedLY / 1000000;
        end;

        "In Sales Order" := gInSalesOrder;


        gAllocatedCustSalesperson := GetSalespersCustAllocation;
        OnAfterGetCurrRecord;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin

    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

        "Sales Date" := GetRangeMax("Date filter");
        "Begin Date" := GetRangeMin("Date filter");
        "Entry Type" := "Entry Type"::Allocation;
        gSalesPersonPerCustPrognosis := 0;
        gInventory := 0;

        OnAfterGetCurrRecord;
    end;

    trigger OnOpenPage()
    begin

        GetBejoSetup;

    end;

    var
        grecBejoSetup: Record "Bejo Setup";
        grecPrognosisAllocationEntry: Record "Prognosis/Allocation Entry";
        grecItem: Record Item;
        grecInventorySetup: Record "Inventory Setup";
        grecUnitOfMeasure: Record "Unit of Measure";
        gVarietyInOrder: Decimal;
        gVarietyInOrderKg: Decimal;
        gCountryPrognosis: Decimal;
        gInSalesOrder: Decimal;
        gInvoiced: Decimal;
        gInvoicedLY: Decimal;
        gSalesPersonPerCustPrognosis: Decimal;
        gInventory: Decimal;
        gStartLY: Date;
        gEndLY: Date;
        gStartCY: Date;
        gEndCY: Date;
        gHasInventorySetup: Boolean;
        gHasBejoSetup: Boolean;
        gReserved: Boolean;
        gPrognosisNextYear: Decimal;
        gAllocatedCustSalesperson: Decimal;

    procedure GetInventorySetup()
    begin

        if not gHasInventorySetup then begin
            grecInventorySetup.Get;
            gHasInventorySetup := true;
        end;

    end;

    procedure GetBejoSetup()
    begin

        if not gHasBejoSetup then begin
            grecBejoSetup.Get;
            gHasBejoSetup := true;
        end;

    end;

    procedure CalcInvoiced()
    var
        lrecItemLedgerEntry: Record "Item Ledger Entry";
        lrecSalesHeader: Record "Sales Header";
    begin
        if not lrecItemLedgerEntry.SetCurrentKey("Item No.", "Entry Type") then
            lrecItemLedgerEntry.SetCurrentKey("Entry Type", "Item No.");
        lrecItemLedgerEntry.SetRange("Entry Type", lrecItemLedgerEntry."Entry Type"::Sale);
        lrecItemLedgerEntry.SetRange("Posting Date", GetRangeMin("Date filter"), GetRangeMax("Date filter"));
        lrecItemLedgerEntry.SetRange("Item No.", "Item No.");
        if Customer <> '' then
            lrecItemLedgerEntry.SetRange("Source No.", Customer);
        if Salesperson <> '' then
            lrecItemLedgerEntry.SetRange("B Salesperson", Salesperson);


        if Customer = '' then begin
            grecPrognosisAllocationEntry.SetRange("Item No.", "Item No.");
            grecPrognosisAllocationEntry.SetRange(Salesperson, Salesperson);
            grecPrognosisAllocationEntry.SetRange("Begin Date", GetRangeMin("Date filter"), GetRangeMax("Date filter"));
            if lrecItemLedgerEntry.FindSet then begin
                repeat
                    grecPrognosisAllocationEntry.SetRange(Customer, lrecItemLedgerEntry."Source No.");
                    if not (grecPrognosisAllocationEntry.FindFirst) then begin
                        gInvoiced := gInvoiced + -lrecItemLedgerEntry."Invoiced Quantity";
                    end;
                until lrecItemLedgerEntry.Next = 0;
            end;

            lrecItemLedgerEntry.SetRange("Posting Date", gStartLY, gEndLY);
            if lrecItemLedgerEntry.FindSet then begin
                repeat
                    grecPrognosisAllocationEntry.SetRange(Customer, lrecItemLedgerEntry."Source No.");
                    if not (grecPrognosisAllocationEntry.FindFirst) then begin
                        gInvoicedLY := gInvoicedLY + -lrecItemLedgerEntry."Invoiced Quantity";
                    end;
                until lrecItemLedgerEntry.Next = 0;
            end;
        end else begin
            if lrecItemLedgerEntry.FindSet then
                repeat
                    gInvoiced := gInvoiced + -lrecItemLedgerEntry."Invoiced Quantity";
                until lrecItemLedgerEntry.Next = 0;

            lrecItemLedgerEntry.SetRange("Posting Date", gStartLY, gEndLY);
            if lrecItemLedgerEntry.FindSet then
                repeat
                    gInvoicedLY := gInvoicedLY + -lrecItemLedgerEntry."Invoiced Quantity";
                until lrecItemLedgerEntry.Next = 0;

        end;
    end;

    procedure CalcPrognosisNextYear()
    var
        lFromDate: Date;
        lUptoDate: Date;
        lrecPrognosisAllocationEntry: Record "Prognosis/Allocation Entry";
    begin

        lFromDate := CalcDate('<+1Y>', gStartCY);
        lUptoDate := CalcDate('<+1Y>', gEndCY);
        lrecPrognosisAllocationEntry.Copy(grecPrognosisAllocationEntry);
        lrecPrognosisAllocationEntry.SetRange("Sales Date", lFromDate, lUptoDate);
        lrecPrognosisAllocationEntry.CalcSums(Prognoses);
        gPrognosisNextYear := lrecPrognosisAllocationEntry.Prognoses;

    end;

    procedure DrillDownPrognosisNextYear()
    var
        lFromDate: Date;
        lUptoDate: Date;
        lrecPrognosisAllocationEntry: Record "Prognosis/Allocation Entry";
    begin

        lrecPrognosisAllocationEntry.SetRange("Item No.", "Item No.");
        lFromDate := CalcDate('<+1Y>', GetRangeMin("Date filter"));
        lUptoDate := CalcDate('<+1Y>', GetRangeMax("Date filter"));
        lrecPrognosisAllocationEntry.SetRange("Sales Date", lFromDate, lUptoDate);
        lrecPrognosisAllocationEntry.SetRange("Entry Type", "Entry Type"::Prognoses);
        lrecPrognosisAllocationEntry.SetRange(Salesperson, Salesperson);
        lrecPrognosisAllocationEntry.SetRange(Customer, Customer);
        PAGE.RunModal(50086, lrecPrognosisAllocationEntry);

    end;

    local procedure GetSalespersCustAllocation(): Decimal
    var
        lrecPrognosisAllocationEntry: Record "Prognosis/Allocation Entry";
    begin

        FilterSalespersCustAllocation(lrecPrognosisAllocationEntry);
        lrecPrognosisAllocationEntry.CalcSums("Allocated Cust. Sales person");
        exit(lrecPrognosisAllocationEntry."Allocated Cust. Sales person");

    end;

    local procedure AddSalespersCustAllocation()
    var
        lrecPrognosisAllocationEntry: Record "Prognosis/Allocation Entry";
        lExistingValue: Decimal;
        lChange: Decimal;
    begin

        FilterSalespersCustAllocation(lrecPrognosisAllocationEntry);
        if not lrecPrognosisAllocationEntry.IsEmpty then begin
            lExistingValue := GetSalespersCustAllocation;
            lChange := gAllocatedCustSalesperson - lExistingValue;
            if lChange <> 0 then begin
                lrecPrognosisAllocationEntry.Init;
                lrecPrognosisAllocationEntry."Internal Entry No." := 0;

                lrecPrognosisAllocationEntry."Item No." := "Item No.";
                lrecPrognosisAllocationEntry."Sales Date" := GetRangeMax("Date filter");
                lrecPrognosisAllocationEntry."Begin Date" := GetRangeMin("Date filter");
                lrecPrognosisAllocationEntry.Salesperson := Salesperson;
                lrecPrognosisAllocationEntry.Customer := Customer;
                lrecPrognosisAllocationEntry."Entry Type" := lrecPrognosisAllocationEntry."Entry Type"::Allocation;
                lrecPrognosisAllocationEntry.Validate("Allocated Cust. Sales person", lChange);
                lrecPrognosisAllocationEntry.Insert(true);
            end;
        end else
            Validate("Allocated Cust. Sales person", gAllocatedCustSalesperson);

    end;

    local procedure DrillDownSalespersCustAlloc()
    var
        lrecPrognosisAllocationEntry: Record "Prognosis/Allocation Entry";
    begin

        FilterSalespersCustAllocation(lrecPrognosisAllocationEntry);
        PAGE.RunModal(50094, lrecPrognosisAllocationEntry, lrecPrognosisAllocationEntry."Allocated Cust. Sales person");

    end;

    local procedure SalespersonOnAfterValidate()
    begin
        if "Item No." = '' then
            "Item No." := GetRangeMin("Item No.");
        grecPrognosisAllocationEntry.Reset;
        grecPrognosisAllocationEntry.SetCurrentKey("Entry Type", "Item No.", "Unit of Measure", "Sales Date", Salesperson);
        grecPrognosisAllocationEntry.SetRange("Item No.", "Item No.");
        grecPrognosisAllocationEntry.SetRange("Sales Date", grecBejoSetup."Begin Date", grecBejoSetup."End Date");
        grecPrognosisAllocationEntry.CalcSums(Prognoses);

    end;

    local procedure CustomerOnAfterValidate()
    begin
        if "Item No." = '' then begin
            "Item No." := GetRangeMin("Item No.");
        end;

        grecPrognosisAllocationEntry.Reset;
        grecPrognosisAllocationEntry.SetCurrentKey("Entry Type", "Item No.", "Unit of Measure", "Sales Date", Salesperson);
        grecPrognosisAllocationEntry.SetRange("Item No.", "Item No.");
        grecPrognosisAllocationEntry.SetRange("Sales Date", grecBejoSetup."Begin Date", grecBejoSetup."End Date");
        grecPrognosisAllocationEntry.CalcSums(Prognoses);

    end;

    local procedure gAllocatedCustSalespersonOnAft()
    var
        restant: Decimal;
    begin

        CurrPage.Update;

    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;

        gAllocatedCustSalesperson := GetSalespersCustAllocation;

    end;

    procedure ApplyFilters(DateFilterText: Text[250]; SalespersonfilterText: Text[250]; CustomerfilterText: Text[250])
    begin

        if DateFilterText <> '' then
            SetFilter("Date filter", DateFilterText)
        else
            SetRange("Date filter");

        if DateFilterText <> '' then
            SetFilter("Sales Date", DateFilterText)
        else
            SetRange("Sales Date");


        if SalespersonfilterText <> '' then begin
            SetFilter(Salesperson, SalespersonfilterText);
        end else
            SetRange(Salesperson);


        if CustomerfilterText <> '' then begin
            SetFilter(Customer, CustomerfilterText);
        end else
            SetRange(Customer);

    end;

    local procedure GetLastUserID1(): Code[50]
    var
        PrognosisAllocationEntry: Record "Prognosis/Allocation Entry";
    begin

        PrognosisAllocationEntry.SetCurrentKey("Internal Entry No.");
        PrognosisAllocationEntry.SetRange("Item No.", "Item No.");
        PrognosisAllocationEntry.SetRange(Salesperson, Salesperson);
        PrognosisAllocationEntry.SetRange(Customer, Customer);
        PrognosisAllocationEntry.SetRange("Date Modified", "Last Date Modified");
        if PrognosisAllocationEntry.FindLast then
            exit(PrognosisAllocationEntry."User-ID")
        else
            exit('');
    end;
}

