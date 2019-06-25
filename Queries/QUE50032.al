query 50032 "QCompByCrop-PA"
{

    elements
    {
        dataitem(Prognosis_Allocation_Entry; "Prognosis/Allocation Entry")
        {
            column(Sales_Date; "Sales Date")
            {
            }
            column(Item_No; "Item No.")
            {
            }
            column(Unit_of_Measure; "Unit of Measure")
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

