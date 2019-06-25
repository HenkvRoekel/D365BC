report 50097 "Delete Original Purchase Line"
{
    DefaultLayout = RDLC;
    RDLCLayout = './RDLC/Delete Original Purchase Line.rdlc';

    Caption = 'Delete Original Purchase Line';

    dataset
    {
        dataitem("Purchase Line"; "Purchase Line")
        {
            DataItemTableView = WHERE (Type = CONST (Item));
            RequestFilterFields = "Document No.";
            column(COMPANYNAME; CompanyName)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(USERID; UserId)
            {
            }
            column(Purchase_Line__Document_No__; "Document No.")
            {
            }
            column(Purchase_Line__Line_No__; "Line No.")
            {
            }
            column(Purchase_Line__No__; "No.")
            {
            }
            column(grecPurchaseLine__Qty__to_Receive__Base__; grecPurchaseLine."Qty. to Receive (Base)")
            {
                DecimalPlaces = 0 : 2;
            }
            column(grecPurchaseLine__No__; grecPurchaseLine."No.")
            {
            }
            column(grecPurchaseLine__Line_No__; grecPurchaseLine."Line No.")
            {
            }
            column(Purchase_Line__Purchase_Line___External_Document_No__; "Purchase Line"."B External Document No.")
            {
            }
            column(gEqual; gEqual)
            {
            }
            column(gDeleted; gDeleted)
            {
            }
            column(grecPurchaseLine__Unit_of_Measure_Code_; grecPurchaseLine."Unit of Measure Code")
            {
            }
            column(Purchase_Line__Qty__to_Receive__Base__; "Qty. to Receive (Base)")
            {
            }
            column(Purchase_Line_Description; Description)
            {
            }
            column(Purchase_Line__Unit_of_Measure_Code_; "Unit of Measure Code")
            {
            }
            column(gErrortxt_1_; gErrortxt[1])
            {
            }
            column(gErrortxt_2_; gErrortxt[2])
            {
            }
            column(Purchase_Line__Document_No__Caption; FieldCaption("Document No."))
            {
            }
            column(Purchase_Line__Line_No__Caption; FieldCaption("Line No."))
            {
            }
            column(Purchase_Line__No__Caption; FieldCaption("No."))
            {
            }
            column(grecPurchaseLine__Qty__to_Receive__Base__Caption; grecPurchaseLine__Qty__to_Receive__Base__CaptionLbl)
            {
            }
            column(grecPurchaseLine__No__Caption; grecPurchaseLine__No__CaptionLbl)
            {
            }
            column(grecPurchaseLine__Line_No__Caption; grecPurchaseLine__Line_No__CaptionLbl)
            {
            }
            column(Purchase_Line__Purchase_Line___External_Document_No__Caption; Purchase_Line__Purchase_Line___External_Document_No__CaptionLbl)
            {
            }
            column(Purchase_Order_Import_NLCaption; Purchase_Order_Import_NLCaptionLbl)
            {
            }
            column(Purchase_Order_OriginalCaption; Purchase_Order_OriginalCaptionLbl)
            {
            }
            column(CheckCaption; CheckCaptionLbl)
            {
            }
            column(DeletedCaption; DeletedCaptionLbl)
            {
            }
            column(MatchCaption; MatchCaptionLbl)
            {
            }
            column(grecPurchaseLine__Unit_of_Measure_Code_Caption; grecPurchaseLine__Unit_of_Measure_Code_CaptionLbl)
            {
            }
            column(Delete_Original_Purchase_LineCaption; Delete_Original_Purchase_LineCaptionLbl)
            {
            }
            column(PageCaption; PageCaptionLbl)
            {
            }
            column(Purchase_Line__Qty__to_Receive__Base__Caption; Purchase_Line__Qty__to_Receive__Base__CaptionLbl)
            {
            }
            column(Purchase_Line_DescriptionCaption; FieldCaption(Description))
            {
            }
            column(Purchase_Line__Unit_of_Measure_Code_Caption; Purchase_Line__Unit_of_Measure_Code_CaptionLbl)
            {
            }
            column(Purchase_Line_Document_Type; "Document Type")
            {
            }

            trigger OnAfterGetRecord()
            var
                lExternalDocumentNo: Decimal;
                TempExternalDocumentNo: Code[20];
                lPlace: Integer;
                lcuBejoManagement: Codeunit "Bejo Management";
                lAlternativeItemNo: Code[20];
            begin
                Clear(gEqual);
                Clear(gDeleted);
                Clear(gQtyFound);

                // - BEJOWW5.0.007 ---
                lExternalDocumentNo := 0;
                if StrLen("B External Document No.") > 0 then
                    repeat
                        lPlace := lPlace + 1;
                        TempExternalDocumentNo := CopyStr("B External Document No.", lPlace, StrLen("B External Document No."));
                    until Evaluate(lExternalDocumentNo, TempExternalDocumentNo) or (lPlace = StrLen("B External Document No."));
                // + BEJOWW5.0.007 +++

                grecPurchaseLine.Reset;
                // grecPurchaseLine.SETRANGE("Document No.","External Document No.");        // BEJOWW5.0.007
                // grecPurchaseLine.SETFILTER("Document No.",'*'+FORMAT(lExternalDocumentNo));  // BEJOWW5.0.007
                // - BEJOWW6.00.016 --- RFC 63343
                if TempExternalDocumentNo = ''
                  then grecPurchaseLine.SetFilter("Document No.", '<>%1', "Document No.")
                else
                    // + BEJOWW6.00.016 +++  RFC 63343
                    grecPurchaseLine.SetFilter("Document No.", '*' + TempExternalDocumentNo);  // BEJOWW5.0.007 HOTFIX
                grecPurchaseLine.SetRange("Document Type", grecPurchaseLine."Document Type"::Order);
                grecPurchaseLine.SetRange(Type, Type::Item);

                // - BEJOWW5.01.007 issue 6475 ---
                if lcuBejoManagement.GetAlternativeItemNo("No.", lAlternativeItemNo) then
                    grecPurchaseLine.SetFilter("No.", '%1|%2', "No.", lAlternativeItemNo)
                else
                    grecPurchaseLine.SetRange("No.", "No.");
                // + BEJOWW5.01.007 issue 6475 +++

                if not grecPurchaseLine.Find('-') then begin
                    grecPurchaseLine.Init;
                    grecPurchaseLine."Document No." := '';
                    grecPurchaseLine."Line No." := 0;
                    Clear(gErrortxt);
                end else begin
                    // QtyFound := "Purchase Line".COUNT; // BEJOWW5.0.007
                    gQtyFound := grecPurchaseLine.Count;    // BEJOWW5.0.007 Count on the wrong variable

                    if ((grecPurchaseLine."No." = "No.") or (grecPurchaseLine."No." = lAlternativeItemNo)) and // - BEJOWW5.01.007 issue 6475 ---
                        (grecPurchaseLine."Qty. per Unit of Measure" = "Qty. per Unit of Measure") and
                       (grecPurchaseLine."Qty. to Receive (Base)" = "Qty. to Receive (Base)") then begin
                        gEqual := true
                    end else begin
                        if gQtyFound > 1 then begin
                            grecPurchaseLineTemp := grecPurchaseLine;
                            grecPurchaseLine.SetRange("Qty. per Unit of Measure", "Qty. per Unit of Measure");
                            if (grecPurchaseLine.Find('-')) and (grecPurchaseLine."Qty. to Receive (Base)" = "Qty. to Receive (Base)") then
                                gEqual := true
                            else
                                gErrortxt[2] := StrSubstNo(text50001);
                        end else begin
                            grecPurchaseLine := grecPurchaseLineTemp;
                            gEqual := false;
                            Clear(gErrortxt);
                            if grecPurchaseLine."Qty. per Unit of Measure" <> "Qty. per Unit of Measure" then
                                gErrortxt[1] := StrSubstNo(text50000);
                            if (grecPurchaseLine."Qty. to Receive (Base)" <> "Qty. to Receive (Base)") then
                                gErrortxt[2] := StrSubstNo(text50001);
                        end;
                    end;
                end;
                if (gEqual = true) then
                    Clear(gErrortxt);
                if (gEqual = true) and (gDeleteEqual = true) then begin
                    gDeleted := true;
                    MoveTextLines(grecPurchaseLine, "Purchase Line");
                    // - BEJOW19.00.22 --- 100626
                    // grecPurchaseLine.DELETE;
                    grecPurchaseLine.Delete(true);
                    // + BEJOW19.00.22 +++ 100626
                    // - BEJOWW6.00.014 --- Issue 13906
                    DeletePurchHeaderIfNoLines(grecPurchaseLine."Document Type", grecPurchaseLine."Document No.");
                    // + BEJOWW6.00.014 +++ Issue 13906
                end;

                // 030108 Geen meldingen tonen + beperkte info van niet overeenkomstige regels tonen
                if gEqual = false then begin
                    Clear(gErrortxt);
                    Clear(grecPurchaseLine."Line No.");
                    Clear(grecPurchaseLine."No."); // BEJOWW5.01.012
                    Clear(grecPurchaseLine."Qty. to Receive (Base)");
                    Clear(grecPurchaseLine."Unit of Measure Code");
                    Clear(grecPurchaseLine."Outstanding Amount");
                end;
                //
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
                    field(gDeleteEqual; gDeleteEqual)
                    {
                        Caption = 'Delete Original Lines';
                        MultiLine = true;
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

    var
        grecPurchaseLine: Record "Purchase Line";
        grecPurchaseLineTemp: Record "Purchase Line";
        gEqual: Boolean;
        gDeleteEqual: Boolean;
        gDeleted: Boolean;
        gErrortxt: array[5] of Text[30];
        text50000: Label 'Different Unit';
        text50001: Label 'Different Quantity';
        gQtyFound: Integer;
        gcuBejoMgt: Codeunit "Bejo Management";
        grecPurchaseLine__Qty__to_Receive__Base__CaptionLbl: Label 'Quantity';
        grecPurchaseLine__No__CaptionLbl: Label 'No.';
        grecPurchaseLine__Line_No__CaptionLbl: Label 'Line No.';
        Purchase_Line__Purchase_Line___External_Document_No__CaptionLbl: Label 'Document No.';
        Purchase_Order_Import_NLCaptionLbl: Label 'Purchase Order Import NL';
        Purchase_Order_OriginalCaptionLbl: Label 'Purchase Order Original';
        CheckCaptionLbl: Label 'Check';
        DeletedCaptionLbl: Label 'Deleted';
        MatchCaptionLbl: Label 'Match';
        grecPurchaseLine__Unit_of_Measure_Code_CaptionLbl: Label 'Unit';
        Delete_Original_Purchase_LineCaptionLbl: Label 'Delete Original Purchase Line';
        PageCaptionLbl: Label 'Page';
        Purchase_Line__Qty__to_Receive__Base__CaptionLbl: Label 'Quantity';
        Purchase_Line__Unit_of_Measure_Code_CaptionLbl: Label 'Unit';

    procedure MoveTextLines(OriginalPurchaseLine: Record "Purchase Line"; NewPurchaseLine: Record "Purchase Line")
    var
        lrecPurchCommentLine: Record "Purch. Comment Line";
        lrecPurchCommentLineNew: Record "Purch. Comment Line";
    begin
        // - BEJOW19.00.22 --- 100626
        // KEY:: Document Type,No.,Document Line No.,Line No.
        lrecPurchCommentLine.SetRange("Document Type", OriginalPurchaseLine."Document Type");
        lrecPurchCommentLine.SetRange("No.", OriginalPurchaseLine."Document No.");
        lrecPurchCommentLine.SetRange("Document Line No.", OriginalPurchaseLine."Line No.");

        if lrecPurchCommentLine.FindSet(false, false) then
            repeat
                lrecPurchCommentLineNew.Copy(lrecPurchCommentLine);
                lrecPurchCommentLineNew."No." := NewPurchaseLine."Document No.";
                lrecPurchCommentLineNew."Document Line No." := NewPurchaseLine."Line No.";
                lrecPurchCommentLineNew.Insert();
            until lrecPurchCommentLine.Next = 0;
    end;

    procedure DeletePurchHeaderIfNoLines(DocType: Option "0","1","2","3","4","5","6","7","8","9"; DocNo: Code[20])
    var
        lrecPurchHeader: Record "Purchase Header";
        lrecPurchLine: Record "Purchase Line";
    begin
        // - BEJOWW6.00.014 --- Issue 13906
        lrecPurchLine.SetRange("Document Type", DocType);
        lrecPurchLine.SetRange("Document No.", DocNo);
        if lrecPurchLine.IsEmpty then
            if lrecPurchHeader.Get(DocType, DocNo) then
                lrecPurchHeader.Delete;
        // + BEJOWW6.00.014 +++ Issue 13906
    end;
}

