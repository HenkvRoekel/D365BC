report 50087 "Calculate Inventory Bejo"
{

    Caption = 'Calculate Inventory Bejo';
    ProcessingOnly = true;

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = SORTING ("No.") WHERE (Type = CONST (Inventory), Blocked = CONST (false));
            RequestFilterFields = "No.";
            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                CalcFields = "Reserved Quantity";
                DataItemLink = "Item No." = FIELD ("No.");
                DataItemTableView = SORTING ("Item No.", "Lot No.", Open) WHERE (Open = CONST (true));
                RequestFilterFields = "Location Code";

                trigger OnAfterGetRecord()
                var
                    lrecItemJnl: Record "Item Journal Line";
                begin

                    if ("Item Ledger Entry"."Remaining Quantity" <> 0) and ("Item Ledger Entry".Open = true) then begin
                        lrecItemJnl.SetRange("Posting Date", BoekDatum);
                        lrecItemJnl.SetRange("Document No.", gDocumentNo);
                        lrecItemJnl.SetRange("Location Code", "Location Code");
                        lrecItemJnl.SetRange("Item No.", "Item No.");
                        lrecItemJnl.SetRange("Lot No.", "Lot No.");
                        if lrecItemJnl.FindFirst then exit;

                        VolgRegelNr := VolgRegelNr + 10000;
                        grecItemJnlLine.Init;
                        grecItemJnlLine."Line No." := VolgRegelNr;
                        grecItemJnlLine.Validate("Posting Date", BoekDatum);
                        grecItemJnlLine.Validate("Entry Type", "Entry Type"::"Positive Adjmt.");
                        grecItemJnlLine.Validate("Document No.", gDocumentNo);
                        grecItemJnlLine.Validate("Item No.", "Item Ledger Entry"."Item No.");
                        grecItemJnlLine.Validate("Location Code", "Item Ledger Entry"."Location Code");
                        grecItemJnlLine.Validate("Source Code", grecSourceCodeSetup."Phys. Inventory Journal");
                        grecItemJnlLine."Phys. Inventory" := true;
                        grecItemJnlLine.Validate("Unit Amount", 0);


                        grecItemJnlLine."Lot No." := "Item Ledger Entry"."Lot No.";
                        grecItemJnlLine."B Line type" := "Item Ledger Entry"."B Line type";

                        WarehouseEntry.Reset;
                        WarehouseEntry.SetRange("Item No.", "Item No.");
                        WarehouseEntry.SetRange("Lot No.", "Lot No.");
                        WarehouseEntry.SetRange("Location Code", "Item Ledger Entry"."Location Code");

                        Aantalposten := WarehouseEntry.Count;
                        if WarehouseEntry.Find('-') then
                            repeat
                                grecItemJnlLine."Qty. (Phys. Inventory)" := WarehouseEntry.Quantity / "Item Ledger Entry"."Qty. per Unit of Measure";
                                grecItemJnlLine."Phys. Inventory" := true;
                                grecItemJnlLine.Validate("Qty. (Calculated)", WarehouseEntry.Quantity / "Item Ledger Entry"."Qty. per Unit of Measure");
                                grecItemJnlLine.Validate("Unit Amount", 0);
                                grecItemJnlLine."Qty. per Unit of Measure" := "Item Ledger Entry"."Qty. per Unit of Measure";
                                grecItemJnlLine."Unit of Measure Code" := "Item Ledger Entry"."Unit of Measure Code";
                                grecItemJnlLine."Line No." := VolgRegelNr;
                                grecItemJnlLine."Bin Code" := WarehouseEntry."Bin Code";
                                grecItemJnlLine."Quantity (Base)" := (grecItemJnlLine."Qty. (Phys. Inventory)" * "Item Ledger Entry"."Qty. per Unit of Measure"); // PB EOSS

                                grecItemJnlLine2.Reset;
                                grecItemJnlLine2.SetRange("Posting Date", BoekDatum);
                                grecItemJnlLine2.SetRange("Document No.", gDocumentNo);
                                grecItemJnlLine2.SetRange("Item No.", "Item No.");
                                grecItemJnlLine2.SetRange("Lot No.", "Lot No.");
                                grecItemJnlLine2.SetRange("Bin Code", WarehouseEntry."Bin Code");
                                if not grecItemJnlLine2.Find('-') then begin
                                    VolgRegelNr := VolgRegelNr + 10000;
                                    if grecItemJnlLine."Qty. (Calculated)" <> 0 then begin
                                        grecItemJnlLine.Insert;
                                    end;
                                end else begin
                                    grecItemJnlLine2."Qty. (Phys. Inventory)" := grecItemJnlLine2."Qty. (Phys. Inventory)" +
                                                                              (WarehouseEntry.Quantity / "Item Ledger Entry"."Qty. per Unit of Measure");
                                    grecItemJnlLine2.Validate("Qty. (Calculated)", grecItemJnlLine2."Qty. (Calculated)" +
                                                          (WarehouseEntry.Quantity / "Item Ledger Entry"."Qty. per Unit of Measure"));
                                    grecItemJnlLine2."Qty. per Unit of Measure" := "Item Ledger Entry"."Qty. per Unit of Measure";
                                    grecItemJnlLine2."Unit of Measure Code" := "Item Ledger Entry"."Unit of Measure Code";
                                    grecItemJnlLine2."Quantity (Base)" := (grecItemJnlLine2."Qty. (Phys. Inventory)" * "Item Ledger Entry"."Qty. per Unit of Measure"); // PB EOSS
                                    grecItemJnlLine2.Modify;
                                end;
                            until WarehouseEntry.Next = 0;

                    end;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Venster.Update;
            end;

            trigger OnPreDataItem()
            var
                ArtDagbSjabloon: Record "Item Journal Template";
            begin
                if BoekDatum = 0D then
                    Error(text50000);

                ArtDagbSjabloon.Get(grecItemJnlLine."Journal Template Name");
                grecItemJnlBatch.Get(grecItemJnlLine."Journal Template Name", grecItemJnlLine."Journal Batch Name");
                if gDocumentNo = '' then begin
                    if grecItemJnlBatch."No. Series" <> '' then begin
                        grecItemJnlLine.SetRange("Journal Template Name", grecItemJnlLine."Journal Template Name");
                        grecItemJnlLine.SetRange("Journal Batch Name", grecItemJnlLine."Journal Batch Name");
                        if not grecItemJnlLine.Find('-') then
                            gDocumentNo := gcuNoSeriesMgt.GetNextNo(grecItemJnlBatch."No. Series", BoekDatum, false);
                        grecItemJnlLine.Init;
                    end;
                    if gDocumentNo = '' then
                        Error(text50001);
                end;

                grecItemJnlLine1.SetRange("Journal Template Name", ArtDagbSjabloon.Name);
                grecItemJnlLine1.SetRange("Journal Batch Name", grecItemJnlBatch.Name);
                if grecItemJnlLine1.Find('+') then
                    VolgRegelNr := grecItemJnlLine1."Line No.";

                grecSourceCodeSetup.Get;

                Venster.Open(text50002 + '   #1##########', Item."No.");
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(BoekDatum; BoekDatum)
                    {
                        Caption = 'Posting Date';
                        ApplicationArea = All;
                    }
                    field(gDocumentNo; gDocumentNo)
                    {
                        Caption = 'Document No.';
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    var
        lrecItemJnlBejo: Record "EOSS Journal Line";
        lrecItemJnlLine: Record "Item Journal Line";
    begin
        grecItemJnlLine1.SetRange("Journal Template Name", grecItemJnlLine."Journal Template Name");
        grecItemJnlLine1.SetRange("Journal Batch Name", grecItemJnlLine."Journal Batch Name");
        grecItemJnlLine1.SetRange(grecItemJnlLine1."Qty. (Calculated)", 0);
        grecItemJnlLine1.DeleteAll;
    end;

    trigger OnPreReport()
    var
        lcuBejoEvents: Codeunit "Bejo Trade Add-On Events";
    begin
        lcuBejoEvents.GetCurrentItemJnlRecord(grecItemJnlLine);
        SetItemJnlLine(grecItemJnlLine);
    end;

    var
        grecItemJnlBatch: Record "Item Journal Batch";
        grecItemJnlLine: Record "Item Journal Line";
        grecItemJnlLine1: Record "Item Journal Line";
        grecItemJnlLine2: Record "Item Journal Line";
        WarehouseEntry: Record "Warehouse Entry";
        grecSourceCodeSetup: Record "Source Code Setup";
        gcuNoSeriesMgt: Codeunit NoSeriesManagement;
        Venster: Dialog;
        BoekDatum: Date;
        gDocumentNo: Code[20];
        VolgRegelNr: Integer;
        PerKostenpl: Boolean;
        PerKostendr: Boolean;
        PerLocatie: Boolean;
        PerSchap: Boolean;
        NulAant: Boolean;
        Aantalposten: Integer;
        text50000: Label 'You must enter a Posting Date.';
        text50001: Label 'You must enter the Document No.';
        text50002: Label 'Item No.';

    local procedure SetItemJnlLine(var NweArtDagbRegel: Record "Item Journal Line")
    begin
        grecItemJnlLine := NweArtDagbRegel;
        grecItemJnlLine."Phys. Inventory" := false;
    end;

    local procedure CheckBookDate()
    begin
        grecItemJnlBatch.Get(grecItemJnlLine."Journal Template Name", grecItemJnlLine."Journal Batch Name");
        if grecItemJnlBatch."No. Series" = '' then
            gDocumentNo := ''
        else begin
            gDocumentNo := gcuNoSeriesMgt.GetNextNo(grecItemJnlBatch."No. Series", BoekDatum, false);
            Clear(gcuNoSeriesMgt);
        end;
    end;

    local procedure InsertItemJnlLine()
    begin
    end;

    local procedure InitialiseSeletion(NweBoekDatum: Date; Stuknr: Code[20]; ArtNietInVoorraad: Boolean; PerKostenpl2: Boolean; PerKostendr2: Boolean; PerLocatie2: Boolean; PerSchap2: Boolean)
    begin
        BoekDatum := NweBoekDatum;
        gDocumentNo := Stuknr;
        NulAant := ArtNietInVoorraad;
        PerKostenpl := PerKostenpl2;
        PerKostendr := PerKostendr2;
        PerLocatie := PerLocatie2;
        PerSchap := PerSchap2;
    end;
}

