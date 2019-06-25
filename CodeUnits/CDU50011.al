codeunit 50011 "Prognosis Calculation"
{
    trigger OnRun()
    begin
    end;

    procedure CalcVarietyPrognosis(VarietyNo: Code[5]; BeginDate: Date; EndDate: Date) lPrognosis: Decimal
    var
        lrecItem: Record Item;
        lrecUoM: Record "Unit of Measure";
        lrecVariety: Record Varieties;
    begin
        lPrognosis := 0;
        lrecVariety.Get(VarietyNo);
        lrecItem.SetCurrentKey("B Variety");
        lrecItem.SetRange("B Variety", VarietyNo);
        lrecItem.SetRange("Date Filter", BeginDate, EndDate);
        if lrecItem.FindSet then repeat
                                     if lrecUoM.Get(lrecItem."Base Unit of Measure") then begin
                                         lrecItem.CalcFields("B Prognoses");
                                         if lrecUoM."B Unit in Weight" and (lrecVariety.TSW > 0) then
                                             lPrognosis := lPrognosis + (lrecItem."B Prognoses" / lrecVariety.TSW * 1000000)
                                         else
                                             lPrognosis := lPrognosis + (lrecItem."B Prognoses" * 1000000);
                                     end;
            until lrecItem.Next = 0;

        if (lrecVariety."Year Prognosis in" = lrecVariety."Year Prognosis in"::KG) and (lrecVariety.TSW > 0) then
            lPrognosis := (lPrognosis / 1000000 * lrecVariety.TSW)
        else
            lPrognosis := (lPrognosis / 1000000);
    end;

    procedure CalcItemPrognosis(ItemNo: Code[20]; BeginDate: Date; EndDate: Date) lPrognosis: Decimal
    var
        lrecItem: Record Item;
        lrecUoM: Record "Unit of Measure";
        lrecVariety: Record Varieties;
    begin
        lPrognosis := 0;
        if lrecItem.Get(ItemNo) then begin
            lrecItem.SetRange("Date Filter", BeginDate, EndDate);
            if lrecVariety.Get(lrecItem."B Variety") then begin
                if lrecUoM.Get(lrecItem."Base Unit of Measure") then begin
                    lrecItem.CalcFields("B Prognoses");
                    if lrecUoM."B Unit in Weight" and (lrecVariety.TSW > 0) then
                        lPrognosis := lPrognosis + (lrecItem."B Prognoses" / lrecVariety.TSW * 1000000)
                    else
                        lPrognosis := lPrognosis + (lrecItem."B Prognoses" * 1000000);
                end;

                if (lrecVariety."Year Prognosis in" = lrecVariety."Year Prognosis in"::KG) and (lrecVariety.TSW > 0) then
                    lPrognosis := (lPrognosis / 1000000 * lrecVariety.TSW)
                else
                    lPrognosis := (lPrognosis / 1000000);
            end;
        end;
    end;
}

