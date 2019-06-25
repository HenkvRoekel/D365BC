pageextension 90016 ChartofAccountsBTPageExt extends "Chart of Accounts"
{
    //aaaa
    layout
    {
        addafter("Default IC Partner G/L Acc. No")
        {
            field("<B Consolidation Line>"; "B Consolidation Line")
            {
                ApplicationArea = All;
            }
            field("<B Consolidation Row>"; "B Consolidation Row")
            {
                ApplicationArea = All;
            }
        }
    }
}

