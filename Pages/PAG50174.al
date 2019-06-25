page 50174 "Scan Lot Info"
{

    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    RefreshOnActivate = true;
    ShowFilter = false;

    layout
    {
        area(content)
        {
            field(LotNo; LotNo)
            {
                Caption = 'Lot  No.';
                ApplicationArea = All;

                trigger OnValidate()
                var
                    TmpWhseBin: Record Bin temporary;
                    TmpBin: Record Bin temporary;
                    ctxtUnknownLot: Label 'Lot %1 not found';
                    ILEUnitOfMeasureCode: Code[10];
                    ILEUnitQtyPerOfMeasure: Decimal;
                    WarehouseEntry: Record "Warehouse Entry";
                    LocationCode: Code[20];
                begin
                    Descriptions := '';

                    if LotNo <> '' then begin

                        LotNoInf.Reset;
                        LotNoInf.SetFilter("Lot No.", StrSubstNo('%1%2', LotNo, '*'));
                        if not LotNoInf.FindSet then begin
                            Clear(LotNoInf);
                            InfoMessage := StrSubstNo(ctxtUnknownLot, LotNo);
                            LotNo := '';
                            Bins := '';

                        end else begin

                            repeat

                                InfoMessage := '';

                                LotNoInf.CalcFields("B Description 1", "B Description 2");

                                TmpWhseBin.DeleteAll;
                                TmpBin.DeleteAll;
                                Bins := '';

                                WarehouseEntry.Reset;
                                WarehouseEntry.SetCurrentKey("Lot No.");
                                WarehouseEntry.SetRange("Lot No.", LotNoInf."Lot No.");
                                if WarehouseEntry.FindSet then repeat

                                                                   if not TmpWhseBin.Get(WarehouseEntry."Location Code", WarehouseEntry."Bin Code") then begin

                                                                       TmpWhseBin.Init;
                                                                       TmpWhseBin."Location Code" := WarehouseEntry."Location Code";
                                                                       TmpWhseBin.Code := WarehouseEntry."Bin Code";
                                                                       if TmpWhseBin.Insert then;

                                                                       BinContent.SetRange("Location Code", WarehouseEntry."Location Code");
                                                                       BinContent.SetRange("Bin Code", WarehouseEntry."Bin Code");
                                                                       BinContent.SetRange("Item No.", LotNoInf."Item No.");
                                                                       if BinContent.FindFirst then begin
                                                                           BinContent.SetFilter("Lot No. Filter", WarehouseEntry."Lot No.");
                                                                           BinContent.CalcFields(Quantity);
                                                                           if BinContent.Quantity > 0 then begin

                                                                               TmpBin.Init;
                                                                               TmpBin."Location Code" := BinContent."Location Code";
                                                                               TmpBin.Code := BinContent."Bin Code";
                                                                               if TmpBin.Insert then;

                                                                           end;
                                                                       end;

                                                                   end;

                                    until WarehouseEntry.Next = 0;

                                LocationCode := '';
                                TmpBin.SetCurrentKey("Location Code", Code);
                                if TmpBin.FindSet then repeat

                                                           if LocationCode <> TmpBin."Location Code" then begin
                                                               if Bins = '' then
                                                                   Bins := TmpBin."Location Code" + '-' + TmpBin.Code
                                                               else
                                                                   Bins += ', ' + TmpBin."Location Code" + '-' + TmpBin.Code;
                                                           end else begin
                                                               if Bins = '' then
                                                                   Bins := TmpBin.Code
                                                               else
                                                                   Bins += ', ' + TmpBin.Code;
                                                           end;
                                                           LocationCode := TmpBin."Location Code";

                                    until TmpBin.Next = 0;

                                LotNoInf.CalcFields(Inventory);
                                GetUOM(LotNoInf, ILEUnitOfMeasureCode, ILEUnitQtyPerOfMeasure);

                                if Descriptions = '' then begin
                                    if LotNoInf."Lot No." <> '' then
                                        Descriptions := LotNoInf."Lot No." + ' (' + ILEUnitOfMeasureCode + ')';
                                end else begin
                                    if LotNoInf."Lot No." <> '' then
                                        Descriptions := StrSubstNo('%1\%2', Descriptions, LotNoInf."Lot No." + ' (' + ILEUnitOfMeasureCode + ')');
                                end;

                                if LotNoInf."B Description 1" <> '' then
                                    Descriptions := StrSubstNo('%1 %2', Descriptions, LotNoInf."B Description 1");

                                if LotNoInf."B Description 2" <> '' then
                                    Descriptions := StrSubstNo('%1\%2', Descriptions, LotNoInf."B Description 2");

                                if Bins <> '' then
                                    Descriptions := StrSubstNo('%1\%2', Descriptions, Bins);

                                if LotNoInf.Inventory <> 0 then begin
                                    if ILEUnitQtyPerOfMeasure <> 0 then
                                        Descriptions := StrSubstNo('%1 (%2)', Descriptions, LotNoInf.Inventory / ILEUnitQtyPerOfMeasure);
                                end;

                            until LotNoInf.Next = 0;

                        end;

                    end else begin
                        Clear(LotNoInf);
                        InfoMessage := '';
                        LotNo := '';
                        Bins := '';
                        Descriptions := '';
                    end;

                    if InfoMessage <> '' then
                        Descriptions := InfoMessage;

                    LotNo := '';

                    CurrPage.Update(false);
                end;
            }
            field(Descriptions; Descriptions)
            {

                Editable = false;
                MultiLine = true;
                Style = Unfavorable;
                StyleExpr = InfoMessage <> '';
                ApplicationArea = All;

            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        CurrPage.Editable := true;
        CurrPage.Update(false);
    end;

    var
        LotNo: Code[20];
        LotNoInf: Record "Lot No. Information";
        Bin: Record Bin;
        BinContent: Record "Bin Content";
        Bins: Text;
        InfoMessage: Text[250];
        Descriptions: Text;

    local procedure GetUOM(var TheLotNoInf: Record "Lot No. Information"; var ILEUnitOfMeasureCode: Code[10]; var ILEUnitQtyPerOfMeasure: Decimal): Boolean
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
    begin
        ItemLedgerEntry.SetCurrentKey("Item No.", "Variant Code", Open);
        ItemLedgerEntry.SetRange("Item No.", TheLotNoInf."Item No.");
        ItemLedgerEntry.SetRange(Open, true);
        ItemLedgerEntry.SetRange("Lot No.", TheLotNoInf."Lot No.");
        if ItemLedgerEntry.FindFirst then begin
            ILEUnitOfMeasureCode := ItemLedgerEntry."Unit of Measure Code";
            ILEUnitQtyPerOfMeasure := ItemLedgerEntry."Qty. per Unit of Measure";
            exit(true);
        end;

        exit(false);
    end;
}

