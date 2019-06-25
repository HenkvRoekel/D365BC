report 50077 "Copy Prognoses"
{

    DefaultLayout = RDLC;
    RDLCLayout = './RDLC/Copy Prognoses.rdlc';

    Caption = 'Copy Prognoses';

    dataset
    {
        dataitem("Prognosis/Allocation Entry"; "Prognosis/Allocation Entry")
        {
            DataItemTableView = SORTING ("Entry Type", "Item No.", "Sales Date", Salesperson) WHERE ("Entry Type" = CONST (Prognoses), Adjusted = CONST (false));
            RequestFilterFields = "Sales Date", Salesperson, Customer, "Item No.", "Unit of Measure";
            column(Prognosis_Allocation_Entry__Item_No__; "Item No.")
            {
            }
            column(Prognosis_Allocation_Entry__Item_No__Caption; FieldCaption("Item No."))
            {
            }
            column(Prognosis_Allocation_Entry_Internal_Entry_No_; "Internal Entry No.")
            {
            }

            trigger OnAfterGetRecord()
            var
                lrecItem: Record Item;
                lrecVariety: Record Varieties;
            begin

                if gCopyOption = gCopyOption::Totals then begin

                    gTotalQty := 0;
                    if "Entry No." > gLastEntryNo then
                        CurrReport.Break;


                    if not lrecItem.Get("Item No.") then
                        CurrReport.Skip
                    else
                        if lrecVariety.Get(lrecItem."B Variety") then
                            if gcuBlockingMgt.VarietyBlockCode(lrecVariety) = '1' then
                                CurrReport.Skip;


                    grecPrognosisEntry2 := "Prognosis/Allocation Entry";
                    if gDateFormula <> '' then
                        grecPrognosisEntry2."Sales Date" := CalcDate(gDateFormula, "Sales Date");
                    grecPrognosisEntry2."Internal Entry No." := gNextEntryNo;
                    grecPrognosisEntry2."User-ID" := UserId;

                    grecPrognosisEntry1.SetCurrentKey("Entry Type", "Item No.", "Sales Date", Salesperson, Customer, "Unit of Measure");


                    grecPrognosisEntry1.SetRange("Item No.", "Item No.");
                    grecPrognosisEntry1.SetRange("Entry Type", grecPrognosisEntry1."Entry Type"::Prognoses);
                    grecPrognosisEntry1.SetRange("Unit of Measure", grecPrognosisEntry2."Unit of Measure");
                    grecPrognosisEntry1.SetRange("Sales Date", gFromDate, gUptoDate);

                    grecPrognosisEntry1.CalcSums(Prognoses);
                    gTotalQty := grecPrognosisEntry1.Prognoses;

                    grecPrognosisEntry1.SetRange("Sales Date", grecPrognosisEntry2."Sales Date");
                    if not grecPrognosisEntry1.Find('-') then begin
                        grecPrognosisEntry2."Date Modified" := Today;
                        grecPrognosisEntry2.Prognoses := gTotalQty;
                        grecPrognosisEntry2.Exported := false;
                        grecPrognosisEntry2."Export/Import Date" := 0D;

                        grecPrognosisEntry2.Adjusted := false;
                        grecPrognosisEntry2.Blocked := false;
                        grecPrognosisEntry2."BZ Original Prognoses" := false;

                        grecPrognosisEntry2.Handled := false;

                        if Format(lrecItem."B Purchase BZ Lead Time Calc") = '' then

                            grecPrognosisEntry2."Purchase Date" := grecPrognosisEntry2."Sales Date"
                        else

                            Evaluate(gReversedSDBZLeadTime, ReverseSign(Format(lrecItem."B Purchase BZ Lead Time Calc")));
                        grecPrognosisEntry2."Purchase Date" := CalcDate(gReversedSDBZLeadTime, grecPrognosisEntry2."Sales Date");

                        grecPrognosisEntry2."Prognosis Remark" := '';

                        if grecPrognosisEntry2.Prognoses <> 0 then
                            grecPrognosisEntry2.Insert;
                    end;

                    gNextEntryNo := gNextEntryNo + 1;
                end else begin


                    if Prognoses <> 0 then begin
                        if "Internal Entry No." > gLastEntryNo then
                            CurrReport.Break;

                        if not lrecItem.Get("Item No.") then
                            CurrReport.Skip
                        else
                            if lrecVariety.Get(lrecItem."B Variety") then
                                if gcuBlockingMgt.VarietyBlockCode(lrecVariety) = '1' then
                                    CurrReport.Skip;

                        grecPrognosisEntry2 := "Prognosis/Allocation Entry";
                        grecPrognosisEntry2."Sales Date" := CalcDate(gDateFormula, "Sales Date");

                        grecPrognosisEntryTEMP.Reset;
                        grecPrognosisEntryTEMP.SetRange("Item No.", grecPrognosisEntry2."Item No.");
                        grecPrognosisEntryTEMP.SetRange("Sales Date", grecPrognosisEntry2."Sales Date");
                        grecPrognosisEntryTEMP.SetRange("Unit of Measure", grecPrognosisEntry2."Unit of Measure");
                        grecPrognosisEntryTEMP.SetRange(Customer, grecPrognosisEntry2.Customer);
                        grecPrognosisEntryTEMP.SetRange(Salesperson, grecPrognosisEntry2.Salesperson);
                        if grecPrognosisEntryTEMP.FindFirst then
                            CurrReport.Skip;

                        grecPrognosisEntry1.Reset;
                        grecPrognosisEntry1.SetCurrentKey("Entry Type", "Item No.", Salesperson, Customer, "Unit of Measure", "Sales Date");
                        grecPrognosisEntry1.SetRange("Entry Type", grecPrognosisEntry1."Entry Type"::Prognoses);
                        grecPrognosisEntry1.SetRange("Item No.", grecPrognosisEntry2."Item No.");
                        grecPrognosisEntry1.SetRange(Salesperson, grecPrognosisEntry2.Salesperson);
                        grecPrognosisEntry1.SetRange(Customer, grecPrognosisEntry2.Customer);
                        grecPrognosisEntry1.SetRange("Unit of Measure", grecPrognosisEntry2."Unit of Measure");
                        grecPrognosisEntry1.SetRange("Sales Date", "Sales Date");
                        grecPrognosisEntry1.CalcSums(Prognoses);
                        grecPrognosisEntry2.Prognoses := grecPrognosisEntry1.Prognoses;


                        if grecPrognosisEntry1.Prognoses = 0 then
                            CurrReport.Skip;

                        grecPrognosisEntry1.SetRange("Sales Date", grecPrognosisEntry2."Sales Date");
                        grecPrognosisEntry1.CalcSums(Prognoses);
                        if grecPrognosisEntry1.Prognoses <> 0 then CurrReport.Skip;


                        grecPrognosisEntryTEMP.Init;
                        grecPrognosisEntryTEMP."Internal Entry No." := grecPrognosisEntry2."Internal Entry No.";
                        grecPrognosisEntryTEMP."Item No." := grecPrognosisEntry2."Item No.";
                        grecPrognosisEntryTEMP."Sales Date" := grecPrognosisEntry2."Sales Date";
                        grecPrognosisEntryTEMP."Unit of Measure" := grecPrognosisEntry2."Unit of Measure";
                        grecPrognosisEntryTEMP.Customer := grecPrognosisEntry2.Customer;
                        grecPrognosisEntryTEMP.Salesperson := grecPrognosisEntry2.Salesperson;
                        grecPrognosisEntryTEMP.Insert;

                        grecPrognosisEntry2."Internal Entry No." := gNextEntryNo;
                        grecPrognosisEntry2."User-ID" := UserId;
                        grecPrognosisEntry2."Date Modified" := Today;
                        grecPrognosisEntry2.Exported := false;
                        grecPrognosisEntry2."Export/Import Date" := 0D;
                        grecPrognosisEntry2.Handled := false;

                        if Format(lrecItem."B Purchase BZ Lead Time Calc") = '' then

                            grecPrognosisEntry2."Purchase Date" := grecPrognosisEntry2."Sales Date"
                        else

                            Evaluate(gReversedSDBZLeadTime, ReverseSign(Format(lrecItem."B Purchase BZ Lead Time Calc")));
                        grecPrognosisEntry2."Purchase Date" := CalcDate(gReversedSDBZLeadTime, grecPrognosisEntry2."Sales Date");

                        grecPrognosisEntry2."Prognosis Remark" := '';

                        grecPrognosisEntry2.Adjusted := false;
                        grecPrognosisEntry2.Blocked := false;
                        grecPrognosisEntry2."BZ Original Prognoses" := false;


                        grecPrognosisEntry2.Insert;
                        gNextEntryNo := gNextEntryNo + 1;
                    end;
                end;

            end;

            trigger OnPreDataItem()
            begin
                if not Confirm(Text000, false) then
                    exit;

                LockTable;

                if grecPrognosisEntry2.FindLast then
                    gLastEntryNo := grecPrognosisEntry2."Internal Entry No.";

                gNextEntryNo := gLastEntryNo + 1;

                if "Prognosis/Allocation Entry".GetFilter("Sales Date") = '' then
                    Error(Text002);

                gFromDate := GetRangeMin("Sales Date");
                gUptoDate := GetRangeMax("Sales Date");
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(gDateFormula; gDateFormula)
                    {
                        Caption = 'Period';
                        DateFormula = true;
                        ApplicationArea = All;
                    }
                    field(gCopyOption; gCopyOption)
                    {
                        Caption = 'Copy Option';
                        OptionCaption = 'Total,Detail';
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
    }

    trigger OnInitReport()
    begin

        gCopyOption := gCopyOption::Totals;

    end;

    trigger OnPreReport()
    var
        lTestDate: Date;
    begin

        if gCopyOption = gCopyOption::Entries then begin
            if gDateFormula = '' then
                Error(Text003);
            lTestDate := CalcDate(gDateFormula, Today);
        end;

    end;

    var
        grecPrognosisEntry2: Record "Prognosis/Allocation Entry";
        grecPrognosisEntry1: Record "Prognosis/Allocation Entry";
        grecPrognosisEntryTEMP: Record "Prognosis/Allocation Entry" temporary;
        gDateFormula: Code[20];
        gLastEntryNo: Integer;
        gNextEntryNo: Integer;
        gTotalQty: Decimal;
        gFromDate: Date;
        gUptoDate: Date;
        Text000: Label 'Do you want to copy the prognoses?';
        Text002: Label 'You must enter a Date.';
        gcuBejoMgt: Codeunit "Bejo Management";
        gcuBlockingMgt: Codeunit "Blocking Management";
        gCopyOption: Option Totals,Entries;
        Text003: Label 'You must enter a Period if Copy Option = Entries.';
        gReversedSDBZLeadTime: DateFormula;
}

