report 50080 "Export Year Prognoses"
{


    Caption = 'Export Year Prognoses';
    ProcessingOnly = true;

    dataset
    {
        dataitem("<Dummy>"; "Year Prognoses")
        {
            DataItemTableView = SORTING ("Internal Entry No.") ORDER(Ascending) WHERE (Exported = CONST (false));
            MaxIteration = 1;

            trigger OnPostDataItem()
            var
                //lcuWebService: Codeunit Webservices;
                lFromEntryNo: Integer;
                lToEntryNo: Integer;
                lrecYearprognoses: Record "Year Prognoses";
                lProgressCounter: Integer;
                lRecordSetCount: Integer;
                lProgressStep: Integer;
                lStepSize: Integer;
            begin

                lStepSize := 20;
                gdlgWindow.Open('@1@@@@@@@@@@@@@@@@@@@@');
                lProgressCounter := 1000;
                gdlgWindow.Update(1, lProgressCounter);

                lrecYearprognoses.SetCurrentKey("Internal Entry No.");
                lrecYearprognoses.SetRange(Exported, false);

                if lrecYearprognoses.FindSet(false, false) then begin

                    lRecordSetCount := lrecYearprognoses.Count();
                    lProgressStep := Round((8000 / (lRecordSetCount / lStepSize)), 1, '=');

                    lFromEntryNo := lrecYearprognoses."Internal Entry No.";
                    lrecYearprognoses.Next(lStepSize);
                    lToEntryNo := lrecYearprognoses."Internal Entry No.";

                    repeat

                        //lcuWebService.PutYearPrognoses(lFromEntryNo, lToEntryNo);

                        lProgressCounter += lProgressStep;
                        gdlgWindow.Update(1, lProgressCounter);

                        if lrecYearprognoses.Next(1) <> 0 then begin
                            lFromEntryNo := lrecYearprognoses."Internal Entry No.";
                        end;

                        if lrecYearprognoses.Next(lStepSize) <> 0 then begin
                            lToEntryNo := lrecYearprognoses."Internal Entry No.";
                            lrecYearprognoses.Next(-lStepSize);
                        end;

                    until lrecYearprognoses.Next(lStepSize) = 0;

                end;


                if lrecYearprognoses.Next(1) <> 0 then begin
                    lFromEntryNo := lrecYearprognoses."Internal Entry No.";
                end;
                if lrecYearprognoses.FindLast() then
                    ;
                if lToEntryNo < lrecYearprognoses."Internal Entry No." then begin
                    lToEntryNo := lrecYearprognoses."Internal Entry No.";
                    //lcuWebService.PutYearPrognoses(lFromEntryNo, lToEntryNo);

                    lProgressCounter += lProgressStep;
                    gdlgWindow.Update(1, lProgressCounter);
                end;


                //lcuWebService.PutYearPrognosesComplete;


                gdlgWindow.Update(1, 10000);
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
        lrecYearPrognoses: Record "Year Prognoses";
    begin
        lrecYearPrognoses.SetCurrentKey("Internal Entry No.");
        lrecYearPrognoses.SetRange(Exported, false);
        if lrecYearPrognoses.FindSet then
            gNumberOfRec := lrecYearPrognoses.Count
        else
            Error(Text50000);
    end;

    var
        gdlgWindow: Dialog;
        gNumberOfRec: Integer;
        Text50000: Label 'No prognoses to send.';
}

