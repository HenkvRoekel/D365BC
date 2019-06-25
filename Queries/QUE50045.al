query 50045 "Count My Sales Orders"
{

    Caption = 'Count Sales Orders';

    elements
    {
        dataitem(Sales_Header; "Sales Header")
        {
            DataItemTableFilter = "Document Type" = CONST (Order);
            filter(Status; Status)
            {
            }
            filter(Shipped; Shipped)
            {
            }
            filter(Completely_Shipped; "Completely Shipped")
            {
            }
            filter(Responsibility_Center; "Responsibility Center")
            {
            }
            filter(Ship; Ship)
            {
            }
            filter(Invoice; Invoice)
            {
            }
            filter(Shipment_Date; "Shipment Date")
            {
            }
            filter(Salesperson_Code; "Salesperson Code")
            {
            }
            column(Count_Orders)
            {
                Method = Count;
            }
        }
    }
}

