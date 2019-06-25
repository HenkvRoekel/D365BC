query 50082 QJobLedgerEntry
{

    elements
    {
        dataitem(Job_Ledger_Entry; "Job Ledger Entry")
        {
            column(Type; Type)
            {
            }
            column(No; "Job No.")
            {
            }
            column(Job_Task_No; "Job Task No.")
            {
            }
            column(Month_Posting_Date; "Posting Date")
            {
                Method = Month;
            }
            column(JLENo; "No.")
            {
            }
            column(Year_Posting_Date; "Posting Date")
            {
                Method = Year;
            }
            column(Total_Cost_LCY; "Total Cost (LCY)")
            {
                Method = Sum;
            }
            column(Total_Price_LCY; "Total Price (LCY)")
            {
                Method = Sum;
            }
            dataitem(Job_Task; "Job Task")
            {
                DataItemLink = "Job No." = Job_Ledger_Entry."Job No.", "Job Task No." = Job_Ledger_Entry."Job Task No.";
                column(Job_Task_Description; Description)
                {
                }
                dataitem(General_Posting_Setup; "General Posting Setup")
                {
                    DataItemLink = "Gen. Bus. Posting Group" = Job_Ledger_Entry."Gen. Bus. Posting Group", "Gen. Prod. Posting Group" = Job_Ledger_Entry."Gen. Prod. Posting Group";
                    SqlJoinType = InnerJoin;
                    column(GLAccount; "COGS Account")
                    {
                    }
                }
            }
        }
    }
}

