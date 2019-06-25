query 50013 QILEforVendorItem
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
            column(Vendor_No; "Source No.")
            {
            }
            column(Item_No; "Item No.")
            {
            }
            column(Unit_of_Measure_Code; "Unit of Measure Code")
            {
            }
            column(Quantity_or_KG; "Invoiced Quantity")
            {
                Method = Sum;
            }
            column(Amount; "Purchase Amount (Actual)")
            {
                Method = Sum;
            }
            dataitem(Vendor; Vendor)
            {
                DataItemLink = "No." = Item_Ledger_Entry."Source No.";
                column(Vendor_Name; Name)
                {
                }
                column(Vendor_Name_2; "Name 2")
                {
                }
                column(Vendor_Address; Address)
                {
                }
                column(Vendor_City; City)
                {
                }
                column(Country_Region_Code; "Country/Region Code")
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
                        }
                    }
                }
            }
        }
    }

    trigger OnBeforeOpen()
    begin
        SetRange(Entry_Type, Entry_Type::Purchase);
        SetRange(Source_Type, Source_Type::Vendor);
    end;
}

