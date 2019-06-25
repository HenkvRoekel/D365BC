codeunit 50010 "Item Management"
{

    trigger OnRun()
    begin
    end;

    var
        //gcuWebservices: Codeunit Webservices;
        gcuBlockingMgt: Codeunit "Blocking Management";
        Text001: Label 'Retrieving available Varieties';
        gcuBejoManagement: Codeunit "Bejo Management";

    procedure CreateItemFromTemplate(TemplateCode: Code[10]; ItemNo: Code[20]; ItemUoMCode: Code[10]; VarietyCode: Code[5]; BaseUoMCode: Code[10]) Success: Boolean
    var
        NewItem: Record Item;
        NewUoM: Record "Unit of Measure";
        NewItemUoM: Record "Item Unit of Measure";
        NewItemUnit: Record "Item/Unit";
        AvailableTemplatesTEMP: Record "Config. Template Header" temporary;
        AvailableItemListTEMP: Record Item temporary;
        AvailableItemUoMListTEMP: Record "Item Unit of Measure" temporary;
        RecRef: RecordRef;
        TemplateMgt: Codeunit "Config. Template Management";
    begin
        if GetAvailableTemplates(AvailableTemplatesTEMP, TemplateCode) = 1 then begin
            if GetAvailableItems(AvailableItemListTEMP, ItemNo, VarietyCode) = 1 then begin

                if (GetAvailableItemUoMs(AvailableItemUoMListTEMP, VarietyCode, ItemNo, ItemUoMCode) = 1) or
                   (ItemUoMCode = BaseUoMCode) then begin

                    AvailableTemplatesTEMP.FindFirst;
                    AvailableItemListTEMP.FindFirst;

                    if not NewItem.Get(ItemNo) then begin
                        NewItem.Init;

                        NewItem."No." := ItemNo;

                        NewItem.Insert(true);

                        if not NewUoM.Get(BaseUoMCode) then begin
                            NewUoM.Init;
                            NewUoM.Code := BaseUoMCode;
                            NewUoM.Description := BaseUoMCode;
                            NewUoM.Insert;
                        end;


                        NewItemUoM.Init;
                        NewItemUoM."Item No." := NewItem."No.";
                        NewItemUoM.Code := BaseUoMCode;
                        NewItemUoM."Qty. per Unit of Measure" := 1;
                        NewItemUoM.Insert(true);

                        NewItem.TransferFields(AvailableItemListTEMP, false);

                        NewItem.Validate("No.");

                        NewItem.Validate(Description);
                        NewItem."Base Unit of Measure" := BaseUoMCode;
                        NewItem.Modify;
                        RecRef.GetTable(NewItem);
                        TemplateMgt.UpdateRecord(AvailableTemplatesTEMP, RecRef);

                        NewItem.Get(NewItem."No.");
                        NewItem."B Variety" := VarietyCode;
                        NewItem."B Created from Template" := TemplateCode;
                        NewItem.Modify(true);

                    end;


                    if ItemUoMCode <> BaseUoMCode then begin
                        if not NewUoM.Get(ItemUoMCode) then begin
                            NewUoM.Init;
                            NewUoM.Code := ItemUoMCode;
                            NewUoM.Description := ItemUoMCode;
                            NewUoM.Insert;
                        end;


                        AvailableItemUoMListTEMP.FindFirst;


                        NewItemUoM.Init;
                        NewItemUoM."Item No." := NewItem."No.";
                        NewItemUoM.Code := AvailableItemUoMListTEMP.Code;
                        NewItemUoM.TransferFields(AvailableItemUoMListTEMP, false);
                        NewItemUoM.Insert(true);


                    end;

                    Success := true;
                end;
            end;
        end;
    end;

    procedure GetAvailableTemplates(var TemplateList: Record "Config. Template Header" temporary; TemplateFilter: Code[10]) NumberAvailable: Integer
    var
        DataTemplateHeader: Record "Config. Template Header";
    begin
        NumberAvailable := 0;
        TemplateList.Reset;
        TemplateList.DeleteAll;

        DataTemplateHeader.Reset;

        DataTemplateHeader.SetRange("Table ID", DATABASE::Item);
        if TemplateFilter <> '' then
            DataTemplateHeader.SetRange(Code, TemplateFilter);
        if DataTemplateHeader.FindSet then repeat
                                               TemplateList.Init;
                                               TemplateList.TransferFields(DataTemplateHeader, true);
                                               TemplateList.Insert;
                                               NumberAvailable += 1;
            until DataTemplateHeader.Next = 0;
    end;

    procedure GetAvailableItems(var ItemList: Record Item temporary; ItemNoFilter: Code[20]; VarietyNo: Code[5]) NumberAvailable: Integer
    var
        lrecItem: Record Item;
        lSomeMarked: Boolean;
    begin
        NumberAvailable := 0;
        ItemList.Reset;
        ItemList.DeleteAll;



        //gcuWebservices.GetVarietyItem(VarietyNo, ItemList);
        if ItemNoFilter <> '' then
            ItemList.SetRange("No.", ItemNoFilter)
        else
            ItemList.SetFilter("No.", '<>%1', '');

        if ItemList.FindSet then begin
            ItemList.ClearMarks;
            lSomeMarked := false;
            repeat
                if gcuBlockingMgt.VarietyItemUoMIsBlocked(VarietyNo, ItemList."No.", '') then begin
                    ItemList.Mark(true);
                    lSomeMarked := true;
                end;
            until ItemList.Next = 0;
            if lSomeMarked then begin
                ItemList.MarkedOnly(true);
                ItemList.DeleteAll;
                ItemList.MarkedOnly(false);
            end;
        end;


        NumberAvailable := ItemList.Count;
    end;

    procedure GetAvailableItemUoMs(var ItemUoMList: Record "Item Unit of Measure" temporary; VarietyNo: Code[5]; ItemNo: Code[20]; ItemUoMFilter: Code[10]) NumberAvailable: Integer
    var
        ItemUoM: Record "Item Unit of Measure";
        UoM: Record "Unit of Measure";
        lSomeMarked: Boolean;
    begin
        NumberAvailable := 0;
        ItemUoMList.Reset;
        ItemUoMList.DeleteAll;


        //gcuWebservices.GetItemUOM(ItemNo, ItemUoMList);

        TranslateUoMCodes(ItemUoMList);


        ItemUoM.Reset;
        ItemUoM.SetRange("Item No.", ItemNo);
        if ItemUoM.FindSet then repeat
                                    if ItemUoMList.Get('', ItemUoM.Code) then
                                        ItemUoMList.Delete;
            until ItemUoM.Next = 0;

        if ItemUoMFilter <> '' then
            ItemUoMList.SetRange(Code, ItemUoMFilter)
        else
            ItemUoMList.SetFilter(Code, '<>%1', '');

        if ItemUoMList.FindSet then begin
            ItemUoMList.ClearMarks;
            lSomeMarked := false;
            repeat
                if gcuBlockingMgt.VarietyItemUoMIsBlocked(VarietyNo, ItemNo, ItemUoMList.Code) then begin
                    ItemUoMList.Mark(true);
                    lSomeMarked := true;
                end;
            until ItemUoMList.Next = 0;
            if lSomeMarked then begin
                ItemUoMList.MarkedOnly(true);
                ItemUoMList.DeleteAll;
                ItemUoMList.MarkedOnly(false);
            end;
        end;


        NumberAvailable := ItemUoMList.Count;
    end;

    procedure GetAvailableVarieties(var VarietyList: Record Varieties temporary) NumberAvailable: Integer
    var
        lrecVariety: Record Varieties;
        ldlgWindow: Dialog;
    begin

        if GuiAllowed then
            ldlgWindow.Open(Text001);

        NumberAvailable := 0;
        VarietyList.Reset;
        VarietyList.DeleteAll;

        lrecVariety.Reset;
        if lrecVariety.FindSet then repeat
                                        if not gcuBlockingMgt.VarietyItemUoMIsBlocked(lrecVariety."No.", '', '') then begin
                                            VarietyList.Init;
                                            VarietyList.TransferFields(lrecVariety, true);
                                            VarietyList.Insert;
                                            NumberAvailable += 1;
                                        end;
            until lrecVariety.Next = 0;

        if GuiAllowed then
            ldlgWindow.Close;

    end;

    local procedure TranslateUoMCodes(var ItemUoMListTEMP: Record "Item Unit of Measure")
    var
        lrecUnitOfMeasure: Record "Unit of Measure";
        lrecItemUoMTranslatedTEMP: Record "Item Unit of Measure" temporary;
        lUoMCode: Code[10];
    begin

        ItemUoMListTEMP.Reset;
        lrecItemUoMTranslatedTEMP.Reset;
        lrecItemUoMTranslatedTEMP.DeleteAll;
        if ItemUoMListTEMP.FindSet then begin
            repeat
                lUoMCode := ItemUoMListTEMP.Code;
                if gcuBejoManagement.FindUoMFromCodeBejoNL(lUoMCode) then begin
                    if not lrecItemUoMTranslatedTEMP.Get(ItemUoMListTEMP."Item No.", lUoMCode) then begin
                        lrecItemUoMTranslatedTEMP.Init;
                        lrecItemUoMTranslatedTEMP.TransferFields(ItemUoMListTEMP, true);
                        lrecItemUoMTranslatedTEMP.Code := lUoMCode;
                        lrecItemUoMTranslatedTEMP.Insert;
                    end;
                end;
            until ItemUoMListTEMP.Next = 0;
            ItemUoMListTEMP.DeleteAll;
            if lrecItemUoMTranslatedTEMP.FindSet then repeat
                                                          ItemUoMListTEMP.TransferFields(lrecItemUoMTranslatedTEMP, true);
                                                          ItemUoMListTEMP.Insert;
                until lrecItemUoMTranslatedTEMP.Next = 0;
            lrecItemUoMTranslatedTEMP.DeleteAll;
        end;

    end;
}

