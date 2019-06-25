page 50001 "Season Dates Day"
{

    PageType = List;
    SourceTable = Date;
    SourceTableView = SORTING ("Period Type", "Period Start")
                      ORDER(Ascending)
                      WHERE ("Period Type" = FILTER (Date),
                            "Period Start" = FILTER (19950101D .. 20300101D));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Period Start"; "Period Start")
                {
                    ApplicationArea = All;
                }
                field("Period End"; "Period End")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Period No."; "Period No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Period Name"; "Period Name")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Season; gSeason)
                {
                    ApplicationArea = All;
                }
                field("Season Name"; gSeasonName)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        if Date2DMY("Period Start", 2) < 9 then begin
            gSeason := Date2DMY(CalcDate('<-8M>', "Period Start"), 3);

        end
        else begin
            gSeason := Date2DMY("Period Start", 3);
        end;
        gSeasonName := Format(gSeason) + ' - ' + Format(gSeason + 1);
    end;

    var
        gSeason: Integer;
        gSeasonName: Text[11];
}

