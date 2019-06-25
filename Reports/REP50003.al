report 50003 "Mark/Unmark Handled Prognosis"
{


    Caption = 'Mark/Unmark Handled Prognosis';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Prognosis/Allocation Entry"; "Prognosis/Allocation Entry")
        {
            DataItemTableView = SORTING ("Entry Type", "Item No.", "Unit of Measure", "Sales Date", Salesperson, Customer) WHERE ("Entry Type" = CONST (Prognoses));
            RequestFilterFields = "Item No.", "Sales Date", "Unit of Measure", Customer, Salesperson;

            trigger OnAfterGetRecord()
            begin
                case ReportOption of

                    ReportOption::"Mark as Handled":
                        Validate(Handled, true);
                    ReportOption::"Mark as UnHandled":
                        Validate(Handled, false);


                end;
                Modify;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(ReportOption; ReportOption)
                    {
                        OptionCaption = 'Mark as Handled,Mark as UnHandled';
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        ReportOption: Option "Mark as Handled","Mark as UnHandled";
}

