report 50063 "Quantity to Purchase"
{

    DefaultLayout = RDLC;
    RDLCLayout = './RDLC/Quantity to Purchase.rdlc';


    dataset
    {
        dataitem(Item; Item)
        {
            CalcFields = Inventory, "B Country allocated", "B Promo Status";
            DataItemTableView = SORTING ("No.");
            RequestFilterFields = "No.", "Location Filter", "Date Filter";
            column(UserId; UserId)
            {
            }
            column(CompanyName; CompanyName)
            {
            }
            column(No_Item; Item."No.")
            {
                IncludeCaption = true;
            }
            column(Description_Item; Item.Description)
            {
                IncludeCaption = true;
            }
            column(Description2_Item; Item."Description 2")
            {
                IncludeCaption = true;
            }
            column(DisplayPromoStatus_Item; Item."B DisplayPromoStatus")
            {
            }
            column(gTxtItemFilter; gTxtItemFilter)
            {
            }
            dataitem("Item Unit of Measure"; "Item Unit of Measure")
            {
                DataItemLink = "Item No." = FIELD ("No.");
                DataItemTableView = SORTING ("Item No.", Code);
                column(BlockingCode; lcuBlockingMgt.ItemBlockDescription(Item))
                {
                }
                column(gFinal; gFinal)
                {
                }
                column(Code_ItemUnitofMeasure; "Item Unit of Measure".Code)
                {

                }
                column(SalesQty; SalesQty)
                {
                }
                column(TrackingQuantity; TrackingQuantity)
                {
                }
                column(Stock; Stock)
                {
                }
                column(PurchaseQty; PurchaseQty)
                {
                }
                column(QuantityToPurchase; QuantityToPurchase)
                {
                }
                column(AllocationDeficit; AllocationDeficit)
                {
                }
                column(show; show)
                {
                }

                trigger OnAfterGetRecord()
                var
                    AlternativeItemNo: Code[20];
                    AlternativeItemExist: Boolean;
                    lUnitofMeasure: Record "Unit of Measure";
                begin

                    if GetAlternativeItemNo("Item No.", AlternativeItemNo) then AlternativeItemExist := true;

                    ItemLedgerEntry.SetRange("Item No.", Item."No.");
                    ItemLedgerEntry.SetRange("Unit of Measure Code", Code);
                    ItemLedgerEntry.CalcSums("Remaining Quantity");
                    Stock := ItemLedgerEntry."Remaining Quantity";

                    ItemLedgerEntry.SetRange("Posting Date", 0D, grecBejoSetup."Begin Date" - 1);
                    ItemLedgerEntry.CalcSums(Quantity);
                    BeginStock := ItemLedgerEntry.Quantity;
                    ItemLedgerEntry.SetRange("Posting Date");


                    SalesLine.SetRange("No.", Item."No.");
                    SalesLine.SetFilter("Unit of Measure Code", Code);

                    TrackingQuantity := 0;
                    SalesQty := 0;
                    if SalesLine.Find('-') then
                        repeat
                            SalesLine.CalcFields("B Tracking Quantity");
                            SalesQty := SalesQty + SalesLine."Outstanding Qty. (Base)";
                            TrackingQuantity := TrackingQuantity + SalesLine."B Tracking Quantity";
                        until (SalesLine.Next = 0);


                    PurchaseLine.SetRange("No.", Item."No.");
                    PurchaseLine.SetFilter("Unit of Measure Code", Code);
                    PurchaseQty := 0;
                    if PurchaseLine.Find('-') then
                        repeat
                            PurchaseQty := PurchaseQty + PurchaseLine."Outstanding Qty. (Base)";
                        until (PurchaseLine.Next = 0);



                    grecPrognAlloc.SetRange("Item No.", Item."No.");
                    grecPrognAlloc.SetRange("Unit of Measure", Code);
                    grecPrognAlloc.CalcSums(Prognoses);
                    PrognosedQty := grecPrognAlloc.Prognoses;


                    grecILEPurch.SetRange("Item No.", Item."No.");
                    grecILEPurch.SetRange("Unit of Measure Code", Code);
                    grecILEPurch.CalcSums(Quantity);
                    PurchasedQty := grecILEPurch.Quantity;


                    grecILESales.SetRange("Item No.", Item."No.");
                    grecILESales.SetRange("Unit of Measure Code", Code);
                    grecILESales.CalcSums(Quantity);
                    SalesPreviousSeason := -grecILESales.Quantity;


                    gRecILESaleCurrSeason.SetRange("Item No.", Item."No.");
                    gRecILESaleCurrSeason.SetRange("Unit of Measure Code", Code);
                    gRecILESaleCurrSeason.CalcSums(Quantity);
                    SalesCurrSeason := -gRecILESaleCurrSeason.Quantity;

                    CountryAllocated := Item."B Country allocated";


                    if showConsolidated and GetAlternativeItemNo("Item No.", AlternativeItemNo) then begin
                        if "Item No." > AlternativeItemNo then CurrReport.Skip;
                        CalculateAlternative(AlternativeItemNo);
                    end;

                    if lUnitofMeasure.Get(Code) then
                        if not lUnitofMeasure."B Unit in Weight"
                            then
                            CountryAllocated := CountryAllocated * 1000000;


                    QuantityToPurchase := SalesQty - Stock - PurchaseQty;


                    if not gShowNegativeValues then
                        if QuantityToPurchase < 0 then QuantityToPurchase := 0;



                    if (CountryAllocated - PurchaseQty - PurchasedQty) <= 0
                      then
                        gFinal := true
                    else
                        gFinal := false;

                    AllocationDeficit := CountryAllocated - PurchaseQty - PurchasedQty - QuantityToPurchase;
                    if AllocationDeficit > 0 then AllocationDeficit := 0;

                    if PerUnit then begin
                        PurchaseQty := PurchaseQty / "Item Unit of Measure"."Qty. per Unit of Measure";
                        PurchasedQty := PurchasedQty / "Item Unit of Measure"."Qty. per Unit of Measure";
                        Stock := Stock / "Item Unit of Measure"."Qty. per Unit of Measure";
                        SalesQty := SalesQty / "Item Unit of Measure"."Qty. per Unit of Measure";
                        QuantityToPurchase := QuantityToPurchase / "Item Unit of Measure"."Qty. per Unit of Measure";
                        AllocationDeficit := AllocationDeficit / "Item Unit of Measure"."Qty. per Unit of Measure";
                        CountryAllocated := CountryAllocated / "Item Unit of Measure"."Qty. per Unit of Measure";
                        SalesPreviousSeason := SalesPreviousSeason / "Item Unit of Measure"."Qty. per Unit of Measure";

                        BeginStock := BeginStock / "Item Unit of Measure"."Qty. per Unit of Measure";
                        SalesCurrSeason := SalesCurrSeason / "Item Unit of Measure"."Qty. per Unit of Measure";

                    end
                    else
                        TrackingQuantity := TrackingQuantity * "Item Unit of Measure"."Qty. per Unit of Measure";

                    QuantityInunitofmeasure := (Stock - TrackingQuantity) / "Qty. per Unit of Measure";
                    show := ((SalesQty + Stock + PurchaseQty) <> 0) or ((CountryAllocated <> 0) and (PrognosedQty <> 0));

                    if PrintToExcel and show then begin
                        Row += 1;

                        EnterCell(Row, 1, "Item No.", false, false, '@', ExcelBuf."Cell Type"::Text);
                        EnterCell(Row, 2, Item.Description, false, false, '@', ExcelBuf."Cell Type"::Text);
                        EnterCell(Row, 3, Item."Description 2", false, false, '@', ExcelBuf."Cell Type"::Text);
                        EnterCell(Row, 4, ItemExtension."Extension Code", false, false, '@', ExcelBuf."Cell Type"::Text);
                        EnterCell(Row, 5, lcuBlockingMgt.ItemBlockDescription(Item), false, false, '@', ExcelBuf."Cell Type"::Text);
                        EnterCell(Row, 6, Format(Item."B DisplayPromoStatus"), false, false, '@', ExcelBuf."Cell Type"::Text);
                        EnterCell(Row, 7, Format(gFinal), false, false, '@', ExcelBuf."Cell Type"::Text);
                        EnterCell(Row, 8, Code, false, false, '@', ExcelBuf."Cell Type"::Text);
                        EnterCell(Row, 9, Format(SalesQty), false, false, '@', ExcelBuf."Cell Type"::Text);
                        EnterCell(Row, 10, Format(TrackingQuantity), false, false, '@', ExcelBuf."Cell Type"::Text);
                        EnterCell(Row, 11, Format(Stock), false, false, '@', ExcelBuf."Cell Type"::Text);
                        EnterCell(Row, 12, Format(PurchaseQty), false, false, '@', ExcelBuf."Cell Type"::Text);
                        EnterCell(Row, 13, Format(QuantityToPurchase), false, false, '@', ExcelBuf."Cell Type"::Text);
                        EnterCell(Row, 14, Format(AllocationDeficit), false, false, '@', ExcelBuf."Cell Type"::Text);
                        EnterCell(Row, 15, Format(CountryAllocated), false, false, '@', ExcelBuf."Cell Type"::Text);
                        EnterCell(Row, 16, Format(PurchasedQty), false, false, '@', ExcelBuf."Cell Type"::Text);
                        EnterCell(Row, 17, Format(SalesPreviousSeason), false, false, '@', ExcelBuf."Cell Type"::Text);
                        EnterCell(Row, 18, Format(SalesCurrSeason), false, false, '@', ExcelBuf."Cell Type"::Text);
                        EnterCell(Row, 19, Format(BeginStock), false, false, '@', ExcelBuf."Cell Type"::Text);
                    end;
                end;
            }

            trigger OnAfterGetRecord()
            var
                lSalesLine: Record "Sales Line";
            begin

                if ItemExtension.Get("B Extension") then;
                FirstOfItem := true;

                lSalesLine.SetCurrentKey(Type, "No.");
                lSalesLine.SetRange(lSalesLine."Document Type", lSalesLine."Document Type"::Order); // BEJOWW5.0.007
                lSalesLine.SetRange(lSalesLine.Type, lSalesLine.Type::Item);
                lSalesLine.SetRange("No.", "No.");
                TrackingQuantityPerItem := 0;
                if lSalesLine.Find('-') then
                    repeat
                        lSalesLine.CalcFields("B Tracking Quantity");
                        TrackingQuantityPerItem := TrackingQuantityPerItem +
                                                   (lSalesLine."B Tracking Quantity" * lSalesLine."Qty. per Unit of Measure");
                    until (lSalesLine.Next = 0);
            end;

            trigger OnPostDataItem()
            var
                Text50020: Label 'Excel file %1 is created and saved on %2';
            begin

                if PrintToExcel then begin

                    Row += 2;

                    FileName := text50000 + Format(Today, 0, '<Day,2>-<Month,2>-<Year>') + '.xls';

                end;
            end;

            trigger OnPreDataItem()
            begin


                gTxtItemFilter := Item.GetFilters;

                LastFieldNo := FieldNo("No.");
                Item.SetFilter("Date Filter", '%1..%2', grecBejoSetup."Begin Date", grecBejoSetup."End Date");
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(PerUnit; PerUnit)
                    {
                        Caption = 'Per Unit';
                        ApplicationArea = All;
                    }
                    field(ShowNegativeValues; gShowNegativeValues)
                    {
                        Caption = 'Show Also Negative Values';
                        ApplicationArea = All;
                    }
                    field(showConsolidated; showConsolidated)
                    {
                        Caption = 'Show Cumulated Data for HWT and non HWT NCT and non NCT';
                        Enabled = true;
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
        lblReportName = 'Quantity to purchase per Unit of Measure';
        lblBlockingCode = 'Blocking Code';
        lblPromoStatus = 'Promo Status';
        lblFinal = 'Final';
        lblUOMCode = 'Unit of Measure';
        lblInSalesOrder = 'In Sales Order';
        lblTrackingQuantity = 'Tracking Quantity';
        lblInventory = 'Inventory';
        lblInPurchaseOrder = 'In Purchase Order';
        lblToPurchase = 'To Purchase';
        lblAllocationDeficit = 'Allocation Deficit';
    }

    trigger OnInitReport()
    begin


        BejoSetup.Get;
        FileName := BejoSetup.ExportPath() + text50000 + '.xls';

    end;

    trigger OnPostReport()
    begin

        if PrintToExcel then begin
            ExcelBuf.CreateNewBook(text50000);
            ExcelBuf.WriteSheet(text50000, CompanyName, UserId);
            ExcelBuf.CloseBook;
            ExcelBuf.OpenExcel();
        end
    end;

    trigger OnPreReport()
    var
        text50001: Label 'Item No.';
        text50002: Label 'Description';
        text50003: Label 'Description 2';
        text50004: Label 'Item Extension';
        text50006: Label 'In Sales Order';
        text50007: Label 'Inventory';
        text50008: Label 'In Purchase Order';
        text50009: Label 'Unit of Measure';
        text50010: Label 'To Purchase';
        text50011: Label 'Tracking Quantity';
        text50012: Label 'Blocking Code';
        text50013: Label 'Promo Status';
        text50014: Label 'Final';
        text50015: Label 'Allocation Exceeded';
        text50016: Label 'Country Allocated';
        text50017: Label 'Purchased Qty';
        text50018: Label 'SalesPreviousSeason';
        text50019: Label 'SalesCurrSeason';
        text50020: Label 'Inventory at %1';
    begin
        ExcelBuf.DeleteAll;


        gLocationFilter := Item.GetFilter("Location Filter");
        gDate := Item.GetRangeMax("Date Filter");
        grecBejoSetup.Find('-');


        ItemLedgerEntry.SetCurrentKey("Item No.", "Source No.", "Unit of Measure Code", "Posting Date",
                                     "Entry Type", "Source Type", "B Salesperson", "Location Code");

        SalesLine.SetCurrentKey("Document Type", Type, "No.", "Unit of Measure Code", "Shipment Date",
                                "Location Code", "B Line type", "B Salesperson", "Sell-to Customer No.");
        SalesLine.SetRange(SalesLine."Document Type", SalesLine."Document Type"::Order);
        SalesLine.SetRange(SalesLine.Type, SalesLine.Type::Item);

        PurchaseLine.SetCurrentKey("Variant Code", "Drop Shipment", "Location Code", "No.", Type, "Document Type",
                                  "Requested Receipt Date", "Unit of Measure Code");
        PurchaseLine.SetRange(PurchaseLine."Document Type", PurchaseLine."Document Type"::Order);
        PurchaseLine.SetRange(PurchaseLine.Type, PurchaseLine.Type::Item);

        grecILEPurch.SetCurrentKey("Item No.", "Source No.", "Unit of Measure Code", "Posting Date",
                                "Entry Type", "Source Type", "B Salesperson", "Location Code");
        grecILEPurch.SetRange("Entry Type", grecILEPurch."Entry Type"::Purchase);
        grecILEPurch.SetRange("Source No.", grecBejoSetup."Vendor No. BejoNL");

        grecILESales.SetCurrentKey("Item No.", "Source No.", "Unit of Measure Code", "Posting Date",
                                "Entry Type", "Source Type", "B Salesperson", "Location Code");
        grecILESales.SetRange("Entry Type", grecILEPurch."Entry Type"::Sale);
        grecILESales.SetRange("Source Type", grecILESales."Source Type"::Customer);
        grecILESales.SetRange("Posting Date", CalcDate('<-1Y>', grecBejoSetup."Begin Date"), CalcDate('<-1Y>', grecBejoSetup."End Date"));

        grecPrognAlloc.SetCurrentKey("Entry Type", "Item No.", "Sales Date", "Unit of Measure", Salesperson);
        grecPrognAlloc.SetRange("Entry Type", grecPrognAlloc."Entry Type"::Prognoses);


        gRecILESaleCurrSeason.SetCurrentKey("Item No.", "Source No.", "Unit of Measure Code", "Posting Date",
                                "Entry Type", "Source Type", "B Salesperson", "Location Code");
        gRecILESaleCurrSeason.SetRange("Entry Type", gRecILESaleCurrSeason."Entry Type"::Sale);
        gRecILESaleCurrSeason.SetRange("Source Type", gRecILESaleCurrSeason."Source Type"::Customer);


        if gLocationFilter <> '' then begin
            ItemLedgerEntry.SetFilter("Location Code", gLocationFilter);
            SalesLine.SetFilter("Location Code", gLocationFilter);
            PurchaseLine.SetFilter("Location Code", gLocationFilter);
            grecILEPurch.SetFilter("Location Code", gLocationFilter);
            grecILESales.SetFilter("Location Code", gLocationFilter);
            gRecILESaleCurrSeason.SetFilter("Location Code", gLocationFilter);
        end;
        if gDate <> 0D then begin
            SalesLine.SetRange("Shipment Date", grecBejoSetup."Begin Date", gDate);
            PurchaseLine.SetRange("Requested Receipt Date", grecBejoSetup."Begin Date", gDate);
            grecILEPurch.SetRange("Posting Date", grecBejoSetup."Begin Date", gDate);
            grecPrognAlloc.SetRange("Sales Date", grecBejoSetup."Begin Date", gDate);
            gRecILESaleCurrSeason.SetRange("Posting Date", grecBejoSetup."Begin Date", gDate);
        end;

        if PrintToExcel then begin
            EnterCell(1, 1, text50000, true, false, '@', ExcelBuf."Cell Type"::Text);
            EnterCell(1, 19, Format(Today), true, false, '@', ExcelBuf."Cell Type"::Text);
            EnterCell(2, 1, CompanyName, true, false, '@', ExcelBuf."Cell Type"::Text);
            EnterCell(2, 19, UserId, true, false, '@', ExcelBuf."Cell Type"::Text);
            EnterCell(4, 1, text50001, true, false, '@', ExcelBuf."Cell Type"::Text);
            EnterCell(4, 2, text50002, true, false, '@', ExcelBuf."Cell Type"::Text);
            EnterCell(4, 3, text50003, true, false, '@', ExcelBuf."Cell Type"::Text);
            EnterCell(4, 4, text50004, true, false, '@', ExcelBuf."Cell Type"::Text);
            EnterCell(4, 5, text50012, true, false, '@', ExcelBuf."Cell Type"::Text);
            EnterCell(4, 6, text50013, true, false, '@', ExcelBuf."Cell Type"::Text);
            EnterCell(4, 7, text50014, true, false, '@', ExcelBuf."Cell Type"::Text);
            EnterCell(4, 8, text50009, true, false, '@', ExcelBuf."Cell Type"::Text);
            EnterCell(4, 9, text50006, true, false, '@', ExcelBuf."Cell Type"::Text);
            EnterCell(4, 10, text50011, true, false, '@', ExcelBuf."Cell Type"::Text);
            EnterCell(4, 11, text50007, true, false, '@', ExcelBuf."Cell Type"::Text);
            EnterCell(4, 12, text50008, true, false, '@', ExcelBuf."Cell Type"::Text);
            EnterCell(4, 13, text50010, true, false, '@', ExcelBuf."Cell Type"::Text);
            EnterCell(4, 14, text50015, true, false, '@', ExcelBuf."Cell Type"::Text);
            EnterCell(4, 15, text50016, true, false, '@', ExcelBuf."Cell Type"::Text);
            EnterCell(4, 16, text50017, true, false, '@', ExcelBuf."Cell Type"::Text);
            EnterCell(4, 17, text50018, true, false, '@', ExcelBuf."Cell Type"::Text);
            EnterCell(4, 18, text50019, true, false, '@', ExcelBuf."Cell Type"::Text);
            EnterCell(4, 19, StrSubstNo(text50020, grecBejoSetup."Begin Date"), true, false, '@', ExcelBuf."Cell Type"::Text);
            Row := 4;
        end;

    end;

    var
        LastFieldNo: Integer;
        ItemLedgerEntry: Record "Item Ledger Entry";
        SalesLine: Record "Sales Line";
        SalesQty: Decimal;
        TrackingQuantity: Decimal;
        ItemExtension: Record "Item Extension";
        FirstOfItem: Boolean;
        QuantityInunitofmeasure: Decimal;
        PrintToExcel: Boolean;
        Row: Integer;
        TrackingQuantityPerItem: Decimal;
        PurchaseQty: Decimal;
        PurchaseLine: Record "Purchase Line";
        QuantityToPurchase: Decimal;
        PerUnit: Boolean;
        gcuBejoMgt: Codeunit "Bejo Management";
        gFinal: Boolean;
        AllocationDeficit: Decimal;
        gLocationFilter: Text[1024];
        gDate: Date;
        grecBejoSetup: Record "Bejo Setup";
        grecILEPurch: Record "Item Ledger Entry";
        Stock: Decimal;
        PurchasedQty: Decimal;
        CountryAllocated: Decimal;
        showConsolidated: Boolean;
        SalesPreviousSeason: Decimal;
        grecILESales: Record "Item Ledger Entry";
        BejoSetup: Record "Bejo Setup";
        FileName: Text[250];
        grecPrognAlloc: Record "Prognosis/Allocation Entry";
        PrognosedQty: Decimal;
        show: Boolean;
        lcuBlockingMgt: Codeunit "Blocking Management";
        gTxtItemFilter: Text[250];
        BeginStock: Decimal;
        gRecILESaleCurrSeason: Record "Item Ledger Entry";
        SalesCurrSeason: Decimal;
        gShowNegativeValues: Boolean;
        text50000: Label 'Quantity to Purchase';
        ExcelBuf: Record "Excel Buffer" temporary;

    procedure GetAlternativeItemNo(ItemNo: Code[20]; var AlternativeItemNo: Code[20]): Boolean
    var
        lrecItem: Record Item;
        lExtension: Code[1];
    begin

        lrecItem.Get(ItemNo);

        lExtension := CopyStr(lrecItem."No.", StrLen(lrecItem."No."), 1);
        case lExtension of
            '0':
                AlternativeItemNo := CopyStr(lrecItem."No.", 1, StrLen(lrecItem."No.") - 1) + '4';
            '4':
                AlternativeItemNo := CopyStr(lrecItem."No.", 1, StrLen(lrecItem."No.") - 1) + '0';
            '1':
                AlternativeItemNo := CopyStr(lrecItem."No.", 1, StrLen(lrecItem."No.") - 1) + '5';
            '5':
                AlternativeItemNo := CopyStr(lrecItem."No.", 1, StrLen(lrecItem."No.") - 1) + '1';
        end;

        exit((AlternativeItemNo <> ''));

    end;

    procedure CalculateAlternative(AlternativeItemNo: Code[20])
    var
        lrecItem: Record Item;
    begin

        ItemLedgerEntry.SetRange("Item No.", AlternativeItemNo);
        ItemLedgerEntry.CalcSums("Remaining Quantity");
        Stock := Stock + ItemLedgerEntry."Remaining Quantity";

        SalesLine.SetRange("No.", AlternativeItemNo);
        if SalesLine.Find('-') then
            repeat
                SalesLine.CalcFields("B Tracking Quantity");
                SalesQty := SalesQty + SalesLine."Outstanding Qty. (Base)";
                TrackingQuantity := TrackingQuantity + SalesLine."B Tracking Quantity";
            until (SalesLine.Next = 0);

        PurchaseLine.SetRange("No.", AlternativeItemNo);
        if PurchaseLine.Find('-') then
            repeat
                PurchaseQty := PurchaseQty + PurchaseLine."Outstanding Qty. (Base)";
            until (PurchaseLine.Next = 0);

        grecILEPurch.SetRange("Item No.", AlternativeItemNo);
        grecILEPurch.CalcSums(Quantity);
        PurchasedQty := PurchasedQty + grecILEPurch.Quantity;

        grecILESales.SetRange("Item No.", AlternativeItemNo);
        grecILESales.CalcSums(Quantity);
        SalesPreviousSeason := SalesPreviousSeason - grecILESales.Quantity;

        grecPrognAlloc.SetRange("Item No.", AlternativeItemNo);
        grecPrognAlloc.CalcSums(Prognoses);
        PrognosedQty := PrognosedQty + grecPrognAlloc.Prognoses;

        if lrecItem.Get(AlternativeItemNo) then begin
            lrecItem.CalcFields("B Country allocated");
            CountryAllocated := CountryAllocated + lrecItem."B Country allocated";
        end;

    end;

    local procedure EnterCell(RowNo: Integer; ColumnNo: Integer; CellValue: Text[250]; Bold: Boolean; UnderLine: Boolean; NumberFormat: Text[30]; CellType: Option)
    begin
        ExcelBuf.Init;
        ExcelBuf.Validate("Row No.", RowNo);
        ExcelBuf.Validate("Column No.", ColumnNo);
        ExcelBuf."Cell Value as Text" := CellValue;
        ExcelBuf.Formula := '';
        ExcelBuf.Bold := Bold;
        ExcelBuf.Underline := UnderLine;
        ExcelBuf.NumberFormat := NumberFormat;
        ExcelBuf."Cell Type" := CellType;
        ExcelBuf.Insert;
    end;
}

