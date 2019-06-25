pageextension 90021 CustomerCardBTPageExt extends "Customer Card"
{


    layout
    {
        addafter(PricesandDiscounts)
        {
            field("B Country of Origin and PhytoC"; "B Country of Origin and PhytoC")
            {
                ApplicationArea = All;
            }
        }
    }
}

