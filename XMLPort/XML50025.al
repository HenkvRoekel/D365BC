xmlport 50025 "Year Prognoses"
{

    Caption = 'Year Prognoses';
    FormatEvaluate = Xml;

    schema
    {
        textelement(YearPrognoses)
        {
            tableelement("<yearprognose>"; "Year Prognoses")
            {
                XmlName = 'YearPrognose';
                SourceTableView = WHERE (Exported = CONST (false));
                fieldelement(Variety; "<YearPrognose>".Variety)
                {
                }
                textelement(gdate)
                {
                    XmlName = 'Date';

                    trigger OnBeforePassVariable()
                    begin
                        gDate := Format("<YearPrognose>".Date, 0, '<Day>-<Month>-<Year4>');
                    end;
                }
                fieldelement(Country; "<YearPrognose>".Country)
                {
                }
                fieldelement(UserID; "<YearPrognose>"."User-ID")
                {
                }
                textelement(gmodificationdate)
                {
                    XmlName = 'ModificationDate';

                    trigger OnAfterAssignVariable()
                    begin
                        gModificationDate := Format("<YearPrognose>"."Modification date", 0, '<Day>-<Month>-<Year4>');
                    end;
                }
                fieldelement(Quantity; "<YearPrognose>"."Quantity(period)")
                {

                    trigger OnBeforePassField()
                    begin
                        "<YearPrognose>".Exported := true;
                        "<YearPrognose>"."Date Exported" := Today;
                        "<YearPrognose>".Modify;
                    end;
                }
                textelement(gstartdate)
                {
                    XmlName = 'StartDate';

                    trigger OnBeforePassVariable()
                    begin
                        gStartDate := Format("<YearPrognose>".Begindate, 0, '<Day>-<Month>-<Year4>');
                    end;
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
}

