query 50051 QAnalysisViewEntry
{

    elements
    {
        dataitem(Analysis_View_Entry; "Analysis View Entry")
        {
            column(Posting_Date; "Posting Date")
            {
            }
            column(Debit_Amount; "Debit Amount")
            {
            }
            column(Credit_Amount; "Credit Amount")
            {
            }
            column(Amount; Amount)
            {
            }
            column(Analysis_View_Code; "Analysis View Code")
            {
            }
            column(Dimension_1_Value_Code; "Dimension 1 Value Code")
            {
            }
            column(Dimension_2_Value_Code; "Dimension 2 Value Code")
            {
            }
            column(Dimension_3_Value_Code; "Dimension 3 Value Code")
            {
            }
            column(Dimension_4_Value_Code; "Dimension 4 Value Code")
            {
            }
            column(Account_No; "Account No.")
            {
            }
            dataitem(Analysis_View; "Analysis View")
            {
                DataItemLink = Code = Analysis_View_Entry."Analysis View Code";
                column(Dimension_1_Code; "Dimension 1 Code")
                {
                }
                column(Dimension_2_Code; "Dimension 2 Code")
                {
                }
                column(Dimension_3_Code; "Dimension 3 Code")
                {
                }
                column(Dimension_4_Code; "Dimension 4 Code")
                {
                }
            }
        }
    }

    trigger OnBeforeOpen()
    var
        AnalysViewCard: Record "Analysis View";
    begin
    end;
}

