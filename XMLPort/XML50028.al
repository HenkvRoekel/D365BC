xmlport 50028 "Import Result Month Prognoses"
{

    Caption = 'Import Result Month Prognoses';
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
                        textelement(MonthPrognosis)
                        {
                            textelement(Company_Entry_No)
                            {
                            }
                            textelement(Processed)
                            {

                                trigger OnAfterAssignVariable()
                                var
                                    lrecMonthPrognosesExported: Record "Prognosis/Allocation Entry";
                                    lEntryNo: Integer;
                                    lrecInterfacelog: Record "Interface log";
                                    lrecPrognosisAllocationEntry: Record "Prognosis/Allocation Entry";
                                begin
                                    if Evaluate(lEntryNo, Company_Entry_No) then begin
                                        lrecMonthPrognosesExported.SetRange(lrecMonthPrognosesExported."Internal Entry No.", lEntryNo);

                                        if (lrecMonthPrognosesExported.FindFirst and (Processed = 'true')) then begin
                                            // Update all the records that were summed before sending
                                            lrecPrognosisAllocationEntry.SetCurrentKey("Entry Type", "Item No.", "Unit of Measure", "Purchase Date");
                                            lrecPrognosisAllocationEntry.SetRange("Entry Type", lrecMonthPrognosesExported."Entry Type"::Prognoses);
                                            lrecPrognosisAllocationEntry.SetRange("Item No.", lrecMonthPrognosesExported."Item No.");
                                            lrecPrognosisAllocationEntry.SetRange("Purchase Date", lrecMonthPrognosesExported."Purchase Date");
                                            lrecPrognosisAllocationEntry.SetRange("Unit of Measure", lrecMonthPrognosesExported."Unit of Measure");
                                            lrecPrognosisAllocationEntry.ModifyAll(lrecPrognosisAllocationEntry."Export/Import Date", Today, false);
                                            lrecPrognosisAllocationEntry.ModifyAll(lrecPrognosisAllocationEntry.Exported, true, false);


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
        if not grecWebservice.Get('MPROGNOSES') then
            Error(Text50000);
    end;

    var
        grecWebservice: Record Webservice;
        Text50000: Label 'The record for the Month Prognoses webservice could not be retrieved.';

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

