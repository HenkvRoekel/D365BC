tableextension 90032 ItemLedgerEntryBTExt extends "Item Ledger Entry"
{

    fields
    {
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
        field(50043; "B Variety"; Code[10])
        {
            Caption = 'Variety';

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
        field(50090; "B Requested Delivery Date"; Date)
        {
            Caption = 'Requested Delivery Date';

        }
        field(50095; "B Salesperson"; Code[20])
        {
            Caption = 'Salesperson';

            TableRelation = "Salesperson/Purchaser";
        }
        field(50103; "B Tracking Qty. on Lot"; Decimal)
        {
            CalcFormula = - Sum ("Reservation Entry"."Quantity (Base)" WHERE ("Reservation Status" = CONST (Surplus),
                                                                            "Item No." = FIELD ("Item No."),
                                                                            "Source Type" = CONST (37),
                                                                            "Source Subtype" = CONST ("1"),
                                                                            "Lot No." = FIELD ("Lot No."),
                                                                            "Location Code" = FIELD ("Location Code")));
            Caption = 'Tracking Qty. on Lot';
            DecimalPlaces = 0 : 5;

            Editable = false;
            FieldClass = FlowField;
        }
    }
}

