query 50048 "Cust. Ledg. Entry Sales MOBS"
{

    Caption = 'Cust. Ledg. Entry Sales';

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
            filter(Customer_No; "Customer No.")
            {
            }
            filter(Posting_Date; "Posting Date")
            {
            }
            filter(Salesperson_Code; "Salesperson Code")
            {
            }
            column(Sum_Sales_LCY; "Sales (LCY)")
            {
                Method = Sum;
            }
        }
    }
}

