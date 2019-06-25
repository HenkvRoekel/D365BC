query 50046 qItemSalesPerson
{

    elements
    {
        dataitem(Item; Item)
        {
            column(No; "No.")
            {
            }
            column(Description; Description)
            {
            }
            column(Description_2; "Description 2")
            {
            }
            filter(B_Salespersonfilter; "B Salespersonfilter")
            {
            }
            column(Sum_B_Allocated; "B Allocated")
            {
                Method = Sum;
            }
            column(Sum_B_Remaining_Quantity; "B Remaining Quantity")
            {
                Method = Sum;
            }
            column(B_Organic; "B Organic")
            {
            }
            dataitem(Varieties; Varieties)
            {
                DataItemLink = "No." = Item."B Variety";
                dataitem(Promo_Status; "Promo Status")
                {
                    DataItemLink = Code = Varieties."Promo Status";
                    column(Promostatus; "Code")
                    {
                        Caption = 'Promo status';
                    }
                    column(P_Description; Description)
                    {
                    }
                    dataitem(Block_Entry; "Block Entry")
                    {
                        DataItemLink = "Item No." = Item."No.";
                        column(Block_Code; "Block Code")
                        {
                        }
                        column(Block_Description; "Block Description")
                        {
                        }
                    }
                }
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}

