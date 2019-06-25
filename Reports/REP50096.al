report 50096 "Create Purchase Order"
{

    Caption = 'Create Purchase Order';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Imported Purchase Lines"; "Imported Purchase Lines")
        {
            DataItemTableView = WHERE ("Purchase Order Created" = CONST (false));
            RequestFilterFields = "Order Address Code";

            trigger OnAfterGetRecord()
            var
                lrecPurchaseLine: Record "Purchase Line";
                lrecItemExtension: Record "Item Extension";
            begin

                if Type = Type::Item then begin
                    if not grecItem.Get("No.") then
                        CurrReport.Skip;
                end else
                    if gCreateSeparateOrders then
                        CurrReport.Skip;

                if gCreateSeparateOrders and grecItem."B Organic" then
                    CreatePurchHeader(grecPurchHeaderORGANIC, gHeaderCreatedORGANIC, Text50002)
                else
                    CreatePurchHeader(grecPurchHeaderCONVENTIONAL, gHeaderCreated, Text50003);

                if "Customer No. BejoNL" = '' then begin
                    grecImportedPurchaseLines.SetRange("Document Type", "Document Type");
                    grecImportedPurchaseLines.SetRange("Document No.", "Document No.");
                    grecImportedPurchaseLines.SetFilter("Customer No. BejoNL", '<>%1', '');
                    if grecImportedPurchaseLines.Find('-') then
                        "Customer No. BejoNL" := grecImportedPurchaseLines."Customer No. BejoNL";
                    Modify;
                end;

                if (grecPurchHeader."Buy-from Vendor No." = '') and ("Customer No. BejoNL" <> '') then begin
                    grecPurchHeader.Get(grecPurchHeader."Document Type", grecPurchHeader."No.");
                    grecPurchHeader.Validate("Buy-from Vendor No.", "Customer No. BejoNL");
                    grecPurchHeader."Posting Description" := "Document No.";
                    grecPurchHeader."Your Reference" := "Document No.";
                    grecPurchHeader.Modify;
                end;


                lrecPurchaseLine."B SkipAllocationCheck" := true;


                lrecPurchaseLine.Init;
                lrecPurchaseLine.Validate("Document Type", grecPurchHeader."Document Type");
                lrecPurchaseLine.Validate("Document No.", grecPurchHeader."No.");
                lrecPurchaseLine.Validate("Line No.", "Line No.");
                lrecPurchaseLine.Validate("Buy-from Vendor No.", grecPurchHeader."Buy-from Vendor No.");
                lrecPurchaseLine.Validate(Type, Type);
                if lrecPurchaseLine.Type > 0 then begin
                    lrecPurchaseLine.Validate("No.", "No.");
                    if CopyStr("Document No.", 1, 2) <> 'PR' then
                        lrecPurchaseLine.Validate("Location Code", "Location Code");
                    lrecPurchaseLine.Validate(Quantity, "Qty. to Receive");
                    lrecPurchaseLine.Validate("Unit of Measure Code", "Unit of Measure Code");
                    lrecPurchaseLine.Validate("Requested Receipt Date", "Requested Receipt Date");
                    if lrecPurchaseLine."Requested Receipt Date" = 0D then
                        lrecPurchaseLine.Validate("Requested Receipt Date", grecPurchHeader."Requested Receipt Date");
                    lrecPurchaseLine.Validate("Direct Unit Cost", "Direct Unit Cost");
                    lrecPurchaseLine."Bin Code" := "Bin Code";
                    lrecPurchaseLine."B External Document No." := "External Document No.";
                    lrecPurchaseLine."B Line type" := "Line type";
                    lrecPurchaseLine."Net Weight" := "Net Weight";

                    lrecPurchaseLine."B Variety" := Variety;
                    if lrecItemExtension.Get(grecItem."B Extension", grecPurchHeader."Language Code") then begin
                        lrecPurchaseLine."B ItemExtensionCode" := lrecItemExtension."Extension Code";
                    end;


                end else begin
                    lrecPurchaseLine.Description := Description;
                    lrecPurchaseLine."Description 2" := "Description 2";
                end;

                if lrecPurchaseLine.Insert(true) then;

                "Purchase Order Created" := true;
                Modify;

                if "Lot No." <> '' then begin
                    grecLotNoInformation.SetRange("Item No.", "No.");
                    grecLotNoInformation.SetRange("Lot No.", "Lot No.");
                    if not grecLotNoInformation.Find('-') then begin
                        grecLotNoInformation.Init;
                        grecLotNoInformation."Item No." := "No.";
                        grecLotNoInformation."Lot No." := "Lot No.";
                        grecLotNoInformation.Insert;
                    end;
                    grecLotNoInformation."B Tsw. in gr." := "Tsw. in gr.";
                    grecLotNoInformation."B Germination" := Germination;
                    grecLotNoInformation."B Abnormals" := Abnormals;
                    grecLotNoInformation."B Grade Code" := "Grade Code";
                    grecLotNoInformation."B Best used by" := "Best used by";
                    grecLotNoInformation."B Treatment Code" := "Treatment Code";
                    grecLotNoInformation."B Remark" := "Remark Bejo NL";
                    grecLotNoInformation."B Variety" := Variety;
                    grecLotNoInformation."B Test Date" := "Test Date";
                    grecLotNoInformation."B Multi Germination" := "Multi Germination";
                    grecLotNoInformation.Modify;

                    grecReservationEntry.Lock;
                    if not grecReservationEntry.FindLast then
                        grecReservationEntry."Entry No." := 1
                    else
                        grecReservationEntry."Entry No." += 1;
                    grecReservationEntry.Positive := true;
                    grecReservationEntry.Init;

                    grecReservationEntry."Item No." := lrecPurchaseLine."No.";
                    grecReservationEntry."Location Code" := lrecPurchaseLine."Location Code";
                    grecReservationEntry."Quantity (Base)" := lrecPurchaseLine."Quantity (Base)";
                    grecReservationEntry."Reservation Status" := grecReservationEntry."Reservation Status"::Surplus;
                    grecReservationEntry."Creation Date" := Today;
                    grecReservationEntry."Source Type" := DATABASE::"Purchase Line";
                    grecReservationEntry."Source Subtype" := lrecPurchaseLine."Document Type";
                    grecReservationEntry."Source Ref. No." := lrecPurchaseLine."Line No.";
                    grecReservationEntry."Source ID" := lrecPurchaseLine."Document No.";
                    grecReservationEntry."Created By" := UserId;
                    grecReservationEntry."Qty. per Unit of Measure" := lrecPurchaseLine."Qty. per Unit of Measure";
                    grecReservationEntry.Quantity := lrecPurchaseLine.Quantity;
                    grecReservationEntry."Qty. to Handle (Base)" := lrecPurchaseLine."Quantity (Base)";
                    grecReservationEntry."Qty. to Invoice (Base)" := lrecPurchaseLine."Qty. to Invoice (Base)";
                    grecReservationEntry."Lot No." := "Lot No.";
                    grecReservationEntry."Item Tracking" := grecReservationEntry."Item Tracking"::"Lot No.";
                    grecReservationEntry.Insert;
                end;

            end;

            trigger OnPostDataItem()
            begin


                if gCreateSeparateOrders then begin
                    if gHeaderCreated and gHeaderCreatedORGANIC then begin
                        Message(Text50004, grecPurchHeaderORGANIC."No.", Text50002, grecPurchHeaderCONVENTIONAL."No.", Text50003,
                                grecPurchHeaderCONVENTIONAL."Pay-to Name")
                    end else begin
                        if gHeaderCreated then
                            Message(text50000, grecPurchHeaderCONVENTIONAL."No.", grecPurchHeaderCONVENTIONAL."Pay-to Name")
                        else
                            if gHeaderCreatedORGANIC then
                                Message(text50000, grecPurchHeaderORGANIC."No.", grecPurchHeaderORGANIC."Pay-to Name")
                            else
                                Message(Text50005);
                    end;
                end else
                    if gHeaderCreated then
                        Message(text50000, grecPurchHeaderCONVENTIONAL."No.", grecPurchHeaderCONVENTIONAL."Pay-to Name")
                    else
                        Message(Text50005);

            end;

            trigger OnPreDataItem()
            begin


                gHeaderCreated := false;
                gHeaderCreatedORGANIC := false;

            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin

        grecBejoSetup.Get;
        grecBejoSetup.TestField("Vendor No. BejoNL");


    end;

    trigger OnPostReport()
    begin

    end;

    trigger OnPreReport()
    begin

        gCreateSeparateOrders := Confirm(Text50001, false);

    end;

    var
        grecImportedPurchaseLines: Record "Imported Purchase Lines";
        grecLotNoInformation: Record "Lot No. Information";
        grecReservationEntry: Record "Reservation Entry";
        text50000: Label 'Purchase order %1 for %2 has been created.';
        grecBejoSetup: Record "Bejo Setup";
        gCreateSeparateOrders: Boolean;
        grecItem: Record Item;
        Text50001: Label 'Do you want separate orders for organic and conventional items?';
        Text50002: Label 'ORGANIC';
        Text50003: Label 'CONVENTIONAL';
        grecPurchHeader: Record "Purchase Header";
        grecPurchHeaderORGANIC: Record "Purchase Header";
        grecPurchHeaderCONVENTIONAL: Record "Purchase Header";
        gHeaderCreated: Boolean;
        gHeaderCreatedORGANIC: Boolean;
        Text50004: Label 'Purchase Orders %1 (%2) and %3 (%4) have been created for %5.';
        Text50005: Label 'No Purchase Order has been created.';

    procedure CreatePurchHeader(var lrecPurchHeader: Record "Purchase Header"; var lOrderCreated: Boolean; lFirstLineText: Text[50])
    var
        lrecPurchLine: Record "Purchase Line";
    begin


        if not lOrderCreated then begin
            lrecPurchHeader.Init;
            lrecPurchHeader."Document Type" := "Imported Purchase Lines"."Document Type";
            lrecPurchHeader."No." := '';
            lrecPurchHeader.Insert(true);

            with lrecPurchHeader do begin
                Validate("Buy-from Vendor No.", grecBejoSetup."Vendor No. BejoNL");
                "Posting Description" := "Imported Purchase Lines"."Document No.";
                "Your Reference" := "Imported Purchase Lines"."Document No.";
                "Vendor Invoice No." := "Imported Purchase Lines"."Document No.";
                "Vendor Order No." := "Imported Purchase Lines"."Receipt No.";
                "Requested Receipt Date" := "Imported Purchase Lines"."Requested Receipt Date";
                if "Requested Receipt Date" = 0D then
                    "Requested Receipt Date" := "Posting Date";
                Modify;
            end;
            lOrderCreated := true;

            if gCreateSeparateOrders then begin
                lrecPurchLine.Init;
                lrecPurchLine.Validate("Document Type", lrecPurchHeader."Document Type");
                lrecPurchLine.Validate("Document No.", lrecPurchHeader."No.");
                lrecPurchLine.Validate("Line No.", "Imported Purchase Lines"."Line No." - 1);
                lrecPurchLine.Validate("Buy-from Vendor No.", lrecPurchHeader."Buy-from Vendor No.");
                lrecPurchLine.Validate(Type, 0);
                lrecPurchLine.Validate(Description, lFirstLineText);
                if lrecPurchLine.Insert(true) then;
            end;
        end;
        grecPurchHeader := lrecPurchHeader;
    end;

    local procedure CheckHeaderAndLines()
    var
        lrecPurchHeaderTemp: Record "Purchase Header" temporary;
    begin
        lrecPurchHeaderTemp.Validate("Document Type", "Imported Purchase Lines"."Document Type");

        lrecPurchHeaderTemp."No." := 'TEMP_SO';

        lrecPurchHeaderTemp.Insert(true);

        with lrecPurchHeaderTemp do begin
            Validate("Buy-from Vendor No.", grecBejoSetup."Vendor No. BejoNL");
            Validate("Posting Description", "Imported Purchase Lines"."Document No.");
            Validate("Your Reference", "Imported Purchase Lines"."Document No.");
            Validate("Vendor Invoice No.", "Imported Purchase Lines"."Document No.");
            Validate("Vendor Order No.", "Imported Purchase Lines"."Receipt No.");
            if "Requested Receipt Date" = 0D then
                Validate("Requested Receipt Date", "Posting Date")
            else
                Validate("Requested Receipt Date", "Imported Purchase Lines"."Requested Receipt Date");

            Modify;
        end;

        CheckLines(lrecPurchHeaderTemp);
    end;

    local procedure CheckLines(var pPurchHeaderTemp: Record "Purchase Header" temporary)
    var
        lrecImportedPurchLines: Record "Imported Purchase Lines";
        lText50000: Label 'U moet eerst als tekstbestand exporteren voordat u een order aanmaakt.';
        lText50001: Label 'Lot No. %1 does not exist for Item %2.';
        lrecItemUnitOfMeasure: Record "Item Unit of Measure";
        lrecPurchLineTemp: Record "Purchase Line" temporary;
    begin
        lrecImportedPurchLines.CopyFilters("Imported Purchase Lines");
        if lrecImportedPurchLines.FindSet then
            repeat

                case lrecImportedPurchLines.Type of
                    lrecImportedPurchLines.Type::Item:
                        begin
                            lrecImportedPurchLines.TestField("No.");
                            lrecImportedPurchLines.TestField("Unit of Measure Code");
                            lrecItemUnitOfMeasure.Get(lrecImportedPurchLines."No.", lrecImportedPurchLines."Unit of Measure Code");
                            lrecImportedPurchLines.TestField("Qty. per Unit of Measure", lrecItemUnitOfMeasure."Qty. per Unit of Measure");
                            lrecImportedPurchLines.TestField("Qty. to Receive (Base)", lrecImportedPurchLines."Qty. to Receive"
                                                              * lrecItemUnitOfMeasure."Qty. per Unit of Measure");
                        end;
                end;

                lrecPurchLineTemp."B SkipAllocationCheck" := true;

                lrecPurchLineTemp.Init;
                lrecPurchLineTemp.Validate("Document Type", pPurchHeaderTemp."Document Type");
                lrecPurchLineTemp."Document No." := pPurchHeaderTemp."No.";
                lrecPurchLineTemp.Validate("Line No.", lrecImportedPurchLines."Line No.");
                lrecPurchLineTemp.Validate("Buy-from Vendor No.", pPurchHeaderTemp."Buy-from Vendor No.");
                lrecPurchLineTemp.Type := lrecImportedPurchLines.Type;
                if lrecPurchLineTemp.Type > 0 then begin

                    lrecPurchLineTemp."No." := lrecImportedPurchLines."No.";
                    if CopyStr(lrecImportedPurchLines."Document No.", 1, 2) <> 'PR' then
                        lrecPurchLineTemp.Validate("Location Code", lrecImportedPurchLines."Location Code");
                    lrecPurchLineTemp.Validate(Quantity, lrecImportedPurchLines."Qty. to Receive");
                    lrecPurchLineTemp.Validate("Unit of Measure Code", lrecImportedPurchLines."Unit of Measure Code");
                    lrecPurchLineTemp.Validate("Requested Receipt Date", lrecImportedPurchLines."Requested Receipt Date");
                    if lrecPurchLineTemp."Requested Receipt Date" = 0D then
                        lrecPurchLineTemp.Validate("Requested Receipt Date", pPurchHeaderTemp."Requested Receipt Date");
                    lrecPurchLineTemp.Validate("Direct Unit Cost", lrecImportedPurchLines."Direct Unit Cost");
                    lrecPurchLineTemp.Validate("Bin Code", lrecImportedPurchLines."Bin Code");
                    lrecPurchLineTemp.Validate("B External Document No.", lrecImportedPurchLines."External Document No.");
                    lrecPurchLineTemp.Validate("B Line type", lrecImportedPurchLines."Line type");
                    lrecPurchLineTemp.Validate("Net Weight", lrecImportedPurchLines."Net Weight");
                end else begin
                    lrecPurchLineTemp.Description := lrecImportedPurchLines.Description;
                    lrecPurchLineTemp."Description 2" := lrecImportedPurchLines."Description 2";
                end;

                if lrecPurchLineTemp.Insert(true) then;
            until lrecImportedPurchLines.Next = 0;
    end;
}

