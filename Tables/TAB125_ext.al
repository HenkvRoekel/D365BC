tableextension 90125 PurchCrMemoLineBTExt extends "Purch. Cr. Memo Line" 
{
   

    fields
    {
        field(50000;"B Line Text";Boolean)
        {
            CalcFormula = Exist("Purch. Comment Line" WHERE ("No."=FIELD("Document No."),
                                                             "Document Line No."=FIELD("Line No.")));
            
            FieldClass = FlowField;
        }
        field(50003;"B Line Type";Option)
        {
            Caption = 'Line Type';
            
            OptionCaption = 'Normal,Market introduction,Compensation,Zero normal,Government,Price introduction,Other';
            OptionMembers = Normal,"Market introduction",Compensation,"Zero normal",Government,"Price introduction",Other;
        }
        field(50057;"B Box No.";Text[20])
        {
            Caption = 'Box No.';
           
        }
        field(50089;"B Characteristic";Option)
        {
            Caption = 'Characteristic';
            
            OptionCaption = ' ,Price correction,Return-to stock,Return seed destruction,Customer seed destruction,Stock revaluation,Customs sample,Not to join';
            OptionMembers = " ","Price correction","Return-to stock","Return seed destruction","Customer seed destruction","Stock revaluation","Customs sample","Not to join";
        }
    }
}

