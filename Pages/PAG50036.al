page 50036 "Crop Extension Descr. List"
{

    Caption = 'Crop Extension Description List';
    PageType = List;
    SourceTable = "Crop Extension Description";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Crop Code"; "Crop Code")
                {
                    ApplicationArea = All;
                }
                field(Extension; Extension)
                {
                    ApplicationArea = All;
                }
                field(Language; Language)
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

