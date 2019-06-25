query 50015 "QVEforItemSalesperson-PA"
{

    elements
    {
        dataitem(Prognosis_Allocation_Entry; "Prognosis/Allocation Entry")
        {
            column(Month_Posting_Date; "Sales Date")
            {
                Method = Month;
            }
            column(Year_Posting_Date; "Sales Date")
            {
                Method = Year;
            }
            column(Item_No; "Item No.")
            {
            }
            column(Salesperson_Code; Salesperson)
            {
            }
            column(Prognoses; Prognoses)
            {
                Method = Sum;
            }
            dataitem(Item; Item)
            {
                DataItemLink = "No." = Prognosis_Allocation_Entry."Item No.";
                column(Item_Description; Description)
                {
                }
                column(Base_Unit_of_Measure; "Base Unit of Measure")
                {
                }
                dataitem(Salesperson_Purchaser; "Salesperson/Purchaser")
                {
                    DataItemLink = Code = Prognosis_Allocation_Entry.Salesperson;
                    column(Sales_Name; Name)
                    {
                    }
                }
            }
        }
    }
}

