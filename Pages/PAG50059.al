page 50059 "Year Prognoses"
{

    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SaveValues = true;
    SourceTable = Varieties;
    SourceTableView = SORTING ("Crop Variant Code", "Crop Type Code")
                      ORDER(Ascending)
                      WHERE ("Year Prognosis Available" = CONST (true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Promo Status"; "Promo Status")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(VarietyBlockDescription; BlockingMgt.VarietyBlockDescription(Rec))
                {
                    Caption = 'Blocking Code';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("-gInvoiced[4]"; -gInvoiced[4])
                {
                    BlankZero = true;
                    CaptionClass = '1,5,,' + text50001 + ' ' + Format(Date2DMY(BeginDate[4], 3)) + '-' + Format(Date2DMY(EndDate[4], 3));
                    DecimalPlaces = 2 : 3;
                    Editable = false;
                    Width = 60;
                    ApplicationArea = All;
                }
                field("-gInvoiced[3]"; -gInvoiced[3])
                {
                    BlankZero = true;
                    CaptionClass = '1,5,,' + text50001 + ' ' + Format(Date2DMY(BeginDate[3], 3)) + '-' + Format(Date2DMY(EndDate[3], 3));
                    DecimalPlaces = 2 : 3;
                    Editable = false;
                    ApplicationArea = All;
                }
                field("-gInvoiced[2]"; -gInvoiced[2])
                {
                    BlankZero = true;
                    CaptionClass = '1,5,,' + text50001 + ' ' + Format(Date2DMY(BeginDate[2], 3)) + '-' + Format(Date2DMY(EndDate[2], 3));
                    DecimalPlaces = 2 : 3;
                    Editable = false;
                    ApplicationArea = All;
                }
                field("-gInvoiced[1]"; -gInvoiced[1])
                {
                    BlankZero = true;
                    CaptionClass = '1,5,,' + text50001 + ' ' + Format(Date2DMY(BeginDate[1], 3)) + '-' + Format(Date2DMY(EndDate[1], 3));
                    DecimalPlaces = 2 : 3;
                    Editable = false;
                    ApplicationArea = All;
                }
                field(gPrognosis; gPrognosis)
                {
                    BlankZero = true;
                    Caption = 'Tot. Month Progn.';
                    DecimalPlaces = 2 : 2;
                    Editable = false;
                    ApplicationArea = All;
                }
                field(gPrognosisNext; gPrognosisNext)
                {
                    BlankZero = true;
                    Caption = 'Tot. Month Progn. (Next Season)';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(gAllocated; gAllocated)
                {
                    BlankZero = true;
                    Caption = 'Allocated';
                    DecimalPlaces = 2 : 2;
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Field1; MATRIX_CellData[1])
                {
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[1];
                    DecimalPlaces = 0 : 4;
                    Style = None;
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(1);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(1);
                    end;
                }
                field(Field2; MATRIX_CellData[2])
                {
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[2];
                    DecimalPlaces = 0 : 4;
                    Style = None;
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(2);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(2);
                    end;
                }
                field(Field3; MATRIX_CellData[3])
                {
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[3];
                    DecimalPlaces = 0 : 4;
                    Style = None;
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(3);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(3);
                    end;
                }
                field(Field4; MATRIX_CellData[4])
                {
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[4];
                    DecimalPlaces = 0 : 4;
                    Style = None;
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(4);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(4);
                    end;
                }
                field(Field5; MATRIX_CellData[5])
                {
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[5];
                    DecimalPlaces = 0 : 4;
                    Style = None;
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(5);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(5);
                    end;
                }
                field(Field6; MATRIX_CellData[6])
                {
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[6];
                    DecimalPlaces = 0 : 4;
                    Style = None;
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(6);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(6);
                    end;
                }
                field(Field7; MATRIX_CellData[7])
                {
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[7];
                    DecimalPlaces = 0 : 4;
                    Style = None;
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(7);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(7);
                    end;
                }
                field(Field8; MATRIX_CellData[8])
                {
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[8];
                    DecimalPlaces = 0 : 4;
                    Style = None;
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(8);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(8);
                    end;
                }
                field(Field9; MATRIX_CellData[9])
                {
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[9];
                    DecimalPlaces = 0 : 4;
                    Style = None;
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(9);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(9);
                    end;
                }
                field(Field10; MATRIX_CellData[10])
                {
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[10];
                    DecimalPlaces = 0 : 4;
                    Style = None;
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(10);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(10);
                    end;
                }
                field(Field11; MATRIX_CellData[11])
                {
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[11];
                    DecimalPlaces = 0 : 4;
                    Style = None;
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(11);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(11);
                    end;
                }
                field(Field12; MATRIX_CellData[12])
                {
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[12];
                    DecimalPlaces = 0 : 4;
                    Style = None;
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(12);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(12);
                    end;
                }
            }
            part(Crop; "Year Prog Market Pot Subf")
            {
                Caption = 'Market Potential';
                Editable = false;
                SubPageView = SORTING ("Crop Variant Code", "Crop Type", Year, "Customer No.", "Salesperson Code")
                              ORDER(Ascending);
                ApplicationArea = All;
            }
            part(Comment; "Stock Information sub 3")
            {
                Caption = 'Comment';
                Editable = false;
                SubPageLink = "Table Name" = CONST (Item),
                "B Comment Type" = CONST ("Var 5 pos"),
                "B Variety" = FIELD ("No.");
                SubPageView = SORTING ("Table Name", "B Comment Type", "No.", "B Variety");
                ApplicationArea = All;
            }
        }
        area(factboxes)
        {
            part("Variety Details"; "Year Prognoses FactBox")
            {
                Caption = 'Variety Details';
                SubPageLink = "No." = FIELD ("No.");
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Previous Column")
            {
                Caption = 'Previous Column';
                Image = PreviousRecord;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    SetColumns(4);
                end;
            }
            action("Next Column")
            {
                Caption = 'Next Column';
                Image = NextRecord;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    SetColumns(5);
                end;
            }
        }
        area(processing)
        {
            action("Export Year Prognoses")
            {
                Image = ExportToBank;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    REPORT.RunModal(50080);
                end;
            }
            action("Refresh Market Potential")
            {
                Image = Refresh;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    CurrPage.Crop.PAGE.RefreshData("Crop Variant Code", "Crop Type Code", Date2DMY(BeginDate[1], 3));
                end;
            }
            action(Hidelines)
            {
                Caption = 'Hide Lines without Prognoses';
                Image = "Filter";
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    SetFilter("Year Prognosis Exist", '<>%1', 0);
                    CurrPage.Update;
                end;
            }
            action(Unhide)
            {
                Caption = 'Show All Lines';
                Image = UseFilters;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    SetRange("Year Prognosis Exist");
                    CurrPage.Update;
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        CalcCurrentValues;
    end;

    trigger OnAfterGetRecord()
    var
        MATRIX_CurrentColumnOrdinal: Integer;
    begin
        MATRIX_CurrentColumnOrdinal := 0;
        if MatrixRecord.Find('-') then
            repeat
                MATRIX_CurrentColumnOrdinal := MATRIX_CurrentColumnOrdinal + 1;
                MATRIX_OnAfterGetRecord(MATRIX_CurrentColumnOrdinal);
            until (MatrixRecord.Next(1) = 0) or (MATRIX_CurrentColumnOrdinal = MATRIX_NoOfMatrixColumns);

        CalcValues;

        CalcFields("Promo Status Description");
    end;

    trigger OnOpenPage()
    var
        i: Integer;
    begin
        FirstDayCurrYear := DMY2Date(1, 1, Date2DMY(Today, 3));

        MATRIX_NoOfMatrixColumns := 12;
        MatrixRecord.SetRange("Period Type", MatrixRecord."Period Type"::Year);
        MatrixRecord.SetRange("Period Start", 20050101D, 20250101D);
        SetColumns(0);

        DefaultYear := 20050101D;

        if FirstDayCurrYear > DefaultYear then
            repeat
                SetColumns(5);
                DefaultYear := CalcDate('<+1Y>', DefaultYear);
            until FirstDayCurrYear = DefaultYear;

        grecBejoSetup.Get;

        BeginDate[1] := grecBejoSetup."Begin Date";
        EndDate[1] := grecBejoSetup."End Date";
        BeginDate[2] := CalcDate('<-1Y>', BeginDate[1]);
        EndDate[2] := CalcDate('<-1Y>', EndDate[1]);
        BeginDate[3] := CalcDate('<-2Y>', BeginDate[1]);
        EndDate[3] := CalcDate('<-2Y>', EndDate[1]);
        BeginDate[4] := CalcDate('<-3Y>', BeginDate[1]);
        EndDate[4] := CalcDate('<-3Y>', EndDate[1]);

        gPeriodType := gPeriodType::Jaar;
    end;

    var
        MATRIX_CellData: array[12] of Decimal;
        MATRIX_CaptionSet: array[12] of Text[80];
        MatrixRecord: Record Date;
        MatrixRecords: array[12] of Record Date;
        MATRIX_CaptionRange: Text[100];
        MATRIX_PKFirstRecInCurrSet: Text[100];
        MATRIX_CurrSetLength: Integer;
        MatrixRecordRef: RecordRef;
        MATRIX_NoOfMatrixColumns: Integer;
        gBookType: Option Mutatie,"Saldo t/m datum";
        gInvoiced: array[10] of Decimal;
        gPrognosis: Decimal;
        gAllocated: Decimal;
        text50000: Label 'Variety not found.';
        text50001: Label 'Sales';
        BeginDate: array[10] of Date;
        EndDate: array[10] of Date;
        lcuBlockingMgt: Codeunit "Blocking Management";
        grecBejoSetup: Record "Bejo Setup";
        i: Integer;
        grecItemUnit: Record "Item/Unit";
        grecItem: Record Item;
        cuPeriodFormManagement: Codeunit PeriodFormManagement;
        p: Integer;
        gPeriodType: Option Dag,Week,Maand,Kwartaal,Jaar,Boekhoudperiode;
        FirstDayCurrYear: Date;
        Hidelines: Boolean;
        DefaultYear: Date;
        BlockingMgt: Codeunit "Blocking Management";
        gPrognosisNext: Decimal;

    local procedure MATRIX_OnAfterGetRecord(ColumnID: Integer)
    var
        MATRIX_CurrentColumnOrdinal: Integer;
        Varieties: Record Varieties;
    begin
        Varieties.Copy(Rec);
        if gBookType = gBookType::Mutatie then
            if MatrixRecords[ColumnID]."Period Start" = MatrixRecords[ColumnID]."Period End" then
                Varieties.SetRange("Date filter", MatrixRecords[ColumnID]."Period Start")
            else
                Varieties.SetRange("Date filter", MatrixRecords[ColumnID]."Period Start", MatrixRecords[ColumnID]."Period End")
        else
            Varieties.SetRange("Date filter", MatrixRecords[ColumnID]."Period Start", MatrixRecords[ColumnID]."Period End");
        Varieties.CalcFields("Year Prognosis");
        MATRIX_CellData[ColumnID] := Varieties."Year Prognosis";
    end;

    procedure SetColumns(SetWanted: Option Initial,Previous,Same,Next,PreviousColumn,NextColumn)
    var
        MatrixMgt: Codeunit "Matrix Management";
        CaptionFieldNo: Integer;
        CurrentMatrixRecordOrdinal: Integer;
    begin
        Clear(MATRIX_CaptionSet);
        Clear(MatrixRecords);
        CurrentMatrixRecordOrdinal := 1;

        MatrixRecordRef.GetTable(MatrixRecord);
        MatrixRecordRef.SetTable(MatrixRecord);

        CaptionFieldNo := MatrixRecord.FieldNo(MatrixRecord."Period Start");

        MatrixMgt.GenerateMatrixData(MatrixRecordRef, SetWanted, ArrayLen(MatrixRecords), CaptionFieldNo, MATRIX_PKFirstRecInCurrSet,
          MATRIX_CaptionSet, MATRIX_CaptionRange, MATRIX_CurrSetLength);

        if MATRIX_CurrSetLength > 0 then begin
            MatrixRecord.SetPosition(MATRIX_PKFirstRecInCurrSet);
            MatrixRecord.Find;
            repeat
                MatrixRecords[CurrentMatrixRecordOrdinal].Copy(MatrixRecord);
                MATRIX_CaptionSet[CurrentMatrixRecordOrdinal] :=
                Format(Date2DMY(MatrixRecord."Period Start", 3)) + '-' + Format(Date2DMY(CalcDate('<+1Y>', MatrixRecord."Period Start"), 3));

                CurrentMatrixRecordOrdinal := CurrentMatrixRecordOrdinal + 1;
            until (CurrentMatrixRecordOrdinal > MATRIX_CurrSetLength) or (MatrixRecord.Next <> 1);
        end;

    end;

    procedure MATRIX_OnDrillDown(ColumnID: Integer)
    var
        YearPrognoses: Record "Year Prognoses";
    begin
        YearPrognoses.SetRange(Variety, "No.");
        YearPrognoses.SetRange(Date, MatrixRecords[ColumnID]."Period Start", MatrixRecords[ColumnID]."Period End");
        PAGE.Run(0, YearPrognoses);
    end;

    procedure UpdateAmount(MATRIX_ColumnOrdinal: Integer)
    var
        NewAmount: Decimal;
        YearPrognoses: Record "Year Prognoses";
        grecVarieties: Record Varieties;
        SumaX: Decimal;
    begin
        grecVarieties.Reset;
        grecVarieties.SetRange(grecVarieties."No.", "No.");
        grecVarieties.SetFilter("Date filter", '%1..%2', MatrixRecords[MATRIX_ColumnOrdinal]."Period Start", MatrixRecords[MATRIX_ColumnOrdinal]."Period End");
        SumaX := MATRIX_CellData[MATRIX_ColumnOrdinal];
        if grecVarieties.FindFirst then
            grecVarieties.Validate("Year Prognosis", MATRIX_CellData[MATRIX_ColumnOrdinal]);
    end;

    procedure CalcValues()
    var
        lrecUOM: Record "Unit of Measure";
    begin
        Clear(gInvoiced);
        Clear(gPrognosis);
        Clear(gPrognosisNext);
        Clear(gAllocated);

        for i := 1 to 3 do begin
            grecItemUnit.SetCurrentKey(grecItemUnit.Variety);
            grecItemUnit.SetRange("Date Filter", BeginDate[i], EndDate[i]);
            grecItemUnit.SetRange("Date Filter Previous Year", BeginDate[i + 1], EndDate[i + 1]);
            grecItemUnit.SetRange(Variety, "No.");
            grecItemUnit.SetFilter("Unit of Measure", '<>%1', '');
            if grecItemUnit.FindFirst then
                repeat

                    if lrecUOM.Get(grecItemUnit."Unit of Measure") then begin
                        grecItemUnit.CalcFields(Invoiced, "Sales Previous Year");

                        if lrecUOM."B Unit in Weight" and (Rec.TSW > 0) then begin

                            gInvoiced[i] := gInvoiced[i] + (grecItemUnit.Invoiced / Rec.TSW * 1000000);
                            gInvoiced[i + 1] := gInvoiced[i + 1] + (grecItemUnit."Sales Previous Year" / Rec.TSW * 1000000);
                        end
                        else begin
                            gInvoiced[i] := gInvoiced[i] + grecItemUnit.Invoiced;
                            gInvoiced[i + 1] := gInvoiced[i + 1] + grecItemUnit."Sales Previous Year";
                        end;
                    end;
                until grecItemUnit.Next = 0;
            i := i + 1;
        end;

        grecItem.SetCurrentKey("B Variety");
        grecItem.SetRange("B Variety", "No.");
        grecItem.SetRange("Date Filter", BeginDate[1], EndDate[1]);
        if grecItem.FindSet then
            repeat

                if lrecUOM.Get(grecItem."Base Unit of Measure") then begin
                    grecItem.CalcFields("B Prognoses", "B Country allocated");


                    if lrecUOM."B Unit in Weight" and (Rec.TSW > 0) then begin
                        gPrognosis := gPrognosis + (grecItem."B Prognoses" / Rec.TSW * 1000000);
                        gAllocated := gAllocated + (grecItem."B Country allocated" / Rec.TSW * 1000000);
                    end else begin
                        gPrognosis := gPrognosis + (grecItem."B Prognoses" * 1000000);
                        gAllocated := gAllocated + (grecItem."B Country allocated" * 1000000);
                    end;
                end;
            until grecItem.Next = 0;


        grecItem.SetCurrentKey("B Variety");
        grecItem.SetRange("B Variety", "No.");
        grecItem.SetRange("Date Filter", CalcDate('<+1Y>', BeginDate[1]), CalcDate('<+1Y>', EndDate[1]));
        if grecItem.FindSet then
            repeat

                if lrecUOM.Get(grecItem."Base Unit of Measure") then begin
                    grecItem.CalcFields("B Prognoses", "B Country allocated");


                    if lrecUOM."B Unit in Weight" and (Rec.TSW > 0) then begin
                        gPrognosisNext := gPrognosisNext + (grecItem."B Prognoses" / Rec.TSW * 1000000);
                    end else begin
                        gPrognosisNext := gPrognosisNext + (grecItem."B Prognoses" * 1000000);
                    end;
                end;
            until grecItem.Next = 0;

        if Rec."Year Prognosis in" = Rec."Year Prognosis in"::KG then begin
            gInvoiced[1] := (gInvoiced[1] / 1000000 * Rec.TSW);
            gInvoiced[2] := (gInvoiced[2] / 1000000 * Rec.TSW);
            gInvoiced[3] := (gInvoiced[3] / 1000000 * Rec.TSW);
            gInvoiced[4] := (gInvoiced[4] / 1000000 * Rec.TSW);
            gPrognosis := (gPrognosis / 1000000 * Rec.TSW);
            gPrognosisNext := (gPrognosisNext / 1000000 * Rec.TSW);
            gAllocated := (gAllocated / 1000000 * Rec.TSW);
        end else begin
            gInvoiced[1] := (gInvoiced[1] / 1000000);
            gInvoiced[2] := (gInvoiced[2] / 1000000);
            gInvoiced[3] := (gInvoiced[3] / 1000000);
            gInvoiced[4] := (gInvoiced[4] / 1000000);
            gPrognosis := (gPrognosis / 1000000);
            gPrognosisNext := (gPrognosisNext / 1000000);
            gAllocated := (gAllocated / 1000000);
        end;

        if not grecItem.Get("No." + '000') then
            if not grecItem.Get("No." + '001') then
                grecItem.Init;
    end;

    procedure CalcCurrentValues()
    begin
        CurrPage.Crop.PAGE.GetData("Crop Variant Code", "Crop Type Code", Date2DMY(BeginDate[1], 3));
    end;
}

