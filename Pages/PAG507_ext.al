pageextension 90507 BlanketSalesOrderBTPageExt extends "Blanket Sales Order"
{


    layout
    {
        addafter("Bill-to City")
        {
            field("B Warehouse Remark"; "B Warehouse Remark")
            {
                ApplicationArea = All;
            }
            field("Reason Code"; "Reason Code")
            {
                ApplicationArea = All;
            }
        }
        addafter("Area")
        {
            field("B Marks"; "B Marks")
            {
                ApplicationArea = All;
            }
            field("B Contents"; "B Contents")
            {
                ApplicationArea = All;
            }
            field("B Packing Description"; "B Packing Description")
            {
                ApplicationArea = All;
            }
            field("B Gross weight"; "B Gross weight")
            {
                ApplicationArea = All;
            }
            field("B Reserved weight"; "B Reserved weight")
            {
                ApplicationArea = All;
            }
        }
    }
}

