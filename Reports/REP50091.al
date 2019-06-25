report 50091 "Export Market Potential"
{

    Caption = 'Export Market Potential';
    ProcessingOnly = true;

    dataset
    {
        dataitem("<Dummy>"; "Integer")
        {
            DataItemTableView = SORTING (Number) WHERE (Number = CONST (1));
            MaxIteration = 1;

            trigger OnPostDataItem()
            var
                //lcuWebService: Codeunit Webservices;
                lProgressCounter: Integer;
            begin
                lProgressCounter := 1000;
                gdlgWindow.Open('@1@@@@@@');
                gdlgWindow.Update(1, lProgressCounter);

                //lcuWebService.PutMarketPotential;
                lProgressCounter += 8500;
                gdlgWindow.Update(1, lProgressCounter);

                lProgressCounter := 10000;
                gdlgWindow.Update(1, lProgressCounter);

                Sleep(2000);

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
        lrecMarketPotentialSum: Record "Prognosis/Allocation Entry";
        lPrevYear: Integer;
        lPrevVariant: Code[20];
        lPrevType: Code[20];
        lrecMarketPotential: Record "Market Potential";
        lrecBejoSetup: Record "Bejo Setup";
    begin

        lrecBejoSetup.Get;
        lrecMarketPotential.SetRange(Year, Date2DWY(lrecBejoSetup."Begin Date", 3), Date2DWY(CalcDate('<+5Y>', WorkDate), 3));

        gNumberOfRec := lrecMarketPotential.Count();
        if gNumberOfRec = 0 then
            Error(Text50000);
    end;

    var
        gdlgWindow: Dialog;
        gNumberOfRec: Integer;
        Text50000: Label 'No records to send.';
        grecBejoSetup: Record "Bejo Setup";
        nextSeasonStart: Date;
}

