tableextension 90112 SalesInvoiceHeaderBTExt extends "Sales Invoice Header"
{


    fields
    {
        field(50005; "B Proforma No."; Code[10])
        {
            Caption = 'Proforma No.';

        }
        field(50066; "B Contents"; Text[35])
        {
            Caption = 'Contents';

        }
        field(50068; "B Gross weight"; Decimal)
        {
            Caption = 'Gross weight';

        }
        field(50080; "B Reserved weight"; Decimal)
        {
            CalcFormula = Sum ("Sales Invoice Line"."B Reserved weight" WHERE ("Document No." = FIELD ("No.")));
            Caption = 'Reserved weight';

            Editable = false;
            FieldClass = FlowField;
        }
        field(50089; "B Characteristic"; Option)
        {
            Caption = 'Characteristic';

            OptionCaption = ' ,Price correction,Return-to stock,Return seed destruction,Customer seed destruction,Stock revaluation,Customs sample,Not to join';
            OptionMembers = " ","Price correction","Return-to stock","Return seed destruction","Customer seed destruction","Stock revaluation","Customs sample","Not to join";
        }
        field(50090; "B Order Type"; Option)
        {
            Caption = 'Order Type';

            OptionCaption = 'Normal,Market introduction,Compensation,Zero normal,Government,Price introduction,Other';
            OptionMembers = Normal,"Market introduction",Compensation,"Zero normal",Government,"Price introduction",Other;
        }
        field(50203; "B Warehouse Remark"; Text[50])
        {
            Caption = 'Warehouse Remark';

        }
    }
}

