page 50027 "Item Extension"
{

    Caption = 'Item Extension';
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Item Extension";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
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
                field("Extension Code"; "Extension Code")
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

