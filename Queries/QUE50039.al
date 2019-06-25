query 50039 QGLEntryForConsolidation
{

    elements
    {
        dataitem(G_L_Entry; "G/L Entry")
        {
            column(Month_Posting_Date; "Posting Date")
            {
                Method = Month;
            }
            column(Year_Posting_Date; "Posting Date")
            {
                Method = Year;
            }
            column(G_L_Account_No; "G/L Account No.")
            {
            }
            column(Sum_GL_Amount; Amount)
            {
                Method = Sum;
            }
            column(Sum_Debit_Amount; "Debit Amount")
            {
                Method = Sum;
            }
            column(Is_Closing_Entry; "B Is Closing Entry")
            {
            }
            column(Global_Dimension_1_Value; "Global Dimension 1 Code")
            {
            }
            column(Global_Dimension_2_Value; "Global Dimension 2 Code")
            {
            }
            column(Sum_Credit_Amount; "Credit Amount")
            {
                Method = Sum;
            }
            dataitem(G_L_Account; "G/L Account")
            {
                DataItemLink = "No." = G_L_Entry."G/L Account No.";
                column(GL_Name; Name)
                {
                }
                column(Income_Balance; "Income/Balance")
                {
                }
                column(Consolidation_Line; "B Consolidation Line")
                {
                }
                column(Consolidation_Row; "B Consolidation Row")
                {
                }
                dataitem(General_Ledger_Setup; "General Ledger Setup")
                {
                    SqlJoinType = CrossJoin;
                    column(Global_Dimension_1_Code; "Global Dimension 1 Code")
                    {
                    }
                    column(Global_Dimension_2_Code; "Global Dimension 2 Code")
                    {
                    }
                }
            }
        }
    }

    trigger OnBeforeOpen()
    var
        gRecBejoSetup: Record "Bejo Setup";
    begin
    end;
}

