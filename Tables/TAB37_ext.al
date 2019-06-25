tableextension 90037 SalesLineBTExt extends "Sales Line"
{


    fields
    {
        field(50000; "B Line Text"; Boolean)
        {
            CalcFormula = Exist ("Sales Comment Line" WHERE ("No." = FIELD ("Document No."),
                                                            "Document Line No." = FIELD ("Line No.")));
            FieldClass = FlowField;
        }
        field(50003; "B Line type"; Option)
        {
            Caption = 'Line type';

            OptionCaption = 'Normal,Market introduction,Compensation,Zero normal,Government,Price introduction,Other,Trial Registration';
            OptionMembers = Normal,"Market introduction",Compensation,"Zero normal",Government,"Price introduction",Other,TrialRegistration;
        }
        field(50020; "B External Document No."; Code[20])
        {
            Caption = 'External Document No.';

        }
        field(50033; "B Salesperson"; Code[10])
        {
            Caption = 'Salesperson';

            TableRelation = "Salesperson/Purchaser";
        }
        field(50043; "B Variety"; Code[40])
        {
            Caption = 'Variety';

        }
        field(50057; "B Box No."; Text[20])
        {
            Caption = 'Box No.';

        }
        field(50080; "B Reserved weight"; Decimal)
        {
            Caption = 'Reserved weight';

        }
        field(50089; "B Characteristic"; Option)
        {
            Caption = 'Characteristic';

            OptionCaption = ' ,Price correction,Return-to stock,Return seed destruction,Customer seed destruction,Stock revaluation,Customs sample,Not to join';
            OptionMembers = " ","Price correction","Return-to stock","Return seed destruction","Customer seed destruction","Stock revaluation","Customs sample","Not to join";
        }
        field(50093; "B Ship-to Code"; Code[10])
        {
            Caption = 'Ship-to Code';

        }
        field(50095; "B Tracking Quantity"; Decimal)
        {
            CalcFormula = - Sum ("Reservation Entry".Quantity WHERE ("Source Type" = CONST (37),
                                                                   "Source Subtype" = FIELD ("Document Type"),
                                                                   "Source ID" = FIELD ("Document No."),
                                                                   "Source Ref. No." = FIELD ("Line No."),
                                                                   "Reservation Status" = FILTER (Surplus | Prospect)));
            Caption = 'Tracking Quantity';
            DecimalPlaces = 0 : 5;

            Editable = false;
            FieldClass = FlowField;
        }
        field(50110; "B Allocation Exceeded"; Boolean)
        {
            Caption = 'Allocation Exceeded';


            trigger OnValidate()
            var
                lrecUserSetup: Record "User Setup";
                Text50024: Label 'User %1 is not allowed to modify Allocation Exceeded';
            begin

                lrecUserSetup.Get(UserId);
                if not lrecUserSetup."B Allow Modify Sales Alloc.Exc" then Error(StrSubstNo(Text50024, UserId));

            end;
        }
        field(50130; "B Lot No."; Code[20])
        {
            Caption = 'Lot No.';

            TableRelation = "Lot No. Information"."Lot No.";

            trigger OnLookup()
            var
                lrecSalesLine: Record "Sales Line";
            begin

                SalesLineLotNoLookup(Rec);

            end;

            trigger OnValidate()
            var
                LotNoInfo: Record "Lot No. Information";
                SalesSetup: Record "Sales & Receivables Setup";
                tempReservEntry: Record "Reservation Entry" temporary;
                tempEntrySummary: Record "Entry Summary" temporary;
                itemTrackingSummaryForm: Page "Item Tracking Summary";
                SkipVerifyChange: Boolean;
                LotNoInformation: Record "Lot No. Information";
                Text50009: Label 'Lot  %1 does not exist for item %2!';
                Text50011: Label 'Lot %1 is blocked!';
                Text50012: Label 'Item tracking stopped!';
                Text50022: Label 'Not (enough) available, use standard item tracking!';
                Text50023: Label 'Attention: Item Tracking exists for this Sales Line!';
                Text50050: Label 'Remove Lot No. %1?';
                Text50025: Label 'You need to delete the Line Texts first.';
            begin
            end;
        }
        field(50140; "B Reason Code"; Code[10])
        {
            Caption = 'Reason Code';

            TableRelation = "Reason Code";
        }
        field(50150; "B AvailableQty"; Decimal)
        {

        }
        field(50151; "B ItemExtensionCode"; Code[10])
        {

        }
        field(50152; "B ReservEntryLotNo"; Code[20])
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

    [BusinessEvent(false)]
    local procedure SalesLineLotNoLookup(var Rec: Record "Sales Line")
    begin

    end;
}

