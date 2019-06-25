tableextension 90114 SalesCrMemoHeaderBTExt extends "Sales Cr.Memo Header"
{

    fields
    {
        field(50066; "B Contents"; Text[35])
        {
            Caption = 'Contents';

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
    }
}

