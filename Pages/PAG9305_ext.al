pageextension 99305 SalesOrderListBTPageExt extends "Sales Order List"
{

    layout
    {
        addafter("Sell-to Customer Name")
        {
            field("B Warehouse Remark"; "B Warehouse Remark")
            {
                Visible = false;
                ApplicationArea = All;
            }
        }
    }
}

