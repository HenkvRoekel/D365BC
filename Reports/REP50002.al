report 50002 "Block/Unlock Prognosis"
{

    Caption = 'Block/Unlock Prognosis';
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
                    ReportOption::"Block Prognosis":
                        Blocked := true;
                    ReportOption::"Unblock Prognosis":
                        Blocked := false;
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
                    field(Block; ReportOption)
                    {
                        OptionCaption = 'Block Prognosis,Unblock Prognosis';
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
        ReportOption: Option "Block Prognosis","Unblock Prognosis";
}

