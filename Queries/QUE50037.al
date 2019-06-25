query 50037 QILEforMarketPotential
{

    elements
    {
        dataitem(Item_Ledger_Entry; "Item Ledger Entry")
        {
            filter(Entry_Type; "Entry Type")
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
            column(Sales_Quantity; Quantity)
            {
                Method = Sum;
                ReverseSign = true;
            }
            dataitem(Item; Item)
            {
                DataItemLink = "No." = Item_Ledger_Entry."Item No.";
                column(Base_Unit_of_Measure; "Base Unit of Measure")
                {
                }
                dataitem(Varieties; Varieties)
                {
                    DataItemLink = "No." = Item."B Variety";
                    column(Variety_No; "No.")
                    {
                    }
                    dataitem(Unit_of_Measure; "Unit of Measure")
                    {
                        DataItemLink = Code = Item_Ledger_Entry."Unit of Measure Code";
                        column(Unit_in_Weight; "B Unit in Weight")
                        {
                        }
                    }
                }
            }
        }
    }

    trigger OnBeforeOpen()
    begin
        SetRange(Entry_Type, Entry_Type::Sale);
        SetRange(Source_Type, Source_Type::Customer);
    end;
}

