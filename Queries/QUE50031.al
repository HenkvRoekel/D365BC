query 50031 QILECompByCrop
{

    elements
    {
        dataitem(Item_Ledger_Entry; "Item Ledger Entry")
        {
            column(Posting_Date; "Posting Date")
            {
            }
            column(Entry_Type; "Entry Type")
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
                dataitem(Crops; Crops)
                {
                    DataItemLink = "Crop Code" = Item."B Crop";
                    column(Crop_Code; "Crop Code")
                    {
                    }
                    column(Crop_Description; Description)
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
}

