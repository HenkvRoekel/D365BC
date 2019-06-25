query 50014 QVEforItemSalesperson
{

    elements
    {
        dataitem(Value_Entry; "Value Entry")
        {
            filter(Item_Ledger_Entry_Type_filter; "Item Ledger Entry Type")
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
            column(Posting_Date; "Posting Date")
            {
            }
            column(Sales_Quantity; "Invoiced Quantity")
            {
                Method = Sum;
                ReverseSign = true;
            }
            column(Sales_Amount; "Sales Amount (Actual)")
            {
                Method = Sum;
            }
            column(Item_No; "Item No.")
            {
            }
            column(Salesperson_Code; "Salespers./Purch. Code")
            {
            }
            dataitem(Item; Item)
            {
                DataItemLink = "No." = Value_Entry."Item No.";
                column(Item_Description; Description)
                {
                }
                column(Base_Unit_of_Measure; "Base Unit of Measure")
                {
                }
                column(Variety; "B Variety")
                {
                }
                column(Crop; "B Crop")
                {
                }
                dataitem(Salesperson_Purchaser; "Salesperson/Purchaser")
                {
                    DataItemLink = Code = Value_Entry."Salespers./Purch. Code";
                    column(Sales_Name; Name)
                    {
                    }
                    dataitem(Varieties; Varieties)
                    {
                        DataItemLink = "No." = Item."B Variety";
                        column(Description; Description)
                        {
                        }
                        column(Organic; Organic)
                        {
                        }
                        column(Promo_Status; "Promo Status")
                        {
                        }
                        column(Promo_Status_Description; "Promo Status Description")
                        {
                        }
                    }
                }
            }
        }
    }

    trigger OnBeforeOpen()
    begin
        SetRange(Item_Ledger_Entry_Type_filter, Item_Ledger_Entry_Type_filter::Sale);
        SetFilter(Item_No, '<>%1', '');
    end;
}

