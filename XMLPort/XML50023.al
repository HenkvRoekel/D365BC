xmlport 50023 "Import Year Prognoses"
{

    FormatEvaluate = Xml;

    schema
    {
        textelement(YearPrognoses)
        {
            tableelement("Year Prognoses"; "Year Prognoses")
            {
                XmlName = 'YearPrognose';
                fieldelement(Variety; "Year Prognoses".Variety)
                {
                }
                textelement(gdate)
                {
                    XmlName = 'Date';

                    trigger OnAfterAssignVariable()
                    begin
                        "Year Prognoses".Date := GetDate(gDate);
                    end;
                }
                fieldelement(Country; "Year Prognoses".Country)
                {
                }
                fieldelement(UserID; "Year Prognoses"."User-ID")
                {
                }
                textelement(gmodificationdate)
                {
                    XmlName = 'ModificationDate';

                    trigger OnAfterAssignVariable()
                    begin
                        "Year Prognoses"."Modification date" := GetDate(gModificationDate);
                    end;
                }
                fieldelement(Quantity; "Year Prognoses"."Quantity(period)")
                {
                    FieldValidate = no;
                }
                textelement(gstartdate)
                {
                    XmlName = 'StartDate';

                    trigger OnAfterAssignVariable()
                    begin
                        "Year Prognoses".Begindate := GetDate(gStartDate);
                    end;
                }

                trigger OnBeforeInsertRecord()
                begin
                    gNo := gNo + 1;
                    "Year Prognoses"."Internal Entry No." := gNo;
                    "Year Prognoses"."Modification date" := Today;
                    "Year Prognoses".Type := "Year Prognoses".Type::Prognose;
                    "Year Prognoses".Exported := true;
                    "Year Prognoses"."Date Exported" := Today;
                end;
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

    trigger OnPreXmlPort()
    begin
        grecYearPrognoses.Reset;
        grecYearPrognoses.FindLast;
        gNo := grecYearPrognoses."Internal Entry No.";
    end;

    var
        grecYearPrognoses: Record "Year Prognoses";
        gNo: Integer;

    procedure GetDate(lInDateText: Code[10]) NewDate: Date
    var
        lYearno: Integer;
        lMonthno: Integer;
        lDayno: Integer;
    begin
        // FORMAT = YYYY-MM-DD
        if StrLen(lInDateText) = 10 then begin
            Evaluate(lYearno, CopyStr(lInDateText, 1, 4));
            Evaluate(lMonthno, CopyStr(lInDateText, 6, 2));
            Evaluate(lDayno, CopyStr(lInDateText, 9, 2));
            NewDate := DMY2Date(lDayno, lMonthno, lYearno);
        end;
    end;
}

