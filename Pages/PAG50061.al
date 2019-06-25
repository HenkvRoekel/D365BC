page 50061 "Sales Terms"
{

    Caption = 'Sales Terms';
    PageType = Card;
    SourceTable = "Sales Terms";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Language Code"; "Language Code")
                {
                    Caption = 'Language';
                    ApplicationArea = All;
                }
                field("Entry No."; "Entry No.")
                {
                    Caption = 'Entry No.';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    Caption = 'Description';
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Description 2"; "Description 2")
                {
                    Caption = 'Description 1';
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Description 3"; "Description 3")
                {
                    Caption = 'Description 2';
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Description 4"; "Description 4")
                {
                    Caption = 'Description 3';
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Description 5"; "Description 5")
                {
                    Caption = 'Description 4';
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Description 6"; "Description 6")
                {
                    Caption = 'Description 5';
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Description 7"; "Description 7")
                {
                    Caption = 'Description 6';
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Description 8"; "Description 8")
                {
                    Caption = 'Description 7';
                    MultiLine = true;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

