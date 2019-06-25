page 50104 PDimensionValue
{

    PageType = List;
    SourceTable = "Dimension Value";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Dimension Code"; "Dimension Code")
                {
                    ApplicationArea = All;
                }
                field("Code"; Code)
                {
                    ApplicationArea = All;
                }
                field(DimensionGroupName; DimensionGroupName)
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
        DimensionGroupName := '';

        if gRecDimensionTemp1.Get("Dimension Code", Code) then
            DimensionGroupName := gRecBejoSetup."Dimension Group 1 Name"
        else begin
            if gRecDimensionTemp2.Get("Dimension Code", Code) then
                DimensionGroupName := gRecBejoSetup."Dimension Group 2 Name"
            else begin
                if gRecDimensionTemp3.Get("Dimension Code", Code) then
                    DimensionGroupName := gRecBejoSetup."Dimension Group 3 Name"
                else begin
                    if gRecDimensionTemp4.Get("Dimension Code", Code) then
                        DimensionGroupName := gRecBejoSetup."Dimension Group 4 Name";
                end;

            end;
        end;
    end;

    trigger OnOpenPage()
    var
        i: Integer;
        lRecDimension: Record "Dimension Value";
    begin


        gRecBejoSetup.Get;
        SetRange("Dimension Code", gRecBejoSetup."Global Dimension to group on");
        for i := 1 to 4 do begin
            Clear(lRecDimension);
            lRecDimension.Reset;
            lRecDimension.SetRange("Dimension Code", gRecBejoSetup."Global Dimension to group on");
            if i = 1 then
                lRecDimension.SetFilter(Code, gRecBejoSetup."Dimension Group 1");
            if i = 2 then
                lRecDimension.SetFilter(Code, gRecBejoSetup."Dimension Group 2");
            if i = 3 then
                lRecDimension.SetFilter(Code, gRecBejoSetup."Dimension Group 3");
            if i = 4 then
                lRecDimension.SetFilter(Code, gRecBejoSetup."Dimension Group 4");
            if lRecDimension.Find('-') then
                repeat
                    if i = 1 then begin
                        gRecDimensionTemp1.Init;
                        gRecDimensionTemp1.TransferFields(lRecDimension);
                        gRecDimensionTemp1.Insert;
                    end;

                    if i = 2 then begin
                        gRecDimensionTemp2.Init;
                        gRecDimensionTemp2.TransferFields(lRecDimension);
                        gRecDimensionTemp2.Insert;
                    end;

                    if i = 3 then begin
                        gRecDimensionTemp3.Init;
                        gRecDimensionTemp3.TransferFields(lRecDimension);
                        gRecDimensionTemp3.Insert;
                    end;

                    if i = 4 then begin
                        gRecDimensionTemp4.Init;
                        gRecDimensionTemp4.TransferFields(lRecDimension);
                        gRecDimensionTemp4.Insert;
                    end;
                until lRecDimension.Next = 0;


        end;

    end;

    var
        DimensionGroupName: Text;
        gRecDimensionTemp1: Record "Dimension Value" temporary;
        gRecBejoSetup: Record "Bejo Setup";
        gRecDimensionTemp2: Record "Dimension Value" temporary;
        gRecDimensionTemp3: Record "Dimension Value" temporary;
        gRecDimensionTemp4: Record "Dimension Value" temporary;
}

