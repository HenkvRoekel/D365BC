page 50060 "Year Prognoses List"
{

    Caption = 'Year Prognoses List';
    Editable = false;
    PageType = List;
    SourceTable = "Year Prognoses";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field(Date; Date)
                {
                    ApplicationArea = All;
                }
                field("Internal Entry No."; "Internal Entry No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Variety; Variety)
                {
                    ApplicationArea = All;
                }
                field(Country; Country)
                {
                    ApplicationArea = All;
                }
                field("Quantity(period)"; "Quantity(period)")
                {
                    ApplicationArea = All;
                }
                field("User-ID"; "User-ID")
                {
                    ApplicationArea = All;
                }
                field(Type; Type)
                {
                    ApplicationArea = All;
                }
                field("Modification date"; "Modification date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

