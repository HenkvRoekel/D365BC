query 50010 QGLEntryForSales
{

    elements
    {
        dataitem(G_L_Entry; "G/L Entry")
        {
            filter(G_L_Account_No; "G/L Account No.")
            {
            }
            filter(Document_Type; "Document Type")
            {
            }
            filter(Source_Type; "Source Type")
            {
            }
            column(Month_Posting_Date; "Posting Date")
            {
                Method = Month;
            }
            column(Year_Posting_Date; "Posting Date")
            {
                Method = Year;
            }
            column(Customer_No; "Source No.")
            {
            }
            column(Sum_GL_Amount; Amount)
            {
                Method = Sum;
            }
        }
    }

    trigger OnBeforeOpen()
    var
        gRecBejoSetup: Record "Bejo Setup";
    begin
        gRecBejoSetup.Get;
        if gRecBejoSetup."G/L Account No. Sales" <> '' then begin
            SetRange(Source_Type, Source_Type::Customer);
            SetFilter(G_L_Account_No, gRecBejoSetup."G/L Account No. Sales");
            SetFilter(Document_Type, '%1|%2', Document_Type::Invoice, Document_Type::Reminder);
        end
        else begin
            SetRange(G_L_Account_No, 'ASDFDFDS');
        end;
    end;
}

