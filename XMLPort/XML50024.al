xmlport 50024 "Export Year Prognoses OBSOLE"
{

    Caption = 'Export Year Prognoses';
    Direction = Export;
    FormatEvaluate = Xml;

    schema
    {
        textelement(YearPrognoses)
        {
            tableelement("<yearprognose>"; "Year Prognoses")
            {
                XmlName = 'YearPrognose';
                SourceTableView = SORTING ("Internal Entry No.") WHERE (Exported = CONST (false));
                fieldelement(Company_Entry_No; "<YearPrognose>"."Internal Entry No.")
                {
                }
                fieldelement(Variety; "<YearPrognose>".Variety)
                {
                }
                fieldelement(Date; "<YearPrognose>".Date)
                {
                }
                fieldelement(Country; "<YearPrognose>".Country)
                {
                }
                fieldelement(User_ID; "<YearPrognose>"."User-ID")
                {
                }
                fieldelement(Modification_Date; "<YearPrognose>"."Modification date")
                {
                }
                fieldelement(Quantity; "<YearPrognose>"."Quantity(period)")
                {
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

