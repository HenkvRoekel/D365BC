report 50009 "Tool for Prognosis"
{

    Caption = 'Tool for Prognosis';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Prognosis/Allocation Entry"; "Prognosis/Allocation Entry")
        {
            DataItemTableView = WHERE ("Entry Type" = CONST (Prognoses), Adjusted = CONST (false));
            RequestFilterFields = "Item No.", "Unit of Measure", "Sales Date", Salesperson, Customer;

            trigger OnAfterGetRecord()
            begin
                CopyPrognose;
            end;

            trigger OnPreDataItem()
            var
                lrecPrognosisAllocation: Record "Prognosis/Allocation Entry";
            begin
                lrecPrognosisAllocation.FindLast;
                "Prognosis/Allocation Entry".SetRange("Internal Entry No.", 0, lrecPrognosisAllocation."Internal Entry No.");
                gEntryNo := lrecPrognosisAllocation."Internal Entry No.";
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
                    field("grecNewItemNo.""No."""; grecNewItemNo."No.")
                    {
                        Caption = 'New Item No.';
                        TableRelation = Item;
                        ApplicationArea = All;
                    }
                    field(gMultiplicator; gMultiplicator)
                    {
                        Caption = 'Multiplicator %';
                        DecimalPlaces = 0 : 2;
                        MaxValue = 100;
                        MinValue = 1;
                        ApplicationArea = All;
                    }
                    field(gRestOriginal; gRestOriginal)
                    {
                        Caption = 'Rest Stay in Original Item No.';
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

    trigger OnPreReport()
    begin
        if "Prognosis/Allocation Entry".GetRangeMin("Item No.") = '' then
            Error(Text50000);

        if "Prognosis/Allocation Entry".GetRangeMin("Sales Date") = 0D then

            Error(Text50001);
    end;

    var
        grecNewItemNo: Record Item;
        gMultiplicator: Decimal;
        gRestOriginal: Boolean;
        Text50000: Label 'Item No. must not be empty.';
        Text50001: Label 'DateFilter must not be empty.';
        Text50003: Label 'Item Unit of Measure for item %1 not available.';
        gEntryNo: Integer;

    procedure CopyPrognose()
    var
        lrecPrognosisAllocation: Record "Prognosis/Allocation Entry";
        lrecItemUnitofMeasure: Record "Item Unit of Measure";
        lrecUOM: Record "Unit of Measure";
    begin
        lrecPrognosisAllocation.Init;
        lrecPrognosisAllocation.CopyFilters("Prognosis/Allocation Entry");
        if grecNewItemNo."No." <> '' then begin // Copy prognose
            lrecItemUnitofMeasure.Init;

            lrecItemUnitofMeasure.SetRange("Item No.", grecNewItemNo."No.");

            lrecItemUnitofMeasure.SetRange(Code, "Prognosis/Allocation Entry"."Unit of Measure");
            if not lrecItemUnitofMeasure.FindFirst then
                Error(Text50003, grecNewItemNo."No.");
            gEntryNo := gEntryNo + 1;
            lrecPrognosisAllocation.Init;
            lrecPrognosisAllocation := "Prognosis/Allocation Entry";
            lrecPrognosisAllocation."Internal Entry No." := gEntryNo;
            lrecPrognosisAllocation."Item No." := grecNewItemNo."No.";
            lrecPrognosisAllocation."Date Modified" := Today;
            lrecPrognosisAllocation."User-ID" := UserId;


            lrecUOM.Get(lrecItemUnitofMeasure.Code);
            if lrecUOM."B Unit in Weight" then
                lrecPrognosisAllocation.Prognoses := Round(((gMultiplicator / 100) * "Prognosis/Allocation Entry".Prognoses)
                / lrecItemUnitofMeasure."Qty. per Unit of Measure", 1, '>') * lrecItemUnitofMeasure."Qty. per Unit of Measure"
            else
                lrecPrognosisAllocation.Prognoses := Round((((gMultiplicator / 100) * "Prognosis/Allocation Entry".Prognoses) * 1000000)
                  / lrecItemUnitofMeasure."Qty. per Unit of Measure", 1, '>') * (lrecItemUnitofMeasure."Qty. per Unit of Measure" / 1000000);

            lrecPrognosisAllocation.Insert;

            gEntryNo := gEntryNo + 1;
            lrecPrognosisAllocation.Init;
            lrecPrognosisAllocation := "Prognosis/Allocation Entry";
            lrecPrognosisAllocation."Internal Entry No." := gEntryNo;
            lrecPrognosisAllocation."Date Modified" := Today;
            lrecPrognosisAllocation."User-ID" := UserId;


            if lrecUOM."B Unit in Weight" then
                lrecPrognosisAllocation.Prognoses := Round(((((100 - gMultiplicator) / 100) * "Prognosis/Allocation Entry".Prognoses)
                  / lrecItemUnitofMeasure."Qty. per Unit of Measure"), 1, '>') * (lrecItemUnitofMeasure."Qty. per Unit of Measure")
            else
                lrecPrognosisAllocation.Prognoses := Round(((((100 - gMultiplicator) / 100) * "Prognosis/Allocation Entry".Prognoses)
                  * 1000000)
                  / lrecItemUnitofMeasure."Qty. per Unit of Measure", 1, '>') * (lrecItemUnitofMeasure."Qty. per Unit of Measure" / 1000000);


            lrecPrognosisAllocation.Prognoses := -("Prognosis/Allocation Entry".Prognoses - lrecPrognosisAllocation.Prognoses);


            if (not gRestOriginal) or (gMultiplicator = 100) then

                lrecPrognosisAllocation.Prognoses := -("Prognosis/Allocation Entry".Prognoses);
            lrecPrognosisAllocation.Insert;

        end else begin // Delete prognose
            gEntryNo := gEntryNo + 1;
            lrecPrognosisAllocation.Init;
            lrecPrognosisAllocation := "Prognosis/Allocation Entry";
            lrecPrognosisAllocation."Internal Entry No." := gEntryNo;
            lrecPrognosisAllocation."Date Modified" := Today;
            lrecPrognosisAllocation."User-ID" := UserId;

            lrecItemUnitofMeasure.SetRange("Item No.", grecNewItemNo."No.");
            lrecItemUnitofMeasure.SetRange(Code, "Prognosis/Allocation Entry"."Unit of Measure");
            if not lrecItemUnitofMeasure.FindFirst then
                Error(Text50003, grecNewItemNo."No.");
            lrecUOM.Get(lrecItemUnitofMeasure.Code);
            if lrecUOM."B Unit in Weight" then
                lrecPrognosisAllocation.Prognoses := -Round(((gMultiplicator / 100) * "Prognosis/Allocation Entry".Prognoses)
                  / lrecItemUnitofMeasure."Qty. per Unit of Measure", 1, '>') * lrecItemUnitofMeasure."Qty. per Unit of Measure"
            else
                lrecPrognosisAllocation.Prognoses := -Round((((gMultiplicator / 100) * "Prognosis/Allocation Entry".Prognoses) * 1000000)
                  / lrecItemUnitofMeasure."Qty. per Unit of Measure", 1, '>') * (lrecItemUnitofMeasure."Qty. per Unit of Measure" / 1000000);


            lrecPrognosisAllocation.Insert;

        end;
    end;
}

