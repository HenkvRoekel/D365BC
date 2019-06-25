xmlport 50026 "Import Result Year Prognoses"
{

    Caption = 'Import Result Year Prognoses';
    Direction = Import;
    FormatEvaluate = Xml;

    schema
    {
        textelement(Envelope)
        {
            textelement(Body)
            {
                textelement(CREATEResponse)
                {
                    textelement(CREATEResult)
                    {
                        textelement(Process_name)
                        {
                        }
                        textelement(Identifier)
                        {
                        }
                        textelement(YearPrognose)
                        {
                            textelement(Company_Entry_No)
                            {
                            }
                            textelement(Processed)
                            {

                                trigger OnAfterAssignVariable()
                                var
                                    lrecYearPrognosesExported: Record "Year Prognoses";
                                    lEntryNo: Integer;
                                    lrecInterfacelog: Record "Interface log";
                                begin
                                    if Evaluate(lEntryNo, Company_Entry_No) then begin
                                        lrecYearPrognosesExported.SetRange(lrecYearPrognosesExported."Internal Entry No.", lEntryNo);

                                        if (lrecYearPrognosesExported.FindFirst and (Processed = 'true')) then begin
                                            lrecYearPrognosesExported."Date Exported" := Today;
                                            lrecYearPrognosesExported.Exported := true;
                                            lrecYearPrognosesExported.Modify(false);
                                        end;
                                    end;

                                    if grecWebservice."Log result" then begin
                                        lrecInterfacelog.Init;
                                        lrecInterfacelog."Entry No." := 0;
                                        lrecInterfacelog."Process name" := Process_name;
                                        lrecInterfacelog.Identifier := Identifier;
                                        lrecInterfacelog."Extra 1" := Company_Entry_No;
                                        lrecInterfacelog.Processed := (Processed = 'true');
                                        lrecInterfacelog.Insert(true);
                                    end;
                                end;
                            }
                        }
                    }
                }
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    trigger OnInitXmlPort()
    begin
        if not grecWebservice.Get('YPROGNOSES') then
            Error(Text50000);
    end;

    var
        grecWebservice: Record Webservice;
        Text50000: Label 'The record for the Year Prognoses webservice could not be retrieved.';

    procedure FormatDate(aDate: Text[30]) ResultDate: Date
    var
        lYear: Integer;
        lMonth: Integer;
        lDay: Integer;
    begin
        Evaluate(lYear, CopyStr(aDate, 1, 4));
        Evaluate(lMonth, CopyStr(aDate, 6, 2));
        Evaluate(lDay, CopyStr(aDate, 9, 2));

        ResultDate := DMY2Date(lDay, lMonth, lYear);
    end;
}

