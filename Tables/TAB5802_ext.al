tableextension 95802 ValueEntryBTExt extends "Value Entry"
{

    fields
    {
        field(50018; "B Line type"; Option)
        {
            Caption = 'Line type';

            OptionCaption = 'Normal,Market introduction,Compensation,Zero normal,Government,Price introduction,Other';
            OptionMembers = Normal,"Market introduction",Compensation,"Zero normal",Government,"Price introduction",Other;
        }
        field(50045; "B Treatment Code"; Code[10])
        {
            Caption = 'Treatment Code';

            TableRelation = "Treatment Code";
        }
        field(50046; "B Unit in Weight"; Boolean)
        {
            Caption = 'Unit in Weight';

        }
        field(50089; "B Characteristic"; Option)
        {
            Caption = 'Characteristic';

            OptionCaption = ' ,Price correction,Return-to stock,Return seed destruction,Customer seed destruction,Stock revaluation,Customs sample,Not to join';
            OptionMembers = " ","Price correction","Return-to stock","Return seed destruction","Customer seed destruction","Stock revaluation","Customs sample","Not to join";
        }
    }
}

