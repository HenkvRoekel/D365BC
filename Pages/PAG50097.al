page 50097 "Allocation Main"
{

    Caption = 'Allocation';
    DataCaptionFields = "No.", Description;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = Document;
    Permissions = TableData Item = rm;
    PopulateAllFields = true;
    SaveValues = true;
    ShowFilter = false;
    SourceTable = Item;
    SourceTableView = SORTING ("No.");

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; "No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Search Description"; "Search Description")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            group(Filters)
            {
                Caption = 'Filters';
                grid(Control22)
                {
                    GridLayout = Rows;
                    ShowCaption = false;
                    group(Control23)
                    {
                        ShowCaption = false;
                        field(StartingDate; StartingDate)
                        {
                            Caption = 'Begin Date';
                            ApplicationArea = All;

                            trigger OnValidate()
                            begin

                                CurrPage.SaveRecord;
                                SetRecFilters;
                                UpdateFields;

                            end;
                        }
                        field(EndingDate; EndingDate)
                        {
                            Caption = 'End Date';
                            ApplicationArea = All;

                            trigger OnValidate()
                            begin

                                CurrPage.SaveRecord;
                                SetRecFilters;
                                UpdateFields;

                            end;
                        }
                        field(SalespersonfilterText; SalespersonfilterText)
                        {
                            Caption = 'Salesperson';
                            TableRelation = "Salesperson/Purchaser";
                            ApplicationArea = All;

                            trigger OnValidate()
                            begin

                                CurrPage.SaveRecord;
                                SetRecFilters;
                                UpdateFields;

                            end;
                        }
                        field(CustomerfilterText; CustomerfilterText)
                        {
                            Caption = 'Customer';
                            TableRelation = Customer;
                            ApplicationArea = All;

                            trigger OnValidate()
                            begin

                                CurrPage.SaveRecord;
                                SetRecFilters;
                                UpdateFields;

                            end;
                        }
                    }
                }
            }
            part("Salesperson Allocation"; "Allocation Salesperson")
            {
                SubPageLink = "Item No." = FIELD ("No."),
                              "Date filter" = FIELD ("Date Filter"),
                              "Sales Date" = FIELD ("Date Filter");
                SubPageView = SORTING ("Entry Type", "Item No.", "Sales Date", Salesperson)
                              WHERE ("Entry Type" = FILTER (<> Prognoses),
                                    Salesperson = FILTER (<> ''));
                ApplicationArea = All;
            }
            part(Comments; "Alllocation Comment Line")
            {
                Caption = 'Comments';
                SubPageLink = "B Variety" = FIELD ("B Variety");
                SubPageView = SORTING ("Table Name", "B Comment Type", "No.", "B Variety")
                              WHERE ("Table Name" = CONST (Item),
                                    "B Comment Type" = FILTER ("Var 5 pos"));
                ApplicationArea = All;
            }
            part("Allocation Item"; "Allocation Item")
            {
                Caption = 'Variety';
                Editable = false;
                SubPageLink = "B Variety" = FIELD ("B Variety"),
                              "Date Filter" = FIELD ("Date Filter"),
                              "B Salespersonfilter" = FIELD ("B Salespersonfilter"),
                              "B Customerfilter" = FIELD ("B Customerfilter");
                ApplicationArea = All;
            }
            part(SubPageConsolidated; "Allocation Item Consolidated")
            {
                Caption = 'Consolidated';
                Editable = false;
                SubPageLink = "Date Filter" = FIELD ("Date Filter"),
                              "B Salespersonfilter" = FIELD ("B Salespersonfilter"),
                              "B Customerfilter" = FIELD ("B Customerfilter");
                ApplicationArea = All;
            }
        }
        area(factboxes)
        {
            part("Item Details"; "Allocation FactBox")
            {
                Caption = 'Item Details';
                SubPageLink = "No." = FIELD ("No.");
                ApplicationArea = All;
            }
            part(AllocationMainSubformPurch; "Allocation Main Subform Purch")
            {
                Caption = 'Allocation (Purchase)';
                SubPageLink = "No." = FIELD ("No.");
                ApplicationArea = All;
            }
            part(AllocationMainSubformSale; "Allocation Main Subform Sale")
            {
                Caption = 'Allocation (Sales)';
                ShowFilter = false;
                SubPageLink = "No." = FIELD ("No.");
                ApplicationArea = All;
            }
            part("Variety Details"; "Allocation FactBox2")
            {
                Caption = 'Variety Details';
                SubPageLink = "No." = FIELD ("No.");
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Bejo)
            {
                Caption = 'Bejo';
                action("Import &Allocation NL")
                {
                    Caption = 'Import &Allocation NL';
                    Ellipsis = true;
                    Image = Entry;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Report "Import Allocation";
                    ApplicationArea = All;
                }
                action("Import Comments NL")
                {
                    Caption = 'Import Comments NL';
                    Ellipsis = true;
                    Image = RoutingVersions;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Report "Import Item Remarks";
                    ApplicationArea = All;
                }
                action("Allocate Salesperson/Customer")
                {
                    Caption = 'Allocate Salesperson/Customer';
                    Image = BankAccount;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Commit;
                        grecItemUnit.SetRange(grecItemUnit."Item No.", "No.");
                        REPORT.Run(50043, true, true, grecItemUnit);
                    end;
                }
                action("Stock Information")
                {
                    Caption = 'Stock Information';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Stock Information";
                    RunPageLink = "No." = FIELD ("B Variety");
                    ShortCutKey = 'Shift+Ctrl+S';
                    ApplicationArea = All;
                }
                action("Print Allocation Total")
                {
                    Caption = 'Print Allocation Total';
                    Image = Totals;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Report "Total Country Allocation";
                    ApplicationArea = All;
                }
                action("Print Allocation per Salesperson")
                {
                    Caption = 'Print Allocation per Salesperson';
                    Image = SalesPerson;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Report "Allocation per Salesperson";
                    ApplicationArea = All;
                }
                action("Allocate Non Bejo Items")
                {
                    Caption = 'Allocate Non Bejo Items';
                    Image = Allocate;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        AllocateNonBejoItems: Page "Allocate Non Bejo Items";
                        BejoManagement: Codeunit "Bejo Management";
                        ctxtBEJOItem: Label 'This Item is a BEJO Item, this function cannot be used.';
                    begin

                        Commit;
                        if not BejoManagement.BejoItem("No.") then begin
                            AllocateNonBejoItems.SetItem("No.");
                            AllocateNonBejoItems.RunModal;
                            CurrPage.Update(false);
                        end else
                            Message(ctxtBEJOItem);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        UpdateFields;
        CalcPrognosisNextYear;
        SetRecFilters;
        CalcFields("B Description 3");

        SetRange("No.");
    end;

    trigger OnInit()
    begin
        grecBejoSetup.Get;
        grecCompanyInfo.Get;

        SetFilter("Date Filter", '%1..%2', grecBejoSetup."Begin Date", grecBejoSetup."End Date");

        StartingDate := grecBejoSetup."Begin Date";
        EndingDate := grecBejoSetup."End Date";
        DateFilterText := GetFilter("Date Filter")
    end;

    trigger OnOpenPage()
    begin
        grecBejoSetup.Get;
        grecCompanyInfo.Get;
        SetFilter("Date Filter", '%1..%2', grecBejoSetup."Begin Date", grecBejoSetup."End Date");
        DateFilterText := GetFilter("Date Filter");
        StartingDate := grecBejoSetup."Begin Date";
        EndingDate := grecBejoSetup."End Date";
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
        text50000: Label 'Million';
        grecItemExtension: Record "Item Extension";
        grecBejoSetup: Record "Bejo Setup";
        text50001: Label 'KG';
        gBeginLY: Date;
        gEndLY: Date;
        gInvoicedLY: Decimal;
        grecItemLedgerEntry: Record "Item Ledger Entry";
        "gUsed%": Decimal;
        gUsed: Code[30];
        lcuBlockingMgt: Codeunit "Blocking Management";
        gRestPurchase: Decimal;
        Text50002: Label 'Nothing found.';
        [InDataSet]
        PromoStatusText: Text[1024];
        DateFilterText: Text[250];
        SalespersonfilterText: Text[250];
        CustomerfilterText: Text[250];
        StartingDate: Date;
        EndingDate: Date;
        ProgNextYear: Decimal;

    procedure CalcPrognosisNextYear()
    var
        lFromDate: Date;
        lUptoDate: Date;
        lItem: Record Item;
        lPrognosisAllocationEntry: Record "Prognosis/Allocation Entry";
    begin

        lFromDate := CalcDate('<+1Y>', GetRangeMin("Date Filter"));
        lUptoDate := CalcDate('<+1Y>', GetRangeMax("Date Filter"));
        lPrognosisAllocationEntry.SetCurrentKey("Entry Type", "Item No.", "Sales Date");
        lPrognosisAllocationEntry.SetRange("Item No.", "No.");
        lPrognosisAllocationEntry.SetRange("Sales Date", lFromDate, lUptoDate);
        lPrognosisAllocationEntry.CalcSums(Prognoses);
        ProgNextYear := lPrognosisAllocationEntry.Prognoses;

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

    local procedure PromoStatusTextOnFormat(var Text: Text[1024])
    begin
        Text := "B DisplayPromoStatus";
    end;

    local procedure UpdateFields()
    begin
        CalcFields("Purchases (Qty.)", "Qty. on Purch. Order", "B Qty. on Purch. Quote", "B Country allocated");
        CalcFields("Sales (Qty.)", "B Qty. to Invoice");
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



        gRestPurchase := "B Country allocated" - ("Purchases (Qty.)" + "Qty. on Purch. Order" + "B Qty. on Purch. Quote"); // BEJOWW5.01.011

        PromoStatusText := Format("B Promo Status");
        PromoStatusTextOnFormat(PromoStatusText);


        CurrPage.AllocationMainSubformSale.PAGE.RefreshForm;
    end;

    local procedure SetRecFilters()
    begin
        CalcFields("B Prognoses", "B Allocated");

        DateFilterText := Format(StartingDate) + '..' + Format(EndingDate);
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

        CurrPage."Salesperson Allocation".PAGE.ApplyFilters(DateFilterText, SalespersonfilterText, CustomerfilterText);
        CurrPage."Allocation Item".PAGE.ApplyFilters(DateFilterText, SalespersonfilterText, CustomerfilterText);
        CurrPage.SubPageConsolidated.PAGE.ApplyFilters(DateFilterText, SalespersonfilterText, CustomerfilterText);
        CurrPage.SubPageConsolidated.PAGE.InitTempTable(Rec);


        CurrPage.AllocationMainSubformPurch.PAGE.SetFilters(gInvoicedLY, ProgNextYear, gRestPurchase,
                                                            grecItemLedgerEntry."Invoiced Quantity", "gUsed%", "B Prognoses", Rec);

        CurrPage.AllocationMainSubformSale.PAGE.SetFilters("B Country allocated" - "B Allocated", "B Country allocated" - "Sales (Qty.)" - "B Qty. to Invoice",
                                                            gInvoicedLY, Rec);

    end;
}

