tableextension 90083 ItemJournalLineBTExt extends "Item Journal Line"
{

    fields
    {

        //Unsupported feature: Code Insertion on ""Lot No."(Field 6501)".
        //trigger OnLookup()
        //Parameters and return type have not been exported.
        //var
        //    LocalisationCodeunit: Codeunit "Localisation Codeunit";
        //begin
        /*
        LotNoLookupItmJn(Rec); //BEJOW110.00.026 120643
        */
        //end;

        field(50003; "B Line type"; Option)
        {
            Caption = 'Line type';

            OptionCaption = 'Normal,Market introduction,Compensation,Zero normal,Government,Price introduction,Other';
            OptionMembers = Normal,"Market introduction",Compensation,"Zero normal",Government,"Price introduction",Other;
        }
        field(50031; "B Comment"; Text[50])
        {
            Caption = 'Comment';

        }
        field(50089; "B Characteristic"; Option)
        {
            Caption = 'Characteristic';

            OptionCaption = ' ,Price correction,Return-to stock,Return seed destruction,Customer seed destruction,Stock revaluation,Customs sample,Not to join';
            OptionMembers = " ","Price correction","Return-to stock","Return seed destruction","Customer seed destruction","Stock revaluation","Customs sample","Not to join";
        }
        field(50100; "B LookUpLotNoAvailQty"; Decimal)
        {

            Editable = false;
        }
        field(50101; "B Page_Action ID"; Text[30])
        {

        }
        field(50110; "B Scanning"; Boolean)
        {

        }
    }

    [BusinessEvent(false)]
    local procedure LotNoLookupItmJn(var Rec: Record "Item Journal Line")
    begin
    end;
}

