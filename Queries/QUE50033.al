query 50033 QMarginPurchInvLine
{

    elements
    {
        dataitem(Purch_Inv_Line; "Purch. Inv. Line")
        {
            filter(Type; Type)
            {
            }
            column(Posting_Date; "Posting Date")
            {
            }
            column(No; "No.")
            {
            }
            column(Unit_of_Measure_Code; "Unit of Measure Code")
            {
            }
            column(Sum_Quantity; Quantity)
            {
                Method = Sum;
            }
            column(Unit_Cost_LCY; "Unit Cost (LCY)")
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin
        SetRange(Type, Type::Item);
    end;
}

