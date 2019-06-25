query 50047 "Cust. L. E. Remain. Amt."
{

    Caption = 'Cust. Ledg. Entry Remain. Amt.';

    elements
    {
        dataitem(Cust_Ledger_Entry; "Cust. Ledger Entry")
        {
            filter(Document_Type; "Document Type")
            {
            }
            filter(IsOpen; Open)
            {
            }
            filter(Due_Date; "Due Date")
            {
            }
            filter(Customer_No; "Customer No.")
            {
            }
            filter(Customer_Posting_Group; "Customer Posting Group")
            {
            }
            filter(Salesperson_Code; "Salesperson Code")
            {
            }
            column(Sum_Remaining_Amt_LCY; "Remaining Amt. (LCY)")
            {
                Method = Sum;
            }
        }
    }
}

