page 50009 "Interface log"
{
    Caption = 'Interface log';
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Interface log";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Entry No."; "Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Process name"; "Process name")
                {
                    ApplicationArea = All;
                }
                field(Identifier; Identifier)
                {
                    ApplicationArea = All;
                }
                field("Log date"; "Log date")
                {
                    ApplicationArea = All;
                }
                field("Log time"; "Log time")
                {
                    ApplicationArea = All;
                }
                field(Processed; Processed)
                {
                    ApplicationArea = All;
                }
                field("Extra 1"; "Extra 1")
                {
                    ApplicationArea = All;
                }
                field("Extra 2"; "Extra 2")
                {
                    ApplicationArea = All;
                }
                field("Extra 3"; "Extra 3")
                {
                    ApplicationArea = All;
                }
                field("Extra 4"; "Extra 4")
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

