query 50042 QILEforTradeMasterCustomer
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
            column(Customer_No; "Source No.")
            {
            }
            column(Salesperson; "B Salesperson")
            {
            }
            column(Item_No; "Item No.")
            {
            }
            column(Sales_Qty; Quantity)
            {
                Method = Sum;
                ReverseSign = true;
            }
            dataitem(Item; Item)
            {
                DataItemLink = "No." = Item_Ledger_Entry."Item No.";
                column(Item_Description; Description)
                {
                }
                column(Base_Unit_of_Measure; "Base Unit of Measure")
                {
                }
                column(Description_2; "Description 2")
                {
                }
                column(Description_3; "B Description 3")
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
                    dataitem(Crops; Crops)
                    {
                        DataItemLink = "Crop Code" = Item."B Crop";
                        column(Crop_Code; "Crop Code")
                        {
                        }
                        column(Crop_Description; Description)
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
    end;
}

