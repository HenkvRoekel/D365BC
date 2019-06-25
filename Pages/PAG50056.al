page 50056 "Monthly Prognoses"
{

    Caption = 'Monthly Prognoses';
    DeleteAllowed = false;
    Description = '=text50002';
    InsertAllowed = false;
    PageType = List;
    SaveValues = true;
    SourceTable = "Item/Unit";
    SourceTableView = SORTING ("Item No.", "Unit of Measure")
                      WHERE ("Unit of Measure" = FILTER (<> ''));

    layout
    {
        area(content)
        {
            group(Options)
            {
                Caption = 'Options';
                grid(Control6)
                {
                    GridLayout = Columns;
                    ShowCaption = false;
                    group(Control1)
                    {
                        ShowCaption = false;
                        field(SalesPersonFilterText; SalesPersonFilterText)
                        {
                            Caption = 'Salesperson';
                            Editable = "Sales Person FilterEditable";
                            Importance = Promoted;
                            TableRelation = "Salesperson/Purchaser";
                            ApplicationArea = All;

                            trigger OnValidate()
                            begin
                                SalesPersonFilterOnAfterValida;
                            end;
                        }
                    }
                    group(Control9)
                    {
                        ShowCaption = false;
                        field(gSalespersonName; gSalespersonName)
                        {
                            Importance = Promoted;
                            Visible = false;
                            ApplicationArea = All;
                        }
                    }
                    group(Control2)
                    {
                        ShowCaption = false;
                        field(CustomerFilterText; CustomerFilterText)
                        {
                            Caption = 'Customer';
                            Editable = "Customer FilterEditable";
                            Importance = Promoted;
                            TableRelation = Customer;
                            ApplicationArea = All;

                            trigger OnValidate()
                            begin
                                CustomerFilterOnAfterValidate;
                            end;
                        }
                    }
                    group(Control10)
                    {
                        ShowCaption = false;
                        field(gCustomerName; gCustomerName)
                        {
                            Editable = false;
                            Visible = false;
                            ApplicationArea = All;
                        }
                    }
                    group(Control4)
                    {
                        ShowCaption = false;
                        field(BeginDate; gBeginDate)
                        {
                            Caption = 'Begin Date';
                            Importance = Promoted;
                            StyleExpr = TRUE;
                            ApplicationArea = All;

                            trigger OnValidate()
                            begin
                                gBeginDateOnAfterValidate;
                            end;
                        }
                    }
                    group(Control12)
                    {
                        ShowCaption = false;
                        field(EndDate; gEndDate)
                        {
                            Caption = 'End Date';
                            Importance = Promoted;
                            ApplicationArea = All;

                            trigger OnValidate()
                            begin
                                gEndDateOnAfterValidate;
                            end;
                        }
                    }
                    group(Control5)
                    {
                        ShowCaption = false;
                        field(gShowUnits; gShowUnits)
                        {
                            Caption = 'Per unit';
                            Importance = Promoted;
                            Style = StandardAccent;
                            ApplicationArea = All;

                            trigger OnValidate()
                            begin
                                CurrPage.Update;
                            end;
                        }
                    }
                    group(Control8)
                    {
                        ShowCaption = false;
                        field(gShowPTO; gShowPTO)
                        {
                            Caption = 'Purchase Plan';
                            Description = 'BEJOWW5.01.012';
                            Importance = Promoted;
                            Style = Strong;
                            StyleExpr = TRUE;
                            ApplicationArea = All;

                            trigger OnValidate()
                            begin
                                DatumFilterInstell;

                                if gShowPTO then CurrPage.Caption := text50010
                                else CurrPage.Caption := text50009;

                                CurrPage.Update;
                            end;
                        }
                    }
                }
            }
            repeater(Control146)
            {
                FreezeColumn = "Item No.";
                ShowCaption = false;
                field("Item No."; "Item No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Unit of Measure"; "Unit of Measure")
                {
                    Caption = 'Unit of Measure';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Search Description"; "Search Description")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Organic; Organic)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Promo Status"; "Promo Status")
                {
                    ApplicationArea = All;
                }
                field("MATRIX_CellData[1]"; MATRIX_CellData[1])
                {
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[1];
                    DecimalPlaces = 0 : 4;
                    Editable = gEditable;
                    StyleExpr = MyStyleVar1;
                    ApplicationArea = All;

                    trigger OnControlAddIn(Index: Integer; Data: Text)
                    begin
                        ColCur := 1;
                    end;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(1);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(1);
                        ColCur := 1;
                    end;
                }
                field("MATRIX_CellData[2]"; MATRIX_CellData[2])
                {
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[2];
                    DecimalPlaces = 0 : 4;
                    Editable = gEditable;
                    StyleExpr = MyStyleVar2;
                    ApplicationArea = All;

                    trigger OnControlAddIn(Index: Integer; Data: Text)
                    begin
                        ColCur := 2;
                    end;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(2);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(2);
                        ColCur := 2;
                    end;
                }
                field("MATRIX_CellData[3]"; MATRIX_CellData[3])
                {
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[3];
                    DecimalPlaces = 0 : 4;
                    Editable = gEditable;
                    StyleExpr = MyStyleVar3;
                    ApplicationArea = All;

                    trigger OnControlAddIn(Index: Integer; Data: Text)
                    begin
                        ColCur := 3;
                    end;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(3);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(3);
                        ColCur := 3;
                    end;
                }
                field("MATRIX_CellData[4]"; MATRIX_CellData[4])
                {
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[4];
                    DecimalPlaces = 0 : 4;
                    Editable = gEditable;
                    StyleExpr = MyStyleVar4;
                    ApplicationArea = All;

                    trigger OnControlAddIn(Index: Integer; Data: Text)
                    begin
                        ColCur := 4;
                    end;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(4);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(4);
                        ColCur := 4;
                    end;
                }
                field("MATRIX_CellData[5]"; MATRIX_CellData[5])
                {
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[5];
                    DecimalPlaces = 0 : 4;
                    Editable = gEditable;
                    StyleExpr = MyStyleVar5;
                    ApplicationArea = All;

                    trigger OnControlAddIn(Index: Integer; Data: Text)
                    begin
                        ColCur := 5;
                    end;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(5);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(5);
                        ColCur := 5;
                    end;
                }
                field("MATRIX_CellData[6]"; MATRIX_CellData[6])
                {
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[6];
                    DecimalPlaces = 0 : 4;
                    Editable = gEditable;
                    StyleExpr = MyStyleVar6;
                    ApplicationArea = All;

                    trigger OnControlAddIn(Index: Integer; Data: Text)
                    begin
                        ColCur := 6;
                    end;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(6);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(6);
                        ColCur := 6;
                    end;
                }
                field("MATRIX_CellData[7]"; MATRIX_CellData[7])
                {
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[7];
                    DecimalPlaces = 0 : 4;
                    Editable = gEditable;
                    StyleExpr = MyStyleVar7;
                    ApplicationArea = All;

                    trigger OnControlAddIn(Index: Integer; Data: Text)
                    begin
                        ColCur := 7;
                    end;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(7);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(7);
                        ColCur := 7;
                    end;
                }
                field("MATRIX_CellData[8]"; MATRIX_CellData[8])
                {
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[8];
                    DecimalPlaces = 0 : 4;
                    Editable = gEditable;
                    StyleExpr = MyStyleVar8;
                    ApplicationArea = All;

                    trigger OnControlAddIn(Index: Integer; Data: Text)
                    begin
                        ColCur := 8;
                    end;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(8);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(8);
                        ColCur := 8;
                    end;
                }
                field("MATRIX_CellData[9]"; MATRIX_CellData[9])
                {
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[9];
                    DecimalPlaces = 0 : 4;
                    Editable = gEditable;
                    StyleExpr = MyStyleVar9;
                    ApplicationArea = All;

                    trigger OnControlAddIn(Index: Integer; Data: Text)
                    begin
                        ColCur := 9;
                    end;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(9);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(9);
                        ColCur := 9;
                    end;
                }
                field("MATRIX_CellData[10]"; MATRIX_CellData[10])
                {
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[10];
                    DecimalPlaces = 0 : 4;
                    Editable = gEditable;
                    StyleExpr = MyStyleVar10;
                    ApplicationArea = All;

                    trigger OnControlAddIn(Index: Integer; Data: Text)
                    begin
                        ColCur := 10;
                    end;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(10);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(10);
                        ColCur := 10;
                    end;
                }
                field("MATRIX_CellData[11]"; MATRIX_CellData[11])
                {
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[11];
                    DecimalPlaces = 0 : 4;
                    Editable = gEditable;
                    StyleExpr = MyStyleVar11;
                    ApplicationArea = All;

                    trigger OnControlAddIn(Index: Integer; Data: Text)
                    begin
                        ColCur := 11;
                    end;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(11);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(11);
                        ColCur := 11;
                    end;
                }
                field("MATRIX_CellData[12]"; MATRIX_CellData[12])
                {
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[12];
                    DecimalPlaces = 0 : 4;
                    Editable = gEditable;
                    StyleExpr = MyStyleVar12;
                    ApplicationArea = All;

                    trigger OnControlAddIn(Index: Integer; Data: Text)
                    begin
                        ColCur := 12;
                    end;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(12);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(12);
                        ColCur := 12;
                    end;
                }
                field("MATRIX_CellData[13]"; MATRIX_CellData[13])
                {
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[13];
                    DecimalPlaces = 0 : 4;
                    Editable = gEditable;
                    StyleExpr = MyStyleVar13;
                    ApplicationArea = All;

                    trigger OnControlAddIn(Index: Integer; Data: Text)
                    begin
                        ColCur := 13;
                    end;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(13);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(13);
                        ColCur := 13;
                    end;
                }
                field("MATRIX_CellData[14]"; MATRIX_CellData[14])
                {
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[14];
                    DecimalPlaces = 0 : 4;
                    Editable = gEditable;
                    StyleExpr = MyStyleVar14;
                    ApplicationArea = All;

                    trigger OnControlAddIn(Index: Integer; Data: Text)
                    begin
                        ColCur := 14;
                    end;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(14);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(14);
                        ColCur := 14;
                    end;
                }
                field("MATRIX_CellData[15]"; MATRIX_CellData[15])
                {
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[15];
                    DecimalPlaces = 0 : 4;
                    Editable = gEditable;
                    StyleExpr = MyStyleVar15;
                    ApplicationArea = All;

                    trigger OnControlAddIn(Index: Integer; Data: Text)
                    begin
                        ColCur := 15;
                    end;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(15);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(15);
                        ColCur := 15;
                    end;
                }
                field("MATRIX_CellData[16]"; MATRIX_CellData[16])
                {
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[16];
                    DecimalPlaces = 0 : 4;
                    Editable = gEditable;
                    StyleExpr = MyStyleVar16;
                    ApplicationArea = All;

                    trigger OnControlAddIn(Index: Integer; Data: Text)
                    begin
                        ColCur := 16;
                    end;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(16);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(16);
                        ColCur := 16;
                    end;
                }
                field("MATRIX_CellData[17]"; MATRIX_CellData[17])
                {
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[17];
                    DecimalPlaces = 0 : 4;
                    Editable = gEditable;
                    StyleExpr = MyStyleVar17;
                    ApplicationArea = All;

                    trigger OnControlAddIn(Index: Integer; Data: Text)
                    begin
                        ColCur := 17;
                    end;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(17);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(17);
                        ColCur := 17;
                    end;
                }
                field("MATRIX_CellData[18]"; MATRIX_CellData[18])
                {
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[18];
                    DecimalPlaces = 0 : 4;
                    Editable = gEditable;
                    StyleExpr = MyStyleVar18;
                    ApplicationArea = All;

                    trigger OnControlAddIn(Index: Integer; Data: Text)
                    begin
                        ColCur := 18;
                    end;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(18);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(18);
                        ColCur := 18;
                    end;
                }
            }
            group(Filtered)
            {
                Caption = 'Filtered';
            }
        }
        area(factboxes)
        {
            part(Control17; "Item Details FactBox")
            {
                SubPageLink = "Item No." = FIELD ("Item No."),
                              "Unit of Measure" = FIELD ("Unit of Measure");
                Visible = true;
                ApplicationArea = All;
            }
            part("Item Status Prognoses"; "Country Total FactBox")
            {
                Caption = 'Country Total';
                SubPageLink = "Item No." = FIELD ("Item No."),
                              "Unit of Measure" = FIELD ("Unit of Measure"),
                              "Date Filter" = FIELD ("Date Filter");
                ApplicationArea = All;
            }
            part(MonthPrognFiltered; "MonthProgn Filtered FactBox")
            {
                Caption = 'Filtered';
                SubPageLink = "Item No." = FIELD ("Item No."),
                              "Unit of Measure" = FIELD ("Unit of Measure"),
                              "Date Filter" = FIELD ("Date Filter");
                ApplicationArea = All;
            }
            part(Control13; "Item Year Prog FactBox")
            {
                SubPageLink = "Item No." = FIELD ("Item No."),
                              "Unit of Measure" = FIELD ("Unit of Measure");
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Add)
            {
                Caption = 'Add';
                Image = AddAction;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin

                    PAGE.Run(50057);
                end;
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Print prognoses")
                {
                    Caption = 'Print prognoses';
                    Image = FinChargeMemo;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        grecUserSetup.Get(UserId);
                        grecItemUnit.Reset;
                        // "Ras/land/verp".SETRANGE("Ras/land/verp".Manager,gebruiker."Manager (standaard)");
                        grecItemUnit.SetRange("Date Filter", gBeginDate, gEndDate);
                        REPORT.RunModal(50069, true, false, grecItemUnit);
                    end;
                }
                separator(Separator30)
                {
                }
                action("Copy prognoses")
                {
                    Caption = 'Copy prognoses';
                    Image = CompareCOA;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        lrecProgn: Record "Prognosis/Allocation Entry";
                    begin
                        lrecProgn.Reset;
                        lrecProgn.SetRange("Item No.", "Item No.");

                        lrecProgn.SetRange("Unit of Measure", "Unit of Measure");
                        if SalesPersonFilterText <> '' then
                            lrecProgn.SetFilter(Salesperson, SalesPersonFilterText);
                        if CustomerFilterText <> '' then
                            lrecProgn.SetFilter(Customer, CustomerFilterText);
                        if ColCur <> 0 then begin
                            lrecProgn.SetRange("Sales Date", MATRIX_PeriodRecordsL[ColCur]."Period Start", MATRIX_PeriodRecordsL[ColCur]."Period End");
                        end;

                        REPORT.RunModal(50077, true, true, lrecProgn);

                    end;
                }
                action("Export Monthly Prognoses")
                {
                    Caption = 'Export Monthly Prognoses';
                    Image = ExportToBank;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin

                        REPORT.RunModal(50082);
                    end;
                }
                action("Block/Unblock from Salespersons' Changes")
                {
                    Caption = 'Block/Unblock from Salespersons'' Changes';
                    Image = ImplementCostChanges;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        lrptBlockPrognosis: Report "Block/Unlock Prognosis";
                        lrecProgn: Record "Prognosis/Allocation Entry";
                        lrecUser: Record "User Setup";
                    begin

                        if lrecUser.Get(UserId) and lrecUser."B Allow Block Prognosis" then begin
                            Clear(lrptBlockPrognosis);
                            lrecProgn.SetRange("Entry Type", lrecProgn."Entry Type"::Prognoses);
                            lrecProgn.SetRange("Item No.", "Item No.");
                            lrecProgn.SetRange("Unit of Measure", "Unit of Measure");
                            if ColCur <> 0 then begin
                                lrecProgn.SetRange("Sales Date", MATRIX_PeriodRecordsL[ColCur]."Period Start", MATRIX_PeriodRecordsL[ColCur]."Period End");
                            end;
                            if CustomerFilterText <> '' then
                                lrecProgn.SetRange(Customer, CustomerFilterText);
                            if SalesPersonFilterText <> '' then
                                lrecProgn.SetRange(Salesperson, SalesPersonFilterText);

                            REPORT.RunModal(50002, true, true, lrecProgn);
                        end else
                            Message(StrSubstNo(text50004, UserId));

                    end;
                }
                action("Mark/Unmark Progn as Handled")
                {
                    Caption = 'Mark/Unmark Progn as Handled';
                    Image = RefreshVoucher;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        lrecUser: Record "User Setup";
                        lrepMarkProgn: Report "Mark/Unmark Handled Prognosis";
                        lrecProgn: Record "Prognosis/Allocation Entry";
                    begin

                        if lrecUser.Get(UserId) and lrecUser."B Allow Marking Progn Handled" then begin
                            Clear(lrepMarkProgn);
                            lrecProgn.SetRange("Entry Type", lrecProgn."Entry Type"::Prognoses);
                            lrecProgn.SetRange("Item No.", "Item No.");
                            lrecProgn.SetRange("Unit of Measure", "Unit of Measure");

                            if CustomerFilterText <> '' then lrecProgn.SetRange(Customer, CustomerFilterText);
                            if SalesPersonFilterText <> '' then lrecProgn.SetRange(Salesperson, SalesPersonFilterText);

                            if ColCur <> 0 then begin
                                lrecProgn.SetRange("Sales Date", MATRIX_PeriodRecordsL[ColCur]."Period Start", MATRIX_PeriodRecordsL[ColCur]."Period End");
                            end;

                            lrepMarkProgn.SetTableView(lrecProgn);
                            lrepMarkProgn.RunModal;
                        end
                        else
                            Message(StrSubstNo(text50006, UserId));

                    end;
                }
                separator(Separator1000000044)
                {
                }
                action("Change Purchase Date")
                {
                    Caption = 'Change Purchase Date';
                    Image = DataEntry;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin

                        if not gShowPTO then Error(text50011);
                        Clear(grecPrognosisAllocationEntry);
                        grecPrognosisAllocationEntry.SetRange("Item No.", "Item No.");
                        grecPrognosisAllocationEntry.SetRange("Unit of Measure", "Unit of Measure");
                        if SalesPersonFilterText <> '' then
                            grecPrognosisAllocationEntry.SetFilter(Salesperson, SalesPersonFilterText);



                        if CustomerFilterText <> '' then
                            grecPrognosisAllocationEntry.SetFilter(Customer, CustomerFilterText);


                        if ColCur <> 0 then begin
                            grecPrognosisAllocationEntry.SetRange("Purchase Date", MATRIX_PeriodRecordsL[ColCur]."Period Start", MATRIX_PeriodRecordsL[ColCur]."Period End");
                        end;

                        REPORT.RunModal(50098, true, true, grecPrognosisAllocationEntry);

                    end;
                }
                action("Transfer Prognoses")
                {
                    Caption = 'Transfer Prognoses';
                    Image = TransferFunds;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        lrecProgn: Record "Prognosis/Allocation Entry";
                    begin


                        lrecProgn.Reset;
                        lrecProgn.SetRange("Item No.", "Item No.");
                        lrecProgn.SetRange("Unit of Measure", "Unit of Measure");

                        if SalesPersonFilterText <> '' then
                            lrecProgn.SetFilter(Salesperson, SalesPersonFilterText);
                        if CustomerFilterText <> '' then
                            lrecProgn.SetFilter(Customer, CustomerFilterText);

                        if ColCur <> 0 then begin
                            lrecProgn.SetRange("Sales Date", MATRIX_PeriodRecordsL[ColCur]."Period Start", MATRIX_PeriodRecordsL[ColCur]."Period End");
                        end;

                        REPORT.RunModal(50009, true, true, lrecProgn);
                    end;
                }
                separator(Separator1000000023)
                {
                }
                action("Variety Comments")
                {
                    Caption = 'Variety Comments';
                    Image = Comment;
                    ShortCutKey = 'Shift+Ctrl+V';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        lfrmBejoComment: Page "Comment Sheet Bejo";
                        lrecCommentLine: Record "Comment Line";
                    begin

                        Clear(lfrmBejoComment);

                        lrecCommentLine.SetRange("Table Name", lrecCommentLine."Table Name"::Item);

                        lrecCommentLine.SetRange("B Variety", Variety);
                        lrecCommentLine.SetRange("B Comment Type", lrecCommentLine."B Comment Type"::"Var 5 pos");
                        lrecCommentLine.SetFilter("B End Date", '>=%1', Today);
                        lfrmBejoComment.SetTableView(lrecCommentLine);
                        lfrmBejoComment.RunModal;

                    end;
                }
            }
            action("Previous Set")
            {
                Caption = 'Previous Set';
                Image = PreviousSet;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Previous Set';
                ApplicationArea = All;

                trigger OnAction()
                begin

                    MATRIX_Step := MATRIX_Step::Previous;
                    MATRIX_GenerateColumnCaptions(MATRIX_Step);
                    UpdateMatrixSubform;
                    boolExecuteUpdateOnGetRec := false;
                end;
            }
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
                    MATRIX_Step := MATRIX_Step::PreviousColumn;
                    MATRIX_GenerateColumnCaptions(MATRIX_Step);
                    UpdateMatrixSubform;
                    boolExecuteUpdateOnGetRec := false;
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
                    MATRIX_Step := MATRIX_Step::NextColumn;
                    MATRIX_GenerateColumnCaptions(MATRIX_Step);
                    UpdateMatrixSubform;
                    boolExecuteUpdateOnGetRec := false;
                end;
            }
            action("Next Set")
            {
                Caption = 'Next Set';
                Image = NextSet;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Next Set';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    MATRIX_Step := MATRIX_Step::Next;
                    MATRIX_GenerateColumnCaptions(MATRIX_Step);
                    UpdateMatrixSubform;
                    boolExecuteUpdateOnGetRec := false;
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateMatrixSubform;
    end;

    trigger OnAfterGetRecord()
    var
        lVarietyLandUnitofmeasure: Record "Item/Unit";
        n: Integer;
        lrecSalesPerson: Record "Salesperson/Purchaser";
        lrecCustomer: Record Customer;
        lrecUOM: Record "Unit of Measure";
        MATRIX_CurrentColumnOrdinal: Integer;
        lrecItemUnit: Record "Item/Unit";
    begin
        gFilter_description := '';

        if grecUserSetup."B Department" = 'SALESP' then
            SetRange("Sales Person Filter", grecUserSetup."B Initials");

        if grecUnitofMeasure1.Get("Unit of Measure") then
            gUnit := grecUnitofMeasure1."B Description for Prognoses"
        else
            gUnit := '';

        if (GetFilter("Sales Person Filter") <> '') or (GetFilter("Customer Filter") <> '') then begin
            if lrecSalespers.Get(SalesPersonFilterText) then begin
                gFilter_description := gSalespersonName;
                if lrecCustomer.Get(CustomerFilterText) then
                    gFilter_description := gFilter_description + ' / ' + gCustomerName;
            end else
                if lrecCustomer.Get(CustomerFilterText) then
                    gFilter_description := gCustomerName;
        end;

        DatumFilterInstell;
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
            MATRIX_GenerateColumnCaptions(MATRIX_Step);
            boolExecuteUpdateOnGetRec := false;
            UpdateMatrixSubform;
        end;

        PromoStatusText := Format("Promo Status");
        PromoStatusTextOnFormat(PromoStatusText);

        GetCommentLine();

        for MATRIX_CurrentColumnOrdinal := 1 to MATRIX_CurrentNoOfMatrixColumn do
            MATRIX_OnAfterGetRecord(MATRIX_CurrentColumnOrdinal);

        CurrPage."Item Status Prognoses".PAGE.Setfilters(gFilter_description, GetFilter("Date Filter"), gSalesPersonFilter, gCustFilter, gBeginDate, gEndDate, GetFilter("Unit of Measure Filter"));
        CurrPage."Item Status Prognoses".PAGE.Refreshform;
        CurrPage.MonthPrognFiltered.PAGE.Setfilters(gFilter_description, GetFilter("Date Filter"), gSalesPersonFilter, gCustFilter, gBeginDate, gEndDate, GetFilter("Unit of Measure Filter"));
        CurrPage.MonthPrognFiltered.PAGE.Refreshform;
    end;

    trigger OnInit()
    begin
        "Customer FilterEditable" := true;
        "Sales Person FilterEditable" := true;
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

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        fnOnAfterGetCurrRecord;
    end;

    trigger OnOpenPage()
    var
        lrecCustomer: Record Customer;
    begin
        gPeriodType := gPeriodType::Month;

        if (grecUserSetup."B Department" = 'SALESP') or (grecUserSetup."B Department" = 'SALESP+') then
            SalesPersonFilterText := grecUserSetup."B Initials";

        SalesPersonFilterOnAfterValida;
        CustomerFilterOnAfterValidate;

        if grecUserSetup."B Department" = 'SALESP' then begin
            "Sales Person FilterEditable" := false;
            "Customer FilterEditable" := false;
        end;

        if lrecSalespers.Get(GetFilter("Sales Person Filter"))
          then gSalespersonName := lrecSalespers.Name
        else gSalespersonName := '';

        if gShowPTO then CurrPage.Caption := text50010
        else CurrPage.Caption := text50009;

        gcuPeriodFormManagement.CreatePeriodFormat(gPeriodType, TempRecDate."Period Start");
        PeriodType := PeriodType::Month;

        MATRIX_Step := MATRIX_Step::First;
        boolExecuteUpdateOnGetRec := true;
        SetRange("Date Filter", gBeginDate, gEndDate);

        SetRecordFilters();
    end;

    var
        gcuPeriodFormManagement: Codeunit PeriodFormManagement;
        gPeriodType: Option Day,Week,Month,Quarter,Year,AccountingPeriod;
        gAmountType: Option NetChange,"Balance at date";
        grecItem: Record Item;
        grecItemUnit: Record "Item/Unit";
        gUnit: Text[15];
        i: Integer;
        grecUnitofMeasure1: Record "Unit of Measure";
        gDate1: Text[30];
        gDate2: Date;
        gBeginDate: Date;
        gBeginDateLY: Date;
        gEndDate: Date;
        gEndDateLY: Date;
        gTxtLJ: Text[80];
        gTxtVJ: Text[80];
        grecUserSetup: Record "User Setup";
        gShowUnits: Boolean;
        grecItemUnitofMeasure: Record "Item Unit of Measure";
        gUnit_prognoses: Decimal;
        gFilter_description: Text[100];
        grecBejoSetup: Record "Bejo Setup";
        grecCommentLine: Record "Comment Line";
        gstrComments: Text[1024];
        text50004: Label 'User %1 is not allowed to block/unblock prognosis.';
        text50006: Label 'User %1 is not allowed to mark/unmark prognoses as handled.';
        gCustomerName: Text[100];
        gSalespersonName: Text[100];
        gOldText: Text[250];
        grecPrognosisAllocationEntry: Record "Prognosis/Allocation Entry";
        gPack: Text[15];
        gBeginDate1: array[10] of Date;
        EndDate: array[10] of Date;
        gShowPTO: Boolean;
        text50009: Label 'Sales Prognoses per Period';
        text50010: Label 'Purchase Prognoses per Period';
        text50011: Label 'This functionality is available only when ”Purchase Plan” is activated';
        text50012: Label 'You are not allowed to Prognose for items within the following filter: %1';
        ColumnCaptions: array[12] of Text[30];
        ColumnValues: array[12] of Decimal;
        TempRecDate: Record Date;
        ColumnNo: Integer;
        loopbreak: Boolean;
        TempRecDate2: Record Date;
        MATRIX_MatrixRecords: array[18] of Record "Item/Unit";
        MATRIX_CaptionSet: array[32] of Text[80];
        FirstColumn: Text[80];
        LastColumn: Text[80];
        MATRIX_CurrentNoOfColumns: Integer;
        ShowColumnName: Boolean;
        xDateFilter: Text[30];
        MATRIX_PrimKeyFirstCaptionInCu: Text[80];
        MATRIX_CaptionRange: Text[80];
        InternalDateFilter: Text[30];
        MATRIX_Step: Option First,Previous,Same,Next,PreviousColumn,NextColumn;
        GlobalDim1Filter: Code[250];
        GlobalDim2Filter: Code[250];
        BudgetDim1Filter: Code[250];
        BudgetDim2Filter: Code[250];
        BudgetDim3Filter: Code[250];
        BudgetDim4Filter: Text[30];
        LineDimOption: Option "G/L Account",Period,"Business Unit","Global Dimension 1","Global Dimension 2","Budget Dimension 1","Budget Dimension 2","Budget Dimension 3","Budget Dimension 4";
        LineDimCode: Text[30];
        GLAccFilter: Code[250];
        PeriodType: Option Day,Week,Month,Quarter,Year,"Accounting Period";
        MATRIX_PeriodRecords: array[32] of Record Date;
        [InDataSet]
        "Sales Person FilterEditable": Boolean;
        [InDataSet]
        "Customer FilterEditable": Boolean;
        [InDataSet]
        PromoStatusText: Text[1024];
        Text19011378: Label 'Item';
        Text19050243: Label 'Prognoses';
        Text19075742: Label 'Sales';
        Text19003981: Label 'Filtered';
        Text19080001: Label 'Prognoses';
        Text19080002: Label 'Sales';
        Text19004798: Label 'Year Prognoses';
        boolExecuteUpdateOnGetRec: Boolean;
        gUOM: Text[30];
        SalesPersonFilterText: Code[20];
        CustomerFilterText: Code[20];
        UnitofMeasureFilterText: Text[50];
        MATRIX_CurrentNoOfMatrixColumn: Integer;
        MATRIX_CellData: array[18] of Decimal;
        MatrixRecords: array[18] of Record "Item/Unit";
        MATRIX_MatrixRecord: Record "Item/Unit";
        PeriodInitialized: Boolean;
        gEditable: Boolean;
        [InDataSet]
        gPerUnit: Boolean;
        MATRIX_PeriodRecordsL: array[32] of Record Date;
        gSalesPersonFilter: Code[150];
        gUOMFilter: Text[150];
        gCustFilter: Code[150];
        gProgText: Text[250];
        lrecSalespers: Record "Salesperson/Purchaser";
        lrecCustomer: Record Customer;
        NewAmount: Decimal;
        [InDataSet]
        MyStyleVar1: Text[20];
        [InDataSet]
        MyStyleVar2: Text[20];
        [InDataSet]
        MyStyleVar3: Text[20];
        [InDataSet]
        MyStyleVar4: Text[20];
        [InDataSet]
        MyStyleVar5: Text[20];
        [InDataSet]
        MyStyleVar6: Text[20];
        [InDataSet]
        MyStyleVar7: Text[20];
        [InDataSet]
        MyStyleVar8: Text[20];
        [InDataSet]
        MyStyleVar9: Text[20];
        [InDataSet]
        MyStyleVar10: Text[20];
        [InDataSet]
        MyStyleVar11: Text[20];
        [InDataSet]
        MyStyleVar12: Text[20];
        [InDataSet]
        MyStyleVar13: Text[20];
        [InDataSet]
        MyStyleVar14: Text[20];
        [InDataSet]
        MyStyleVar15: Text[20];
        [InDataSet]
        MyStyleVar16: Text[20];
        [InDataSet]
        MyStyleVar17: Text[20];
        [InDataSet]
        MyStyleVar18: Text[20];
        gHandled: Boolean;
        ColCur: Integer;
        gBlocked: Boolean;
        gStyleUnit: Boolean;
        grecTempPrognosisAllocation: Record "Prognosis/Allocation Entry" temporary;
        Text50000_1: Label 'General Level';
        Text50001_1: Label 'Salesperson Level';
        Text50002_1: Label 'Customer Level';
        Text50003_1: Label 'Detail Level';
        text50005: Label 'Prognoses for item %1, unit of measure %2, period %3 cannot be changed because it is being handled.';
        xx: Integer;

    local procedure DatumFilterInstell()
    begin
        if not gShowPTO then begin

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

    local procedure BedrFormatteren(var Tkst: Text[250])
    var
        Bedr: Decimal;
    begin
        if Evaluate(Bedr, Tkst) then begin
            if gShowUnits = true then begin
                if grecItemUnitofMeasure.Get("Item No.", "Unit of Measure") then begin
                    if grecUnitofMeasure1.Get("Unit of Measure") then begin
                        if (grecUnitofMeasure1."B Unit in Weight") and (grecItemUnitofMeasure."Qty. per Unit of Measure" <> 0) then
                            Bedr := Bedr / grecItemUnitofMeasure."Qty. per Unit of Measure"
                        else
                            Bedr := Round(Bedr * (1000000 / grecItemUnitofMeasure."Qty. per Unit of Measure"), 0.001);
                    end;
                end;
            end;
            Tkst := Format(Bedr);
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

    procedure MATRIX_GenerateColumnCaptions(MATRIX_SetWanted: Option First,Previous,Same,Next,PreviousColumn,NextColumn)
    var
        BusUnit: Record "Business Unit";
        GLAccount: Record "G/L Account";
        MatrixMgt: Codeunit "Matrix Management";
        RecRef: RecordRef;
        FieldRef: FieldRef;
        CurrentMatrixRecordOrdinal: Integer;
        i: Integer;
    begin
        Clear(MATRIX_CaptionSet);
        CurrentMatrixRecordOrdinal := 1;
        Clear(MATRIX_MatrixRecords);
        FirstColumn := '';
        LastColumn := '';

        MATRIX_CurrentNoOfColumns := 18;
        if MATRIX_SetWanted = MATRIX_SetWanted::First then begin
            if (gBeginDate <> 0D) and (gEndDate <> 0D) then begin
                xDateFilter := (Format(gBeginDate) + '..' + Format(CalcDate('<+6M>', gEndDate)));
            end;
        end
        else begin
            xDateFilter := '';
        end;

        MatrixMgt.GeneratePeriodMatrixData(
          MATRIX_SetWanted, MATRIX_CurrentNoOfColumns, ShowColumnName,
          PeriodType, xDateFilter, MATRIX_PrimKeyFirstCaptionInCu,
          MATRIX_CaptionSet, MATRIX_CaptionRange, MATRIX_CurrentNoOfColumns, MATRIX_PeriodRecords);

        for i := 1 to MATRIX_CurrentNoOfColumns do begin

            MATRIX_MatrixRecords[i]."Item No." := "Item No.";
            MATRIX_MatrixRecords[i]."Unit of Measure" := "Unit of Measure";
            MATRIX_MatrixRecords[i].SetRange("Date Filter", MATRIX_PeriodRecords[i]."Period Start", MATRIX_PeriodRecords[i]."Period End");
            MATRIX_MatrixRecords[i].SetRange("Sales Person Filter", "Sales Person Filter");
            MATRIX_MatrixRecords[i].SetRange("Customer Filter", "Customer Filter");
            MATRIX_MatrixRecords[i].SetRange("Unit of Measure Filter", "Unit of Measure Filter");

            if MATRIX_MatrixRecords[i]."Date Filter" <> 0D then
                MATRIX_MatrixRecords[i].SetRange("Date Filter Previous Year", CalcDate('<-1Y>', MATRIX_MatrixRecords[i]."Date Filter"));
        end;

        FirstColumn := Format(MATRIX_PeriodRecords[1]."Period Start");
        LastColumn := Format(MATRIX_PeriodRecords[MATRIX_CurrentNoOfColumns]."Period End");
    end;

    local procedure FindPeriod(SearchText: Code[10])
    var
        GLAcc: Record "G/L Account";
        Calendar: Record Date;
        PeriodFormMgt: Codeunit PeriodFormManagement;
    begin
        if xDateFilter <> '' then begin
            Calendar.SetFilter("Period Start", xDateFilter);
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

    procedure UpdateMatrixSubform()
    var
        TextTest: Code[10];
    begin
        TextTest := GetFilter("Sales Person Filter");
        if TextTest <> '' then
            GLAccFilter := TextTest
        else
            GLAccFilter := '';

        if (GetFilter("Customer Filter") <> '') and (GetFilter("Customer Filter") <> '''') then
            BudgetDim1Filter := GetFilter("Customer Filter")
        else
            BudgetDim1Filter := '';

        BudgetDim2Filter := GetFilter("Unit of Measure Filter");
        BudgetDim4Filter := GetFilter("Date Filter Previous Year");

        Load(
          MATRIX_CaptionSet, MATRIX_MatrixRecords, MATRIX_CurrentNoOfColumns, LineDimCode,
          LineDimOption, gShowUnits, GlobalDim1Filter, GlobalDim2Filter, BudgetDim1Filter,
          BudgetDim2Filter, BudgetDim3Filter, BudgetDim4Filter, MATRIX_PeriodRecords, xDateFilter,
          GLAccFilter, gShowPTO, PeriodType);

        SetRecordFilters();
    end;

    local procedure gBeginDateOnAfterValidate()
    begin
        gTxtLJ := Format(gBeginDate) + ' ..................................................... ' + Format(gEndDate);
        gTxtVJ := Format(gBeginDateLY) + ' ........................... ' + Format(gEndDateLY);
        SetRange("Date Filter", gBeginDate, gEndDate);
        CurrPage.Update;
    end;

    local procedure gEndDateOnAfterValidate()
    begin
        if gBeginDate <> 0D then begin
            gBeginDateLY := CalcDate('<-1Y>', gBeginDate);
        end;
        if gEndDate <> 0D then begin
            gEndDateLY := CalcDate('<-1Y>', gEndDate);
        end;

        if (gBeginDate = 0D) and (gEndDate = 0D) then begin
            gEndDate := Rec.GetRangeMax("Date Filter");
        end;

        gTxtLJ := Format(gBeginDate) + ' ..................................................... ' + Format(gEndDate);
        gTxtVJ := Format(gBeginDateLY) + ' ........................... ' + Format(gEndDateLY);
        SetRange("Date Filter", gBeginDate, gEndDate);
        CurrPage.Update;
    end;

    local procedure SalesPersonFilterOnAfterValida()
    begin
        if lrecSalespers.Get(SalesPersonFilterText) then begin
            gSalespersonName := lrecSalespers.Name;
            if SalesPersonFilterText <> '' then
                SetFilter("Sales Person Filter", SalesPersonFilterText);
        end else begin
            gSalespersonName := '';
            SetRange("Sales Person Filter");
        end;
        UpdateMatrixSubform;
        SetRecordFilters();
        CurrPage.Update;
    end;

    local procedure CustomerFilterOnAfterValidate()
    begin
        if lrecCustomer.Get(CustomerFilterText) then begin
            gCustomerName := lrecCustomer.Name;
            if CustomerFilterText <> '' then
                SetFilter("Customer Filter", CustomerFilterText);
        end else begin
            gCustomerName := '';
            SetRange("Customer Filter");
        end;
        UpdateMatrixSubform;
        SetRecordFilters();
        CurrPage.Update;
    end;

    local procedure UnitofMeasureFilterOnAfterVali()
    var
        lUOM: Record "Unit of Measure";
    begin
        if lUOM.Get(UnitofMeasureFilterText) then begin
            gUOM := lUOM.Description;
            SetRange("Unit of Measure Filter", UnitofMeasureFilterText);
        end else begin
            gUOM := '';
            SetRange("Unit of Measure Filter");
        end;
        UpdateMatrixSubform;
        SetRecordFilters();
        CurrPage.Update;
    end;

    local procedure fnOnAfterGetCurrRecord()
    begin
        xRec := Rec;
        GetCommentLine();

    end;

    local procedure AccountingPeriogPeriodTyOnPush()
    begin
        PeriodType := PeriodType::"Accounting Period";
        MATRIX_Step := MATRIX_Step::First;

        MATRIX_GenerateColumnCaptions(MATRIX_Step);
        UpdateMatrixSubform;
        CurrPage.Update;

        boolExecuteUpdateOnGetRec := true;
    end;

    local procedure YeargPeriodTypeOnPush()
    begin
        PeriodType := PeriodType::Year;
        boolExecuteUpdateOnGetRec := false;
    end;

    local procedure QuartergPeriodTypeOnPush()
    begin
        PeriodType := PeriodType::Quarter;
        boolExecuteUpdateOnGetRec := false;
    end;

    local procedure MonthgPeriodTypeOnPush()
    begin
        PeriodType := PeriodType::Month;
        boolExecuteUpdateOnGetRec := false;
    end;

    local procedure WeekgPeriodTypeOnPush()
    begin
        PeriodType := PeriodType::Week;
        boolExecuteUpdateOnGetRec := false;
    end;

    local procedure DaygPeriodTypeOnPush()
    begin
        PeriodType := PeriodType::Day;
        boolExecuteUpdateOnGetRec := false;
    end;

    local procedure PromoStatusTextOnFormat(var Text: Text[1024])
    begin
        Text := DisplayPromoStatus;
    end;

    local procedure DaygPeriodTypeOnValidate()
    begin
        DaygPeriodTypeOnPush;
    end;

    local procedure WeekgPeriodTypeOnValidate()
    begin
        WeekgPeriodTypeOnPush;
    end;

    local procedure MonthgPeriodTypeOnValidate()
    begin
        MonthgPeriodTypeOnPush;
    end;

    local procedure QuartergPeriodTypeOnValidate()
    begin
        QuartergPeriodTypeOnPush;
    end;

    local procedure YeargPeriodTypeOnValidate()
    begin
        YeargPeriodTypeOnPush;
    end;

    local procedure AccountingPeriogPeriodTypeOnVa()
    begin
        AccountingPeriogPeriodTyOnPush;
    end;

    procedure Load(var MatrixColumns1: array[32] of Text[80]; var MatrixRecords1: array[18] of Record "Item/Unit"; CurrentNoOfMatrixColumns: Integer; _LineDimCode: Text[30]; _LineDimOption: Integer; _ColumnDimOption: Boolean; _GlobalDim1Filter: Code[250]; _GlobalDim2Filter: Code[250]; _BudgetDim1Filter: Code[250]; _BudgetDim2Filter: Code[250]; _BudgetDim3Filter: Code[250]; _BudgetDim4Filter: Text; var MATRIX_PeriodRecords: array[32] of Record Date; _DateFilter: Text[30]; _GLAccFilter: Code[250]; _RoundingFactor: Boolean; _PeriodType: Option Day,Week,Month,Quarter,Year,"Accounting Period")
    var
        i: Integer;
    begin
        for i := 1 to 18 do begin
            if MatrixColumns1[i] = '' then
                MATRIX_CaptionSet[i] := ' '
            else
                MATRIX_CaptionSet[i] := MatrixColumns1[i];
            MatrixRecords[i] := MatrixRecords1[i];
            MATRIX_PeriodRecordsL[i] := MATRIX_PeriodRecords[i];
        end;
        if MATRIX_CaptionSet[1] = '' then;
        if CurrentNoOfMatrixColumns > ArrayLen(MATRIX_CellData) then
            MATRIX_CurrentNoOfMatrixColumn := ArrayLen(MATRIX_CellData)
        else
            MATRIX_CurrentNoOfMatrixColumn := CurrentNoOfMatrixColumns;

        SetRange("Unit of Measure Filter", _BudgetDim2Filter);

        if _DateFilter <> '' then begin
            SetFilter("Date Filter", _DateFilter);
        end;

        SetRange("Sales Person Filter", _GLAccFilter);
        SetRange("Customer Filter", _BudgetDim1Filter);
        SetFilter("Date Filter Previous Year", _BudgetDim4Filter);

        gSalesPersonFilter := _GLAccFilter;
        gCustFilter := _BudgetDim1Filter;
        gUOMFilter := _BudgetDim2Filter;
        gShowUnits := _ColumnDimOption;
        gShowPTO := _RoundingFactor;
    end;

    local procedure MATRIX_OnDrillDown(MATRIX_ColumnOrdinal: Integer)
    var
        teste: Record "Prognosis/Allocation Entry";
    begin
        ColCur := MATRIX_ColumnOrdinal;
        MATRIX_MatrixRecord := MatrixRecords[MATRIX_ColumnOrdinal];

        grecPrognosisAllocationEntry.Reset;
        grecPrognosisAllocationEntry.SetRange("Item No.", "Item No.");
        grecPrognosisAllocationEntry.SetRange("Unit of Measure", "Unit of Measure");

        if gShowPTO then
            grecPrognosisAllocationEntry.SetRange(Handled, true);

        grecPrognosisAllocationEntry.SetRange("Date filter", MATRIX_PeriodRecordsL[MATRIX_ColumnOrdinal]."Period Start", MATRIX_PeriodRecordsL[MATRIX_ColumnOrdinal]."Period End");

        fct_drilldown(MATRIX_ColumnOrdinal);
        grecTempPrognosisAllocation.Reset;
        PAGE.Run(50058, grecTempPrognosisAllocation);
    end;

    local procedure MATRIX_OnAfterGetRecord(MATRIX_ColumnOrdinal: Integer)
    var
        lrecItemUnit: Record "Item/Unit";
        lrecProgn: Record "Prognosis/Allocation Entry";
        lrecItem: Record Item;
    begin
        MATRIX_MatrixRecord := MatrixRecords[MATRIX_ColumnOrdinal];

        lrecItemUnit.SetRange("Item No.", "Item No.");
        lrecItemUnit.SetRange("Unit of Measure", "Unit of Measure");

        if gShowPTO then begin
            if (MATRIX_PeriodRecordsL[MATRIX_ColumnOrdinal]."Period Start" <> 0D) and
              (MATRIX_PeriodRecordsL[MATRIX_ColumnOrdinal]."Period End" <> 0D) then
                lrecItemUnit.SetRange("Date Filter Previous Year", MATRIX_PeriodRecordsL[MATRIX_ColumnOrdinal]."Period Start",
                                                   MATRIX_PeriodRecordsL[MATRIX_ColumnOrdinal]."Period End");
        end else begin

            if (MATRIX_PeriodRecordsL[MATRIX_ColumnOrdinal]."Period Start" <> 0D) and
                  (MATRIX_PeriodRecordsL[MATRIX_ColumnOrdinal]."Period End" <> 0D) then
                lrecItemUnit.SetRange("Date Filter", MATRIX_PeriodRecordsL[MATRIX_ColumnOrdinal]."Period Start",
                                                   MATRIX_PeriodRecordsL[MATRIX_ColumnOrdinal]."Period End");
        end;

        if lrecSalespers.Get(SalesPersonFilterText) then
            lrecItemUnit.SetRange("Sales Person Filter", gSalesPersonFilter)
        else
            lrecItemUnit.SetRange("Sales Person Filter");

        if lrecCustomer.Get(CustomerFilterText) then
            lrecItemUnit.SetRange("Customer Filter", gCustFilter)
        else
            lrecItemUnit.SetRange("Customer Filter");

        if lrecItemUnit.FindSet then;

        lrecItemUnit.CalcFields(Prognoses);

        MATRIX_CellData[MATRIX_ColumnOrdinal] := lrecItemUnit.Prognoses;

        gPerUnit := false;
        gHandled := false;
        gBlocked := false;
        gStyleUnit := false;

        if gShowUnits = true then begin
            gPerUnit := true;
            gStyleUnit := true;
        end;

        if gShowPTO then
            gEditable := false
        else
            gEditable := true;

        gProgText := Format(lrecItemUnit.Prognoses);
        BedrFormatteren(gProgText);

        lrecProgn.SetCurrentKey("Entry Type", "Item No.", "Unit of Measure", "Sales Date", Salesperson, Customer);
        lrecProgn.SetRange("Entry Type", lrecProgn."Entry Type"::Prognoses);
        lrecProgn.SetRange("Item No.", "Item No.");
        lrecProgn.SetRange("Unit of Measure", "Unit of Measure");
        lrecProgn.SetRange("Sales Date", MATRIX_PeriodRecordsL[MATRIX_ColumnOrdinal]."Period Start",
                               MATRIX_PeriodRecordsL[MATRIX_ColumnOrdinal]."Period End");

        if lrecProgn.Find('-') then begin
            if lrecProgn.Blocked then begin
                gPerUnit := true;
                gBlocked := true;
            end;
            if lrecProgn.Handled then
                gHandled := true;
        end;

        if gBlocked and not gHandled then begin
            if MATRIX_ColumnOrdinal = 1 then begin
                MyStyleVar1 := 'Attention';
            end;
            if MATRIX_ColumnOrdinal = 2 then begin
                MyStyleVar2 := 'Attention';
            end;
            if MATRIX_ColumnOrdinal = 3 then begin
                MyStyleVar3 := 'Attention';
            end;
            if MATRIX_ColumnOrdinal = 4 then begin
                MyStyleVar4 := 'Attention';
            end;
            if MATRIX_ColumnOrdinal = 5 then begin
                MyStyleVar5 := 'Attention';
            end;
            if MATRIX_ColumnOrdinal = 6 then begin
                MyStyleVar6 := 'Attention';
            end;
            if MATRIX_ColumnOrdinal = 7 then begin
                MyStyleVar7 := 'Attention';
            end;
            if MATRIX_ColumnOrdinal = 8 then begin
                MyStyleVar8 := 'Attention';
            end;
            if MATRIX_ColumnOrdinal = 9 then begin
                MyStyleVar9 := 'Attention';
            end;
            if MATRIX_ColumnOrdinal = 10 then begin
                MyStyleVar10 := 'Attention';
            end;
            if MATRIX_ColumnOrdinal = 11 then begin
                MyStyleVar11 := 'Attention';
            end;
            if MATRIX_ColumnOrdinal = 12 then begin
                MyStyleVar12 := 'Attention';
            end;
            if MATRIX_ColumnOrdinal = 13 then begin
                MyStyleVar13 := 'Attention';
            end;
            if MATRIX_ColumnOrdinal = 14 then begin
                MyStyleVar14 := 'Attention';
            end;
            if MATRIX_ColumnOrdinal = 15 then begin
                MyStyleVar15 := 'Attention';
            end;
            if MATRIX_ColumnOrdinal = 16 then begin
                MyStyleVar16 := 'Attention';
            end;
            if MATRIX_ColumnOrdinal = 17 then begin
                MyStyleVar17 := 'Attention';
            end;
            if MATRIX_ColumnOrdinal = 18 then begin
                MyStyleVar18 := 'Attention';
            end;

        end;

        if gBlocked and gHandled then begin
            if MATRIX_ColumnOrdinal = 1 then begin
                MyStyleVar1 := 'Unfavorable';
            end;
            if MATRIX_ColumnOrdinal = 2 then begin
                MyStyleVar2 := 'Unfavorable';
            end;
            if MATRIX_ColumnOrdinal = 3 then begin
                MyStyleVar3 := 'Unfavorable';
            end;
            if MATRIX_ColumnOrdinal = 4 then begin
                MyStyleVar4 := 'Unfavorable';
            end;
            if MATRIX_ColumnOrdinal = 5 then begin
                MyStyleVar5 := 'Unfavorable';
            end;
            if MATRIX_ColumnOrdinal = 6 then begin
                MyStyleVar6 := 'Unfavorable';
            end;
            if MATRIX_ColumnOrdinal = 7 then begin
                MyStyleVar7 := 'Unfavorable';
            end;
            if MATRIX_ColumnOrdinal = 8 then begin
                MyStyleVar8 := 'Unfavorable';
            end;
            if MATRIX_ColumnOrdinal = 9 then begin
                MyStyleVar9 := 'Unfavorable';
            end;
            if MATRIX_ColumnOrdinal = 10 then begin
                MyStyleVar10 := 'Unfavorable';
            end;
            if MATRIX_ColumnOrdinal = 11 then begin
                MyStyleVar11 := 'Unfavorable';
            end;
            if MATRIX_ColumnOrdinal = 12 then begin
                MyStyleVar12 := 'Unfavorable';
            end;
            if MATRIX_ColumnOrdinal = 13 then begin
                MyStyleVar13 := 'Unfavorable';
            end;
            if MATRIX_ColumnOrdinal = 14 then begin
                MyStyleVar14 := 'Unfavorable';
            end;
            if MATRIX_ColumnOrdinal = 15 then begin
                MyStyleVar15 := 'Unfavorable';
            end;
            if MATRIX_ColumnOrdinal = 16 then begin
                MyStyleVar16 := 'Unfavorable';
            end;
            if MATRIX_ColumnOrdinal = 17 then begin
                MyStyleVar17 := 'Unfavorable';
            end;
            if MATRIX_ColumnOrdinal = 18 then begin
                MyStyleVar18 := 'Unfavorable';
            end;

        end;

        if not gBlocked and not gHandled then begin
            if MATRIX_ColumnOrdinal = 1 then begin
                MyStyleVar1 := 'Standard';
            end;
            if MATRIX_ColumnOrdinal = 2 then begin
                MyStyleVar2 := 'Standard';
            end;
            if MATRIX_ColumnOrdinal = 3 then begin
                MyStyleVar3 := 'Standard';
            end;
            if MATRIX_ColumnOrdinal = 4 then begin
                MyStyleVar4 := 'Standard';
            end;
            if MATRIX_ColumnOrdinal = 5 then begin
                MyStyleVar5 := 'Standard';
            end;
            if MATRIX_ColumnOrdinal = 6 then begin
                MyStyleVar6 := 'Standard';
            end;
            if MATRIX_ColumnOrdinal = 7 then begin
                MyStyleVar7 := 'Standard';
            end;
            if MATRIX_ColumnOrdinal = 8 then begin
                MyStyleVar8 := 'Standard';
            end;
            if MATRIX_ColumnOrdinal = 9 then begin
                MyStyleVar9 := 'Standard';
            end;
            if MATRIX_ColumnOrdinal = 10 then begin
                MyStyleVar10 := 'Standard';
            end;
            if MATRIX_ColumnOrdinal = 11 then begin
                MyStyleVar11 := 'Standard';
            end;
            if MATRIX_ColumnOrdinal = 12 then begin
                MyStyleVar12 := 'Standard';
            end;
            if MATRIX_ColumnOrdinal = 13 then begin
                MyStyleVar13 := 'Standard';
            end;
            if MATRIX_ColumnOrdinal = 14 then begin
                MyStyleVar14 := 'Standard';
            end;
            if MATRIX_ColumnOrdinal = 15 then begin
                MyStyleVar15 := 'Standard';
            end;
            if MATRIX_ColumnOrdinal = 16 then begin
                MyStyleVar16 := 'Standard';
            end;
            if MATRIX_ColumnOrdinal = 17 then begin
                MyStyleVar17 := 'Standard';
            end;
            if MATRIX_ColumnOrdinal = 18 then begin
                MyStyleVar18 := 'Standard';
            end;

        end;

        if not gBlocked and gHandled then begin
            if MATRIX_ColumnOrdinal = 1 then begin
                MyStyleVar1 := 'Strong';
            end;
            if MATRIX_ColumnOrdinal = 2 then begin
                MyStyleVar2 := 'Strong';
            end;
            if MATRIX_ColumnOrdinal = 3 then begin
                MyStyleVar3 := 'Strong'
            end;
            if MATRIX_ColumnOrdinal = 4 then begin
                MyStyleVar4 := 'Strong';
            end;
            if MATRIX_ColumnOrdinal = 5 then begin
                MyStyleVar5 := 'Strong';
            end;
            if MATRIX_ColumnOrdinal = 6 then begin
                MyStyleVar6 := 'Strong';
            end;
            if MATRIX_ColumnOrdinal = 7 then begin
                MyStyleVar7 := 'Strong';
            end;
            if MATRIX_ColumnOrdinal = 8 then begin
                MyStyleVar8 := 'Strong';
            end;
            if MATRIX_ColumnOrdinal = 9 then begin
                MyStyleVar9 := 'Strong';
            end;
            if MATRIX_ColumnOrdinal = 10 then begin
                MyStyleVar10 := 'Strong';
            end;
            if MATRIX_ColumnOrdinal = 11 then begin
                MyStyleVar11 := 'Strong';
            end;
            if MATRIX_ColumnOrdinal = 12 then begin
                MyStyleVar12 := 'Strong';
            end;
            if MATRIX_ColumnOrdinal = 13 then begin
                MyStyleVar13 := 'Strong';
            end;
            if MATRIX_ColumnOrdinal = 14 then begin
                MyStyleVar14 := 'Strong';
            end;
            if MATRIX_ColumnOrdinal = 15 then begin
                MyStyleVar15 := 'Strong';
            end;
            if MATRIX_ColumnOrdinal = 16 then begin
                MyStyleVar16 := 'Strong';
            end;
            if MATRIX_ColumnOrdinal = 17 then begin
                MyStyleVar17 := 'Strong';
            end;
            if MATRIX_ColumnOrdinal = 18 then begin
                MyStyleVar18 := 'Strong';
            end;

        end;

        if gStyleUnit and not gBlocked and not gHandled then begin
            if MATRIX_ColumnOrdinal = 1 then begin
                MyStyleVar1 := 'StandardAccent';
            end;
            if MATRIX_ColumnOrdinal = 2 then begin
                MyStyleVar2 := 'StandardAccent';
            end;
            if MATRIX_ColumnOrdinal = 3 then begin
                MyStyleVar3 := 'StandardAccent';
            end;
            if MATRIX_ColumnOrdinal = 4 then begin
                MyStyleVar4 := 'StandardAccent';
            end;
            if MATRIX_ColumnOrdinal = 5 then begin
                MyStyleVar5 := 'StandardAccent';
            end;
            if MATRIX_ColumnOrdinal = 6 then begin
                MyStyleVar6 := 'StandardAccent';
            end;
            if MATRIX_ColumnOrdinal = 7 then begin
                MyStyleVar7 := 'StandardAccent';
            end;
            if MATRIX_ColumnOrdinal = 8 then begin
                MyStyleVar8 := 'StandardAccent';
            end;
            if MATRIX_ColumnOrdinal = 9 then begin
                MyStyleVar9 := 'StandardAccent';
            end;
            if MATRIX_ColumnOrdinal = 10 then begin
                MyStyleVar10 := 'StandardAccent';
            end;
            if MATRIX_ColumnOrdinal = 11 then begin
                MyStyleVar11 := 'StandardAccent';
            end;
            if MATRIX_ColumnOrdinal = 12 then begin
                MyStyleVar12 := 'StandardAccent';
            end;
            if MATRIX_ColumnOrdinal = 13 then begin
                MyStyleVar13 := 'StandardAccent';
            end;
            if MATRIX_ColumnOrdinal = 14 then begin
                MyStyleVar14 := 'StandardAccent';
            end;
            if MATRIX_ColumnOrdinal = 15 then begin
                MyStyleVar15 := 'StandardAccent';
            end;
            if MATRIX_ColumnOrdinal = 16 then begin
                MyStyleVar16 := 'StandardAccent';
            end;
            if MATRIX_ColumnOrdinal = 17 then begin
                MyStyleVar17 := 'StandardAccent';
            end;
            if MATRIX_ColumnOrdinal = 18 then begin
                MyStyleVar18 := 'StandardAccent';
            end;

        end;

        gOldText := gProgText;
        if Evaluate(MATRIX_CellData[MATRIX_ColumnOrdinal], gProgText) then;
    end;

    procedure UpdateAmount(MATRIX_ColumnOrdinal: Integer)
    var
        NewAmount: Decimal;
        lrecProgn: Record "Prognosis/Allocation Entry";
        lSDBZHold: Date;
        lShowMessage: Boolean;
        lrecItem: Record Item;
        lrecPrognosisEntry: Record "Prognosis/Allocation Entry";
        lrecItemUnit: Record "Item/Unit";
        lcuBlockingMgt: Codeunit "Blocking Management";
        InsertPrognosis: Boolean;
    begin
        if grecBejoSetup."Prognoses per Salesperson" then begin
            if not lrecSalespers.Get(GetFilter("Sales Person Filter")) then
                TestField("Sales Person Filter");
        end;

        if grecBejoSetup."Prognoses per Customer" then begin
            if not lrecCustomer.Get(GetFilter("Customer Filter")) then
                TestField("Customer Filter");
        end;


        if grecBejoSetup."PrognNotAllowed Filter" <> '' then begin
            lrecItem.SetFilter("B Crop Extension", grecBejoSetup."PrognNotAllowed Filter");
            lrecItem.SetFilter("No.", "Item No.");
            if not lrecItem.FindFirst then
                Error(StrSubstNo(text50012, grecBejoSetup."PrognNotAllowed Filter"));
        end;

        InsertPrognosis := true;
        lrecProgn.SetCurrentKey("Entry Type", "Item No.", "Unit of Measure", "Sales Date", Salesperson, Customer);
        lrecProgn.SetRange("Entry Type", lrecProgn."Entry Type"::Prognoses);
        lrecProgn.SetRange("Item No.", "Item No.");
        lrecProgn.SetRange("Unit of Measure", "Unit of Measure");
        lrecProgn.SetRange("Sales Date", MATRIX_PeriodRecordsL[MATRIX_ColumnOrdinal]."Period Start",
                               MATRIX_PeriodRecordsL[MATRIX_ColumnOrdinal]."Period End");
        if lrecProgn.FindFirst then
            if lrecProgn.Blocked then begin
                Message(StrSubstNo(text50005, "Item No.", "Unit of Measure",
                        Format(MATRIX_PeriodRecordsL[MATRIX_ColumnOrdinal]."Period Start")
                        + '..' +
                        Format(MATRIX_PeriodRecordsL[MATRIX_ColumnOrdinal]."Period End")));
                InsertPrognosis := false;
                CurrPage.Update(false);

            end;

        if InsertPrognosis then begin

            lrecPrognosisEntry.Init;
            lrecPrognosisEntry."Item No." := "Item No.";
            lrecPrognosisEntry.Validate("Sales Date", MATRIX_PeriodRecordsL[MATRIX_ColumnOrdinal]."Period Start");

            if lrecSalespers.Get(gSalesPersonFilter) then
                lrecPrognosisEntry.Salesperson := lrecSalespers.Code;

            if lrecCustomer.Get(gCustFilter) then
                lrecPrognosisEntry.Customer := lrecCustomer."No.";


            lrecPrognosisEntry."Unit of Measure" := "Unit of Measure";
            lrecPrognosisEntry."Entry Type" := lrecPrognosisEntry."Entry Type"::Prognoses;

            lrecItemUnit.SetRange("Item No.", "Item No.");

            lrecItemUnit.SetRange("Unit of Measure", "Unit of Measure");
            if (MATRIX_PeriodRecordsL[MATRIX_ColumnOrdinal]."Period Start" <> 0D) and
              (MATRIX_PeriodRecordsL[MATRIX_ColumnOrdinal]."Period End" <> 0D) then
                lrecItemUnit.SetRange("Date Filter", MATRIX_PeriodRecordsL[MATRIX_ColumnOrdinal]."Period Start",
                                                     MATRIX_PeriodRecordsL[MATRIX_ColumnOrdinal]."Period End");

            if lrecSalespers.Get(gSalesPersonFilter) then
                lrecItemUnit.SetRange("Sales Person Filter", gSalesPersonFilter);

            if lrecCustomer.Get(gCustFilter) then
                lrecItemUnit.SetRange("Customer Filter", gCustFilter);

            if lrecItemUnit.FindSet then;

            lrecItemUnit.CalcFields(Prognoses);

            NewAmount := MATRIX_CellData[MATRIX_ColumnOrdinal];

            if (grecBejoSetup."Variety Blocking") and (NewAmount <> 0) then
                lcuBlockingMgt.CheckItemUnit(Rec);

            gProgText := Format(NewAmount);
            BedrEvalueren(gProgText);
            if Evaluate(NewAmount, gProgText) then;
            NewAmount := NewAmount - lrecItemUnit.Prognoses;

            lrecPrognosisEntry.Prognoses := NewAmount;

            if lrecPrognosisEntry.Prognoses <> 0 then
                lrecPrognosisEntry.Insert(true);

        end;
    end;

    procedure DateFilterInstall3(CurrMatrixRec: Integer)
    begin

        gDate1 := ('<0D>');
        gDate2 := CalcDate(gDate1);
        SetRange("Date Filter");

        if (MATRIX_PeriodRecordsL[CurrMatrixRec]."Period Start" <> 0D) and (MATRIX_PeriodRecordsL[CurrMatrixRec]."Period End" <> 0D) then
            SetRange("Date Filter Previous Year", MATRIX_PeriodRecords[1]."Period Start")
        else
            SetRange("Date Filter Previous Year", MATRIX_PeriodRecords[CurrMatrixRec]."Period Start", MATRIX_PeriodRecords[CurrMatrixRec]."Period Start")
    end;

    local procedure fct_drilldown(var ColMatrix: Integer)
    var
        lrecPrognosisAllocationEntry: Record "Prognosis/Allocation Entry";
        lTeller: Integer;
    begin
        grecTempPrognosisAllocation.Reset;
        grecTempPrognosisAllocation.DeleteAll;

        Commit;
        xx := grecTempPrognosisAllocation.Count;
        grecTempPrognosisAllocation.Init;
        grecTempPrognosisAllocation."Internal Entry No." := 10000;
        grecTempPrognosisAllocation."Entry Type" := grecTempPrognosisAllocation."Entry Type"::Total;
        grecTempPrognosisAllocation."Item No." := "Item No.";
        grecTempPrognosisAllocation."Unit of Measure" := "Unit of Measure";
        grecTempPrognosisAllocation.Description := Text50000_1;
        grecTempPrognosisAllocation."Filter Text" := Format(MATRIX_PeriodRecordsL[ColMatrix]."Period Start") + '...' + Format(MATRIX_PeriodRecordsL[ColMatrix]."Period End");
        grecTempPrognosisAllocation.Insert;
        grecTempPrognosisAllocation.Init;
        grecTempPrognosisAllocation."Internal Entry No." := 1000000;
        grecTempPrognosisAllocation.Description := Text50001_1;
        grecTempPrognosisAllocation."Filter Text" := Format(MATRIX_PeriodRecordsL[ColMatrix]."Period Start") + '...' + Format(MATRIX_PeriodRecordsL[ColMatrix]."Period End");

        grecTempPrognosisAllocation.Insert;
        grecTempPrognosisAllocation.Init;
        grecTempPrognosisAllocation."Internal Entry No." := 2000000;
        grecTempPrognosisAllocation.Description := Text50002_1;
        grecTempPrognosisAllocation."Filter Text" := Format(MATRIX_PeriodRecordsL[ColMatrix]."Period Start") + '...' + Format(MATRIX_PeriodRecordsL[ColMatrix]."Period End");

        grecTempPrognosisAllocation.Insert;
        grecTempPrognosisAllocation.Init;
        grecTempPrognosisAllocation."Internal Entry No." := 3000000;
        grecTempPrognosisAllocation.Description := Text50003_1;
        grecTempPrognosisAllocation."Filter Text" := Format(MATRIX_PeriodRecordsL[ColMatrix]."Period Start") + '...' + Format(MATRIX_PeriodRecordsL[ColMatrix]."Period End");

        grecTempPrognosisAllocation.Insert;

        lrecPrognosisAllocationEntry.SetCurrentKey("Entry Type", "Item No.", Salesperson, Customer, "Unit of Measure", "Sales Date");
        lrecPrognosisAllocationEntry.SetRange("Item No.", "Item No.");

        if gShowPTO then
            lrecPrognosisAllocationEntry.SetRange("Purchase Date", MATRIX_PeriodRecordsL[ColMatrix]."Period Start", MATRIX_PeriodRecordsL[ColMatrix]."Period End")
        else

            lrecPrognosisAllocationEntry.SetRange("Sales Date", MATRIX_PeriodRecordsL[ColMatrix]."Period Start", MATRIX_PeriodRecordsL[ColMatrix]."Period End");
        lrecPrognosisAllocationEntry.SetRange("Unit of Measure", "Unit of Measure");
        if lrecPrognosisAllocationEntry.FindFirst then begin
            lrecPrognosisAllocationEntry.CalcSums(Prognoses);
            grecTempPrognosisAllocation.Init;
            grecTempPrognosisAllocation := lrecPrognosisAllocationEntry;
            grecTempPrognosisAllocation."Internal Entry No." := 20000;
            grecTempPrognosisAllocation."Internal Comment" := '1';
            grecTempPrognosisAllocation.Salesperson := '';

            if gShowPTO then
                grecTempPrognosisAllocation."Sales Date" := 0D
            else
                grecTempPrognosisAllocation."Purchase Date" := 0D;
            grecTempPrognosisAllocation.Customer := '';
            grecTempPrognosisAllocation."User-ID" := '';
            grecTempPrognosisAllocation.Blocked := false;
            grecTempPrognosisAllocation.Handled := false;
            grecTempPrognosisAllocation."Prognosis Remark" := '';
            grecTempPrognosisAllocation."Handled Remark" := '';
            grecTempPrognosisAllocation."Filter Text" := Format(MATRIX_PeriodRecordsL[ColMatrix]."Period Start") + '...' + Format(MATRIX_PeriodRecordsL[ColMatrix]."Period End");

            if grecTempPrognosisAllocation.Insert then;
        end;
        lrecPrognosisAllocationEntry.SetFilter(Customer, '=%1', '');

        lTeller := 1000000;
        if lrecPrognosisAllocationEntry.FindFirst then
            repeat

                grecTempPrognosisAllocation.Init;
                grecTempPrognosisAllocation := lrecPrognosisAllocationEntry;
                grecTempPrognosisAllocation."Internal Entry No." := lrecPrognosisAllocationEntry."Internal Entry No." + 3000000;
                grecTempPrognosisAllocation."Filter Text" := Format(MATRIX_PeriodRecordsL[ColMatrix]."Period Start") + '...' + Format(MATRIX_PeriodRecordsL[ColMatrix]."Period End");

                grecTempPrognosisAllocation.Insert;

                grecTempPrognosisAllocation.Reset;
                grecTempPrognosisAllocation.SetRange("Item No.", lrecPrognosisAllocationEntry."Item No.");

                if gShowPTO then
                    grecTempPrognosisAllocation.SetRange("Purchase Date", MATRIX_PeriodRecordsL[ColMatrix]."Period Start", MATRIX_PeriodRecordsL[ColMatrix]."Period End")
                else
                    grecTempPrognosisAllocation.SetRange("Sales Date", lrecPrognosisAllocationEntry."Sales Date", MATRIX_PeriodRecordsL[ColMatrix]."Period End");
                grecTempPrognosisAllocation.SetRange("Unit of Measure", lrecPrognosisAllocationEntry."Unit of Measure");
                grecTempPrognosisAllocation.SetRange(Customer, lrecPrognosisAllocationEntry.Customer);
                grecTempPrognosisAllocation.SetRange(Salesperson, lrecPrognosisAllocationEntry.Salesperson);
                grecTempPrognosisAllocation.SetFilter("Internal Entry No.", '0..19999|20001..3000000');
                if grecTempPrognosisAllocation.FindFirst then begin
                    grecTempPrognosisAllocation.Prognoses := grecTempPrognosisAllocation.Prognoses + lrecPrognosisAllocationEntry.Prognoses;
                    grecTempPrognosisAllocation."Internal Comment" := '1';

                    if gShowPTO then
                        grecTempPrognosisAllocation."Sales Date" := 0D
                    else
                        grecTempPrognosisAllocation."Purchase Date" := 0D;

                    grecTempPrognosisAllocation."User-ID" := '';
                    grecTempPrognosisAllocation."Filter Text" := Format(MATRIX_PeriodRecordsL[ColMatrix]."Period Start") + '...' + Format(MATRIX_PeriodRecordsL[ColMatrix]."Period End");

                    grecTempPrognosisAllocation.Modify;
                end else begin
                    grecTempPrognosisAllocation.Init;
                    grecTempPrognosisAllocation := lrecPrognosisAllocationEntry;
                    grecTempPrognosisAllocation."Internal Entry No." := lTeller + 10000;

                    if gShowPTO then
                        grecTempPrognosisAllocation."Sales Date" := 0D
                    else
                        grecTempPrognosisAllocation."Purchase Date" := 0D;
                    grecTempPrognosisAllocation."User-ID" := '';
                    grecTempPrognosisAllocation.Blocked := false; // BEJOWW5.01.011
                    grecTempPrognosisAllocation.Handled := false;
                    grecTempPrognosisAllocation."Prognosis Remark" := '';
                    grecTempPrognosisAllocation."Handled Remark" := '';
                    grecTempPrognosisAllocation."Filter Text" := Format(MATRIX_PeriodRecordsL[ColMatrix]."Period Start") + '...' + Format(MATRIX_PeriodRecordsL[ColMatrix]."Period End");

                    grecTempPrognosisAllocation.Insert;
                    lTeller := lTeller + 10000;
                end;
            until lrecPrognosisAllocationEntry.Next = 0;


        lrecPrognosisAllocationEntry.SetCurrentKey("Item No.", Customer, Salesperson);
        lrecPrognosisAllocationEntry.SetFilter(Customer, '<>%1', '');
        lTeller := 2000000;
        if lrecPrognosisAllocationEntry.FindFirst then
            repeat

                grecTempPrognosisAllocation := lrecPrognosisAllocationEntry;
                grecTempPrognosisAllocation."Internal Entry No." := lrecPrognosisAllocationEntry."Internal Entry No." + 3000000;
                grecTempPrognosisAllocation."Filter Text" := Format(MATRIX_PeriodRecordsL[ColMatrix]."Period Start") + '...' + Format(MATRIX_PeriodRecordsL[ColMatrix]."Period End");

                grecTempPrognosisAllocation.Insert;

                grecTempPrognosisAllocation.Reset;
                grecTempPrognosisAllocation.SetRange("Item No.", lrecPrognosisAllocationEntry."Item No.");

                if gShowPTO then
                    grecTempPrognosisAllocation.SetRange("Purchase Date", lrecPrognosisAllocationEntry."Purchase Date", MATRIX_PeriodRecordsL[ColMatrix]."Period End")
                else
                    grecTempPrognosisAllocation.SetRange("Sales Date", lrecPrognosisAllocationEntry."Sales Date", MATRIX_PeriodRecordsL[ColMatrix]."Period End");
                grecTempPrognosisAllocation.SetRange("Unit of Measure", lrecPrognosisAllocationEntry."Unit of Measure");
                grecTempPrognosisAllocation.SetRange(Customer, lrecPrognosisAllocationEntry.Customer);
                grecTempPrognosisAllocation.SetRange(Salesperson, lrecPrognosisAllocationEntry.Salesperson);
                grecTempPrognosisAllocation.SetRange("Internal Entry No.", 0, 3000000);
                if grecTempPrognosisAllocation.FindFirst then begin
                    grecTempPrognosisAllocation.Prognoses := grecTempPrognosisAllocation.Prognoses + lrecPrognosisAllocationEntry.Prognoses;

                    if gShowPTO then
                        grecTempPrognosisAllocation."Sales Date" := 0D
                    else

                        grecTempPrognosisAllocation."Purchase Date" := 0D;
                    grecTempPrognosisAllocation."Internal Comment" := '1';
                    grecTempPrognosisAllocation."Filter Text" := Format(MATRIX_PeriodRecordsL[ColMatrix]."Period Start") + '...' + Format(MATRIX_PeriodRecordsL[ColMatrix]."Period End");

                    grecTempPrognosisAllocation.Modify;
                end else begin
                    grecTempPrognosisAllocation := lrecPrognosisAllocationEntry;
                    grecTempPrognosisAllocation."Internal Entry No." := lTeller + 10000;

                    if gShowPTO then
                        grecTempPrognosisAllocation."Sales Date" := 0D
                    else
                        grecTempPrognosisAllocation."Purchase Date" := 0D;
                    grecTempPrognosisAllocation."User-ID" := '';
                    grecTempPrognosisAllocation.Blocked := false;
                    grecTempPrognosisAllocation.Handled := false;
                    grecTempPrognosisAllocation."Prognosis Remark" := '';
                    grecTempPrognosisAllocation."Handled Remark" := '';
                    grecTempPrognosisAllocation."Filter Text" := Format(MATRIX_PeriodRecordsL[ColMatrix]."Period Start") + '...' + Format(MATRIX_PeriodRecordsL[ColMatrix]."Period End");

                    grecTempPrognosisAllocation.Insert;
                    lTeller := lTeller + 10000;
                end;
            until lrecPrognosisAllocationEntry.Next = 0;
    end;

    local procedure SetRecordFilters()
    begin
        FilterGroup(200);
        SetFilter("Unit of Measure", '<>%1', '');
        FilterGroup(0);
    end;

    local procedure SetRecordFiltersUpdate()
    begin
        SetRecordFilters();
        CurrPage.Update;
    end;
}

