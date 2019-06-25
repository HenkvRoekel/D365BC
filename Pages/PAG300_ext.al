pageextension 90300 ShiptoAddressBTPageExt extends "Ship-to Address"
{


    layout
    {
        modify("Home Page")
        {
            ToolTip = 'Specifies the recipient''s home page address.';
        }


        addafter("Last Date Modified")
        {
            field("B Default"; "B Default")
            {
                ApplicationArea = All;
            }
            group(Communication)
            {
                Caption = 'Communication';
                field("Phone No.2"; "Phone No.")
                {
                    ApplicationArea = All;
                }
            }
        }
        moveafter(Contact; "Location Code")
    }
}

