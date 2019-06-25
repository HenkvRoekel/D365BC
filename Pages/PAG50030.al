page 50030 "Treatment Codes"
{

    PageType = List;
    SourceTable = "Treatment Code";

    layout
    {
        area(content)
        {
            repeater(List)
            {
                field("Treatment Code"; "Treatment Code")
                {
                    Caption = 'Treatment Code';
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    Caption = 'Description';
                    ApplicationArea = All;
                }
                field("Description Reports"; "Description Reports")
                {
                    ApplicationArea = All;
                }
                field("Not Chemically Treated"; "Not Chemically Treated")
                {
                    Caption = 'Not Chemically Treated';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

