page 50073 "Item Details FactBox"
{


    Caption = 'Item Details';
    Editable = false;
    PageType = CardPart;
    SourceTable = "Item/Unit";

    layout
    {
        area(content)
        {
            field("Item No."; "Item No.")
            {
                Caption = 'Item:';
                ApplicationArea = All;

                trigger OnDrillDown()
                begin
                    ShowDetails;
                end;
            }
            field(gMillion; gMillion)
            {
                Caption = 'Prognoses In:';
                Editable = false;
                ShowCaption = true;
                Style = None;
                StyleExpr = TRUE;
                TableRelation = Item."No." WHERE ("No." = FIELD ("Item No."));
                ApplicationArea = All;
            }
            field("grecItem.Description"; grecItem.Description)
            {
                Caption = 'Description:';
                Editable = false;
                ShowCaption = true;
                ApplicationArea = All;
            }
            field("Search Description"; "Search Description")
            {
                Caption = 'Search Description:';
                DrillDown = false;
                Editable = false;
                ShowCaption = true;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }
            field("grecItem.""Description 2"""; grecItem."Description 2")
            {
                Caption = 'Description 2:';
                Editable = false;
                ShowCaption = true;
                ApplicationArea = All;
            }
            field("""Promo Status""+':'+""Promo Status Description"""; "Promo Status" + ':' + "Promo Status Description")
            {
                Caption = 'Promo Status:';
                Editable = false;
                ShowCaption = true;
                ApplicationArea = All;
            }
            field("Promo Status Description"; "Promo Status Description")
            {
                Caption = 'Promo Status Description:';
                HideValue = true;
                Visible = false;
                ApplicationArea = All;
            }
            field("lcuBlockingMgt.ItemUnitBlockDescription(Rec)"; lcuBlockingMgt.ItemUnitBlockDescription(Rec))
            {
                Caption = 'Blocking Code:';
                Editable = false;
                ShowCaption = true;
                ApplicationArea = All;
            }
            field("grecItemExtension.Description"; grecItemExtension.Description)
            {
                Caption = 'Item Extension Description:';
                Editable = false;
                ApplicationArea = All;
            }
            field("<txtCommentLine>"; gstrComments)
            {
                ColumnSpan = 4;
                Editable = false;
                RowSpan = 2;
                ShowCaption = false;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    var
        MATRIX_CurrentColumnOrdinal: Integer;
        lVarietyLandUnitofmeasure: Record "Item/Unit";
        n: Integer;
    begin

        if grecUnitofMeasure1.Get("Unit of Measure") then
            gUnit := grecUnitofMeasure1."B Description for Prognoses"
        else
            gUnit := '';



        CalcFields("Promo Status", "Search Description");

        gInvoiced := 0;
        gInvoiced1 := 0;
        gInvoicedLY := 0;
        gPrognosed := 0;
        gPrognosedLY := 0;

        gFilter_description := '';

        gMillion := '';


        if grecUserSetup."B Department" = 'SALESP' then
            SetRange("Sales Person Filter", grecUserSetup."B Initials");

        if grecUnitofMeasure1.Get("Unit of Measure") then
            gUnit := grecUnitofMeasure1."B Description for Prognoses"
        else
            gUnit := '';

        if grecUnitofMeasure1."B Unit in Weight" then
            gMillion := text50003
        else
            gMillion := text50002;

        grecItemUnit.SetRange(grecItemUnit."Item No.", grecItem."No.");
        grecItemUnit.SetRange("Date Filter", gBeginDate, gEndDate);
        if grecItemUnit.Find('-') then
            repeat
                grecItemUnit.CalcFields(Invoiced, Prognoses);
                gInvoiced := gInvoiced + grecItemUnit.Invoiced;
                gPrognosed := gPrognosed + grecItemUnit.Prognoses;
                if grecItemUnit."Unit of Measure" = "Unit of Measure" then begin
                    gInvoiced1 := gInvoiced1 + grecItemUnit.Invoiced;
                end;
            until grecItemUnit.Next = 0;

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

        if not grecItemExtension.Get(grecItem."B Extension", '') then
            grecItemExtension.Init;
        if grecItem."B Organic" = true then
            grecItemExtension.Description := '';


        DatumFilterInstell;


        if not grecItem.Get("Item No.") then
            grecItem.Init;

        CalcValues;

        GetCommentLine();

    end;

    trigger OnInit()
    begin
        grecBejoSetup.Get;
        gBeginDate := grecBejoSetup."Begin Date";
        gEndDate := grecBejoSetup."End Date";

        gBeginDateLY := CalcDate('<-1Y>', gBeginDate);
        gEndDateLY := CalcDate('<-1Y>', gEndDate);

        gTxtLJ := Format(gBeginDate) + ' ...................................... ' + Format(gEndDate);
        gTxtVJ := Format(gBeginDateLY) + '......................................................' + Format(gEndDateLY);

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
        CalcFields("Promo Status", "Search Description");
    end;

    var
        MATRIX_CurrentNoOfMatrixColumn: Integer;
        MATRIX_CellData: array[12] of Decimal;
        MATRIX_CaptionSet: array[12] of Text[80];
        gUnit: Text[15];
        MatrixRecords: array[12] of Record "Item/Unit";
        MATRIX_MatrixRecord: Record "Item/Unit";
        MatrixHeader: Text[50];
        PeriodInitialized: Boolean;
        grecUnitofMeasure1: Record "Unit of Measure";
        DateFilter: Text[30];
        PeriodType: Option Day,Week,Month,Quarter,Year,"Accounting Period";
        InternalDateFilter: Text[30];
        grecPrognosisAllocationEntry: Record "Prognosis/Allocation Entry";
        "-------------": Integer;
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
        i: Integer;
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
        FirstColumn: Text[80];
        LastColumn: Text[80];
        MATRIX_CurrentNoOfColumns: Integer;
        ShowColumnName: Boolean;
        MATRIX_PrimKeyFirstCaptionInCu: Text[80];
        MATRIX_CaptionRange: Text[80];
        MATRIX_Step: Option First,Previous,Same,Next,PreviousColumn,NextColumn;
        ColumnDimCode: Text[30];
        GlobalDim1Filter: Code[250];
        GlobalDim2Filter: Code[250];
        BudgetDim1Filter: Code[250];
        BudgetDim2Filter: Code[250];
        BudgetDim3Filter: Code[250];
        BudgetDim4Filter: Code[250];
        LineDimOption: Option "G/L Account",Period,"Business Unit","Global Dimension 1","Global Dimension 2","Budget Dimension 1","Budget Dimension 2","Budget Dimension 3","Budget Dimension 4";
        ColumnDimOption: Option "G/L Account",Period,"Business Unit","Global Dimension 1","Global Dimension 2","Budget Dimension 1","Budget Dimension 2","Budget Dimension 3","Budget Dimension 4";
        RoundingFactor: Option "None","1","1000","1000000";
        LineDimCode: Text[30];
        GLBudgetName: Record "G/L Budget Name";
        GLAccFilter: Code[250];
        MATRIX_PeriodRecords: array[32] of Record Date;
        [InDataSet]
        "Sales Person FilterEditable": Boolean;
        [InDataSet]
        "Customer FilterEditable": Boolean;
        [InDataSet]
        PromoStatusText: Text[1024];
        boolExecuteUpdateOnGetRec: Boolean;
        text50000: Label 'Allocation %1 is less than the prognoses %2 for this period!';
        text50002: Label 'million';
        text50003: Label 'KG';
        text50004: Label 'User %1 is not allowed to block/unblock prognosis.';
        text50005: Label 'Prognoses for item %1, unit of measure %2, period %3 cannot be changed because it is being handled.';
        text50006: Label 'User %1 is not allowed to mark/unmark prognoses as handled.';
        text50007: Label 'You are not allowed to use this function!';
        text50008: Label 'Prognoses cannot be changed from this form, when different active Shipment Date Bejo Zaden values exist.';
        text50009: Label 'Sales Prognoses per Period';
        text50010: Label 'Purchase Prognoses per Period';
        text50011: Label 'This functionality is available only when ”Purchase Plan” is activated';
        text50012: Label 'You are not allowed to Prognose for items within the following filter: %1';
        Text50013: Label 'Placeholder';
        Text19011378: Label 'Item';
        Text19050243: Label 'Prognoses';
        Text19075742: Label 'Sales';
        Text19003981: Label 'Filtered';
        Text19080001: Label 'Prognoses';
        Text19080002: Label 'Sales';
        Text19004798: Label 'Year Prognoses';
        boolCaption: Boolean;
        Text50014: Label 'Country Total';
        Text50015: Label 'Prognosis';
        MATRIX_PeriodRecordsL: array[32] of Record Date;
        gCustFilter: Text[150];
        gSalesPersonFilter: Text[150];
        gUOMFilter: Text[150];
        [InDataSet]
        gPerUnit: Boolean;
        [InDataSet]
        gEditable: Boolean;
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

        if not grecItemExtension.Get(grecItem."B Extension", '') then
            grecItemExtension.Init;
        if grecItem."B Organic" = true then
            grecItemExtension.Description := '';

        if (GetFilter("Sales Person Filter") <> '') or (GetFilter("Customer Filter") <> '') then begin
            gFilter_description := GetFilter("Sales Person Filter") + ' ' + GetFilter("Customer Filter");
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
                    gItem_prognoses_filtered := gItem_prognoses_filtered + lVarietyLandUnitofmeasure.Prognoses;
                    if lVarietyLandUnitofmeasure."Unit of Measure" = "Unit of Measure" then begin
                        gUnit_sales_filtered := gUnit_sales_filtered + lVarietyLandUnitofmeasure.Invoiced;
                        gUnit_prognoses_filtered := gUnit_prognoses_filtered + lVarietyLandUnitofmeasure.Prognoses;
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

    local procedure BedrEvalueren(var Tkst: Text[250])
    var
        Bedr: Decimal;
    begin
        if Evaluate(Bedr, Tkst) then begin
            if gShowUnits = true then begin
                grecItemUnitofMeasure.Get("Item No.", "Unit of Measure");
                grecUnitofMeasure1.Get("Unit of Measure");
                if (grecUnitofMeasure1."B Unit in Weight") and (grecItemUnitofMeasure."Qty. per Unit of Measure" <> 0) then
                    Bedr := Round(Bedr * grecItemUnitofMeasure."Qty. per Unit of Measure", 0.0001)
                else
                    Bedr := Round(Bedr / (1000000 / grecItemUnitofMeasure."Qty. per Unit of Measure"), 0.0001);
            end;
            Tkst := Format(Bedr);
        end;
    end;

    local procedure DatumFilterInstell()
    begin
        if gShowPTO then
            DateFilterInstall2
        else begin
            gDate1 := ('<0D>');
            gDate2 := CalcDate(gDate1);
            SetRange("Date Filter Previous Year");


            if gAmountType = gAmountType::NetChange then
                if MATRIX_PeriodRecords[1]."Period Start" = MATRIX_PeriodRecords[12]."Period Start" then
                    SetRange("Date Filter", MATRIX_PeriodRecords[1]."Period Start")
                else
                    SetRange("Date Filter", MATRIX_PeriodRecords[1]."Period Start", MATRIX_PeriodRecords[12]."Period Start")
            else
                SetRange("Date Filter", gDate2, MATRIX_PeriodRecords[12]."Period Start");

            if gPeriodType = gPeriodType::Year then
                SetRange("Date Filter", CalcDate('<-4M>', MATRIX_PeriodRecords[1]."Period Start"),
                         CalcDate('<-4M>', MATRIX_PeriodRecords[12]."Period Start"));
        end;
    end;

    procedure DateFilterInstall2()
    begin
        gDate1 := ('<0D>');
        gDate2 := CalcDate(gDate1);
        SetRange("Date Filter");

        if gAmountType = gAmountType::NetChange then
            if MATRIX_PeriodRecords[1]."Period Start" = MATRIX_PeriodRecords[12]."Period End" then
                SetRange("Date Filter Previous Year", MATRIX_PeriodRecords[1]."Period Start")
            else
                SetRange("Date Filter Previous Year", MATRIX_PeriodRecords[1]."Period Start", MATRIX_PeriodRecords[12]."Period Start")
        else
            SetRange("Date Filter Previous Year", gDate2, MATRIX_PeriodRecords[12]."Period Start");

        if gPeriodType = gPeriodType::Year then
            SetRange("Date Filter Previous Year", CalcDate('<-4M>', MATRIX_PeriodRecords[1]."Period Start"),
                     CalcDate('<-4M>', MATRIX_PeriodRecords[12]."Period Start"));
    end;

    procedure GetCommentLine()
    var
        boolOK: Boolean;
    begin
        Clear(grecCommentLine);
        gstrComments := '';
        grecCommentLine.SetRange(grecCommentLine."B Comment Type", grecCommentLine."B Comment Type"::Salesperson);
        grecCommentLine.SetRange(grecCommentLine."Table Name", grecCommentLine."Table Name"::Item);
        grecCommentLine.SetFilter(grecCommentLine."No.", "Item No.");
        grecCommentLine.SetFilter(grecCommentLine.Code, "Unit of Measure");
        grecCommentLine.SetFilter(grecCommentLine.Date, '<=%1', gEndDate);
        grecCommentLine.SetFilter(grecCommentLine."B End Date", '>=%1', gBeginDate);

        boolOK := grecCommentLine.FindSet(false, false);
        if boolOK then begin
            repeat
                gstrComments := gstrComments + grecCommentLine.Comment + ' \';
            until grecCommentLine.Next = 0;
            gstrComments := CopyStr(gstrComments, 1, StrLen(gstrComments) - 1);
        end
        else
            gstrComments := '';
        grecCommentLine.SetRange(grecCommentLine.Code, '');
        boolOK := grecCommentLine.FindSet(false, false);
        if boolOK then begin
            gstrComments := gstrComments + ' \';
            repeat
                gstrComments := gstrComments + grecCommentLine.Comment + ' \';
            until grecCommentLine.Next = 0;
            gstrComments := CopyStr(gstrComments, 1, StrLen(gstrComments) - 1);
        end;

    end;

    local procedure BedrFormatteren(var Tkst: Text[250])
    var
        Bedr: Decimal;
    begin
        if Evaluate(Bedr, Tkst) then begin
            if gShowUnits = true then begin
                grecItemUnitofMeasure.Get("Item No.", "Unit of Measure");
                grecUnitofMeasure1.Get("Unit of Measure");
                if (grecUnitofMeasure1."B Unit in Weight") and (grecItemUnitofMeasure."Qty. per Unit of Measure" <> 0) then
                    Bedr := Bedr / grecItemUnitofMeasure."Qty. per Unit of Measure"
                else
                    Bedr := Round(Bedr * (1000000 / grecItemUnitofMeasure."Qty. per Unit of Measure"), 0.001);
            end;
            Tkst := Format(Bedr);
        end;
    end;

    local procedure ShowDetails()
    var
        lrecItem: Record Item;
    begin
        lrecItem.SetFilter(lrecItem."No.", '=%1', "Item No.");
        PAGE.Run(PAGE::"Item Card", lrecItem);
    end;
}

