tableextension 90036 SalesHeaderBTExt extends "Sales Header"
{

    fields
    {
        field(50000; "B OrderStatus"; Option)
        {
            Caption = 'Order Status';

            OptionCaption = '1.Entered,2.Reserved,3.Released,4.Prepared,5.Ready Warehouse';
            OptionMembers = "1.Entered","2.Reserved","3.Released","4.Prepared","5.Ready Warehouse";
        }
        field(50005; "B Proforma No."; Code[10])
        {
            Caption = 'Proforma No.';

        }
        field(50059; "B Marks"; Text[50])
        {
            Caption = 'Marks';

        }
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
            CalcFormula = Sum ("Sales Line"."B Reserved weight" WHERE ("Document Type" = FIELD ("Document Type"),
                                                                      "Document No." = FIELD ("No.")));
            Caption = 'Reserved weight';

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
        field(50202; "B Print Picking List"; Boolean)
        {
            Caption = 'Print picking list';


            trigger OnValidate()
            var
                Text50000: Label 'Not allowed: Order %1 has orderstatus %2!';
            begin

                if ("B OrderStatus" <> "B OrderStatus"::"3.Released") then
                    Error(Text50000, "No.", "B OrderStatus");

            end;
        }
        field(50203; "B Warehouse Remark"; Text[50])
        {
            Caption = 'Warehouse Remark';

        }
        field(50300; "B PrepayUnpaidAmount"; Decimal)
        {

            Editable = false;
        }
        field(50301; "B Page_Action ID"; Text[30])
        {

        }
    }
}

