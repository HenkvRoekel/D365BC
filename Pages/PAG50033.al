page 50033 "Create Item Wizard subform 1"
{

    Caption = 'Create Item Wizard subform 1';
    DelayedInsert = true;
    PageType = ListPart;
    PopulateAllFields = false;
    SourceTable = "Integer";
    SourceTableView = ORDER(Ascending);

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                Editable = false;
                ShowCaption = false;
                field(Mark; Mark)
                {
                    Caption = 'Marked';
                    ApplicationArea = All;
                }
                field("grecItemUoMTEMP.Code"; grecItemUoMTEMP.Code)
                {
                    Caption = 'Code';
                    Style = Strong;
                    StyleExpr = Marked;
                    ApplicationArea = All;
                }
                field("grecItemUoMTEMP.""Qty. per Unit of Measure"""; grecItemUoMTEMP."Qty. per Unit of Measure")
                {
                    Caption = 'Qty. per Unit of Measure';
                    DecimalPlaces = 3 : 3;
                    Style = Strong;
                    StyleExpr = Marked;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(ToMark)
            {
                Caption = 'Mark';
                ShortCutKey = 'Ctrl+F1';
                ApplicationArea = All;

                trigger OnAction()
                begin

                    Mark(not Mark);

                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        GetCurrentRecord;
    end;

    var
        grecItemUoMTEMP: Record "Item Unit of Measure" temporary;
        gRecordCount: Integer;
        Marked: Boolean;

    procedure CreateDataset(var ItemUoMList: Record "Item Unit of Measure" temporary)
    begin
        grecItemUoMTEMP.Reset;
        grecItemUoMTEMP.DeleteAll;
        gRecordCount := 0;
        if ItemUoMList.FindSet then repeat
                                        grecItemUoMTEMP.Init;
                                        grecItemUoMTEMP."Item No." := ItemUoMList."Item No.";
                                        grecItemUoMTEMP.Code := ItemUoMList.Code;
                                        grecItemUoMTEMP."Qty. per Unit of Measure" := ItemUoMList."Qty. per Unit of Measure";
                                        gRecordCount += 1;
                                        grecItemUoMTEMP.Length := gRecordCount;
                                        grecItemUoMTEMP.Insert;
            until ItemUoMList.Next = 0;
        SetRange(Number, 1, gRecordCount);
        CurrPage.Update(false);
    end;

    procedure GetSelectedRecords(var ItemUoMList: Record "Item Unit of Measure" temporary)
    var
        lCurrentNumber: Integer;
        lMarksWereUsed: Boolean;
    begin
        ItemUoMList.Reset;


        lCurrentNumber := Number;
        lMarksWereUsed := false;

        if FindSet then repeat
                            if Mark then begin
                                GetCurrentRecord;
                                if ItemUoMList.Get(grecItemUoMTEMP."Item No.", grecItemUoMTEMP.Code) then begin
                                    ItemUoMList.Mark(true);
                                    lMarksWereUsed := true;
                                end;
                            end;
            until Next = 0;

        Number := lCurrentNumber;
        Find('=');

        if not lMarksWereUsed then begin
            grecItemUoMTEMP.SetRange(Length, lCurrentNumber);
            if grecItemUoMTEMP.FindFirst then begin
                if ItemUoMList.Get(grecItemUoMTEMP."Item No.", grecItemUoMTEMP.Code) then
                    ItemUoMList.Mark(true);
            end;

            CurrPage.SetSelectionFilter(Rec);
            if FindSet then repeat
                                GetCurrentRecord;
                                if ItemUoMList.Get(grecItemUoMTEMP."Item No.", grecItemUoMTEMP.Code) then
                                    ItemUoMList.Mark(true);
                until Next = 0;

            Reset;
            Number := lCurrentNumber;
            Find('=');
        end;

    end;

    local procedure GetCurrentRecord()
    begin

        grecItemUoMTEMP.SetRange(Length, Number);
        if not grecItemUoMTEMP.FindFirst then
            grecItemUoMTEMP.Init;
    end;
}

