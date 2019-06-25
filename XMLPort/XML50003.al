xmlport 50003 "Import VarietyCountry"
{

    Caption = 'Import VarietyCountry';
    Direction = Import;
    FormatEvaluate = Xml;
    UseRequestPage = false;

    schema
    {
        textelement(Envelope)
        {
            textelement(Body)
            {
                textelement(LISTResponse)
                {
                    textelement(LISTResult)
                    {
                        textelement(Variety_Country)
                        {
                            textelement("<variety no.>")
                            {
                                XmlName = 'Variety';

                                trigger OnAfterAssignVariable()
                                begin
                                    gVarietyNo := "<Variety No.>";
                                end;
                            }
                            textelement("<country>")
                            {
                                XmlName = 'Country';

                                trigger OnAfterAssignVariable()
                                var
                                    lrecVariety: Record Varieties;
                                begin
                                    gCountry := "<Country>";

                                    lrecVariety.SetRange("No.", gVarietyNo);
                                    if lrecVariety.FindFirst then begin
                                        lrecVariety."Year Prognosis Available" := true;
                                        lrecVariety.Modify;
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

    var
        gVarietyNo: Code[20];
        gCountry: Code[10];

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

