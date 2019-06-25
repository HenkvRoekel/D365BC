page 50013 "Block Change Log"
{

    Caption = 'Block Change Log';
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Block Change Log";

    layout
    {
        area(content)
        {
            repeater(Control1100531000)
            {
                ShowCaption = false;
                field("Entry No."; "Entry No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("User Id"; "User Id")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Log Date"; "Log Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Log Time"; "Log Time")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Record Type"; "Record Type")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Action Type"; "Action Type")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Block Entry No."; "Block Entry No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Continent Code"; "Continent Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Country Code"; "Country Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Customer No."; "Customer No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Ship-to Code"; "Ship-to Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Crop Code"; "Crop Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Variety Code"; "Variety Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Item No."; "Item No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Treatment Code"; "Treatment Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Previous Code"; "Previous Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Code"; Code)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    Caption = 'Description';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

