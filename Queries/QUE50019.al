query 50019 "QYearProgforVA-Sales"
{

    elements
    {
        dataitem(Value_Entry; "Value Entry")
        {
            filter(Item_Ledger_Entry_Type; "Item Ledger Entry Type")
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
            column(Sales_Qty; "Invoiced Quantity")
            {
                Method = Sum;
                ReverseSign = true;
            }
            dataitem(Item; Item)
            {
                DataItemLink = "No." = Value_Entry."Item No.";
                column(Variety_No; "B Variety")
                {
                }
                dataitem(Varieties; Varieties)
                {
                    DataItemLink = "No." = Item."B Variety";
                    column(Variety_Description; Description)
                    {
                    }
                }
            }
        }
    }

    trigger OnBeforeOpen()
    var
        gText: Text;
    begin
        SetRange(Item_Ledger_Entry_Type, Item_Ledger_Entry_Type::Sale);
    end;
}

