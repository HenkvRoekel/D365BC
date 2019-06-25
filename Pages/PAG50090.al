page 50090 "Alllocation Comment Line"
{

    Caption = 'Alllocation Comment Line';
    Editable = false;
    InsertAllowed = true;
    PageType = ListPart;
    SourceTable = "Comment Line";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field(Date; Date)
                {
                    ApplicationArea = All;
                }
                field("B End Date"; "B End Date")
                {
                    ApplicationArea = All;
                }
                field(Comment; Comment)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin

        SetFilter("B End Date", '>=%1', Today);
    end;
}

