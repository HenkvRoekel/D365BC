codeunit 50017 "Localisation Codeunit"
{

    trigger OnRun()
    begin
    end;

    procedure R50072_GetComment(LotNo: Code[20]; var TheText: array[5] of Text[80]; var TheDate: array[5] of Date)
    var
        i: Integer;
        ItemTrackComment: Record "Item Tracking Comment";
    begin
        i := 0;

        ItemTrackComment.SetCurrentKey(Type, "Item No.", "Variant Code", "Serial/Lot No.");
        ItemTrackComment.SetRange(Type, ItemTrackComment.Type::"Lot No.");
        ItemTrackComment.SetRange("Serial/Lot No.", LotNo);
        if ItemTrackComment.FindFirst then repeat

                                               i += 1;
                                               TheText[i] := ItemTrackComment.Comment;
                                               TheDate[i] := ItemTrackComment.Date;

            until (ItemTrackComment.Next = 0) or (i = 3);
    end;

    procedure P50003_ShowItemTrackingForMasterData(SourceType: Option " ",Customer,Vendor,Item; SourceNo: Code[20]; ItemNo: Code[20]; VariantCode: Code[20]; SerialNo: Code[20]; LotNo: Code[20]; LocationCode: Code[10])
    var
        ItemTrackingDocMgt: Codeunit "Item Tracking Doc. Management";
    begin
        ItemTrackingDocMgt.ShowItemTrackingForMasterData(0, '', ItemNo, VariantCode, '', LotNo, '');
    end;

    procedure P50003_ShowItemTrackingComments(LotNoInf: Record "Lot No. Information")
    var
        ItemTrackingComments: Page "Item Tracking Comments";
        ItemTrackingComment: Record "Item Tracking Comment";
    begin
        ItemTrackingComment.SetRange(Type, ItemTrackingComment.Type::"Lot No.");
        ItemTrackingComment.SetRange("Item No.", LotNoInf."Item No.");
        ItemTrackingComment.SetRange("Variant Code", LotNoInf."Variant Code");
        ItemTrackingComment.SetRange("Serial/Lot No.", LotNoInf."Lot No.");
        ItemTrackingComments.SetTableView(ItemTrackingComment);
        ItemTrackingComments.Run;
    end;
}

