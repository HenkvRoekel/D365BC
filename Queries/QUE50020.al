query 50020 QYearProgforYearProg
{

    elements
    {
        dataitem(Year_Prognoses; "Year Prognoses")
        {
            column(Month_Posting_Date; Date)
            {
                Method = Month;
            }
            column(Year_Posting_Date; Date)
            {
                Method = Year;
            }
            column(YearlyPrognoses; "Quantity(period)")
            {
                Method = Sum;
            }
            dataitem(Varieties; Varieties)
            {
                DataItemLink = "No." = Year_Prognoses.Variety;
                column(Variety_No; "No.")
                {
                }
                column(Variety_Description; Description)
                {
                }
            }
        }
    }

    trigger OnBeforeOpen()
    var
        gText: Text;
    begin
    end;
}

