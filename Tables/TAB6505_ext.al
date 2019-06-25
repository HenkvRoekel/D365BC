tableextension 96505 LotNoInformationBTExt extends "Lot No. Information"
{


    fields
    {
        field(50001; "B Treatment Code"; Code[5])
        {
            Caption = 'Treatment Code';

            TableRelation = "Treatment Code";
        }
        field(50002; "B Tsw. in gr."; Decimal)
        {
            Caption = 'Tsw. in gr.';

            NotBlank = true;
        }
        field(50003; "B Line type"; Option)
        {
            Caption = 'Line type';

            OptionCaption = 'Normal,Market introduction,Compensation,Zero normal,Government,Price introduction,Other';
            OptionMembers = Normaal,Marktintro,Compensatie,"Nul normaal",Overheid,Prijsintro,Overig;
        }
        field(50004; "B Germination"; Integer)
        {
            Caption = 'Germination';

        }
        field(50005; "B Abnormals"; Integer)
        {
            Caption = 'Abnormals';

        }
        field(50010; "B Grade Code"; Integer)
        {
            Caption = 'Grade Code';

            TableRelation = Grade."Grade code";
            ValidateTableRelation = true;
        }
        field(50031; "B Remark"; Text[35])
        {
            Caption = 'Remark';

        }
        field(50033; "B Best used by"; Date)
        {
            Caption = 'Best used by';

        }
        field(50043; "B Variety"; Code[10])
        {
            Caption = 'Variety';

        }
        field(50095; "B Tracking Quantity"; Decimal)
        {
            CalcFormula = Sum ("Reservation Entry"."Quantity (Base)" WHERE ("Reservation Status" = CONST (Surplus),
                                                                           "Item No." = FIELD ("Item No."),
                                                                           "Lot No." = FIELD ("Lot No."),
                                                                           "Source Type" = CONST (37)));
            Caption = 'Tracking Quantity';
            DecimalPlaces = 0 : 5;

            Editable = false;
            FieldClass = FlowField;
        }
        field(50096; "B Qty. per Unit of Measure"; Decimal)
        {
            CalcFormula = Lookup ("Item Ledger Entry"."Qty. per Unit of Measure" WHERE ("Lot No." = FIELD ("Lot No."),
                                                                                       Open = CONST (true)));
            Caption = 'Qty. per Unit of Measure';

            FieldClass = FlowField;
        }
        field(50100; "B Test Date"; Date)
        {
            Caption = 'Test Date';

        }
        field(50101; "B Description 1"; Text[40])
        {
            CalcFormula = Lookup (Item.Description WHERE ("No." = FIELD ("Item No.")));
            Caption = 'Description 1';

            FieldClass = FlowField;
        }
        field(50102; "B Description 2"; Text[40])
        {
            CalcFormula = Lookup (Item."Description 2" WHERE ("No." = FIELD ("Item No.")));
            Caption = 'Description 2';

            FieldClass = FlowField;
        }
        field(50200; "B Bin"; Code[20])
        {
            CalcFormula = Lookup ("Warehouse Entry"."Bin Code" WHERE ("Item No." = FIELD ("Item No."),
                                                                     "Lot No." = FIELD ("Lot No."),
                                                                     "Location Code" = FIELD ("Location Filter")));
            Caption = 'Bin Code';

            FieldClass = FlowField;
        }
        field(50201; BLocation; Code[10])
        {
            CalcFormula = Lookup ("Warehouse Entry"."Location Code" WHERE ("Item No." = FIELD ("Item No."),
                                                                          "Lot No." = FIELD ("Lot No.")));
            Caption = 'Location Code';

            FieldClass = FlowField;
        }
        field(50204; "B Multi Germination"; Integer)
        {
            Caption = 'Multi Germination';

        }
        field(50210; "B Remaining Quantity"; Decimal)
        {
            CalcFormula = Sum ("Item Ledger Entry"."Remaining Quantity" WHERE ("Item No." = FIELD ("Item No."),
                                                                              "Variant Code" = FIELD ("Variant Code"),
                                                                              "Lot No." = FIELD ("Lot No."),
                                                                              "Location Code" = FIELD ("Location Filter")));
            Caption = 'Remaining Quantity';
            DecimalPlaces = 0 : 5;

            FieldClass = FlowField;
        }
        field(50211; "B Text for SalesOrders"; Text[100])
        {
            Caption = 'Text for SalesOrders';

        }
        field(50300; "B ItemExtensionDescription"; Text[60])
        {

            Editable = false;
        }
        field(50301; "B ILEUnitOfMeasureCode"; Code[10])
        {

            Editable = false;
        }
        field(50302; "B ILEUnitQtyPerOfMeasure"; Decimal)
        {

            Editable = false;
        }
        field(50303; "B CountryOfOrigin"; Code[120])
        {

            Editable = false;
        }
        field(50304; "B PhytoCertificate"; Code[110])
        {

            Editable = false;
        }
        field(50305; "B TreatmentDescription"; Text[50])
        {

            Editable = false;
        }
        field(50306; "B GradeDescription"; Text[30])
        {

            Editable = false;
        }
        field(50310; "B Page_Action ID"; Text[30])
        {

        }
    }
}

