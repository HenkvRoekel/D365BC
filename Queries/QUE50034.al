query 50034 QILEMarginUnit
{
    elements
    {
        dataitem(Item_Ledger_Entry; "Item Ledger Entry")
        {
            column(Posting_Date; "Posting Date")
            {
            }
            filter(Entry_Type; "Entry Type")
            {
            }
            column(Item_No; "Item No.")
            {
            }
            column(Unit_of_Measure_Code; "Unit of Measure Code")
            {
            }
            column(Qty_per_Unit_of_Measure; "Qty. per Unit of Measure")
            {
            }
            column(Sum_Quantity; Quantity)
            {
                Method = Sum;
                ReverseSign = true;
            }
            column(Sum_Sales_Amount_Actual; "Sales Amount (Actual)")
            {
                Method = Sum;
            }
        }
    }

    trigger OnBeforeOpen()
    begin
        SetRange(Entry_Type, Entry_Type::Sale);
    end;
}

