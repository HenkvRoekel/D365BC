page 50021 "Stock Information sub 3"
{

    Caption = 'Stock Information sub 3';
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Comment Line";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                Editable = false;
                ShowCaption = false;
                field("B Creation Date"; "B Creation Date")
                {
                    ApplicationArea = All;
                }
                field("B End Date"; "B End Date")
                {
                    ApplicationArea = All;
                }
                field(Comment; Comment)
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("B Show"; "B Show")
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

