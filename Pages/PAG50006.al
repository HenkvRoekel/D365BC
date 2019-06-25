page 50006 "Webservice List"
{


    Caption = 'Webservice List';
    CardPageID = "Webservice Card";
    Editable = false;
    PageType = List;
    SourceTable = Webservice;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
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
                field(FilterDefault5; FilterDefault5)
                {
                    ApplicationArea = All;
                }
                field("Name Filter5"; "Name Filter5")
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
            group(Webservices)
            {
                Caption = 'Webservices';
            }
        }
    }
}

