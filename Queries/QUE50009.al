query 50009 QCustLedgerEntry
{

    elements
    {
        dataitem(Cust_Ledger_Entry; "Cust. Ledger Entry")
        {
            column(Month_Posting_Date; "Posting Date")
            {
                Method = Month;
            }
            column(Year_Posting_Date; "Posting Date")
            {
                Method = Year;
            }
            column(Customer_No; "Customer No.")
            {
            }
            column(Sum_Sales_LCY; "Sales (LCY)")
            {
                Method = Sum;
            }
        }
    }
}

