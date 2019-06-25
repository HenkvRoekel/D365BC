page 50005 "Webservice Card"
{

    Caption = 'Webservice Card';
    PageType = Card;
    SourceTable = Webservice;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(Webservice; Webservice)
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field(URL; URL)
                {
                    ApplicationArea = All;
                }
                field(WSDL; WSDL)
                {
                    ApplicationArea = All;
                }
                field(User; User)
                {
                    ApplicationArea = All;
                }
                field(Password; Password)
                {
                    ApplicationArea = All;
                }
                field("Save XML to local disk"; "Save XML to local disk")
                {
                    ApplicationArea = All;
                }
                field("Log result"; "Log result")
                {
                    ApplicationArea = All;
                }
            }
            group("Default filter")
            {
                Caption = 'Default filter';
                field("Name Filter1"; "Name Filter1")
                {
                    ApplicationArea = All;
                }
                field(FilterDefault1; FilterDefault1)
                {
                    ApplicationArea = All;
                }
                field("Name Filter2"; "Name Filter2")
                {
                    ApplicationArea = All;
                }
                field(FilterDefault2; FilterDefault2)
                {
                    ApplicationArea = All;
                }
                field("Name Filter3"; "Name Filter3")
                {
                    ApplicationArea = All;
                }
                field(FilterDefault3; FilterDefault3)
                {
                    ApplicationArea = All;
                }
                field("Name Filter4"; "Name Filter4")
                {
                    ApplicationArea = All;
                }
                field(FilterDefault4; FilterDefault4)
                {
                    ApplicationArea = All;
                }
                field("Name Filter5"; "Name Filter5")
                {
                    ApplicationArea = All;
                }
                field(FilterDefault5; FilterDefault5)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("We&bservice")
            {
                Caption = 'We&bservice';
                action("Interface log")
                {
                    Caption = 'Interface log';
                    Image = Log;
                    RunObject = Page "Interface log";
                    RunPageLink = "Process name" = FIELD (Webservice);
                    RunPageView = SORTING ("Entry No.");
                    ApplicationArea = All;
                }
            }
        }
    }
}

