page 50057 "Add Item/Unit of Measure"
{

    Caption = 'Add Item/Unit of Measure';
    PageType = List;
    SourceTable = "Item/Unit";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Item No."; "Item No.")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure"; "Unit of Measure")
                {
                    TableRelation = "Item Unit of Measure" WHERE ("Item No." = FIELD ("Item No."));
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
                }
                field("grecItem.Description"; grecItem.Description)
                {
                    Caption = 'Description';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("grecItem.""Description 2"""; grecItem."Description 2")
                {
                    Caption = 'Description 2';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("grecItem.""B Description 3"""; grecItem."B Description 3")
                {
                    Caption = 'Description 3';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Organic; Organic)
                {
                    Editable = false;
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
        if not grecItem.Get("Item No.") then
            grecItem.Init;

        grecItem.CalcFields("B Description 3");
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        TestField("Item No.");

        if grecUnitOfMeasure.Get("Unit of Measure") then
            if grecUnitOfMeasure."B Code BejoNL" = '' then
                Error(Text000);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        grecItem.Init;
        grecUnitOfMeasure.Init;
    end;

    var
        grecUnitOfMeasure: Record "Unit of Measure";
        grecItem: Record Item;
        Text000: Label 'Unit of Measure does not exist in NL.';
}

