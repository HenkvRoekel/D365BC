page 50015 "Stock Info Progn/Alloc FactBox"
{

    Caption = 'Stock Information';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = CardPart;
    SourceTable = Varieties;

    layout
    {
        area(content)
        {
            group("Progn/Alloc")
            {
                Caption = 'Prognoses / Allocations';
                field(Allocated; TotalAllocated)
                {
                    DecimalPlaces = 3 : 3;
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Allocated KG"; TotalAllocatedKG)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Prognoses "; TotalPrognosis)
                {
                    DecimalPlaces = 3 : 3;
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Prosnoses KG"; TotalPrognosisKG)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Received; TotReceived)
                {
                    DecimalPlaces = 3 : 3;
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Received KG"; TotReceivedKG)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Formule; TotalAllocated - TotReceived - TotPurchase)
                {
                    DecimalPlaces = 3 : 3;
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Formule KG"; TotalAllocatedKG - TotReceivedKG - TotPurchaseKG)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Total Purchase"; TotPurchase)
                {
                    Caption = 'Total Purchase';
                    DecimalPlaces = 3 : 3;
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Total Purchase KG"; TotPurchaseKG)
                {
                    Caption = 'Total Purchase KG';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Until Week <"; "UntilWeek<")
                {
                    DecimalPlaces = 3 : 3;
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Until Week KG <"; "UntilWeek<KG")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Until Week"; UntilWeek)
                {
                    DecimalPlaces = 3 : 3;
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Until Week KG"; UntilWeekKG)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Until Week +1"; "UntilWeek+1")
                {
                    DecimalPlaces = 3 : 3;
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Until Week +1 KG"; "UntilWeek+1KG")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Until Week +2"; "UntilWeek+2")
                {
                    DecimalPlaces = 3 : 3;
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Until Week +2 KG"; "UntilWeek+2KG")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Until Week >"; "UntilWeek>")
                {
                    DecimalPlaces = 3 : 3;
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Until Week KG > "; "UntilWeek>KG")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Block Entries")
            {
                ShortCutKey = 'Ctrl+B';
                ApplicationArea = All;
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        lItem: Record Item;
        lUnitofMeasure: Record "Unit of Measure";
        lPackageOnSalesOrder: Decimal;
        lRemainingPackage: Decimal;
        lPackageOnSalesOrderKG: Decimal;
        lRemainingPackageKG: Decimal;
    begin
        grecTmpItemUnit.SetRange(Variety, "No.");
        grecTmpItemUnit.SetFilter("Date Filter", GetFilter("Date filter"));
        grecTmpItemUnit.SetFilter("Unit of Measure", '<>''''');

        OpenStock := 0;
        TotalStock := 0;
        TotalOpenStock := 0;
        TotalStock1 := 0;
        TotalStock1KG := 0;
        TotalOpenstock1 := 0;
        TotalOpenstock1KG := 0;
        TotalTotalStock := 0;
        TotalOpenStockKG := 0;
        TotalTotalStockKG := 0;
        TotalRes := 0;
        TotalResKG := 0;
        TotalOpen := 0;
        TotalOpenKG := 0;
        TotalAllocated := 0;
        TotalPrognosis := 0;
        TotalAllocatedKG := 0;
        TotalPrognosisKG := 0;
        TotPurchase := 0;
        "UntilWeek<" := 0;
        UntilWeek := 0;
        "UntilWeek+1" := 0;
        "UntilWeek+2" := 0;
        "UntilWeek>" := 0;
        UntilWeekKG := 0;
        "UntilWeek+1KG" := 0;
        "UntilWeek+2KG" := 0;
        "UntilWeek>KG" := 0;
        "UntilWeek<KG" := 0;
        TotPurchaseKG := 0;
        TotReceived := 0;
        TotReceivedKG := 0;
        TotQuote := 0;
        TotQuoteKG := 0;

        lItem.SetCurrentKey("B Variety");
        lItem.SetRange("B Variety", "No.");
        if lItem.FindSet then repeat
                                  CopyFilter("Date filter", lItem."Date Filter");
                                  lItem.CalcFields("B Country allocated");
                                  lItem.SetFilter("Date Filter", '');
                                  lItem.CalcFields("B Tracking Qty on Sales Orders", "B Tracking Units on Sales Ords");
                                  if lUnitofMeasure.Get(lItem."Base Unit of Measure") then;
                                  if not lUnitofMeasure."B Unit in Weight" then begin
                                      TotalAllocated := TotalAllocated + lItem."B Country allocated";
                                      TotalRes := TotalRes + lItem."B Tracking Qty on Sales Orders";
                                      lPackageOnSalesOrder := lPackageOnSalesOrder + lItem."B Tracking Units on Sales Ords";
                                  end else begin
                                      TotalAllocatedKG := TotalAllocatedKG + lItem."B Country allocated";
                                      TotalResKG := TotalResKG + lItem."B Tracking Qty on Sales Orders";
                                      lPackageOnSalesOrderKG := lPackageOnSalesOrderKG + lItem."B Tracking Units on Sales Ords";
                                  end;
            until lItem.Next = 0;



        grecItemLedgerEntry.SetCurrentKey("B Variety", Open);
        grecItemLedgerEntry.SetRange(Open, true);
        grecItemLedgerEntry.SetRange("B Variety", "No.");
        if grecItemLedgerEntry.FindSet then
            repeat

                if grecItemLedgerEntry."Qty. per Unit of Measure" = 0 then
                    grecItemLedgerEntry."Qty. per Unit of Measure" := 1;


                OpenStock := (grecItemLedgerEntry."Remaining Quantity" - lItem."B Tracking Qty on Sales Orders")
                           / grecItemLedgerEntry."Qty. per Unit of Measure";

                TotalStock := grecItemLedgerEntry."Remaining Quantity" - lItem."B Tracking Qty on Sales Orders";


                if grecUnitofMeasure.Get(grecItemLedgerEntry."Unit of Measure Code") then;
                if grecUnitofMeasure."B Unit in Weight" = false then begin
                    TotalOpenstock1 := TotalOpenstock1 + (grecItemLedgerEntry."Remaining Quantity" / grecItemLedgerEntry."Qty. per Unit of Measure");
                    TotalStock1 := TotalStock1 + grecItemLedgerEntry."Remaining Quantity";

                    lRemainingPackage := lRemainingPackage +
                                         (grecItemLedgerEntry."Remaining Quantity"
                                         / grecItemLedgerEntry."Qty. per Unit of Measure");
                end else begin
                    TotalOpenstock1KG := TotalOpenstock1KG + (grecItemLedgerEntry."Remaining Quantity"
                                        / grecItemLedgerEntry."Qty. per Unit of Measure");
                    TotalStock1KG := TotalStock1KG + grecItemLedgerEntry."Remaining Quantity";

                    TotalTotalStockKG := TotalTotalStockKG + TotalStock;
                    lRemainingPackageKG := lRemainingPackageKG +
                                         (grecItemLedgerEntry."Remaining Quantity"
                                          / grecItemLedgerEntry."Qty. per Unit of Measure");
                end;
            until grecItemLedgerEntry.Next = 0;

        grecSalesLine.SetCurrentKey("Document Type", Type, "B Variety");
        grecSalesLine.SetRange("Document Type", grecSalesLine."Document Type"::Order);
        grecSalesLine.SetRange(Type, grecSalesLine.Type::Item);
        grecSalesLine.SetRange(grecSalesLine."B Variety", "No.");
        if grecSalesLine.FindSet then
            repeat
                if grecUnitofMeasure.Get(grecSalesLine."Unit of Measure Code") then;
                if grecUnitofMeasure."B Unit in Weight" = false then begin
                    TotalOpen := TotalOpen + grecSalesLine."Outstanding Qty. (Base)";

                end else begin
                    TotalOpenKG := TotalOpenKG + grecSalesLine."Outstanding Qty. (Base)";

                end;
            until grecSalesLine.Next = 0;

        TotalOpenStock := lRemainingPackage - lPackageOnSalesOrder;
        TotalTotalStock := TotalStock1 - TotalRes;
        TotalOpenStockKG := lRemainingPackageKG - lPackageOnSalesOrderKG;
        TotalTotalStockKG := TotalStock1KG - TotalResKG;

        grecItemUnit.SetCurrentKey(Variety);
        grecItemUnit.SetRange(Variety, "No.");
        grecItemUnit.SetFilter("Unit of Measure", '<>%1', '');


        CopyFilter("Date filter", grecItemUnit."Date Filter");

        if grecItemUnit.FindSet then
            repeat
                grecItemUnit.CalcFields(Allocated, Prognoses);
                if grecItem.Get(grecItemUnit."Item No.") then;

                if lUnitofMeasure.Get(grecItem."Base Unit of Measure") then;

                if not lUnitofMeasure."B Unit in Weight" then
                    TotalPrognosis := TotalPrognosis + grecItemUnit.Prognoses
                else
                    TotalPrognosisKG := TotalPrognosisKG + grecItemUnit.Prognoses;
            until grecItemUnit.Next = 0;


        grecItemLedgerEntry1.SetCurrentKey("Entry Type", "B Variety", "Posting Date", Open);

        CopyFilter("Date filter", grecItemLedgerEntry1."Posting Date");

        grecItemLedgerEntry1.SetRange("B Variety", "No.");
        grecItemLedgerEntry1.SetRange("Entry Type", grecItemLedgerEntry1."Entry Type"::Purchase);
        if grecItemLedgerEntry1.FindSet then
            repeat
                if grecUnitofMeasure.Get(grecItemLedgerEntry1."Unit of Measure Code") then;
                if grecUnitofMeasure."B Unit in Weight" = false then
                    TotReceived := TotReceived + grecItemLedgerEntry1."Invoiced Quantity"
                else
                    TotReceivedKG := TotReceivedKG + grecItemLedgerEntry1."Invoiced Quantity";
            until grecItemLedgerEntry1.Next = 0;

        grecPurchaseLine.SetCurrentKey("Document Type", Type, "B Variety");
        grecPurchaseLine.SetRange("Document Type", grecPurchaseLine."Document Type"::Order);
        grecPurchaseLine.SetRange(Type, grecPurchaseLine.Type::Item);
        grecPurchaseLine.SetRange("B Variety", "No.");
        grecPurchaseLine.CalcSums(grecPurchaseLine."Outstanding Qty. (Base)");
        if grecPurchaseLine.FindSet then begin
            repeat
                if grecUnitofMeasure.Get(grecPurchaseLine."Unit of Measure Code") then;
                if grecPurchaseLine."Requested Receipt Date" <> 0D then
                    RowWeekNo := Date2DWY(grecPurchaseLine."Requested Receipt Date", 2)
                else
                    RowWeekNo := 52;

                if grecPurchaseLine."Requested Receipt Date" <> 0D then
                    if Date2DWY(Today, 3) < Date2DWY(grecPurchaseLine."Requested Receipt Date", 3) then
                        RowWeekNo := RowWeekNo + 52;

                if RowWeekNo < CurrentWeekNo then
                    if grecUnitofMeasure."B Unit in Weight" = false then
                        "UntilWeek<" := "UntilWeek<" + grecPurchaseLine."Outstanding Qty. (Base)"
                    else
                        "UntilWeek<KG" := "UntilWeek<KG" + grecPurchaseLine."Outstanding Qty. (Base)";
                if RowWeekNo = CurrentWeekNo then
                    if grecUnitofMeasure."B Unit in Weight" = false then
                        UntilWeek := UntilWeek + grecPurchaseLine."Outstanding Qty. (Base)"
                    else
                        UntilWeekKG := UntilWeekKG + grecPurchaseLine."Outstanding Qty. (Base)";
                if RowWeekNo = CurrentWeekNo + 1 then
                    if grecUnitofMeasure."B Unit in Weight" = false then
                        "UntilWeek+1" := "UntilWeek+1" + grecPurchaseLine."Outstanding Qty. (Base)"
                    else
                        "UntilWeek+1KG" := "UntilWeek+1KG" + grecPurchaseLine."Outstanding Qty. (Base)";
                if RowWeekNo = CurrentWeekNo + 2 then
                    if grecUnitofMeasure."B Unit in Weight" = false then
                        "UntilWeek+2" := "UntilWeek+2" + grecPurchaseLine."Outstanding Qty. (Base)"
                    else
                        "UntilWeek+2KG" := "UntilWeek+2KG" + grecPurchaseLine."Outstanding Qty. (Base)";
                if RowWeekNo > CurrentWeekNo + 2 then
                    if grecUnitofMeasure."B Unit in Weight" = false then
                        "UntilWeek>" := "UntilWeek>" + grecPurchaseLine."Outstanding Qty. (Base)"
                    else
                        "UntilWeek>KG" := "UntilWeek>KG" + grecPurchaseLine."Outstanding Qty. (Base)";
            until grecPurchaseLine.Next = 0;
            TotPurchase := "UntilWeek<" + UntilWeek + "UntilWeek+1" + "UntilWeek+2" + "UntilWeek>";
            TotPurchaseKG := "UntilWeek<KG" + UntilWeekKG + "UntilWeek+1KG" + "UntilWeek+2KG" + "UntilWeek>KG";
        end;

        grecPurchaseLine1.SetCurrentKey("Document Type", Type, "B Variety");
        grecPurchaseLine1.SetRange("Document Type", grecPurchaseLine1."Document Type"::Quote);
        grecPurchaseLine1.SetRange(Type, grecPurchaseLine1.Type::Item);
        grecPurchaseLine1.SetRange("B Variety", "No.");
        grecPurchaseLine1.CalcSums(grecPurchaseLine1."Outstanding Qty. (Base)");
        if grecPurchaseLine1.FindSet then begin
            repeat
                if grecUnitofMeasure.Get(grecPurchaseLine1."Unit of Measure Code") then;
                if grecUnitofMeasure."B Unit in Weight" = false then
                    TotQuote := TotQuote + grecPurchaseLine1."Outstanding Qty. (Base)"
                else
                    TotQuoteKG := TotQuoteKG + grecPurchaseLine1."Outstanding Qty. (Base)";
            until grecPurchaseLine1.Next = 0;
            TotReceivedKG := (TotReceivedKG + TotQuoteKG);
        end;

        TotalOpen := TotalOpen / 1000000;
        TotalStock := TotalStock / 1000000;
        TotalStock1 := TotalStock1 / 1000000;
        TotalTotalStock := TotalTotalStock / 1000000;
        TotalRes := TotalRes / 1000000;
        "UntilWeek<" := "UntilWeek<" / 1000000;
        UntilWeek := UntilWeek / 1000000;
        "UntilWeek+1" := "UntilWeek+1" / 1000000;
        "UntilWeek+2" := "UntilWeek+2" / 1000000;
        "UntilWeek>" := "UntilWeek>" / 1000000;
        TotPurchase := TotPurchase / 1000000;
        TotReceived := (TotReceived + TotQuote) / 1000000;
        PromoStatusText := Format("Promo Status");
        PromoStatusTextOnPageat(PromoStatusText);
    end;

    trigger OnInit()
    begin
        CurrentWeekNo := Date2DWY(Today, 2);

    end;

    trigger OnOpenPage()
    var
        lrecBejoSetup: Record "Bejo Setup";
    begin
        gLanguageCode := '';

        lrecBejoSetup.Get;
        SetRange("Date filter", lrecBejoSetup."Begin Date", lrecBejoSetup."End Date");

    end;

    var
        OpenStock: Decimal;
        TotalOpenstock1: Decimal;
        TotalOpenstock1KG: Decimal;
        TotalOpen: Decimal;
        TotalOpenKG: Decimal;
        TotalOpenStock: Decimal;
        TotalOpenStockKG: Decimal;
        TotalStock: Decimal;
        TotalStock1: Decimal;
        TotalStock1KG: Decimal;
        TotalTotalStock: Decimal;
        TotalTotalStockKG: Decimal;
        TotalRes: Decimal;
        TotalResKG: Decimal;
        grecItemLedgerEntry: Record "Item Ledger Entry";
        grecItemLedgerEntry1: Record "Item Ledger Entry";
        grecSalesLine: Record "Sales Line";
        grecItemUnit: Record "Item/Unit";
        TotalAllocated: Decimal;
        TotalAllocatedKG: Decimal;
        TotalPrognosis: Decimal;
        TotalPrognosisKG: Decimal;
        grecPurchaseLine: Record "Purchase Line";
        CurrentWeekNo: Integer;
        RowWeekNo: Integer;
        "UntilWeek<": Decimal;
        "UntilWeek<KG": Decimal;
        UntilWeek: Decimal;
        UntilWeekKG: Decimal;
        "UntilWeek+1": Decimal;
        "UntilWeek+1KG": Decimal;
        "UntilWeek+2": Decimal;
        "UntilWeek+2KG": Decimal;
        "UntilWeek>": Decimal;
        "UntilWeek>KG": Decimal;
        TotPurchase: Decimal;
        TotPurchaseKG: Decimal;
        grecUnitofMeasure: Record "Unit of Measure";
        TotReceived: Decimal;
        TotReceivedKG: Decimal;
        gLanguageCode: Code[10];
        TotQuote: Decimal;
        TotQuoteKG: Decimal;
        grecPurchaseLine1: Record "Purchase Line";
        grecItem: Record Item;
        grecTmpItemUnit: Record "Item/Unit";
        lcuBlockingMgt: Codeunit "Blocking Management";
        [InDataSet]
        PromoStatusText: Text[1024];
        Text19038312: Label 'Prognoses / Allocation';
        Text19028226: Label 'Total';
        Text19057413: Label 'Million';
        Text19028109: Label 'KG';
        Text19080001: Label 'Total';
        Text19080002: Label 'Million';
        Text19080003: Label 'KG';
        Placeholder: Integer;
        Placeholder2: Integer;
        Placeholder3: Integer;
        Placeholder4: Integer;
        Placeholder5: Integer;
        Placeholder6: Integer;
        Placeholder7: Integer;
        Placeholder8: Integer;
        Placeholder9: Integer;
        Placeholder10: Integer;
        Placeholder11: Integer;
        Placeholder12: Integer;
        pagVarieties: Page "Varieties List";
        recVarieties: Record Varieties;

    local procedure OnTimer()
    begin
        grecTmpItemUnit.SetRange(Variety, "No.");

    end;

    local procedure PromoStatusTextOnPageat(var Text: Text[1024])
    begin
        Text := DisplayPromoStatus
    end;
}

