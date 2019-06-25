tableextension 90121 PurchRcptLineBTExt extends "Purch. Rcpt. Line"
{

    fields
    {
        field(50000; "B Line Text"; Boolean)
        {
            CalcFormula = Exist ("Purch. Comment Line" WHERE ("No." = FIELD ("Document No."),
                                                             "Document Line No." = FIELD ("Line No.")));

            FieldClass = FlowField;
        }
        field(50003; "B Line type"; Option)
        {
            Caption = 'Line type';

            OptionCaption = 'Normal,Market introduction,Compensation,Zero normal,Government,Price introduction,Other';
            OptionMembers = Normal,"Market introduction",Compensation,"Zero normal",Government,"Price introduction",Other;
        }
        field(50030; "B External Document No."; Code[20])
        {
            Caption = 'External Document No.';

        }
        field(50031; "B Remark"; Text[35])
        {
            Caption = 'Remark';

        }
        field(50043; "B Variety"; Code[10])
        {
            Caption = 'Variety';

        }
        field(50057; "B Box No."; Text[20])
        {
            Caption = 'Box No.';

        }
        field(50089; "B Characteristic"; Option)
        {
            Caption = 'Characteristic';

            OptionCaption = ' ,Price correction,Return-to stock,Return seed destruction,Customer seed destruction,Stock revaluation,Customs sample,Not to join';
            OptionMembers = " ","Price correction","Return-to stock","Return seed destruction","Customer seed destruction","Stock revaluation","Customs sample","Not to join";
        }
    }
}

