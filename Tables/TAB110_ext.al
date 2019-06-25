tableextension 90110 SalesShipmentHeaderBTExt extends "Sales Shipment Header"
{

    fields
    {
        field(50066; "B Contents"; Text[35])
        {
            Caption = 'Contents';

        }
        field(50067; "B Packing Description"; Text[50])
        {
            Caption = 'Packing Description';

        }
        field(50068; "B Gross weight"; Decimal)
        {
            Caption = 'Gross weight';

        }
        field(50080; "B Reserved weight"; Decimal)
        {
            CalcFormula = Sum ("Sales Shipment Line"."B Reserved weight" WHERE ("Document No." = FIELD ("No.")));
            Caption = 'Reserved weight';

            Editable = false;
            FieldClass = FlowField;
        }
    }
}

