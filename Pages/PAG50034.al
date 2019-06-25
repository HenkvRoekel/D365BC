page 50034 "Variety Price Group List"
{

    Caption = 'Variety Price Group List';
    PageType = List;
    SourceTable = "Variety Price Group";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Code"; Code)
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

