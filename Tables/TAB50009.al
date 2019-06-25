table 50009 "Block Change Log"
{

    Caption = 'Block Change Log';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
        }
        field(2; "User Id"; Code[20])
        {
            Caption = 'User Id';
        }
        field(3; "Log Date"; Date)
        {
            Caption = 'Log Date';
        }
        field(4; "Log Time"; Time)
        {
            Caption = 'Log Time';
        }
        field(5; "Record Type"; Option)
        {
            Caption = 'Record Type';
            OptionCaption = 'Block,Promo Status';
            OptionMembers = Block,"Promo Status";
        }
        field(6; "Action Type"; Option)
        {
            Caption = 'Action Type';
            OptionCaption = ' ,Insert,Modify,Delete,Rename';
            OptionMembers = " ",Insert,Modify,Delete,Rename;
        }
        field(7; "Block Entry No."; Integer)
        {
            BlankZero = true;
            Caption = 'Block Entry No.';
            TableRelation = "Block Entry";
        }
        field(10; "Continent Code"; Code[10])
        {
            Caption = 'Continent Code';
        }
        field(20; "Country Code"; Code[10])
        {
            Caption = 'Country Code';
            TableRelation = "Country/Region";
        }
        field(30; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;
        }
        field(40; "Ship-to Code"; Code[10])
        {
            Caption = 'Ship-to Code';
            TableRelation = "Ship-to Address".Code WHERE ("Customer No." = FIELD ("Customer No."));
        }
        field(50; "Crop Code"; Code[10])
        {
            Caption = 'Crop Code';
            TableRelation = Crops;
        }
        field(60; "Variety Code"; Code[10])
        {
            Caption = 'Variety Code';
            TableRelation = Varieties;
        }
        field(70; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;
        }
        field(80; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = IF ("Item No." = FILTER (<> '')) "Item Unit of Measure".Code WHERE ("Item No." = FIELD ("Item No."))
            ELSE "Unit of Measure";
        }
        field(90; "Treatment Code"; Code[20])
        {
            Caption = 'Treatment Code';
            TableRelation = "Lot No. Information"."Lot No." WHERE ("Item No." = FIELD ("Item No."));
        }
        field(95; "Previous Code"; Code[10])
        {
            CaptionClass = PreviousCodeCaption;
            Caption = 'Previous Code';
        }
        field(100; "Code"; Code[10])
        {
            CaptionClass = CodeCaption;
            Caption = 'Code';
            TableRelation = IF ("Record Type" = CONST (Block)) "Block Code"
            ELSE
            IF ("Record Type" = CONST ("Promo Status")) "Promo Status";
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
        key(Key2; "Record Type", "Variety Code")
        {
        }
        key(Key3; "Record Type", "Continent Code", "Variety Code")
        {
        }
        key(Key4; "Continent Code", "Country Code", "Crop Code", "Variety Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "User Id" := UserId;
        "Log Date" := Today;
        "Log Time" := Time;
    end;

    procedure AddBlockRecord(var TheBlockEntry: Record "Block Entry"; var TheXBlockEntry: Record "Block Entry"; ActionType: Option " ",Insert,Modify,Delete,Rename)
    begin
        "Record Type" := "Record Type"::Block;
        "Action Type" := ActionType;
        "Block Entry No." := TheBlockEntry."Entry No.";
        "Continent Code" := TheBlockEntry."Continent Code";
        "Country Code" := TheBlockEntry."Country Code";
        "Customer No." := TheBlockEntry."Customer No.";
        "Ship-to Code" := TheBlockEntry."Ship-to Code";
        "Crop Code" := TheBlockEntry."Crop Code";
        "Variety Code" := TheBlockEntry."Variety Code";
        "Item No." := TheBlockEntry."Item No.";
        "Unit of Measure Code" := TheBlockEntry."Unit of Measure Code";
        "Treatment Code" := TheBlockEntry."Treatment Code";
        "Previous Code" := TheXBlockEntry."Block Code";
        Code := TheBlockEntry."Block Code";
        Insert(true);
    end;

    procedure AddVarietyRecord(var TheVariety: Record Varieties; var TheXVariety: Record Varieties; ActionType: Option " ",Insert,Modify,Delete,Rename)
    begin
        if (TheVariety."Promo Status" <> TheXVariety."Promo Status") or
           (TheVariety."No." <> TheXVariety."No.")
        then begin
            "Record Type" := "Record Type"::"Promo Status";
            "Action Type" := ActionType;
            "Variety Code" := TheVariety."No.";
            "Previous Code" := TheXVariety."Promo Status";
            Code := TheVariety."Promo Status";
            Insert(true);
        end;
    end;

    procedure Description(): Text[250]
    var
        lrecBlockCode: Record "Block Code";
        lrecPromoStatus: Record "Promo Status";
    begin
        case "Record Type" of

            "Record Type"::Block:
                if lrecBlockCode.Get(Code) then
                    exit(lrecBlockCode.Description);

            "Record Type"::"Promo Status":
                if lrecPromoStatus.Get(Code) then
                    exit(lrecPromoStatus.Description);

        end;
    end;

    local procedure PreviousCodeCaption(): Text[1024]
    var
        ctBlockCode: Label 'Previous Block Code';
        ctPromoStatus: Label 'Previous Promo Status';
    begin
        case "Record Type" of
            "Record Type"::Block:
                exit('3, ' + ctBlockCode);
            "Record Type"::"Promo Status":
                exit('3, ' + ctPromoStatus);
        end;
    end;

    local procedure CodeCaption(): Text[1024]
    var
        ctBlockCode: Label 'Block Code';
        ctPromoStatus: Label 'Promo Status';
    begin
        case "Record Type" of
            "Record Type"::Block:
                exit('3, ' + ctBlockCode);
            "Record Type"::"Promo Status":
                exit('3, ' + ctPromoStatus);
        end;
    end;
}

