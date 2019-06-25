page 50019 "Stock Information sub 1"
{

    Caption = 'Stock Information sub 1';
    PageType = List;
    SourceTable = "Lot No. Information";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Item No."; "Item No.")
                {
                    ApplicationArea = All;
                }
                field("grecItem1.""Description 2"""; grecItem1."Description 2")
                {
                    Caption = 'Description 2';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("grecItemExtension.""Extension Code"""; grecItemExtension."Extension Code")
                {
                    Caption = 'Description 3';
                    ApplicationArea = All;
                }
                field("B Qty. per Unit of Measure"; "B Qty. per Unit of Measure")
                {
                    DecimalPlaces = 0 : 3;
                    ApplicationArea = All;
                }
                field(gOpenStock; gOpenStock)
                {
                    BlankZero = true;
                    Caption = 'Units available';
                    DecimalPlaces = 0 : 0;
                    ApplicationArea = All;
                }
                field(gTotalStock; gTotalStock)
                {
                    BlankZero = true;
                    Caption = 'Total available';
                    DecimalPlaces = 3 : 3;
                    ApplicationArea = All;
                }
                field("Lot No."; "Lot No.")
                {
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin

                        grecLotNoInformation.SetRange("Lot No.", "Lot No.");

                        PAGE.RunModal(50003, grecLotNoInformation);

                    end;
                }
                field("B Germination"; "B Germination")
                {
                    ApplicationArea = All;
                }
                field("B Tsw. in gr."; "B Tsw. in gr.")
                {
                    ApplicationArea = All;
                }
                field(Bestusedby; "B Best used by")
                {
                    StyleExpr = StyleTxt;
                    ApplicationArea = All;
                }
                field("B Tracking Quantity"; "B Tracking Quantity")
                {
                    BlankZero = true;
                    Caption = 'Tracking Qty.';
                    ApplicationArea = All;
                }
                field(gOpenOrder; gOpenOrder)
                {
                    BlankZero = true;
                    Caption = 'In Sales Order';
                    DecimalPlaces = 3 : 3;
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin
                        if not grecSalesLine1.SetCurrentKey("Document Type", Type, "No.") then
                            grecSalesLine1.SetCurrentKey("Document Type", Type, "B Line type", "No.");

                        grecSalesLine1.SetRange("Document Type", grecSalesLine1."Document Type"::Order);
                        grecSalesLine1.SetRange(Type, grecSalesLine1.Type::Item);
                        grecSalesLine1.SetRange("No.", "Item No.");

                        grecSalesLine1.SetRange("B Lot No.", Rec."Lot No.");
                        if Rec."B ILEUnitOfMeasureCode" <> '' then begin
                            grecSalesLine1.SetRange("Unit of Measure Code", Rec."B ILEUnitOfMeasureCode");
                        end;

                        PAGE.RunModal(50066, grecSalesLine1);
                    end;
                }
                field(gDecOpenBlanketOrder; gDecOpenBlanketOrder)
                {
                    BlankZero = true;
                    Caption = 'In Blanket Order';
                    DecimalPlaces = 3 : 3;
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin

                        if not grecSalesLine.SetCurrentKey("Document Type", Type, "No.") then
                            grecSalesLine.SetCurrentKey("Document Type", Type, "B Line type", "No.");
                        grecSalesLine.SetRange("Document Type", grecSalesLine."Document Type"::"Blanket Order");
                        grecSalesLine.SetRange(Type, grecSalesLine.Type::Item);
                        grecSalesLine.SetRange("No.", "Item No.");
                        PAGE.RunModal(50066, grecSalesLine);

                    end;
                }
                field(gPhysStock; gPhysStock)
                {
                    BlankZero = true;
                    Caption = 'Inventory';
                    DecimalPlaces = 0 : 0;
                    ApplicationArea = All;
                }
                field(gRest; gRest)
                {
                    BlankZero = true;
                    Caption = 'Remaining Quantity';
                    DecimalPlaces = 3 : 3;
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin

                        grecBincontent.Reset;
                        grecBincontent.SetRange("Item No.", "Item No.");
                        grecBincontent.SetFilter("Lot No. Filter", "Lot No.");
                        grecBincontent.SetFilter(Quantity, '>0');
                        PAGE.RunModal(50024, grecBincontent);

                    end;
                }
                field(BLocation; BLocation)
                {
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin

                        grecBincontent.Reset;
                        grecBincontent.SetRange("Item No.", "Item No.");
                        grecBincontent.SetFilter("Lot No. Filter", "Lot No.");
                        grecBincontent.SetFilter(Quantity, '>0');
                        PAGE.RunModal(50024, grecBincontent);

                    end;
                }
                field("B Bin"; "B Bin")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("B Remark"; "B Remark")
                {
                    ApplicationArea = All;
                }
                field(gCommentLine; gCommentLine)
                {
                    ApplicationArea = All;

                    Caption = 'Comment';

                    trigger OnDrillDown()
                    begin
                        grecCommentLine.Init;
                        grecCommentLine.SetRange("Table Name", grecCommentLine."Table Name"::Item);
                        grecCommentLine.SetRange("No.", "Item No.");

                        PAGE.RunModal(50091, grecCommentLine);
                    end;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    var
        lrecItemLedgerEntry: Record "Item Ledger Entry";
    begin

        gDatePageula1 := grecBejoSetup."Best Used By in Red";
        gCalculatedTBT1 := CalcDate(gDatePageula1, Today);

        gDatePageula2 := grecBejoSetup."Best Used By in Blue";
        gCalculatedTBT2 := CalcDate(gDatePageula2, Today);
        gOpenOrder := 0;
        gDecOpenBlanketOrder := 0;

        CalcFields("B Qty. per Unit of Measure", Inventory);
        if "B Qty. per Unit of Measure" = 0 then
            "B Qty. per Unit of Measure" := 1;


        lrecItemLedgerEntry.SetCurrentKey("Item No.", "Variant Code", Open);
        lrecItemLedgerEntry.SetRange("Item No.", Rec."Item No.");
        lrecItemLedgerEntry.SetRange(Open, true);
        lrecItemLedgerEntry.SetRange("Lot No.", Rec."Lot No.");
        if lrecItemLedgerEntry.FindFirst then begin
            "B ILEUnitOfMeasureCode" := lrecItemLedgerEntry."Unit of Measure Code";
            "B ILEUnitQtyPerOfMeasure" := lrecItemLedgerEntry."Qty. per Unit of Measure";
        end;


        gOpenStock := ((Inventory + "B Tracking Quantity") / "B Qty. per Unit of Measure");
        gPhysStock := Inventory / "B Qty. per Unit of Measure";

        if not gRecItem.Get("Item No.") then
            gRecItem.Init;

        if not gRecUnitofMeasure.Get(gRecItem."Base Unit of Measure") then
            gRecUnitofMeasure.Init;


        if gRecUnitofMeasure."B Unit in Weight" = false then begin

            gTotalStock := (Inventory + "B Tracking Quantity") / 1000000;
            gRest := Inventory / 1000000;
        end else begin
            gTotalStock := (Inventory + "B Tracking Quantity");
            gRest := Inventory;
        end;


        grecSalesLine.SetCurrentKey("Document Type", grecSalesLine.Type, grecSalesLine."No.");
        grecSalesLine.SetRange("Document Type", grecSalesLine."Document Type"::Order);
        grecSalesLine.SetRange(Type, grecSalesLine.Type::Item);
        grecSalesLine.SetRange("No.", "Item No.");

        grecSalesLine.SetRange("B Lot No.", Rec."Lot No.");
        if Rec."B ILEUnitOfMeasureCode" <> '' then begin
            grecSalesLine.SetRange("Unit of Measure Code", Rec."B ILEUnitOfMeasureCode");
        end;

        if grecSalesLine.FindSet then
            repeat
                gOpenOrder := gOpenOrder + grecSalesLine."Outstanding Qty. (Base)";
            until grecSalesLine.Next = 0;


        grecSalesLine.SetCurrentKey("Document Type", grecSalesLine.Type, grecSalesLine."No.");
        grecSalesLine.SetRange("Document Type", grecSalesLine."Document Type"::"Blanket Order");
        grecSalesLine.SetRange(Type, grecSalesLine.Type::Item);
        grecSalesLine.SetRange("No.", "Item No.");
        if grecSalesLine.FindSet then
            repeat

                gDecOpenBlanketOrder := gDecOpenBlanketOrder + grecSalesLine."Outstanding Qty. (Base)";

            until grecSalesLine.Next = 0;


        "B Tracking Quantity" := -"B Tracking Quantity";
        if not grecUnitofMeasure1.Get(grecSalesLine."Unit of Measure Code") then
            grecUnitofMeasure1.Init;
        if grecUnitofMeasure1."B Unit in Weight" = false then begin
            gOpenOrder := gOpenOrder / 1000000;
            gDecOpenBlanketOrder := gDecOpenBlanketOrder / 1000000;
            "B Tracking Quantity" := "B Tracking Quantity" / 1000000;
        end;

        grecCommentLine.Init;
        grecCommentLine.SetRange("Table Name", grecCommentLine."Table Name"::Item);
        grecCommentLine.SetRange("No.", "Item No.");
        if grecCommentLine.FindFirst then
            gCommentLine := true
        else
            gCommentLine := false;

        if not grecItem1.Get("Item No.") then
            grecItem1.Init;
        if not grecItemExtension.Get(grecItem1."B Extension", '') then
            grecItemExtension.Init;


        grecBincontent.Reset;
        grecBincontent.SetRange("Item No.", "Item No.");
        grecBincontent.SetFilter("Lot No. Filter", "Lot No.");
        grecBincontent.SetFilter(Quantity, '>0');


        gNoBins := grecBincontent.Count;


        if not grecBincontent.FindFirst then
            grecBincontent.Init;

        "B Bin" := grecBincontent."Bin Code";

        BLocation := grecBincontent."Location Code";

        BestusedbyOnPageat;
        LocationOnPageat;
        BinOnPageat;

        StyleTxt := GetColor;
    end;

    trigger OnInit()
    begin
        grecBejoSetup.Get;
    end;

    var
        gOpenStock: Decimal;
        gTotalStock: Decimal;
        gPhysStock: Decimal;
        grecSalesLine: Record "Sales Line";
        gOpenOrder: Decimal;
        grecSalesLine1: Record "Sales Line";
        gCalculatedTBT1: Date;
        gCalculatedTBT2: Date;
        gDatePageula1: Code[10];
        gDatePageula2: Code[10];
        grecUnitofMeasure1: Record "Unit of Measure";
        gCommentLine: Boolean;
        grecCommentLine: Record "Comment Line";
        grecLotNoInformation: Record "Lot No. Information";
        gRest: Decimal;
        grecItem1: Record Item;
        grecItemExtension: Record "Item Extension";
        gNoBins: Decimal;
        grecBincontent: Record "Bin Content";
        grecBejoSetup: Record "Bejo Setup";
        gRecItem: Record Item;
        gRecUnitofMeasure: Record "Unit of Measure";
        gDecOpenBlanketOrder: Decimal;
        StyleTxt: Text;

    local procedure BestusedbyOnPageat()
    begin
        if ("B Best used by" <> 0D) and ("B Best used by" < gCalculatedTBT2) then;
        if ("B Best used by" <> 0D) and ("B Best used by" < gCalculatedTBT1) then;
    end;

    local procedure LocationOnPageat()
    begin

        if (gNoBins > 1) then;
    end;

    local procedure BinOnPageat()
    begin
        if (gNoBins > 1) then;
    end;

    local procedure GetColor(): Text
    var
        retval: Text;
    begin

        retval := 'Standard';
        if ("B Best used by" <> 0D) and ("B Best used by" < gCalculatedTBT2) then
            retval := 'StandardAccent';
        if ("B Best used by" <> 0D) and ("B Best used by" < gCalculatedTBT1) then
            retval := 'Attention';
        exit(retval);

    end;
}

