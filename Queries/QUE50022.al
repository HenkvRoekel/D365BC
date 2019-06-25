query 50022 QILEforProductSales
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
            column(Region_Code; "Global Dimension 1 Code")
            {
            }
            column(Item_Category_Code; "Item Category Code")
            {
            }
            column(Item_No; "Item No.")
            {
            }
            column(Sum_Quantity; Quantity)
            {
                Method = Sum;
                ReverseSign = true;
            }
            column(Sum_Sales_Amount_Actual; "Sales Amount (Actual)")
            {
                Method = Sum;
            }
            dataitem(Item; Item)
            {
                DataItemLink = "No." = Item_Ledger_Entry."Item No.";
                column(Base_Unit_of_Measure; "Base Unit of Measure")
                {
                }
                column(Organic; "B Organic")
                {
                }
                dataitem(Varieties; Varieties)
                {
                    DataItemLink = "No." = Item."B Variety";
                    column(Variety_No; "No.")
                    {
                    }
                    column(Variety_Description; Description)
                    {
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

