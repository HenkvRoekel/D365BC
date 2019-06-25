tableextension 90039 PurchaseLineBTExt extends "Purchase Line" 
{

    fields
    {
        field(50000;"B Line Text";Boolean)
        {
            CalcFormula = Exist("Purch. Comment Line" WHERE ("No."=FIELD("Document No."),
                                                             "Document Line No."=FIELD("Line No.")));
            
            Editable = false;
            FieldClass = FlowField;
        }
        field(50003;"B Line type";Option)
        {
            Caption = 'Line type';
            
            OptionCaption = 'Normal,Market introduction,Compensation,Zero normal,Government,Price introduction,Other';
            OptionMembers = Normal,"Market introduction",Compensation,"Zero normal",Government,"Price introduction",Other;
        }
        field(50006;"B Original Item No.";Code[20])
        {
            Caption = 'Original Item No.';
            
        }
        field(50030;"B External Document No.";Code[20])
        {
            Caption = 'External Document No.';
           
        }
        field(50043;"B Variety";Code[10])
        {
            Caption = 'Variety';
            
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
        field(50090;"B Requested Delivery Date";Date)
        {
            Caption = 'Requested Delivery Date';
            
        }
        field(50110;"B Allocation exceeded";Boolean)
        {
            Caption = 'Allocation exceeded';
            
        }
        field(50140;"B Reason Code";Code[10])
        {
            Caption = 'Reason Code';
            
            TableRelation = "Reason Code";
        }
        field(50141;"B SkipAllocationCheck";Boolean)
        {
            
        }
        field(50151;"B ItemExtensionCode";Code[10])
        {
            
        }
        field(50152;"B ReservEntryLotNo";Code[20])
        {
            

            trigger OnLookup()
            var
                LotNoInformation: Record "Lot No. Information";
            begin
                
                LotNoInformation.SetRange("Lot No.", "B ReservEntryLotNo");
                PAGE.RunModal(6505, LotNoInformation);
               
            end;
        }
    }
}

