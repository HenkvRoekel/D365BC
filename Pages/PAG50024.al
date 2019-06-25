page 50024 "Stock information Bin Content"
{

    Caption = 'Stock information Bin Content';
    DataCaptionExpression = GetCaption;
    DelayedInsert = true;
    Editable = false;
    PageType = List;
    SourceTable = "Bin Content";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Location Code"; "Location Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Zone Code"; "Zone Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Bin Code"; "Bin Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = All;
                }
                field("Item No."; "Item No.")
                {
                    ApplicationArea = All;
                }

            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        if not grecWarehouseEntry.SetCurrentKey("Bin Code", "Location Code", "Item No.") then
            grecWarehouseEntry.SetCurrentKey("Location Code", "Bin Code", "Item No.");
        grecWarehouseEntry.SetRange(grecWarehouseEntry."Location Code", "Location Code");
        grecWarehouseEntry.SetRange(grecWarehouseEntry."Bin Code", "Bin Code");
        grecWarehouseEntry.SetRange(grecWarehouseEntry."Item No.", "Item No.");
        if not grecWarehouseEntry.Find('-') then
            grecWarehouseEntry.Init;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        if xRec."Location Code" <> '' then
            "Location Code" := xRec."Location Code";
        if xRec."Bin Code" <> '' then
            "Bin Code" := xRec."Bin Code";
        SetUpNewLine;
    end;

    var
        grecWarehouseEntry: Record "Warehouse Entry";

    local procedure GetCaption(): Text[250]
    var
        lrecObjectTranslation: Record "Object Translation";
        lItemNo: Code[20];
        lVariantCode: Code[10];
        lBinCode: Code[20];
        lPageCaption: Text[250];
        lSourceTableName: Text[30];
    begin
        lSourceTableName := lrecObjectTranslation.TranslateObject(lrecObjectTranslation."Object Type"::Table, 14);
        lPageCaption := StrSubstNo('%1 %2', lSourceTableName, "Location Code");
        if GetFilter("Item No.") <> '' then
            if GetRangeMin("Item No.") = GetRangeMax("Item No.") then begin
                lItemNo := GetRangeMin("Item No.");
                if lItemNo <> '' then begin
                    lSourceTableName := lrecObjectTranslation.TranslateObject(lrecObjectTranslation."Object Type"::Table, 27);
                    lPageCaption := StrSubstNo('%1 %2 %3', lPageCaption, lSourceTableName, lItemNo)
                end;
            end;

        if GetFilter("Variant Code") <> '' then
            if GetRangeMin("Variant Code") = GetRangeMax("Variant Code") then begin
                lVariantCode := GetRangeMin("Variant Code");
                if lVariantCode <> '' then begin
                    lSourceTableName := lrecObjectTranslation.TranslateObject(lrecObjectTranslation."Object Type"::Table, 5401);
                    lPageCaption := StrSubstNo('%1 %2 %3', lPageCaption, lSourceTableName, lVariantCode)
                end;
            end;

        if GetFilter("Bin Code") <> '' then
            if GetRangeMin("Bin Code") = GetRangeMax("Bin Code") then begin
                lBinCode := GetRangeMin("Bin Code");
                if lBinCode <> '' then begin
                    lSourceTableName := lrecObjectTranslation.TranslateObject(lrecObjectTranslation."Object Type"::Table, 7354);
                    lPageCaption := StrSubstNo('%1 %2 %3', lPageCaption, lSourceTableName, lBinCode);
                end;
            end;

        exit(lPageCaption);
    end;
}

