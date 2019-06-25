report 50099 "Update Original Orders"
{

    DefaultLayout = RDLC;
    RDLCLayout = './RDLC/Update Original Orders.rdlc';


    dataset
    {
        dataitem("Imported Purchase Lines"; "Imported Purchase Lines")
        {
            DataItemTableView = WHERE ("Purchase Order Created" = CONST (false));
            RequestFilterFields = "Order Address Code";
            column(COMPANYNAME; CompanyName)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(USERID; UserId)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }

            column(DocumentNo_ImportedPurchaseLines; "Imported Purchase Lines"."Document No.")
            {
                IncludeCaption = true;
            }
            column(LineNo_ImportedPurchaseLines; "Imported Purchase Lines"."Line No.")
            {
                IncludeCaption = true;
            }
            column(No_ImportedPurchaseLines; "Imported Purchase Lines"."No.")
            {
                IncludeCaption = true;
            }
            column(LotNo_ImportedPurchaseLines; "Imported Purchase Lines"."Lot No.")
            {
                IncludeCaption = true;
            }
            column(QtytoReceive_ImportedPurchaseLines; "Imported Purchase Lines"."Qty. to Receive")
            {
            }
            column(UnitofMeasureCode_ImportedPurchaseLines; "Imported Purchase Lines"."Unit of Measure Code")
            {
            }
            column(Description_ImportedPurchaseLines; "Imported Purchase Lines".Description)
            {
                IncludeCaption = true;
            }
            column(DocNo_PurchaseLine; grecPurchLine."Document No.")
            {
            }
            column(LineNo_PurchaseLine; grecPurchLine."Line No.")
            {
            }
            column(No_PurchaseLine; grecPurchLine."No.")
            {
            }
            column(UoM_PurchaseLine; grecPurchLine."Unit of Measure Code")
            {
            }
            column(Qty_PurchaseLine; grecPurchLine.Quantity)
            {
            }
            column(gEqual; gEqual)
            {
            }
            column(gErrortxt; gErrortxt)
            {
            }
            column(OldPrice; OldPrice)
            {
            }
            column(NewPrice; NewPrice)
            {
            }

            trigger OnAfterGetRecord()
            begin
                RecNo := RecNo + 1;
                Window.Update(1, Round(RecNo / TotalRecNo * 10000, 1));

                if Type = Type::Item then
                    if not grecItem.Get("No.") then
                        CurrReport.Skip;

                if "Customer No. BejoNL" = '' then begin
                    grecImportedPurchaseLines.SetRange("Document Type", "Document Type");
                    grecImportedPurchaseLines.SetRange("Document No.", "Document No.");
                    grecImportedPurchaseLines.SetFilter("Customer No. BejoNL", '<>%1', '');
                    if grecImportedPurchaseLines.Find('-') then begin
                        "Customer No. BejoNL" := grecImportedPurchaseLines."Customer No. BejoNL";
                        Modify;
                    end;
                end;

                case Type of
                    Type::Item:
                        UpdateOriginalPurchOrder("Imported Purchase Lines");
                    else
                        CurrReport.Skip;
                end;
            end;

            trigger OnPostDataItem()
            var
                WhsRcptHeader: Record "Warehouse Receipt Header";
                WhsRcptLine: Record "Warehouse Receipt Line";
            begin
                //Proccess Charges - Start
                if InsertCharge then begin
                    grecImportedPurchaseLinesChrgs.Reset;
                    grecImportedPurchaseLinesChrgs.SetRange("Document No.", "Document No.");
                    grecImportedPurchaseLinesChrgs.SetRange(Type, Type::Item);
                    TotalQtyApplied := 0;
                    if grecImportedPurchaseLinesChrgs.FindSet then
                        repeat
                            TotalQtyApplied += grecImportedPurchaseLinesChrgs."Qty. to Receive (Base)";
                        until grecImportedPurchaseLinesChrgs.Next = 0;

                    grecImportedPurchaseLinesChrgs.Reset;
                    if tmpPurchHeader.FindSet then begin
                        repeat
                            if grecPurchHeader.Get(tmpPurchHeader."Document Type", tmpPurchHeader."No.") then begin
                                grecImportedPurchaseLinesChrgs.SetRange("Document No.", "Document No.");
                                grecImportedPurchaseLinesChrgs.SetRange("Purchase Order Created", false);
                                grecImportedPurchaseLinesChrgs.SetRange(Type, Type::"G/L Account");
                                if grecImportedPurchaseLinesChrgs.FindSet then
                                    repeat
                                        ProcessCharges(grecImportedPurchaseLinesChrgs, grecPurchHeader);
                                    until grecImportedPurchaseLinesChrgs.Next = 0;
                            end;
                        until tmpPurchHeader.Next = 0;
                        if grecImportedPurchaseLinesChrgs.FindSet then
                            grecImportedPurchaseLinesChrgs.ModifyAll("Purchase Order Created", true);
                    end;
                end else begin
                    grecImportedPurchaseLinesChrgs.SetRange("Document No.", "Document No.");
                    grecImportedPurchaseLinesChrgs.SetRange("Purchase Order Created", false);
                    grecImportedPurchaseLinesChrgs.SetRange(Type, Type::"G/L Account");
                    if grecImportedPurchaseLinesChrgs.FindSet then
                        grecImportedPurchaseLinesChrgs.ModifyAll("Purchase Order Created", true);
                end;
                //Proccess Charges - End

                if tmpPurchHeader.FindSet then begin
                    RecNo := 0;
                    TotalRecNo := tmpPurchHeader.Count;
                    if CreateWhsReceipt then
                        Window.Open(
                          Text001 +
                          '@1@@@@@@@@@@@@@@@@@@@@@\')
                    else
                        Window.Open(
                          Text002 +
                          '@1@@@@@@@@@@@@@@@@@@@@@\');

                    Clear(WhseRcptNo);

                    repeat
                        RecNo := RecNo + 1;
                        Window.Update(1, Round(RecNo / TotalRecNo * 10000, 1));

                        if grecPurchHeader.Get(tmpPurchHeader."Document Type", tmpPurchHeader."No.") then begin

                            ReleasePurchDoc.PerformManualRelease(grecPurchHeader);

                            // Create Warehouse Receipt
                            if CreateWhsReceipt then begin
                                if not CreateCombinedWhsRcpt then
                                    Clear(WhseRcptNo);

                                if (not CreateCombinedWhsRcpt) or (WhseRcptNo = '') then
                                    WhseRcptNo := CreateFromUpdateOriginalOrder(grecPurchHeader)
                                else
                                    if WhseRcptNo <> '' then
                                        if WhsRcptHeader.Get(WhseRcptNo) then

                                            AddAnotherInboundDoc(WhsRcptHeader, grecPurchHeader);

                                if WhseRcptNo <> '' then
                                    if WhsRcptHeader.Get(WhseRcptNo) then begin
                                        WhsRcptHeader."Vendor Shipment No." := grecPurchHeader."Vendor Invoice No.";
                                        WhsRcptHeader.Modify;
                                        // Delete Whs. Rcpt. lines that are not supposed to be received
                                        WhsRcptLine.SetRange("No.", WhsRcptHeader."No.");
                                        WhsRcptLine.SetRange("Source No.", grecPurchHeader."No.");
                                        if WhsRcptLine.FindSet then
                                            repeat
                                                tmpPurchLineForWhsRcpt.SetRange("Document No.", grecPurchHeader."No.");
                                                tmpPurchLineForWhsRcpt.SetRange("Line No.", WhsRcptLine."Source Line No.");
                                                tmpPurchLineForWhsRcpt.SetRange("No.", WhsRcptLine."Item No.");
                                                if tmpPurchLineForWhsRcpt.FindFirst then begin
                                                    // Update Qty to receive
                                                    grecWhsRcptLine.SetRange("No.", WhsRcptLine."No.");
                                                    grecWhsRcptLine.SetRange("Source Type", WhsRcptLine."Source Type");
                                                    grecWhsRcptLine.SetRange("Source Subtype", WhsRcptLine."Source Subtype");
                                                    grecWhsRcptLine.SetRange("Source No.", WhsRcptLine."Source No.");
                                                    grecWhsRcptLine.SetRange("Source Line No.", WhsRcptLine."Source Line No.");
                                                    if grecWhsRcptLine.Find('-') then begin
                                                        grecWhsRcptLine.Validate("Qty. to Receive", tmpPurchLineForWhsRcpt.Quantity);
                                                        grecWhsRcptLine.Modify;
                                                    end;
                                                end else begin
                                                    // Delete the line
                                                    grecWhsRcptLine.SetRange("No.", WhsRcptLine."No.");
                                                    grecWhsRcptLine.SetRange("Source Type", WhsRcptLine."Source Type");
                                                    grecWhsRcptLine.SetRange("Source Subtype", WhsRcptLine."Source Subtype");
                                                    grecWhsRcptLine.SetRange("Source No.", WhsRcptLine."Source No.");
                                                    grecWhsRcptLine.SetRange("Source Line No.", WhsRcptLine."Source Line No.");
                                                    if grecWhsRcptLine.Find('-') then
                                                        grecWhsRcptLine.Delete;
                                                end;
                                            until WhsRcptLine.Next = 0;
                                    end;

                            end; // Create Whse Receipt
                        end;
                    until tmpPurchHeader.Next = 0;


                end;

            end;

            trigger OnPreDataItem()
            begin
                SetCurrentKey("Document Type", "Document No.", "Line No.");


                if (CopyStr("Imported Purchase Lines"."Document No.", 1, 2) = 'PR') then
                    Error(text50005);


                RecNo := 0;
                TotalRecNo := "Imported Purchase Lines".Count;

                Window.Open(
                  Text000 +
                  '@1@@@@@@@@@@@@@@@@@@@@@\');
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
                    field(CreateWhsReceipt; CreateWhsReceipt)
                    {
                        Caption = 'Create Warehouse Receipt';
                        MultiLine = true;
                        ApplicationArea = All;
                    }
                    field(CreateCombinedWhsRcpt; CreateCombinedWhsRcpt)
                    {
                        Caption = 'Combine Orders In One Whs. Receipt';
                        ApplicationArea = All;
                    }
                    field(InsertCharge; InsertCharge)
                    {
                        Caption = 'Add G/L Account Line To Purch. Orders';
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin

            CreateWhsReceipt := false;
            CreateCombinedWhsRcpt := false;
            InsertCharge := false;
        end;
    }

    labels
    {
        lblQty = 'Quantity';
        lblUnit = 'Unit';
        lblFrom = 'From';
        lblTo = 'To';
        lblPriceUpdate = 'Price Update';
        lblTitle = 'Update Original Purchase Line';
        lblStatus = 'Status';
        lblMatch = 'Match';
        lblPurchaseOrderImportNL = 'Purchase Order Import NL';
        lblPurchaseOrderOriginal = 'Purchase Order Original';
        lblCheck = 'Check';
        lblPriceUpdated = 'Price Updated';
    }

    trigger OnInitReport()
    begin
        // - BEJOW18.00.018 ---
        //grecBejoSetup.GET;
        //grecBejoSetup.TESTFIELD("Vendor No. BejoNL");
        // + BEJOW18.00.018 +++
    end;

    trigger OnPostReport()
    begin
        Window.Close;
    end;

    trigger OnPreReport()
    begin
        gOrderAddressCodeFilter := "Imported Purchase Lines".GetFilter("Order Address Code");
    end;

    var
        grecPurchHeader: Record "Purchase Header";
        grecPurchLine: Record "Purchase Line";
        grecPurchLineTemp: Record "Purchase Line" temporary;
        grecImportedPurchaseLines: Record "Imported Purchase Lines";
        grecImportedPurchaseLinesChrgs: Record "Imported Purchase Lines";
        grecLotNoInformation: Record "Lot No. Information";
        grecReservationEntry: Record "Reservation Entry";
        grecBejoSetup: Record "Bejo Setup";
        grecItem: Record Item;
        gOrderAddressCodeFilter: Text[30];
        gEqual: Boolean;
        gErrortxt: Text[30];
        gQtyFound: Integer;
        gcuBejoMgt: Codeunit "Bejo Management";
        gContinue: Boolean;
        NewLineNo: Integer;
        OldPrice: Decimal;
        NewPrice: Decimal;
        gLineNoFilter: Text[100];
        gDocumentNo: Code[20];
        ReleasePurchDoc: Codeunit "Release Purchase Document";
        StatusReleased: Boolean;
        GetSourceDocInbound: Codeunit "Get Source Doc. Inbound";
        CreateWhsReceipt: Boolean;
        WhseRcptNo: Code[20];
        tmpPurchHeader: Record "Purchase Header" temporary;
        RecNo: Integer;
        TotalRecNo: Integer;
        Window: Dialog;
        tmpPurchLineForWhsRcpt: Record "Purchase Line" temporary;
        grecWhsRcptLine: Record "Warehouse Receipt Line";
        CreateCombinedWhsRcpt: Boolean;
        ChargesApplied: Boolean;
        InsertCharge: Boolean;
        TotalQtyApplied: Decimal;
        Text59000: Label 'You have not entered an Order Address Code. Do you wish to continue?';
        text50000: Label 'UOM';
        text50001: Label 'Qty.';
        text50002: Label 'New Line';
        text50003: Label 'Price';
        text50004: Label 'Change';
        Text000: Label 'Updating Original Orders...\';
        Text001: Label 'Creating Warehouse Receipts...\';
        Text002: Label 'Releasing Orders...\';
        lDifference: Decimal;
        text50005: Label 'You cannot update Prognosis Orders (PR)';

    procedure UpdateOriginalPurchOrder(var lrecImportedPurchLines: Record "Imported Purchase Lines")
    var
        lExternalDocumentNo: Decimal;
        TempExternalDocumentNo: Code[20];
        lPlace: Integer;
        lcuBejoManagement: Codeunit "Bejo Management";
        lAlternativeItemNo: Code[20];
        lDifference: Decimal;
    begin
        Clear(gEqual);
        Clear(OldPrice);
        Clear(NewPrice);
        Clear(gErrortxt);
        gContinue := true;

        with lrecImportedPurchLines do begin
            lExternalDocumentNo := 0;


            grecPurchHeader.SetFilter("No.", '*' + TempExternalDocumentNo);
            grecPurchHeader.SetRange("Document Type", grecPurchHeader."Document Type"::Order);
            if not grecPurchHeader.Find('-') then
                CurrReport.Skip;

            if not tmpPurchHeader.Get(grecPurchHeader."Document Type", grecPurchHeader."No.") then begin
                tmpPurchHeader := grecPurchHeader;
                tmpPurchHeader.Insert;
            end;

            if grecPurchHeader.Status = grecPurchHeader.Status::Released then
                ReleasePurchDoc.PerformManualReopen(grecPurchHeader);

            grecPurchHeader.Validate("Posting Date", WorkDate);
            grecPurchHeader.Validate("Due Date", WorkDate);
            grecPurchHeader."Posting Description" := "Document No.";
            grecPurchHeader.Validate("Order Address Code", "Order Address Code");
            grecPurchHeader.Modify;

            grecPurchLine.Reset;
            grecPurchLine.SetRange("Document No.", grecPurchHeader."No.");
            grecPurchLine.SetRange("Document Type", grecPurchLine."Document Type"::Order);
            grecPurchLine.SetRange(Type, Type::Item);
            grecPurchLine.SetRange("Quantity Received", 0);


            grecPurchLine.SetRange("Quantity Received");  //allowing partial receiving
            if lcuBejoManagement.GetAlternativeItemNo("No.", lAlternativeItemNo) then
                grecPurchLine.SetFilter("No.", '%1|%2', "No.", lAlternativeItemNo)
            else
                grecPurchLine.SetRange("No.", "No.");

            grecPurchLine.SetRange("Qty. per Unit of Measure", "Qty. per Unit of Measure");
            if not grecPurchLine.Find('-') then begin
                NewLineNo := 0;
                OldPrice := 0;
                NewPrice := "Direct Unit Cost";
                CreateNewLine(lrecImportedPurchLines, false, 0);
                grecPurchLine.SetRange("Qty. per Unit of Measure");
                if not grecPurchLine.FindFirst then
                    gErrortxt := text50002
                else
                    gErrortxt := text50002 + ' (' + text50000 + ')';
            end else begin
                grecPurchLineTemp.SetCurrentKey("Document Type", "Document No.", "Line No.");

                grecPurchLine.SetRange("Qty. per Unit of Measure", "Qty. per Unit of Measure");

                //Comment: Look for same Item and Quantity
                FindExactQuantity(lrecImportedPurchLines, grecPurchLine);            //Qty. Received =0

                //Comment: Look for same Item and exact remaining qty, to fulfill the existing line
                if gContinue then
                    FindExactRemainingQuantity(lrecImportedPurchLines, grecPurchLine); //Qty. Received <>0

                //Comment: Look for any partial received line that has avilable qty to fulfill
                if gContinue then
                    AddToRemainingQuantity(lrecImportedPurchLines, grecPurchLine);     //Qty. Received <>0

                //Comment: Look for any partial received line that has avilable qty to fulfill and create new line for for remaining
                if gContinue then
                    CloseRemainingQuantity(lrecImportedPurchLines, grecPurchLine);     //Qty. Received <>0

                //Comment: Look for any line that is not received and has available qty to fulfill
                if gContinue then
                    AddToAvailableQuantity(lrecImportedPurchLines, grecPurchLine);     //Qty. Received =0

                //Comment: Look for any line that is not received and has available qty to fulfill and then create new line for remaining
                if gContinue then
                    CloseAvailableQuantity(lrecImportedPurchLines, grecPurchLine);     //Qty. Received =0

                if gContinue then begin
                    NewLineNo := 0;
                    OldPrice := 0;
                    NewPrice := "Direct Unit Cost";
                    CreateNewLine(lrecImportedPurchLines, false, 0);
                    gErrortxt := text50002
                end;
            end;
        end;
    end;

    procedure CreateNewLine(var lrecImportedPurchLines: Record "Imported Purchase Lines"; MoveText: Boolean; Difference: Decimal)
    var
        lrecPurchaseLine: Record "Purchase Line";
    begin
        if NewLineNo = 0 then begin
            NewLineNo += 10000;
            lrecPurchaseLine.SetRange("Document Type", grecPurchHeader."Document Type");
            lrecPurchaseLine.SetRange("Document No.", grecPurchHeader."No.");
            if lrecPurchaseLine.FindLast then
                NewLineNo := lrecPurchaseLine."Line No." + 10000;
        end;

        with lrecImportedPurchLines do begin

            lrecPurchaseLine."B SkipAllocationCheck" := true;

            lrecPurchaseLine.Init;
            lrecPurchaseLine.Validate("Document Type", grecPurchHeader."Document Type");
            lrecPurchaseLine.Validate("Document No.", grecPurchHeader."No.");
            lrecPurchaseLine.Validate("Line No.", NewLineNo);
            lrecPurchaseLine.Validate("Buy-from Vendor No.", grecPurchHeader."Buy-from Vendor No.");
            lrecPurchaseLine.Validate(Type, Type);
            if lrecPurchaseLine.Type > 0 then begin
                lrecPurchaseLine.Validate("No.", "No.");
                lrecPurchaseLine.Validate("Location Code", "Location Code");
                lrecPurchaseLine.Validate("Unit of Measure Code", "Unit of Measure Code");
                lrecPurchaseLine.Validate("Requested Receipt Date", "Requested Receipt Date");
                if lrecPurchaseLine."Requested Receipt Date" = 0D then
                    lrecPurchaseLine.Validate("Requested Receipt Date", grecPurchHeader."Requested Receipt Date");
                if CopyStr("Document No.", 1, 2) <> 'PR' then begin
                    if Difference > 0 then
                        lrecPurchaseLine.Validate(Quantity, Difference)
                    else
                        lrecPurchaseLine.Validate(Quantity, "Qty. to Receive");

                    //non Advance Location - Start
                    if not IsAdvanceWarehouse("Location Code") then
                        lrecPurchaseLine.Validate("Qty. to Receive", lrecPurchaseLine.Quantity)
                    else
                        //non Advance Location - End
                        lrecPurchaseLine.Validate("Qty. to Receive", "Qty. to Receive");
                end else begin
                    CalcFields("Total Quantity to Receive");
                    lrecPurchaseLine.Validate(Quantity, "Total Quantity to Receive");
                    lrecPurchaseLine.Validate("Qty. to Receive", "Total Quantity to Receive");
                end;
                lrecPurchaseLine.Validate("Direct Unit Cost", "Direct Unit Cost");
                lrecPurchaseLine."Bin Code" := "Bin Code";
                lrecPurchaseLine."B External Document No." := "Document No.";
                lrecPurchaseLine."B Line type" := "Line type";
                lrecPurchaseLine."Net Weight" := "Net Weight";
            end else begin
                lrecPurchaseLine.Description := Description;
                lrecPurchaseLine."Description 2" := "Description 2";
            end;



            if lrecPurchaseLine.Insert(true) then begin
                grecPurchLineTemp := lrecPurchaseLine;
                grecPurchLineTemp."Qty. to Receive" := lrecPurchaseLine.Quantity;
                grecPurchLineTemp.Insert;
                // keep this for warehouse receipt
                tmpPurchLineForWhsRcpt := lrecPurchaseLine;
                tmpPurchLineForWhsRcpt.Insert;
                if MoveText then
                    MoveTextLines(grecPurchLine, lrecPurchaseLine);
            end;
            "Purchase Order Created" := true;
            Modify;


            DeleteItemTracking(lrecImportedPurchLines, lrecPurchaseLine, lrecPurchaseLine.Quantity);
            AddItemTracking(lrecImportedPurchLines, lrecPurchaseLine, 0);

        end;
    end;

    procedure UpdateLotItemTracking(var lrecImportedPurchLines: Record "Imported Purchase Lines"; var lrecPurchaseLine: Record "Purchase Line")
    begin
        with lrecImportedPurchLines do begin
            if "Lot No." <> '' then begin
                grecLotNoInformation.SetRange("Item No.", "No.");
                grecLotNoInformation.SetRange("Lot No.", "Lot No.");
                if not grecLotNoInformation.Find('-') then begin
                    grecLotNoInformation.Init;
                    grecLotNoInformation."Item No." := "No.";
                    grecLotNoInformation."Lot No." := "Lot No.";
                    if "Tsw. in gr." <> 0 then
                        grecLotNoInformation."B Description 1" := Format(Round(1000 / "Tsw. in gr.", 0.001) * 454);
                    grecLotNoInformation."B Remark" := "Remark Bejo NL";
                    grecLotNoInformation.Insert;
                end;
                grecLotNoInformation."B Tsw. in gr." := "Tsw. in gr.";
                grecLotNoInformation."B Germination" := Germination;
                grecLotNoInformation."B Abnormals" := Abnormals;
                grecLotNoInformation."B Grade Code" := "Grade Code";
                grecLotNoInformation."B Best used by" := "Best used by";
                grecLotNoInformation."B Treatment Code" := "Treatment Code";
                grecLotNoInformation."B Variety" := Variety;
                grecLotNoInformation."B Test Date" := "Test Date";
                grecLotNoInformation."B Multi Germination" := "Multi Germination";
                grecLotNoInformation.Modify;

                grecReservationEntry.Lock;
                grecReservationEntry.Reset;
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
    end;

    procedure MoveTextLines(OriginalPurchaseLine: Record "Purchase Line"; NewPurchaseLine: Record "Purchase Line")
    var
        lrecPurchComment: Record "Purch. Comment Line";
    begin
        lrecPurchComment.SetRange("No.", OriginalPurchaseLine."Document No.");
        lrecPurchComment.SetRange("Document Type", OriginalPurchaseLine."Document Type");
        lrecPurchComment.SetRange("Document Line No.", OriginalPurchaseLine."Line No.");

        if lrecPurchComment.Find('-') then repeat
                                               lrecPurchComment.Rename(NewPurchaseLine."Document No.", NewPurchaseLine."Line No.");
                                               lrecPurchComment.Modify;
            until not lrecPurchComment.Find('-')
    end;

    procedure DeleteItemTracking(var lrecImportedPurchLines: Record "Imported Purchase Lines"; var lrecPurchaseLine: Record "Purchase Line"; TrackedQty: Decimal)
    begin
        if lrecImportedPurchLines."Lot No." <> '' then begin
            grecReservationEntry.SetRange("Item No.", lrecPurchaseLine."No.");
            grecReservationEntry.SetRange("Location Code", lrecPurchaseLine."Location Code");
            grecReservationEntry.SetRange("Source Type", DATABASE::"Purchase Line");
            grecReservationEntry.SetRange("Source Subtype", lrecPurchaseLine."Document Type");
            grecReservationEntry.SetRange("Source Ref. No.", lrecPurchaseLine."Line No.");
            grecReservationEntry.SetRange("Source ID", lrecPurchaseLine."Document No.");
            grecReservationEntry.SetRange("Lot No.", lrecImportedPurchLines."Lot No.");
            if grecReservationEntry.Find('-') then
                grecReservationEntry.Delete;
        end;
    end;

    procedure ProcessCharges(var ImportedPurchLines: Record "Imported Purchase Lines"; var PurchaseHeader: Record "Purchase Header")
    var
        lrecPurchaseLine: Record "Purchase Line";
        LineNo: Integer;
        AmountToApply: Decimal;
        QtyToApply: Decimal;
        lrecItem: Record Item;
    begin
        //Calculate amount to apply
        AmountToApply := ImportedPurchLines."Direct Unit Cost";

        QtyToApply := 0;
        tmpPurchLineForWhsRcpt.Reset;
        tmpPurchLineForWhsRcpt.SetRange("Document No.", PurchaseHeader."No.");
        if tmpPurchLineForWhsRcpt.FindSet then
            repeat
                QtyToApply += tmpPurchLineForWhsRcpt."Quantity (Base)";
            until tmpPurchLineForWhsRcpt.Next = 0;

        if (TotalQtyApplied <> 0) and (QtyToApply <> 0) then
            AmountToApply := Round(((QtyToApply * AmountToApply) / TotalQtyApplied), 0.01, '=');

        //Delete existing
        grecPurchLine.Reset;
        grecPurchLine.SetRange("Document No.", PurchaseHeader."No.");
        grecPurchLine.SetRange("Document Type", grecPurchLine."Document Type"::Order);
        grecPurchLine.SetRange(Type, grecPurchLine.Type::"G/L Account");
        grecPurchLine.SetRange("No.", ImportedPurchLines."No.");
        grecPurchLine.SetRange("B External Document No.", ImportedPurchLines."Document No.");
        grecPurchLine.SetRange("Quantity Received", 0);
        if grecPurchLine.Find('-') then
            grecPurchLine.Delete;

        //Get last line no
        grecPurchLine.Reset;
        grecPurchLine.SetRange("Document No.", PurchaseHeader."No.");
        grecPurchLine.SetRange("Document Type", grecPurchLine."Document Type"::Order);
        LineNo := 10000;
        if grecPurchLine.FindLast then
            LineNo := grecPurchLine."Line No." + 10000;

        //Insert
        lrecPurchaseLine.Init;
        lrecPurchaseLine."Line No." := LineNo;
        lrecPurchaseLine."Document Type" := lrecPurchaseLine."Document Type"::Order;
        lrecPurchaseLine."Document No." := PurchaseHeader."No.";
        lrecPurchaseLine."Buy-from Vendor No." := grecPurchLine."Buy-from Vendor No.";
        lrecPurchaseLine.Validate(Type, lrecPurchaseLine.Type::"G/L Account");
        lrecPurchaseLine.Validate("No.", ImportedPurchLines."No.");
        lrecPurchaseLine.Validate(Quantity, 1);


        lrecItem.Get(ImportedPurchLines."No.");
        lrecPurchaseLine.Validate("Unit of Measure Code", lrecItem."Base Unit of Measure");


        lrecPurchaseLine.Validate("Direct Unit Cost", AmountToApply);
        lrecPurchaseLine."B External Document No." := ImportedPurchLines."Document No.";
        if lrecPurchaseLine.Insert then;
    end;

    local procedure FindExactQuantity(var lrecImportedPurchLines: Record "Imported Purchase Lines"; var grecPurchaseLine: Record "Purchase Line")
    begin
        with lrecImportedPurchLines do begin
            grecPurchLine.SetRange("Quantity Received", 0);
            if grecPurchLine.Find('-') then
                repeat
                    gContinue := true;
                    if grecPurchLineTemp.Get(grecPurchLine."Document Type", grecPurchLine."Document No.", grecPurchLine."Line No.") then
                        if grecPurchLineTemp."Qty. to Receive" = grecPurchLineTemp.Quantity then
                            gContinue := false;

                    if gContinue then begin
                        if (grecPurchLine.Quantity = "Qty. to Receive") then begin
                            if "Direct Unit Cost" <> grecPurchLine."Direct Unit Cost" then begin
                                OldPrice := grecPurchLine."Direct Unit Cost";
                                NewPrice := "Direct Unit Cost";
                                grecPurchLine.Validate("Direct Unit Cost", NewPrice);
                                grecPurchLine."B External Document No." := "Document No.";
                                gErrortxt := text50003 + ' ' + text50004;
                            end else
                                grecPurchLine."B External Document No." := "Document No.";

                            //non Advance Location - Start
                            if not IsAdvanceWarehouse("Location Code") then
                                grecPurchLine.Validate("Qty. to Receive", grecPurchLine.Quantity)
                            else
                                //non Advance Location - End
                                grecPurchLine.Validate("Qty. to Receive", 0);
                            grecPurchLine.Modify;

                            "Purchase Order Created" := true;
                            Modify;

                            DeleteItemTracking(lrecImportedPurchLines, grecPurchLine, grecPurchLine.Quantity);
                            AddItemTracking(lrecImportedPurchLines, grecPurchLine, 0);

                            grecPurchLineTemp := grecPurchLine;
                            grecPurchLineTemp."Qty. to Receive" := "Qty. to Receive";
                            grecPurchLineTemp.Insert;

                            tmpPurchLineForWhsRcpt := grecPurchLine;
                            tmpPurchLineForWhsRcpt.Insert;
                            gEqual := true;
                            gContinue := false;
                            exit;
                        end;
                    end
                until grecPurchLine.Next = 0;
        end;
        gContinue := true;
    end;

    local procedure FindExactRemainingQuantity(var lrecImportedPurchLines: Record "Imported Purchase Lines"; var grecPurchaseLine: Record "Purchase Line")
    begin
        with lrecImportedPurchLines do begin
            grecPurchLine.SetFilter("Quantity Received", '<>%1', 0);
            if grecPurchLine.Find('-') then
                repeat
                    gContinue := true;
                    if grecPurchLineTemp.Get(grecPurchLine."Document Type", grecPurchLine."Document No.", grecPurchLine."Line No.") then
                        if (grecPurchLineTemp."Qty. to Receive" = grecPurchLineTemp.Quantity - grecPurchLineTemp."Quantity Received") then
                            gContinue := false;

                    if grecPurchLine.Quantity = grecPurchLine."Quantity Received" then
                        gContinue := false;


                    if gContinue then begin
                        if (grecPurchLine.Quantity - grecPurchLine."Quantity Received" = "Qty. to Receive") then begin
                            if "Direct Unit Cost" <> grecPurchLine."Direct Unit Cost" then begin
                                OldPrice := grecPurchLine."Direct Unit Cost";
                                NewPrice := "Direct Unit Cost";
                                grecPurchLine.Validate("Direct Unit Cost", NewPrice);
                                grecPurchLine."B External Document No." := "Document No.";
                                gErrortxt := text50003 + ' ' + text50004;
                            end else
                                grecPurchLine."B External Document No." := "Document No.";

                            //non Advance Location - Start
                            if not IsAdvanceWarehouse("Location Code") then
                                grecPurchLine.Validate("Qty. to Receive", grecPurchLine.Quantity)
                            else
                                grecPurchLine.Validate("Qty. to Receive", 0);
                            //non Advance Location - End
                            grecPurchLine.Modify;

                            "Purchase Order Created" := true;
                            Modify;

                            DeleteItemTracking(lrecImportedPurchLines, grecPurchLine, "Qty. to Receive");
                            AddItemTracking(lrecImportedPurchLines, grecPurchLine, "Qty. to Receive");

                            // Keep this line to know it is updated
                            grecPurchLineTemp := grecPurchLine;
                            grecPurchLineTemp."Qty. to Receive" := "Qty. to Receive";
                            grecPurchLineTemp.Insert;
                            // keep this for warehouse receipt
                            tmpPurchLineForWhsRcpt := grecPurchLine;
                            tmpPurchLineForWhsRcpt.Quantity := "Qty. to Receive";
                            tmpPurchLineForWhsRcpt.Insert;
                            gEqual := true;
                            gContinue := false;
                            exit;
                        end;
                    end;
                until grecPurchLine.Next = 0;
        end;
        gContinue := true;
    end;

    local procedure AddToRemainingQuantity(var lrecImportedPurchLines: Record "Imported Purchase Lines"; var grecPurchaseLine: Record "Purchase Line")
    begin
        with lrecImportedPurchLines do begin
            grecPurchLine.SetFilter("Quantity Received", '<>%1', 0);
            if grecPurchLine.Find('-') then
                repeat
                    gContinue := true;
                    if grecPurchLineTemp.Get(grecPurchLine."Document Type", grecPurchLine."Document No.", grecPurchLine."Line No.") then
                        if (grecPurchLineTemp."Qty. to Receive" = grecPurchLineTemp.Quantity - grecPurchLineTemp."Quantity Received") then
                            gContinue := false;

                    if grecPurchLine.Quantity = grecPurchLine."Quantity Received" then
                        gContinue := false;


                    if gContinue then begin
                        if ("Qty. to Receive" < (grecPurchLine.Quantity - grecPurchLine."Quantity Received")) then begin
                            if "Direct Unit Cost" <> grecPurchLine."Direct Unit Cost" then begin
                                OldPrice := grecPurchLine."Direct Unit Cost";
                                NewPrice := "Direct Unit Cost";
                                grecPurchLine.Validate("Direct Unit Cost", NewPrice);
                                grecPurchLine."B External Document No." := "Document No.";
                                gErrortxt := text50003 + ',';
                            end else
                                grecPurchLine."B External Document No." := "Document No.";

                            //non Advance Location - Start
                            if grecPurchLineTemp.Get(grecPurchLine."Document Type", grecPurchLine."Document No.", grecPurchLine."Line No.") then begin
                                if not IsAdvanceWarehouse("Location Code") then
                                    grecPurchLine.Validate("Qty. to Receive", grecPurchLine."Qty. to Receive" + "Qty. to Receive")
                                else
                                    grecPurchLine.Validate("Qty. to Receive", 0);
                            end else begin
                                if not IsAdvanceWarehouse("Location Code") then
                                    grecPurchLine.Validate("Qty. to Receive", "Qty. to Receive")
                                else
                                    grecPurchLine.Validate("Qty. to Receive", 0);
                            end;
                            grecPurchLine.Modify;
                            //non Advance Location - End


                            "Purchase Order Created" := true;
                            Modify;

                            DeleteItemTracking(lrecImportedPurchLines, grecPurchLine, "Qty. to Receive");
                            AddItemTracking(lrecImportedPurchLines, grecPurchLine, "Qty. to Receive");

                            // Keep this line to know it is updated
                            if grecPurchLineTemp.Get(grecPurchLine."Document Type", grecPurchLine."Document No.", grecPurchLine."Line No.") then begin
                                grecPurchLineTemp."Qty. to Receive" += "Qty. to Receive";
                                grecPurchLineTemp.Modify;
                            end else begin
                                grecPurchLineTemp := grecPurchLine;
                                grecPurchLineTemp."Qty. to Receive" := "Qty. to Receive";
                                grecPurchLineTemp.Insert;
                            end;

                            // keep this for warehouse receipt
                            if tmpPurchLineForWhsRcpt.Get(grecPurchLine."Document Type", grecPurchLine."Document No.", grecPurchLine."Line No.") then begin
                                tmpPurchLineForWhsRcpt.Quantity += "Qty. to Receive";
                                tmpPurchLineForWhsRcpt.Modify;
                            end else begin
                                tmpPurchLineForWhsRcpt := grecPurchLine;
                                tmpPurchLineForWhsRcpt.Quantity := "Qty. to Receive";
                                tmpPurchLineForWhsRcpt.Insert;
                            end;
                            gErrortxt := gErrortxt + text50001 + ' ' + text50004;
                            gContinue := false;
                            exit;
                        end
                    end
                until grecPurchLine.Next = 0;
        end;
        gContinue := true;
    end;

    local procedure CloseRemainingQuantity(var lrecImportedPurchLines: Record "Imported Purchase Lines"; var grecPurchaseLine: Record "Purchase Line")
    var
        tmpItemTrackingPurchaseLine: Record "Purchase Line";
    begin
        with lrecImportedPurchLines do begin
            grecPurchLine.SetFilter("Quantity Received", '<>%1', 0);
            if grecPurchLine.Find('-') then
                repeat
                    gContinue := true;
                    if grecPurchLineTemp.Get(grecPurchLine."Document Type", grecPurchLine."Document No.", grecPurchLine."Line No.") then
                        if (grecPurchLineTemp."Qty. to Receive" = grecPurchLineTemp.Quantity - grecPurchLineTemp."Quantity Received") then
                            gContinue := false;

                    if grecPurchLine.Quantity = grecPurchLine."Quantity Received" then
                        gContinue := false;


                    if gContinue then begin
                        if ("Qty. to Receive" > (grecPurchLine.Quantity - grecPurchLine."Quantity Received")) then begin
                            if "Direct Unit Cost" <> grecPurchLine."Direct Unit Cost" then begin
                                OldPrice := grecPurchLine."Direct Unit Cost";
                                NewPrice := "Direct Unit Cost";
                                grecPurchLine.Validate("Direct Unit Cost", NewPrice);
                                grecPurchLine."B External Document No." := "Document No.";
                                gErrortxt := text50003 + ',';
                            end else
                                grecPurchLine."B External Document No." := "Document No.";

                            lDifference := grecPurchLine.Quantity - grecPurchLine."Quantity Received";
                            //non Advance Location - Start
                            if not IsAdvanceWarehouse("Location Code") then
                                grecPurchLine.Validate("Qty. to Receive", lDifference)
                            else
                                grecPurchLine.Validate("Qty. to Receive", 0);
                            grecPurchLine.Modify;
                            //non Advance Location - End

                            DeleteItemTracking(lrecImportedPurchLines, grecPurchLine, lDifference);
                            AddItemTracking(lrecImportedPurchLines, grecPurchLine, lDifference);

                            grecPurchLineTemp := grecPurchLine;
                            grecPurchLineTemp."Qty. to Receive" := lDifference;
                            grecPurchLineTemp.Insert;

                            tmpPurchLineForWhsRcpt := grecPurchLine;
                            tmpPurchLineForWhsRcpt.Quantity := lDifference;
                            tmpPurchLineForWhsRcpt.Insert;

                            NewLineNo := grecPurchLine."Line No.";
                            NewLineNo += 500;
                            lDifference := "Qty. to Receive" - lDifference;
                            CreateNewLine(lrecImportedPurchLines, true, lDifference);
                            gErrortxt := gErrortxt + text50001 + ' ' + text50004 + ',' + text50002;
                            gContinue := false;
                            exit;
                        end
                    end
                until grecPurchLine.Next = 0;
        end;
        gContinue := true;
    end;

    local procedure AddToAvailableQuantity(var lrecImportedPurchLines: Record "Imported Purchase Lines"; var grecPurchaseLine: Record "Purchase Line")
    var
        tmpItemTrackingPurchaseLine: Record "Purchase Line";
    begin
        with lrecImportedPurchLines do begin
            grecPurchLine.SetRange("Quantity Received", 0);
            if grecPurchLine.Find('-') then
                repeat
                    gContinue := true;
                    if grecPurchLineTemp.Get(grecPurchLine."Document Type", grecPurchLine."Document No.", grecPurchLine."Line No.") then
                        if (grecPurchLineTemp."Qty. to Receive" = grecPurchLineTemp.Quantity) or
                            ("Qty. to Receive" > grecPurchLineTemp.Quantity - grecPurchLineTemp."Qty. to Receive") then
                            gContinue := false;

                    if gContinue then begin
                        if ("Qty. to Receive" <= grecPurchLine.Quantity) then begin
                            if "Direct Unit Cost" <> grecPurchLine."Direct Unit Cost" then begin
                                OldPrice := grecPurchLine."Direct Unit Cost";
                                NewPrice := "Direct Unit Cost";
                                grecPurchLine.Validate("Direct Unit Cost", NewPrice);
                                grecPurchLine."B External Document No." := "Document No.";
                                gErrortxt := text50003 + ',';
                            end else
                                grecPurchLine."B External Document No." := "Document No.";

                            //non Advance Location - Start
                            if grecPurchLineTemp.Get(grecPurchLine."Document Type", grecPurchLine."Document No.", grecPurchLine."Line No.") then begin
                                if not IsAdvanceWarehouse("Location Code") then
                                    grecPurchLine.Validate("Qty. to Receive", grecPurchLine."Qty. to Receive" + "Qty. to Receive")
                                else
                                    grecPurchLine.Validate("Qty. to Receive", 0);
                            end else begin
                                if not IsAdvanceWarehouse("Location Code") then
                                    grecPurchLine.Validate("Qty. to Receive", "Qty. to Receive")
                                else
                                    grecPurchLine.Validate("Qty. to Receive", 0);
                            end;

                            grecPurchLine.Modify;
                            //non Advance Location - End

                            "Purchase Order Created" := true;
                            Modify;

                            DeleteItemTracking(lrecImportedPurchLines, grecPurchLine, "Qty. to Receive");
                            AddItemTracking(lrecImportedPurchLines, grecPurchLine, "Qty. to Receive");

                            if grecPurchLineTemp.Get(grecPurchLine."Document Type", grecPurchLine."Document No.", grecPurchLine."Line No.") then begin
                                grecPurchLineTemp."Qty. to Receive" += "Qty. to Receive";
                                grecPurchLineTemp.Modify;
                            end else begin
                                grecPurchLineTemp := grecPurchLine;
                                grecPurchLineTemp."Qty. to Receive" := "Qty. to Receive";
                                grecPurchLineTemp.Insert;
                            end;

                            // keep this for warehouse receipt
                            if tmpPurchLineForWhsRcpt.Get(grecPurchLine."Document Type", grecPurchLine."Document No.", grecPurchLine."Line No.") then begin
                                tmpPurchLineForWhsRcpt.Quantity += "Qty. to Receive";
                                tmpPurchLineForWhsRcpt.Modify;
                            end else begin
                                tmpPurchLineForWhsRcpt := grecPurchLine;
                                tmpPurchLineForWhsRcpt.Quantity := "Qty. to Receive";
                                tmpPurchLineForWhsRcpt.Insert;
                            end;
                            gErrortxt := gErrortxt + text50001 + ' ' + text50004;
                            gContinue := false;
                            exit;
                        end;
                    end;
                until grecPurchLine.Next = 0;
        end;
        gContinue := true;
    end;

    local procedure CloseAvailableQuantity(var lrecImportedPurchLines: Record "Imported Purchase Lines"; var grecPurchaseLine: Record "Purchase Line")
    var
        tmpItemTrackingPurchaseLine: Record "Purchase Line";
        CurrentQty: Decimal;
    begin
        with lrecImportedPurchLines do begin
            grecPurchLine.SetRange("Quantity Received", 0);
            if grecPurchLine.Find('-') then
                repeat
                    gContinue := true;
                    CurrentQty := grecPurchLine.Quantity;
                    if grecPurchLineTemp.Get(grecPurchLine."Document Type", grecPurchLine."Document No.", grecPurchLine."Line No.") then
                        if (grecPurchLineTemp."Qty. to Receive" = grecPurchLineTemp.Quantity) then
                            gContinue := false
                        else
                            CurrentQty := grecPurchLineTemp.Quantity - grecPurchLineTemp."Qty. to Receive";

                    if gContinue then begin
                        if ("Qty. to Receive" > CurrentQty) then begin
                            if "Direct Unit Cost" <> grecPurchLine."Direct Unit Cost" then begin
                                OldPrice := grecPurchLine."Direct Unit Cost";
                                NewPrice := "Direct Unit Cost";
                                grecPurchLine.Validate("Direct Unit Cost", NewPrice);
                                grecPurchLine."B External Document No." := "Document No.";
                                gErrortxt := text50003 + ',';
                            end else
                                grecPurchLine."B External Document No." := "Document No.";

                            //non Advance Location - Start
                            if grecPurchLineTemp.Get(grecPurchLine."Document Type", grecPurchLine."Document No.", grecPurchLine."Line No.") then begin
                                if not IsAdvanceWarehouse("Location Code") then
                                    grecPurchLine.Validate("Qty. to Receive", grecPurchLine."Qty. to Receive" + CurrentQty)
                                else
                                    grecPurchLine.Validate("Qty. to Receive", 0);
                            end else begin
                                if not IsAdvanceWarehouse("Location Code") then
                                    grecPurchLine.Validate("Qty. to Receive", CurrentQty)
                                else
                                    grecPurchLine.Validate("Qty. to Receive", 0);
                            end;

                            grecPurchLine.Modify;
                            //non Advance Location - End

                            lDifference := CurrentQty;
                            DeleteItemTracking(lrecImportedPurchLines, grecPurchLine, lDifference);
                            AddItemTracking(lrecImportedPurchLines, grecPurchLine, lDifference);

                            if grecPurchLineTemp.Get(grecPurchLine."Document Type", grecPurchLine."Document No.", grecPurchLine."Line No.") then begin
                                grecPurchLineTemp."Qty. to Receive" += lDifference;
                                grecPurchLineTemp.Modify;
                            end else begin
                                grecPurchLineTemp := grecPurchLine;
                                grecPurchLineTemp."Qty. to Receive" := lDifference;
                                grecPurchLineTemp.Insert;
                            end;

                            // keep this for warehouse receipt
                            if tmpPurchLineForWhsRcpt.Get(grecPurchLine."Document Type", grecPurchLine."Document No.", grecPurchLine."Line No.") then begin
                                tmpPurchLineForWhsRcpt.Quantity += lDifference;
                                tmpPurchLineForWhsRcpt.Modify;
                            end else begin
                                tmpPurchLineForWhsRcpt := grecPurchLine;
                                tmpPurchLineForWhsRcpt.Quantity := lDifference;
                                tmpPurchLineForWhsRcpt.Insert;
                            end;



                            NewLineNo := grecPurchLine."Line No.";
                            NewLineNo += 500;
                            lDifference := "Qty. to Receive" - lDifference;
                            CreateNewLine(lrecImportedPurchLines, true, lDifference);
                            gErrortxt := gErrortxt + text50001 + ' ' + text50004 + ',' + text50002;
                            gContinue := false;
                            exit;
                        end;
                    end;
                until grecPurchLine.Next = 0;
        end;
        gContinue := true;
    end;

    local procedure AddItemTracking(var lrecImportedPurchLines: Record "Imported Purchase Lines"; var lrecPurchaseLine: Record "Purchase Line"; Difference: Decimal)
    begin
        with lrecImportedPurchLines do begin
            if "Lot No." <> '' then begin
                grecLotNoInformation.SetRange("Item No.", "No.");
                grecLotNoInformation.SetRange("Lot No.", "Lot No.");
                if not grecLotNoInformation.Find('-') then begin
                    grecLotNoInformation.Init;
                    grecLotNoInformation."Item No." := "No.";
                    grecLotNoInformation."Lot No." := "Lot No.";

                    grecLotNoInformation."B Remark" := "Remark Bejo NL";
                    grecLotNoInformation.Insert;
                end;
                grecLotNoInformation."B Tsw. in gr." := "Tsw. in gr.";
                grecLotNoInformation."B Germination" := Germination;
                grecLotNoInformation."B Abnormals" := Abnormals;
                grecLotNoInformation."B Grade Code" := "Grade Code";
                grecLotNoInformation."B Best used by" := "Best used by";
                grecLotNoInformation."B Treatment Code" := "Treatment Code";
                grecLotNoInformation."B Variety" := Variety;
                grecLotNoInformation."B Test Date" := "Test Date";
                grecLotNoInformation."B Multi Germination" := "Multi Germination";
                grecLotNoInformation.Modify;

                grecReservationEntry.Lock;
                grecReservationEntry.Reset;
                if not grecReservationEntry.FindLast then
                    grecReservationEntry."Entry No." := 1
                else
                    grecReservationEntry."Entry No." += 1;
                grecReservationEntry.Positive := true;
                grecReservationEntry.Init;
                grecReservationEntry."Item No." := lrecPurchaseLine."No.";
                grecReservationEntry."Location Code" := lrecPurchaseLine."Location Code";
                grecReservationEntry."Reservation Status" := grecReservationEntry."Reservation Status"::Surplus;
                grecReservationEntry."Creation Date" := Today;
                grecReservationEntry."Source Type" := DATABASE::"Purchase Line";
                grecReservationEntry."Source Subtype" := lrecPurchaseLine."Document Type";
                grecReservationEntry."Source Ref. No." := lrecPurchaseLine."Line No.";
                grecReservationEntry."Source ID" := lrecPurchaseLine."Document No.";
                grecReservationEntry."Created By" := UserId;
                grecReservationEntry."Qty. per Unit of Measure" := lrecPurchaseLine."Qty. per Unit of Measure";
                if Difference <> 0 then begin
                    grecReservationEntry.Quantity := Difference;
                    grecReservationEntry."Quantity (Base)" := Difference * lrecPurchaseLine."Qty. per Unit of Measure";
                    grecReservationEntry."Qty. to Handle (Base)" := Difference * lrecPurchaseLine."Qty. per Unit of Measure";
                    grecReservationEntry."Qty. to Invoice (Base)" := Difference * lrecPurchaseLine."Qty. per Unit of Measure";
                end else begin
                    grecReservationEntry."Quantity (Base)" := lrecPurchaseLine."Quantity (Base)";
                    grecReservationEntry.Quantity := lrecPurchaseLine.Quantity;
                    grecReservationEntry."Qty. to Handle (Base)" := lrecPurchaseLine."Quantity (Base)";
                    grecReservationEntry."Qty. to Invoice (Base)" := lrecPurchaseLine."Qty. to Invoice (Base)";
                end;
                grecReservationEntry."Lot No." := "Lot No.";
                grecReservationEntry."Item Tracking" := grecReservationEntry."Item Tracking"::"Lot No.";
                grecReservationEntry.Insert;
            end;

        end;
    end;

    local procedure CreateFromUpdateOriginalOrder(PurchHeader: Record "Purchase Header") WhseRcptNo: Code[20]
    var
        WhseRqst: Record "Warehouse Request";
        WhseRcptHeader: Record "Warehouse Receipt Header";
        GetSourceDocuments: Report "Get Source Documents";
    begin
        with PurchHeader do begin
            TestField(Status, Status::Released);
            WhseRqst.SetRange(Type, WhseRqst.Type::Inbound);
            WhseRqst.SetRange("Source Type", DATABASE::"Purchase Line");
            WhseRqst.SetRange("Source Subtype", "Document Type");
            WhseRqst.SetRange("Source No.", "No.");
            WhseRqst.SetRange("Document Status", WhseRqst."Document Status"::Released);

            if WhseRqst.Find('-') then begin
                //GetSourceDocuments.USEREQUESTFORM(FALSE);//not valid for pages
                GetSourceDocuments.SetTableView(WhseRqst);
                GetSourceDocuments.SetHideDialog(true); //To supress Whse Rcpt crested message
                GetSourceDocuments.RunModal;
                GetSourceDocuments.GetLastReceiptHeader(WhseRcptHeader);
                exit(WhseRcptHeader."No.");
            end;
        end;
    end;

    local procedure AddAnotherInboundDoc(WhseReceiptHeader: Record "Warehouse Receipt Header"; PurchHeader: Record "Purchase Header")
    var
        WhseRqst: Record "Warehouse Request";
        SourceDocSelection: Page "Source Documents";
        GetSourceDocuments: Report "Get Source Documents";
    begin
        WhseReceiptHeader.Find;

        with PurchHeader do begin
            TestField(Status, Status::Released);
            WhseRqst.SetRange(Type, WhseRqst.Type::Inbound);
            WhseRqst.SetRange("Source Type", DATABASE::"Purchase Line");
            WhseRqst.SetRange("Source Subtype", "Document Type");
            WhseRqst.SetRange("Source No.", "No.");
            WhseRqst.SetRange("Document Status", WhseRqst."Document Status"::Released);

            if WhseRqst.Find('-') then begin
                GetSourceDocuments.SetOneCreatedReceiptHeader(WhseReceiptHeader);

                GetSourceDocuments.SetTableView(WhseRqst);
                GetSourceDocuments.SetHideDialog(true); //To supress Whse Rcpt crested message
                GetSourceDocuments.RunModal;
            end;
        end;
    end;

    procedure IsAdvanceWarehouse(LocationCode: Code[10]): Boolean
    var
        Locations: Record Location;
    begin
        Locations.Get(LocationCode);
        exit(Locations."Directed Put-away and Pick");
    end;
}

