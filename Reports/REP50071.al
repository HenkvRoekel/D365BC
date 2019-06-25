report 50071 "Daily Email Allocation"
{

    Caption = 'Daily Email Allocation';
    PreviewMode = Normal;
    ProcessingOnly = true;

    dataset
    {
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
                    field(gForDate; gForDate)
                    {
                        Caption = 'From Date';
                        ApplicationArea = All;
                    }
                    field(gUptoDate; gUptoDate)
                    {
                        Caption = 'Upto Date';
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

    trigger OnInitReport()
    begin

        gForDate := WorkDate;
        gUptoDate := gForDate;
    end;

    trigger OnPreReport()
    var
        lrecDate: Record Date;
    begin
        lrecDate.Reset;
        lrecDate.SetRange("Period Type", lrecDate."Period Type"::Date);
        lrecDate.SetRange("Period Start", gForDate, gUptoDate);
        if lrecDate.FindSet then repeat
            begin
                //gcuBejoMgt.SendMailAllocationChangeDaily(lrecDate."Period Start");
            end;
            until lrecDate.Next = 0;
    end;

    var
        gcuBejoMgt: Codeunit "Bejo Management";
        gForDate: Date;
        gUptoDate: Date;
}

