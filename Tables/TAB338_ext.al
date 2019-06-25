tableextension 90338 EntrySummaryBTExt extends "Entry Summary"
{

    fields
    {
        field(50000; "B Item No."; Code[20])
        {
            Caption = 'Item No.';

            TableRelation = Item;
        }
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
        field(50096; "B Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;

        }
        field(50100; "B Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';

            TableRelation = "Item Unit of Measure".Code;
        }
        field(50110; "B Total Quantity (UofM)"; Decimal)
        {
            Caption = 'Total Quantity (UofM)';
            DecimalPlaces = 0 : 5;

        }
        field(50111; "B Tot Reserved Quantity (UofM)"; Decimal)
        {
            Caption = 'Total Reserved Quantity (UofM)';
            DecimalPlaces = 0 : 5;

        }
        field(50112; "B Tot Requested Quantity(UofM)"; Decimal)
        {
            Caption = 'Total Requested Quantity (UofM)';
            DecimalPlaces = 0 : 5;

        }
        field(50113; "B Tot Available Quantity(UofM)"; Decimal)
        {
            Caption = 'Total Available Quantity (UofM)';
            DecimalPlaces = 0 : 5;

        }
        field(50114; "B Location Code"; Code[10])
        {
            Caption = 'Location Code';

            TableRelation = Location;
        }
        field(50115; "B Blocked"; Boolean)
        {
            Caption = 'Blocked';

        }
        field(51020; "B Bin Code"; Code[20])
        {
            Caption = 'Bin Code';

            TableRelation = Bin.Code WHERE ("Location Code" = FIELD ("B Location Code"));
        }
        field(51021; "B Comment"; Text[80])
        {
            CalcFormula = Lookup ("Item Tracking Comment".Comment WHERE (Type = CONST ("Lot No."),
                                                                        "Item No." = FIELD ("B Item No."),
                                                                        "Serial/Lot No." = FIELD ("Lot No.")));
            Caption = 'Comment';

            FieldClass = FlowField;
        }
        field(51022; "B Best used by Style"; Text[50])
        {
            Caption = 'B Best used by Style';
        }
    }
}

