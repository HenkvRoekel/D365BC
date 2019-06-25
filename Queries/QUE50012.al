query 50012 QEOSSperItem
{

    elements
    {
        dataitem(EOSS_Journal_Line; "EOSS Journal Line")
        {
            column(Posting_Date; "Posting Date")
            {
            }
            column(Document_No; "Document No.")
            {
            }
            column(Item_No; "Item No.")
            {
            }
            column(Sum_Quantity_Base; "Quantity (Base)")
            {
                Method = Sum;
            }
            dataitem(Unit_of_Measure; "Unit of Measure")
            {
                DataItemLink = Code = EOSS_Journal_Line."Unit of Measure Code";
                column(B_Unit_in_Weight; "B Unit in Weight")
                {
                }
            }
        }
    }
}

