report 50082 "Export Month Prognoses"
{


    Caption = 'Export Month Prognoses';
    ProcessingOnly = true;

    dataset
    {
        dataitem("<Dummy>"; "Prognosis/Allocation Entry")
        {
            DataItemTableView = SORTING ("Internal Entry No.") ORDER(Ascending) WHERE ("External Comment" = CONST ('n'));
            MaxIteration = 1;

            trigger OnPostDataItem()
            var
                //lcuWebService: Codeunit Webservices;
                lrecPrognosisAllocationEntry: Record "Prognosis/Allocation Entry";
                lCounter: Integer;
                lFromEntry: Integer;
                lToEntry: Integer;
                lrecPrognosisSum: Record "Prognosis/Allocation Entry";
                lPrevPurchDate: Date;
                lPrevUOM: Code[20];
                lPrevItemNo: Code[20];
                lIsFinal: Boolean;
                lProgressCounter: Integer;
                lrecPrognosisAllocationEntry2: Record "Prognosis/Allocation Entry";
            begin

                grecBejoSetup.FindFirst;
                nextSeasonStart := CalcDate('<1Y>', grecBejoSetup."Begin Date");

                lrecPrognosisAllocationEntry.SetCurrentKey("Internal Entry No.");
                lrecPrognosisAllocationEntry.SetRange("Entry Type", lrecPrognosisAllocationEntry."Entry Type"::Prognoses);
                lrecPrognosisAllocationEntry.SetRange(Exported, false);

                if lrecPrognosisAllocationEntry.FindFirst then
                    repeat
                        if (lrecPrognosisAllocationEntry."Sales Date" >= nextSeasonStart) and
                           (Today < nextSeasonStart) then begin
                            lrecPrognosisAllocationEntry."BZ Original Prognoses" := true;
                            lrecPrognosisAllocationEntry.Modify;
                        end
                        else
                            if (lrecPrognosisAllocationEntry."Sales Date" >= grecBejoSetup."Begin Date") and
                               (lrecPrognosisAllocationEntry."Sales Date" < nextSeasonStart) and
                               (Today >= grecBejoSetup."Begin Date") and
                               (Today < nextSeasonStart) then begin
                                if ISNEWVARiety(lrecPrognosisAllocationEntry) then begin
                                    lrecPrognosisAllocationEntry."BZ Original Prognoses" := true;
                                    lrecPrognosisAllocationEntry.Modify;
                                end;
                            end;
                    until lrecPrognosisAllocationEntry.Next = 0;

                lProgressCounter := 1000;
                gdlgWindow.Open('@1@@@@@@@@@@@@@@@@@@@@');
                gdlgWindow.Update(1, lProgressCounter);


                lrecPrognosisAllocationEntry2.SetCurrentKey("Internal Entry No.");

                lrecPrognosisAllocationEntry2.SetRange("Entry Type", lrecPrognosisAllocationEntry2."Entry Type"::Prognoses);
                lrecPrognosisAllocationEntry2.SetRange(Exported, false);
                if lrecPrognosisAllocationEntry2.FindSet(false, false) then begin
                    lrecPrognosisSum.SetCurrentKey("Entry Type", "Item No.", "Unit of Measure", "Purchase Date", Exported);
                    lrecPrognosisSum.SetRange("Entry Type", lrecPrognosisSum."Entry Type"::Prognoses);
                    lrecPrognosisSum.SetRange(Exported, false);

                    repeat

                        if lCounter = 0 then begin
                            lFromEntry := lrecPrognosisAllocationEntry2."Internal Entry No."
                        end;

                        if not ((lrecPrognosisAllocationEntry2."Item No." = lPrevItemNo)
                            and (lrecPrognosisAllocationEntry2."Purchase Date" = lPrevPurchDate)
                            and (lrecPrognosisAllocationEntry2."Unit of Measure" = lPrevUOM)) then begin
                            lrecPrognosisSum.SetRange("Item No.", lrecPrognosisAllocationEntry2."Item No.");
                            lrecPrognosisSum.SetRange("Purchase Date", lrecPrognosisAllocationEntry2."Purchase Date");
                            lrecPrognosisSum.SetRange("Unit of Measure", lrecPrognosisAllocationEntry2."Unit of Measure");
                            lrecPrognosisSum.CalcSums(Prognoses);
                            lPrevUOM := lrecPrognosisAllocationEntry2."Unit of Measure";
                            lPrevItemNo := lrecPrognosisAllocationEntry2."Item No.";
                            lPrevPurchDate := lrecPrognosisAllocationEntry2."Purchase Date";

                            if lrecPrognosisSum.Prognoses <> 0 then
                                lCounter += 1;
                        end;

                        if lCounter = 50 then begin
                            lToEntry := lrecPrognosisAllocationEntry2."Internal Entry No.";
                            //lcuWebService.PutMonthPrognoses(lFromEntry, lToEntry);
                            lProgressCounter += Round(8500 * (lCounter / gNumberOfRec), 1);
                            gdlgWindow.Update(1, lProgressCounter);
                            lCounter := 0;
                        end;

                    until lrecPrognosisAllocationEntry2.Next = 0;


                    if lCounter > 0 then begin
                        lToEntry := lrecPrognosisAllocationEntry2."Internal Entry No.";
                        //lcuWebService.PutMonthPrognoses(lFromEntry, lToEntry);
                        //lcuWebService.PutMonthPrognosesComplete();
                    end else begin
                        //lcuWebService.PutMonthPrognosesComplete();
                    end;

                end;

                lProgressCounter := 10000;
                gdlgWindow.Update(1, lProgressCounter);
                Sleep(1000);

                gdlgWindow.Close;
                Commit;

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
                    field(gNumberOfRec; gNumberOfRec)
                    {
                        Caption = 'Records to send';
                        Editable = false;
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
    var
        lrecPrognosisAllocationEntry: Record "Prognosis/Allocation Entry";
        lrecPrognosisSum: Record "Prognosis/Allocation Entry";
        lPrevPurchDate: Date;
        lPrevUOM: Code[20];
        lPrevItemNo: Code[20];
    begin

        lrecPrognosisAllocationEntry.SetCurrentKey("Entry Type", "Item No.", "Unit of Measure", "Purchase Date", Exported);
        lrecPrognosisAllocationEntry.SetRange("Entry Type", lrecPrognosisAllocationEntry."Entry Type"::Prognoses);
        lrecPrognosisAllocationEntry.SetRange(Exported, false);
        if lrecPrognosisAllocationEntry.FindSet then begin
            lrecPrognosisSum.SetCurrentKey("Entry Type", "Item No.", "Unit of Measure", "Purchase Date", Exported);
            lrecPrognosisSum.SetRange("Entry Type", lrecPrognosisSum."Entry Type"::Prognoses);
            lrecPrognosisSum.SetRange(Exported, false);
            repeat
                if not ((lrecPrognosisAllocationEntry."Item No." = lPrevItemNo)
                    and (lrecPrognosisAllocationEntry."Purchase Date" = lPrevPurchDate)
                    and (lrecPrognosisAllocationEntry."Unit of Measure" = lPrevUOM)) then begin
                    lrecPrognosisSum.SetRange("Item No.", lrecPrognosisAllocationEntry."Item No.");
                    lrecPrognosisSum.SetRange("Purchase Date", lrecPrognosisAllocationEntry."Purchase Date");
                    lrecPrognosisSum.SetRange("Unit of Measure", lrecPrognosisAllocationEntry."Unit of Measure");
                    lrecPrognosisSum.CalcSums(Prognoses);

                    lPrevUOM := lrecPrognosisAllocationEntry."Unit of Measure";
                    lPrevItemNo := lrecPrognosisAllocationEntry."Item No.";
                    lPrevPurchDate := lrecPrognosisAllocationEntry."Purchase Date";

                    if lrecPrognosisSum.Prognoses <> 0 then
                        gNumberOfRec += 1;

                end;
            until lrecPrognosisAllocationEntry.Next = 0;
        end;

        if gNumberOfRec = 0 then
            Error(Text50000);
    end;

    var
        gdlgWindow: Dialog;
        gNumberOfRec: Integer;
        Text50000: Label 'No prognoses to send.';
        grecBejoSetup: Record "Bejo Setup";
        nextSeasonStart: Date;

    procedure ISNEWVARiety(lrecPrognAlloc: Record "Prognosis/Allocation Entry"): Boolean
    var
        lrecAux: Record "Prognosis/Allocation Entry";
    begin

        lrecAux.SetCurrentKey("Entry Type", "Item No.", "Unit of Measure", "Sales Date", Salesperson, Exported, Customer);
        lrecAux.SetRange("Entry Type", lrecAux."Entry Type"::Prognoses);
        lrecAux.SetRange(Variety, lrecPrognAlloc.Variety);
        lrecAux.SetRange(Exported, true);
        if not lrecAux.FindFirst
            then exit(true)
        else exit(false);

    end;
}

