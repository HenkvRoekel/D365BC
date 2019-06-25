page 50007 Grade
{

    Caption = 'Grade Code';
    PageType = List;
    SourceTable = Grade;

    layout
    {
        area(content)
        {
            repeater(List)
            {
                field("Grade code"; "Grade code")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
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

