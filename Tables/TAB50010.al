table 50010 "Imported Purchase Lines"
{

    Caption = 'Imported Purchase Lines';
    PasteIsValid = false;

    fields
    {
        field(1; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(2; "Sell-to Customer No."; Code[20])
        {
            Caption = 'Vendor No. (at BejoNL)';
            Description = 'Table relation removed';
            Editable = false;
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(4; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(5; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,G/L Account,Item,Resource,Fixed Asset,Charge (Item)';
            OptionMembers = " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        }
        field(6; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = Item."No." WHERE ("No." = FIELD ("No."));

            trigger OnValidate()
            begin
                if Item.Get("No.") then begin
                    Description := Item.Description;
                    "Description 2" := Item."Description 2";
                    Variety := CopyStr(Item."No.", 1, 5);
                end;
            end;
        }
        field(7; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location WHERE ("Use As In-Transit" = CONST (false));
        }
        field(10; "Requested Receipt Date"; Date)
        {
            Caption = 'Requested Receipt Date';
        }
        field(18; "Qty. to Receive"; Decimal)
        {
            Caption = 'Qty. to Receive';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                "Qty. to Receive (Base)" := "Qty. to Receive" * "Qty. per Unit of Measure";
            end;
        }
        field(22; "Direct Unit Cost"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Direct Unit Cost';
        }
        field(29; Amount; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount';
        }
        field(31; "Unit Price (LCY)"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Price (LCY)';
        }
        field(35; "Net Weight"; Decimal)
        {
            Caption = 'Net Weight';
            DecimalPlaces = 0 : 5;
            Description = 'BEJOWW5.01.011';
        }
        field(63; "Receipt No."; Code[20])
        {
            Caption = 'Receipt No.';
            Editable = false;
        }
        field(64; "Receipt Line No."; Integer)
        {
            Caption = 'Receipt Line No.';
            Editable = false;
        }
        field(70; "Vendor Item No."; Text[20])
        {
            Caption = 'Vendor Item No.';
        }
        field(100; "Cost Price"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Cost Price';
            Editable = false;
        }
        field(5403; "Bin Code"; Code[20])
        {
            Caption = 'Bin Code';

            trigger OnLookup()
            var
                WMSManagement: Codeunit "WMS Management";
                BinCode: Code[20];
            begin
                BinCode := WMSManagement.BinLookUp("Location Code", "No.", '', '');
                if BinCode <> '' then
                    Validate("Bin Code", BinCode);
            end;
        }
        field(5404; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
            Editable = false;
            InitValue = 1;
        }
        field(5407; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = "Item Unit of Measure".Code WHERE ("Item No." = FIELD ("No."));

            trigger OnValidate()
            begin
                if Artikeleenheid.Get("No.", "Unit of Measure Code") then
                    "Qty. per Unit of Measure" := Artikeleenheid."Qty. per Unit of Measure";
                "Qty. to Receive (Base)" := "Qty. to Receive" * "Qty. per Unit of Measure";
            end;
        }
        field(5418; "Qty. to Receive (Base)"; Decimal)
        {
            Caption = 'Qty. to Receive (Base)';
            DecimalPlaces = 0 : 5;
        }
        field(50000; "Lot No."; Code[10])
        {
            Caption = 'Lot No.';
        }
        field(50001; "Treatment Code"; Code[5])
        {
            Caption = 'Treatment Code';
        }
        field(50002; "Tsw. in gr."; Decimal)
        {
            Caption = 'Tsw. in gr.';
        }
        field(50004; Germination; Integer)
        {
            Caption = 'Germination';
        }
        field(50005; Abnormals; Integer)
        {
            Caption = 'Abnormals';
        }
        field(50007; "Line type"; Option)
        {
            Caption = 'Line Type';
            OptionCaption = 'Normal,Market introduction,Compensation,Zero normal,Government,Price introduction,Other';
            OptionMembers = Normal,"Market introduction",Compensation,"Zero normal",Government,"Price introduction",Other;
        }
        field(50010; "Grade Code"; Integer)
        {
            Caption = 'Grade Code';
            TableRelation = Grade;
        }
        field(50011; Comment; Text[250])
        {
            Caption = 'Comment';
            Description = 'BEJOWW6.00.014';
        }
        field(50016; "Purchase Order Created"; Boolean)
        {
            Caption = 'Purchase Order Created';
            Description = 'Renamed form  Sales to purchases';
        }
        field(50020; "Customer No. BejoNL"; Code[20])
        {
            Caption = 'Vendor No.';
            Description = 'BEJOWW5.0.005';
        }
        field(50031; Description; Text[50])
        {
            Caption = 'Description';
            Description = 'BEJOW110.00.027 (Field length from 35 to 50)';
        }
        field(50032; "Description 2"; Text[50])
        {
            Caption = 'Description 2';
            Description = 'BEJOWW5.0.005';
        }
        field(50033; "Best used by"; Date)
        {
            Caption = 'Best used by';
        }
        field(50043; Variety; Code[10])
        {
            Caption = 'Variety';
        }
        field(50057; "Box No."; Text[20])
        {
            Caption = 'Box No.';
        }
        field(50089; Characteristic; Option)
        {
            Caption = 'Characteristic';
            OptionCaption = ' ,Price correction,Return-to stock,Return seed destruction,Customer seed destruction,Stock revaluation,Customs sample,Not to join';
            OptionMembers = " ","Price correction","Return-to stock","Return seed destruction","Customer seed destruction","Stock revaluation","Customs sample","Not to join";
        }
        field(50091; "Remark Bejo NL"; Text[75])
        {
            Caption = 'Remark Bejo NL';
        }
        field(50100; "Test Date"; Date)
        {
            Caption = 'Test Date';
        }
        field(50110; "Allocation exceeded"; Boolean)
        {
            Caption = 'Allocation exceeded';
        }
        field(50111; "External Document No."; Code[20])
        {
            Caption = 'External Document No.';
        }
        field(50204; "Multi Germination"; Integer)
        {
            Caption = 'Multi Germination';
            Description = 'BEJOWW5.01.011';
        }
        field(50511; "Order Address Code"; Code[10])
        {
            Caption = 'Order Address Code';
            TableRelation = "Order Address".Code WHERE ("Vendor No." = FIELD ("Customer No. BejoNL"));
        }
        field(50512; User; Code[20])
        {
            Caption = 'User';
            Description = 'Changed from 10 to 20 BEJOWW5.0.001';
        }
        field(50513; Exported; Boolean)
        {
            Caption = 'Exported';
        }
        field(50515; "Original Prognoses"; Decimal)
        {
            Caption = 'Original Prognoses';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(60000; Line; Option)
        {
            Caption = 'Line';
            Description = '061202/JO';
            OptionCaption = 'A,B, ';
            OptionMembers = A,B," ";
        }
        field(60001; "Total Quantity to Receive"; Decimal)
        {
            CalcFormula = Sum ("Imported Purchase Lines"."Qty. to Receive" WHERE ("Document Type" = FIELD ("Document Type"),
                                                                                 "Document No." = FIELD ("Document No."),
                                                                                 "No." = FIELD ("No."),
                                                                                 "Unit of Measure Code" = FIELD ("Unit of Measure Code"),
                                                                                 "Line type" = FIELD ("Line type"),
                                                                                 "Purchase Order Created" = CONST (false),
                                                                                 "Order Address Code" = FIELD ("Order Address Code")));
            Caption = 'Total Quantity to Receive';
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Document Type", "Document No.", "Line No.")
        {
            SumIndexFields = Amount;
        }
        key(Key2; "Document Type", "Document No.", "No.")
        {
            SumIndexFields = "Qty. to Receive (Base)";
        }
        key(Key3; "No.", "Document No.", "Document Type")
        {
        }
        key(Key4; "Document Type", "Document No.", "No.", "Unit of Measure Code", "Line type", "Purchase Order Created", "Order Address Code")
        {
            SumIndexFields = "Qty. to Receive";
        }
        key(Key5; "Document No.", "Document Type", "Box No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Original Prognoses" := "Qty. to Receive (Base)";
    end;

    var
        Item: Record Item;
        Artikeleenheid: Record "Item Unit of Measure";
}

