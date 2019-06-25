report 50088 "Create Credit Memo"
{


    Caption = 'Create Credit Memo';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Item Journal Line"; "Item Journal Line")
        {

            trigger OnAfterGetRecord()
            begin
                Nr := Nr + 10000;
                Inkoopregel.Init;
                Inkoopregel.Validate("Document Type", Inkoopkop."Document Type");
                Inkoopregel.Validate("Document No.", Inkoopkop."No.");
                Inkoopregel.Validate("Line No.", Nr);
                Inkoopregel.Validate("Buy-from Vendor No.", Inkoopkop."Buy-from Vendor No.");
                Inkoopregel.Validate(Type, Inkoopregel.Type::Item);
                Inkoopregel.Validate("No.", "Item Journal Line"."Item No.");
                Inkoopregel."B Line type" := "Item Journal Line"."B Line type";
                if Inkoopregel."B Line type" <> 0 then begin
                    Inkoopregel.Validate(Inkoopregel."Direct Unit Cost", 0);
                end;
                if "Item Journal Line"."Qty. per Unit of Measure" = 0 then
                    "Item Journal Line"."Qty. per Unit of Measure" := 1;
                Inkoopregel.Validate(Quantity, "Item Journal Line"."Qty. (Calculated)");
                Inkoopregel.Validate("Unit of Measure Code", "Item Journal Line"."Unit of Measure Code");
                Inkoopregel.Validate("Expected Receipt Date", Inkoopkop."Expected Receipt Date");
                Inkoopregel."Location Code" := "Item Journal Line"."Location Code";
                Inkoopregel."Bin Code" := "Item Journal Line"."Bin Code";
                Inkoopregel."Appl.-to Item Entry" := "Item Journal Line"."Applies-to Entry";
                if Inkoopregel.Insert then;



                if not "Reservation Entry".Find('+') then
                    Clear("Reservation Entry");
                volgnr := "Reservation Entry"."Entry No.";
                "Reservation Entry".Init;
                "Reservation Entry"."Entry No." := volgnr + 1;
                "Reservation Entry".Positive := true;
                "Reservation Entry"."Item No." := Inkoopregel."No.";
                "Reservation Entry"."Location Code" := Inkoopregel."Location Code";
                "Reservation Entry"."Quantity (Base)" := -Inkoopregel."Quantity (Base)";
                "Reservation Entry"."Reservation Status" := "Reservation Entry"."Reservation Status"::Surplus;
                "Reservation Entry"."Creation Date" := Today;
                "Reservation Entry"."Source Type" := 39;
                "Reservation Entry"."Source Subtype" := 3;
                "Reservation Entry"."Source Ref. No." := Inkoopregel."Line No.";
                "Reservation Entry"."Source ID" := Inkoopregel."Document No.";
                "Reservation Entry"."Created By" := UserId;
                "Reservation Entry"."Qty. per Unit of Measure" := Inkoopregel."Qty. per Unit of Measure";
                "Reservation Entry".Quantity := -Inkoopregel.Quantity;
                "Reservation Entry"."Qty. to Handle (Base)" := -Inkoopregel."Quantity (Base)";
                "Reservation Entry"."Qty. to Invoice (Base)" := -Inkoopregel."Qty. to Invoice (Base)";
                "Reservation Entry"."Lot No." := "Item Journal Line"."Lot No.";
                "Reservation Entry".Positive := false;
                if "Reservation Entry".Insert then;
            end;

            trigger OnPostDataItem()
            begin
                Message(text50001, Inkoopkop."No.", Inkoopkop."Pay-to Name");
            end;

            trigger OnPreDataItem()
            begin
                Inkoopkop."Document Type" := Inkoopkop."Document Type"::"Credit Memo";
                Inkoopkop.Insert(true);
                if Relnr = '' then
                    Error(text50000);
                Inkoopkop.Validate(Inkoopkop."Buy-from Vendor No.", Relnr);
                Inkoopkop.Validate("Order Date", Today);
                Inkoopkop.Validate("Posting Date", Today);
                Inkoopkop.Validate(Inkoopkop."Expected Receipt Date", Today);
                Inkoopkop.Modify;
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
                    field(Relnr; Relnr)
                    {
                        Caption = 'Vendor No.';
                        Editable = false;
                        MultiLine = true;
                        TableRelation = Vendor;
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

    trigger OnInitReport()
    var
        lBejoSetup: Record "Bejo Setup";
    begin

        lBejoSetup.Get;
        lBejoSetup.TestField("Vendor No. BejoNL");
        Relnr := lBejoSetup."Vendor No. BejoNL";

    end;

    var
        Inkoopkop: Record "Purchase Header";
        Inkoopregel: Record "Purchase Line";
        text50000: Label 'You must enter the Vendor No.';
        text50001: Label 'Credit Memo %1 for Vendor No. %2 has been created.';
        "Reservation Entry": Record "Reservation Entry";
        volgnr: Integer;
        Relnr: Code[20];
        Nr: Integer;
}

