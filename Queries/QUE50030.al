query 50030 QILEforCropbyDimension
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
            column(Item_No; "Item No.")
            {
            }
            column(Unit_of_Measure_Code; "Unit of Measure Code")
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
            column(Dimension_Set_ID; "Dimension Set ID")
            {
            }
            dataitem(Customer; Customer)
            {
                DataItemLink = "No." = Item_Ledger_Entry."Source No.";
                column(Customer_Name; Name)
                {
                }
                column(Customer_Name_2; "Name 2")
                {
                }
                column(Customer_Address; Address)
                {
                }
                column(Customer_City; City)
                {
                }
                column(Country_Region_Code; "Country/Region Code")
                {
                }
                column(Customer_Posting_Group; "Customer Posting Group")
                {
                }
                column(Payment_Terms_Code; "Payment Terms Code")
                {
                }
                column(Post_Code; "Post Code")
                {
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
                            dataitem(Dimension_Set_Entry; "Dimension Set Entry")
                            {
                                DataItemLink = "Dimension Set ID" = Item_Ledger_Entry."Dimension Set ID";
                                column(Dimension_Code; "Dimension Code")
                                {
                                }
                                column(Dimension_Value_Code; "Dimension Value Code")
                                {
                                }
                            }
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

