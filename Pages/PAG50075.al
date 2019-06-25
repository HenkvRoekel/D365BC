page 50075 "Item Year Prog FactBox"
{

    Caption = 'Item Year Prognoses';
    Editable = false;
    PageType = CardPart;
    SourceTable = "Item/Unit";

    layout
    {
        area(content)
        {
            group(Control2)
            {
                ShowCaption = false;
                field("Prognose[1]"; Prognose[1])
                {
                    Caption = 'Curr. Season+1';
                    DecimalPlaces = 0 : 4;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
            }
            group(Control13)
            {
                ShowCaption = false;
                field("Prognose[2]"; Prognose[2])
                {
                    Caption = 'Curr. Season+2';
                    DecimalPlaces = 0 : 4;
                    ApplicationArea = All;
                }
            }
            group(Control14)
            {
                ShowCaption = false;
                field("Prognose[3]"; Prognose[3])
                {
                    Caption = 'Curr. Season+3';
                    DecimalPlaces = 0 : 4;
                    ApplicationArea = All;
                }
            }
            group(Control15)
            {
                ShowCaption = false;
                field("Prognose[4]"; Prognose[4])
                {
                    Caption = 'Curr. Season+4';
                    DecimalPlaces = 0 : 4;
                    ApplicationArea = All;
                }
            }
            group(Control16)
            {
                ShowCaption = false;
                field("Prognose[5]"; Prognose[5])
                {
                    Caption = 'Curr. Season+5';
                    DecimalPlaces = 0 : 4;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    var
        lVarietyLandUnitofmeasure: Record "Item/Unit";
        n: Integer;
        lrecSalesPerson: Record "Salesperson/Purchaser";
        lrecCustomer: Record Customer;
        lrecUOM: Record "Unit of Measure";
        MATRIX_CurrentColumnOrdinal: Integer;
    begin
        CalcFields("Promo Status", "Search Description");

        gInvoiced := 0;
        gInvoiced1 := 0;
        gInvoicedLY := 0;
        gPrognosed := 0;
        gPrognosedLY := 0;


        if grecUserSetup."B Department" = 'SALESP' then
            SetRange("Sales Person Filter", grecUserSetup."B Initials");

        grecItemUnit.SetRange(grecItemUnit."Item No.", grecItem."No.");
        grecItemUnit.SetRange("Date Filter", gBeginDateLY, gEndDateLY);
        if grecItemUnit.Find('-') then
            repeat
                grecItemUnit.CalcFields(Invoiced, Prognoses);
                gInvoicedLY := gInvoicedLY + grecItemUnit.Invoiced;
                gPrognosedLY := gPrognosedLY + grecItemUnit.Prognoses;
            until grecItemUnit.Next = 0;

        if not grecUnitofMeasure.Get("Unit of Measure") then
            grecUnitofMeasure.Init;
        if grecUnitofMeasure."B Unit in Weight" = true then begin
            gInvoiced := Abs(gInvoiced);
            gInvoiced1 := Abs(gInvoiced1);
            gInvoicedLY := Abs(gInvoicedLY);
        end else begin
            gInvoiced := Abs(gInvoiced) / 1000000;
            gInvoicedLY := Abs(gInvoicedLY) / 1000000;
            gInvoiced1 := Abs(gInvoiced1) / 1000000;
        end;

        if not grecItemExtension.Get(grecItem."B Extension", '') then
            grecItemExtension.Init;
        if grecItem."B Organic" = true then
            grecItemExtension.Description := '';

        // - BEJOWW3.70.001 ---
        if (GetFilter("Sales Person Filter") <> '') or (GetFilter("Customer Filter") <> '') then begin
            if GetFilter("Sales Person Filter") <> '' then begin
                gFilter_description := GetFilter("Sales Person Filter");
                if GetFilter("Customer Filter") <> '' then
                    gFilter_description := gFilter_description + ' ' + GetFilter("Customer Filter");
            end else
                if GetFilter("Customer Filter") <> '' then
                    gFilter_description := GetFilter("Customer Filter");


            lVarietyLandUnitofmeasure.SetRange(lVarietyLandUnitofmeasure."Item No.", "Item No.");
            lVarietyLandUnitofmeasure.SetRange("Date Filter", gBeginDate, gEndDate);
            if GetFilter("Sales Person Filter") <> '' then
                lVarietyLandUnitofmeasure.SetRange(lVarietyLandUnitofmeasure."Sales Person Filter", GetFilter("Sales Person Filter"));
            if GetFilter("Customer Filter") <> '' then
                lVarietyLandUnitofmeasure.SetRange(lVarietyLandUnitofmeasure."Customer Filter", GetFilter("Customer Filter"));

            if lVarietyLandUnitofmeasure.Find('-') then
                repeat
                    lVarietyLandUnitofmeasure.CalcFields(Invoiced, Prognoses);
                    gItem_sales_filtered := gItem_sales_filtered + lVarietyLandUnitofmeasure.Invoiced;
                    if lVarietyLandUnitofmeasure."Unit of Measure" = "Unit of Measure" then begin
                        gUnit_sales_filtered := gUnit_sales_filtered + lVarietyLandUnitofmeasure.Invoiced;
                    end;
                until lVarietyLandUnitofmeasure.Next = 0;
            if grecUnitofMeasure."B Unit in Weight" then begin
                gItem_sales_filtered := Abs(gItem_sales_filtered);
                gUnit_sales_filtered := Abs(gUnit_sales_filtered);
            end else begin
                gItem_sales_filtered := Abs(gItem_sales_filtered) / 1000000;
                gUnit_sales_filtered := Abs(gUnit_sales_filtered) / 1000000;
            end;

        end;

        CalcFields(Prognoses);
        TempRecDate2.SetFilter("Period Type", '%1', TempRecDate."Period Type");
        TempRecDate2.SetRange("Period Start", TempRecDate."Period Start", TempRecDate."Period End");
        loopbreak := false;
        if TempRecDate2.FindSet then
            repeat
                ColumnNo += 1;
                if (ColumnNo <= ArrayLen(ColumnCaptions)) then begin
                    ColumnValues[ColumnNo] := Prognoses;
                    ColumnCaptions[ColumnNo] := gcuPeriodFormManagement.CreatePeriodFormat(gPeriodType, TempRecDate2."Period Start");
                end else
                    loopbreak := true;
            until (TempRecDate2.Next = 0) or loopbreak;

        FindPeriod('');
        if boolExecuteUpdateOnGetRec then begin
        end;

        OnAfterGetCurrRecord;

        CalcValues;
    end;

    trigger OnInit()
    begin
        grecUserSetup.Get(UserId);

        grecBejoSetup.Get;
        gBeginDate := grecBejoSetup."Begin Date";
        gEndDate := grecBejoSetup."End Date";

        gBeginDateLY := CalcDate('<-1Y>', gBeginDate);
        gEndDateLY := CalcDate('<-1Y>', gEndDate);

        gTxtLJ := Format(gBeginDate) + ' .... ' + Format(gEndDate);
        gTxtVJ := Format(gBeginDateLY) + '....' + Format(gEndDateLY);

        gBeginDate1[1] := CalcDate('<+1Y>', grecBejoSetup."Begin Date");
        EndDate[1] := CalcDate('<+1Y>', grecBejoSetup."End Date");
        gBeginDate1[2] := CalcDate('<+2Y>', grecBejoSetup."Begin Date");
        EndDate[2] := CalcDate('<+2Y>', grecBejoSetup."End Date");
        gBeginDate1[3] := CalcDate('<+3Y>', grecBejoSetup."Begin Date");
        EndDate[3] := CalcDate('<+3Y>', grecBejoSetup."End Date");
        gBeginDate1[4] := CalcDate('<+4Y>', grecBejoSetup."Begin Date");
        EndDate[4] := CalcDate('<+4Y>', grecBejoSetup."End Date");
        gBeginDate1[5] := CalcDate('<+5Y>', grecBejoSetup."Begin Date");
        EndDate[5] := CalcDate('<+5Y>', grecBejoSetup."End Date");
    end;

    trigger OnOpenPage()
    var
        lrecSalespers: Record "Salesperson/Purchaser";
        lrecCustomer: Record Customer;
    begin
        gPeriodType := gPeriodType::Month;

        if grecUserSetup."B Department" = 'SALESP' then begin
            "Sales Person FilterEditable" := false;
            "Customer FilterEditable" := false;
        end;
        if (grecUserSetup."B Department" = 'SALESP') or (grecUserSetup."B Department" = 'SALESP+') then
            SetRange("Sales Person Filter", grecUserSetup."B Initials");

        if lrecSalespers.Get(GetFilter("Sales Person Filter"))
          then gSalespersonName := lrecSalespers.Name
        else gSalespersonName := '';



        gcuPeriodFormManagement.CreatePeriodFormat(gPeriodType, TempRecDate."Period Start");
        PeriodType := PeriodType::Month;

        MATRIX_Step := MATRIX_Step::First;
        boolExecuteUpdateOnGetRec := true;
        SetRange("Date Filter", gBeginDate, gEndDate);
    end;

    var
        gcuPeriodFormManagement: Codeunit PeriodFormManagement;
        gPeriodType: Option Day,Week,Month,Quarter,Year,AccountingPeriod;
        gAmountType: Option NetChange,"Balance at date";
        grecItem: Record Item;
        grecItemUnit: Record "Item/Unit";
        gInvoiced: Decimal;
        gInvoicedLY: Decimal;
        gPrognosed: Decimal;
        gInvoiced1: Decimal;
        gPrognosedLY: Decimal;
        gUnit: Text[15];
        i: Integer;
        grecUnitofMeasure1: Record "Unit of Measure";
        gMillion: Text[10];
        gDate1: Text[30];
        gDate2: Date;
        gBeginDate: Date;
        gBeginDateLY: Date;
        gEndDate: Date;
        gEndDateLY: Date;
        gTxtLJ: Text[80];
        gTxtVJ: Text[80];
        gFromVariety: Code[10];
        gUntilVariety: Code[10];
        grecUserSetup: Record "User Setup";
        grecUnitofMeasure: Record "Unit of Measure";
        gTxtTreated: Text[5];
        grecItemExtension: Record "Item Extension";
        gShowUnits: Boolean;
        grecItemUnitofMeasure: Record "Item Unit of Measure";
        gUnit_prognoses: Decimal;
        gItem_sales_filtered: Decimal;
        gItem_prognoses_filtered: Decimal;
        gUnit_sales_filtered: Decimal;
        gUnit_prognoses_filtered: Decimal;
        gFilter_description: Text[30];
        grecBejoSetup: Record "Bejo Setup";
        grecCommentLine: Record "Comment Line";
        gstrComments: Text[1024];
        gCustomerName: Text[100];
        gSalespersonName: Text[100];
        gOldText: Text[250];
        grecPrognosisAllocationEntry: Record "Prognosis/Allocation Entry";
        lcuBlockingMgt: Codeunit "Blocking Management";
        gPack: Text[15];
        gBeginDate1: array[10] of Date;
        EndDate: array[10] of Date;
        grecVarieties: Record Varieties;
        Prognose: array[6] of Decimal;
        gShowPTO: Boolean;
        ColumnCaptions: array[12] of Text[30];
        ColumnValues: array[12] of Decimal;
        ColumnNumber: Integer;
        TempRecDate: Record Date;
        ColumnNo: Integer;
        loopbreak: Boolean;
        TempRecDate2: Record Date;
        MATRIX_MatrixRecords: array[12] of Record "Item/Unit";
        MATRIX_CaptionSet: array[32] of Text[80];
        FirstColumn: Text[80];
        LastColumn: Text[80];
        MATRIX_CurrentNoOfColumns: Integer;
        ShowColumnName: Boolean;
        DateFilter: Text[30];
        MATRIX_PrimKeyFirstCaptionInCu: Text[80];
        MATRIX_CaptionRange: Text[80];
        InternalDateFilter: Text[30];
        MATRIX_Step: Option First,Previous,Same,Next,PreviousColumn,NextColumn;
        ColumnDimCode: Text[30];
        GlobalDim1Filter: Code[250];
        GlobalDim2Filter: Code[250];
        BudgetDim1Filter: Code[250];
        BudgetDim2Filter: Code[250];
        BudgetDim3Filter: Code[250];
        BudgetDim4Filter: Text[30];
        LineDimOption: Option "G/L Account",Period,"Business Unit","Global Dimension 1","Global Dimension 2","Budget Dimension 1","Budget Dimension 2","Budget Dimension 3","Budget Dimension 4";
        ColumnDimOption: Option "G/L Account",Period,"Business Unit","Global Dimension 1","Global Dimension 2","Budget Dimension 1","Budget Dimension 2","Budget Dimension 3","Budget Dimension 4";
        RoundingFactor: Option "None","1","1000","1000000";
        LineDimCode: Text[30];
        GLBudgetName: Record "G/L Budget Name";
        GLAccFilter: Code[250];
        PeriodType: Option Day,Week,Month,Quarter,Year,"Accounting Period";
        MATRIX_PeriodRecords: array[32] of Record Date;
        [InDataSet]
        "Sales Person FilterEditable": Boolean;
        [InDataSet]
        "Customer FilterEditable": Boolean;
        [InDataSet]
        PromoStatusText: Text[1024];
        boolExecuteUpdateOnGetRec: Boolean;
        gUOM: Text[30];
        SalesPersonFilterText: Text[50];
        CustomerFilterText: Text[50];
        UnitofMeasureFilterText: Text[50];
        MATRIX_CurrentNoOfMatrixColumn: Integer;
        MATRIX_CellData: array[12] of Decimal;
        MatrixRecords: array[12] of Record "Item/Unit";
        MATRIX_MatrixRecord: Record "Item/Unit";
        MatrixHeader: Text[50];
        PeriodInitialized: Boolean;
        gEditable: Boolean;
        [InDataSet]
        gPerUnit: Boolean;
        MATRIX_PeriodRecordsL: array[32] of Record Date;
        gSalesPersonFilter: Text[150];
        gUOMFilter: Text[150];
        gCustFilter: Text[150];
        gProgText: Text[250];

    procedure CalcValues()
    var
        lVarietyLandUnitofmeasure: Record "Item/Unit";
        n: Integer;
    begin
        Clear(gPrognosed);
        Clear(gPrognosedLY);
        Clear(gInvoiced);
        Clear(gInvoiced1);
        Clear(gInvoicedLY);
        Clear(gItem_sales_filtered);
        Clear(gItem_prognoses_filtered);
        Clear(gUnit_sales_filtered);
        Clear(gUnit_sales_filtered);
        Clear(gUnit_prognoses);
        Clear(gUnit_prognoses_filtered);
        Clear(Prognose);

        if grecUnitofMeasure1.Get("Unit of Measure") then
            gPack := grecUnitofMeasure1."B Description for Prognoses"
        else
            gPack := '';

        grecItemUnit.SetRange(grecItemUnit."Item No.", "Item No.");
        grecItemUnit.SetRange("Date Filter", gBeginDate, gEndDate);
        if grecItemUnit.Find('-') then
            repeat
                grecItemUnit.CalcFields(Invoiced, Prognoses);
                gInvoiced := gInvoiced + grecItemUnit.Invoiced;
                gPrognosed := gPrognosed + grecItemUnit.Prognoses;
                if grecItemUnit."Unit of Measure" = "Unit of Measure" then begin
                    gInvoiced1 := gInvoiced1 + grecItemUnit.Invoiced;
                    gUnit_prognoses := gUnit_prognoses + grecItemUnit.Prognoses;
                end;
            until grecItemUnit.Next = 0;

        grecItem.SetRange("No.", "Item No.");
        grecItem.SetRange("Date Filter", gBeginDate, gEndDate);
        grecItem.SetRange("B Salespersonfilter", GetFilter("Sales Person Filter"));
        grecItem.CalcFields(grecItem."B Country allocated", "B Salesperson/cust. allocated");


        grecItemUnit.SetRange("Date Filter", gBeginDateLY, gEndDateLY);
        if grecItemUnit.Find('-') then
            repeat
                grecItemUnit.CalcFields(Invoiced, Prognoses);
                gInvoicedLY := gInvoicedLY + grecItemUnit.Invoiced;
                gPrognosedLY := gPrognosedLY + grecItemUnit.Prognoses;
            until grecItemUnit.Next = 0;

        gFromVariety := CopyStr("Item No.", 1, 5) + '00';
        gUntilVariety := CopyStr("Item No.", 1, 5) + '99';
        if not grecUnitofMeasure.Get("Unit of Measure") then
            grecUnitofMeasure.Init;
        if grecUnitofMeasure."B Unit in Weight" = true then begin
            gInvoiced := Abs(gInvoiced);
            gInvoiced1 := Abs(gInvoiced1);
            gInvoicedLY := Abs(gInvoicedLY);
        end else begin
            gInvoiced := Abs(gInvoiced) / 1000000;
            gInvoicedLY := Abs(gInvoicedLY) / 1000000;
            gInvoiced1 := Abs(gInvoiced1) / 1000000;
        end;


        for i := 1 to 5 do begin
            grecVarieties.Reset;
            grecVarieties.SetRange("No.", CopyStr("Item No.", 1, 5));
            grecVarieties.SetRange("Date filter", gBeginDate1[i], EndDate[i]);
            if grecVarieties.FindFirst then
                repeat
                    grecVarieties.CalcFields("Year Prognosis");
                    Prognose[i] := Prognose[i] + grecVarieties."Year Prognosis";
                until grecVarieties.Next = 0;
        end;
    end;

    local procedure FindPeriod(SearchText: Code[10])
    var
        GLAcc: Record "G/L Account";
        Calendar: Record Date;
        PeriodFormMgt: Codeunit PeriodFormManagement;
    begin
        if DateFilter <> '' then begin
            Calendar.SetFilter("Period Start", DateFilter);
            if not PeriodFormMgt.FindDate('+', Calendar, gPeriodType) then
                PeriodFormMgt.FindDate('+', Calendar, gPeriodType::Day);
            Calendar.SetRange("Period Start");
        end;
        PeriodFormMgt.FindDate(SearchText, Calendar, gPeriodType);
        GLAcc.SetRange("Date Filter", Calendar."Period Start", Calendar."Period End");
        if GLAcc.GetRangeMin("Date Filter") = GLAcc.GetRangeMax("Date Filter") then
            GLAcc.SetRange("Date Filter", GLAcc.GetRangeMin("Date Filter"));
        InternalDateFilter := GetFilter("Date Filter");
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
    end;
}

