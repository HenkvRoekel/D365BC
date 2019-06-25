page 50050 "ADP Interface"
{

    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Worksheet;
    SaveValues = false;
    ShowFilter = false;
    SourceTable = "Payment Jnl. Export Error Text";
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            group(Posting)
            {
                Caption = 'Posting';
                field("Journal Template"; grecBejoSetup."ADP Journal Template Name")
                {

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        if PAGE.RunModal(PAGE::"General Journal Templates", grecGenJnlTempl) = ACTION::LookupOK then begin
                            grecBejoSetup."ADP Journal Template Name" := grecGenJnlTempl.Name;
                            grecBejoSetup."ADP Journal Batch Name" := '';
                            grecBejoSetup.Modify;
                            grecGenJnlTempl.Reset;
                        end;
                    end;

                    trigger OnValidate()
                    begin
                        if not grecGenJnlTempl.Get(grecBejoSetup."ADP Journal Template Name") then
                            Error(txtErrorJnlTemplNotValid);

                        grecGenJnlTempl.Reset;
                        grecBejoSetup.Modify;
                    end;
                }
                field("Journal Batch"; grecBejoSetup."ADP Journal Batch Name")
                {

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        grecGenJnlBatch.SetRange("Journal Template Name", grecBejoSetup."ADP Journal Template Name");
                        if PAGE.RunModal(PAGE::"General Journal Batches", grecGenJnlBatch) = ACTION::LookupOK then begin
                            grecBejoSetup."ADP Journal Batch Name" := grecGenJnlBatch.Name;
                            grecBejoSetup.Modify;
                            grecGenJnlBatch.Reset;
                        end;
                    end;

                    trigger OnValidate()
                    begin
                        if not grecGenJnlBatch.Get(grecBejoSetup."ADP Journal Batch Name") then
                            Error(txtErrorJnlBatchNotValid);

                        grecGenJnlBatch.Reset;
                        grecBejoSetup.Modify;
                    end;
                }
                field(Date; gdatPostingDate)
                {
                    Caption = 'Posting Date';
                }
                field("Document Number"; gcodDocNo)
                {
                    Caption = 'Document No.';
                }
            }
            group("Excel Import")
            {
                Caption = 'Excel Import';
                field("Excel Workbook"; gtxtFilename)
                {
                    AssistEdit = true;
                    Caption = 'Excel Workbook';

                    trigger OnAssistEdit()
                    var
                        TextWindowTitle: Label 'Select a file to import...';
                        TextFilter: Label 'Excel documents (*.xls*)|*.xls*';
                    begin
                        gtxtFilename := gcuFileMgmt.OpenFileDialog(TextWindowTitle, '', TextFilter);
                        //gtxtServerFilename := gcuFileMgmt.UploadFileSilent(gtxtFilename);
                    end;
                }
                field("Excel Worksheet"; gtxtSheetname)
                {
                    Caption = 'Excel Worksheet';
                    Lookup = true;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        //gtxtSheetname := grecExcelBuffer.SelectSheetsName(gtxtServerFilename);
                    end;
                }
                field("First Excel line to import"; grecBejoSetup."ADP First line to import")
                {
                    Caption = 'First Excel line to import';

                    trigger OnValidate()
                    begin
                        if grecBejoSetup."ADP First line to import" < 1 then
                            grecBejoSetup."ADP First line to import" := 2;

                        grecBejoSetup.Modify;
                    end;
                }
                field("Excel Format"; grecBejoSetup."ADP Excel Format")
                {
                    Caption = 'Excel Format';

                    trigger OnValidate()
                    begin
                        grecBejoSetup.Modify;
                    end;
                }
            }
            group(Dimensions)
            {
                field("Dimension 1"; grecBejoSetup."ADP Shortcut Dimension 1 Code")
                {
                    Editable = false;
                }
                field("Dimension 2"; grecBejoSetup."ADP Shortcut Dimension 2 Code")
                {
                    Editable = false;
                }
                field("Dimension 3"; grecBejoSetup."ADP Shortcut Dimension 3 Code")
                {

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        if PAGE.RunModal(PAGE::Dimensions, grecDimension) = ACTION::LookupOK then begin
                            grecBejoSetup."ADP Shortcut Dimension 3 Code" := grecDimension.Code;
                            grecBejoSetup.Modify;
                            grecDimension.Reset;
                        end;
                    end;

                    trigger OnValidate()
                    begin
                        if not grecDimension.Get(grecBejoSetup."ADP Shortcut Dimension 3 Code") then
                            Error(txtErrorDimNotValid);

                        grecDimension.Reset;
                        grecBejoSetup.Modify;
                    end;
                }
                field("Dimension 4"; grecBejoSetup."ADP Shortcut Dimension 4 Code")
                {

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        if PAGE.RunModal(PAGE::Dimensions, grecDimension) = ACTION::LookupOK then begin
                            grecBejoSetup."ADP Shortcut Dimension 4 Code" := grecDimension.Code;
                            grecBejoSetup.Modify;
                            grecDimension.Reset;
                        end;
                    end;

                    trigger OnValidate()
                    begin
                        if not grecDimension.Get(grecBejoSetup."ADP Shortcut Dimension 4 Code") then
                            Error(txtErrorDimNotValid);

                        grecDimension.Reset;
                        grecBejoSetup.Modify;
                    end;
                }
            }
            repeater(Errors)
            {
                Editable = false;
                field(Line; "Support URL")
                {
                    Caption = 'Line';
                    Editable = false;
                    Width = 3;
                }
                field(Column; "Additional Information")
                {
                    Caption = 'Column';
                    Editable = false;
                    Width = 2;
                }
                field(Error; "Error Text")
                {
                    Caption = 'Error';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Import)
            {
                Caption = 'Import';
                action(ImportFile)
                {
                    Caption = 'Import Excel file';
                    Image = ImportExcel;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        lrecGenJnlLine: Record "Gen. Journal Line";
                    begin
                        if grecBejoSetup."ADP Journal Template Name" = '' then Error(txtErrorJnlTemplEmpty);
                        if grecBejoSetup."ADP Journal Batch Name" = '' then Error(txtErrorJnlBatchEmpty);
                        if gdatPostingDate = 0D then Error(txtErrorPostingDateEmpty);
                        if gcodDocNo = '' then Error(txtErrorDocNoEmpty);
                        if gtxtFilename = '' then Error(txtErrorExcelBookEmpty);
                        if gtxtSheetname = '' then Error(txtErrorExcelSheetEmpty);
                        if grecBejoSetup."ADP First line to import" < 1 then Error(txtErrorFirstLineEmpty);
                        if grecBejoSetup."ADP Shortcut Dimension 3 Code" = '' then Error(txtErrorDim3lEmpty);
                        if grecBejoSetup."ADP Shortcut Dimension 4 Code" = '' then Error(txtErrorDim4lEmpty);

                        with lrecGenJnlLine do begin
                            SetRange("Journal Template Name", grecBejoSetup."ADP Journal Template Name");
                            SetRange("Journal Batch Name", grecBejoSetup."ADP Journal Batch Name");
                            if FindFirst then Error(txtErrorJnlNotEmpty);
                        end;

                        gintErrorLine := 0;
                        DeleteAll;

                        case grecBejoSetup."ADP Excel Format" of
                            grecBejoSetup."ADP Excel Format"::Standard:
                                begin
                                    ImportStandardExcel(gtxtFilename,
                                              gtxtSheetname,
                                              gtxtPostingDescription,
                                              grecBejoSetup."ADP First line to import",
                                              grecBejoSetup."ADP Journal Template Name",
                                              grecBejoSetup."ADP Journal Batch Name",
                                              gcodDocNo,
                                              gdatPostingDate)
                                end;
                            grecBejoSetup."ADP Excel Format"::"Standard Detailed":
                                begin
                                    ImportStandardDetailedExcel(gtxtFilename,
                                              gtxtSheetname,
                                              gtxtPostingDescription,
                                              grecBejoSetup."ADP First line to import",
                                              grecBejoSetup."ADP Journal Template Name",
                                              grecBejoSetup."ADP Journal Batch Name",
                                              gcodDocNo,
                                              gdatPostingDate);
                                end;
                            grecBejoSetup."ADP Excel Format"::Custom:
                                begin
                                    ImportCustomExcel(gtxtFilename,
                                              gtxtSheetname,
                                              gtxtPostingDescription,
                                              grecBejoSetup."ADP First line to import",
                                              grecBejoSetup."ADP Journal Template Name",
                                              grecBejoSetup."ADP Journal Batch Name",
                                              gcodDocNo,
                                              gdatPostingDate);
                                end;
                        end;
                    end;
                }
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    var
        ErrorCannotDelete: Label 'Only incoming records with no errors can be deleted. Use the actions to delete errors and processed records.';
    begin
    end;

    trigger OnInit()
    var
        lrecGenLedgSetup: Record "General Ledger Setup";
    begin
        grecBejoSetup.Get;
        lrecGenLedgSetup.Get;
        gbolHasRunImport := false;

        if grecBejoSetup."ADP Shortcut Dimension 1 Code" = '' then
            grecBejoSetup."ADP Shortcut Dimension 1 Code" := lrecGenLedgSetup."Shortcut Dimension 1 Code";
        if grecBejoSetup."ADP Shortcut Dimension 2 Code" = '' then
            grecBejoSetup."ADP Shortcut Dimension 2 Code" := lrecGenLedgSetup."Shortcut Dimension 2 Code";
        if grecBejoSetup."ADP Shortcut Dimension 3 Code" = '' then
            grecBejoSetup."ADP Shortcut Dimension 3 Code" := lrecGenLedgSetup."Shortcut Dimension 3 Code";
        if grecBejoSetup."ADP Shortcut Dimension 4 Code" = '' then
            grecBejoSetup."ADP Shortcut Dimension 4 Code" := lrecGenLedgSetup."Shortcut Dimension 4 Code";

        if grecBejoSetup."ADP First line to import" < 1 then
            grecBejoSetup."ADP First line to import" := 2;

        if grecBejoSetup."ADP Journal Template Name" = '' then begin
            if grecGenJnlTempl.Get('GENERAL') then
                grecBejoSetup."ADP Journal Template Name" := 'GENERAL';
        end;

        if (grecBejoSetup."ADP Journal Template Name" <> '') and (grecBejoSetup."ADP Journal Batch Name" = '') then begin
            if grecGenJnlBatch.Get(grecBejoSetup."ADP Journal Template Name", 'DEFAULT') then
                grecBejoSetup."ADP Journal Batch Name" := 'DEFAULT';
        end;

        gdatPostingDate := Today;

        Rec.SetRange("Journal Template Name", grecBejoSetup."ADP Journal Template Name");
        Rec.SetRange("Journal Batch Name", grecBejoSetup."ADP Journal Batch Name");
        Rec.SetRange("Journal Line No.", 0);
        if Rec.FindSet(true, false) then
            Rec.DeleteAll;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if not gbolHasRunImport then
            if not Confirm(txtQueryClose) then
                exit(false);
    end;

    var
        FileBlob: Record TempBlob;
        FileInStream: InStream;
        grecBejoSetup: Record "Bejo Setup";
        grecGenJnlTempl: Record "Gen. Journal Template";
        grecGenJnlBatch: Record "Gen. Journal Batch";
        grecDimension: Record Dimension;
        gtxtExcelBook: Text[1000];
        gtxtExcelSheet: Text[1000];
        gdatPostingDate: Date;
        gcodDocNo: Code[20];
        gtxtPostingDescription: Text[100];
        gtxtFilename: Text[1024];
        gtxtServerFilename: Text[1024];
        gtxtSheetname: Text[1024];
        gintFirstLine: Integer;
        gcodGenJnlTempl: Code[20];
        gcodGenJnlBatch: Code[20];
        gintLineNo: Integer;
        gcuFileMgmt: Codeunit "File Management";
        grecExcelBuffer: Record "Excel Buffer" temporary;
        grecExcelBufferCols: Record "Excel Buffer" temporary;
        grecExcelBufferRows: Record "Excel Buffer" temporary;
        txtErrorJnlTemplNotValid: Label 'The General Journal Template is not valid.';
        txtErrorJnlBatchNotValid: Label 'The General Journal Batch is not valid.';
        txtErrorDimNotValid: Label 'The Dimension Code is not valid.';
        txtErrorJnlTemplEmpty: Label 'Please enter a General Journal Template.';
        txtErrorJnlBatchEmpty: Label 'Please enter a General Journal Batch.';
        txtErrorPostingDateEmpty: Label 'Please enter a Posting Date.';
        txtErrorDocNoEmpty: Label 'Please enter a Document Number.';
        txtErrorExcelBookEmpty: Label 'Please select an Excel book.';
        txtErrorExcelSheetEmpty: Label 'Please select an Excel sheet.';
        txtErrorFirstLineEmpty: Label 'Please select a first line to import.';
        txtErrorDim3lEmpty: Label 'Please enter a Dimension Code to use as Dimension 3.';
        txtErrorDim4lEmpty: Label 'Please enter a Dimension Code to use as Dimension 4.';
        txtErrorJnlNotEmpty: Label 'The selected Journal Batch is not empty. Please post or delete the existing lines before proceeding with the import.';
        txtMsgComplete: Label 'The import has completed successfully.';
        gintErrorLine: Integer;
        gbolHasRunImport: Boolean;
        txtMsgErrors: Label 'The import process has found %1 errors. No lines were sent to the General Journal. Please review the errors below and run the import again.';
        txtQueryClose: Label 'You have not imported any records. Do you want to close this page?';

    procedure ImportStandardExcel(ptxtFilename: Text[250]; ptxtSheetname: Text[30]; ptxtPostingDescription: Text[50]; pintFirstLine: Integer; pcodGenJnlTemplate: Code[20]; pcodGenJnlBatch: Code[20]; var pcodDocNo: Code[20]; pdatPostingDate: Date)
    var
        ldatiCurrentTimeStamp: DateTime;
        lcodGLAccount: Code[20];
        ltxtDescription: Text[100];
        ldecDebitAmount: Decimal;
        ldecCreditAmount: Decimal;
        lcodJobNo: Code[20];
        lcodJobTaskNo: Code[20];
        lcodDimension: array[4] of Code[30];
        lintRowNo: Integer;
        lintLineNo: Integer;

    begin
        lintLineNo := 10000;

        with grecExcelBufferCols do begin
            DeleteAll;
            FileBlob.Blob.Import(ptxtFilename);
            FileBlob.Blob.CreateInStream(FileInStream);
            OpenBookStream(FileInStream, ptxtSheetname);
            ReadSheet;
        end;

        with grecExcelBufferRows do begin
            DeleteAll;
            FileBlob.Blob.Import(ptxtFilename);
            FileBlob.Blob.CreateInStream(FileInStream);
            OpenBookStream(FileInStream, ptxtSheetname);
            ReadSheet;

            // Validate the fields
            Reset;
            SetFilter("Row No.", '>=%1', pintFirstLine);
            if FindSet then
                repeat
                    if "Row No." <> lintRowNo then begin
                        Evaluate(lcodGLAccount, DelChr(GetExcelValue("Row No.", 8), '=', ',.'));
                        Evaluate(ltxtDescription, GetExcelValue("Row No.", 9));
                        Evaluate(ldecDebitAmount, GetExcelValue("Row No.", 12));
                        Evaluate(ldecCreditAmount, GetExcelValue("Row No.", 13));
                        Evaluate(lcodDimension[1], DelChr(GetExcelValue("Row No.", 10), '=', ',.'));
                        Evaluate(lcodDimension[2], '');
                        Evaluate(lcodDimension[3], '');
                        Evaluate(lcodDimension[4], '');
                        Evaluate(lcodJobNo, '');
                        Evaluate(lcodJobTaskNo, '');

                        ValidateFields("Row No.", pcodGenJnlTemplate, pcodGenJnlBatch,
                          pcodDocNo, lcodGLAccount, ltxtDescription, ldecDebitAmount, ldecCreditAmount, lcodJobNo, lcodJobTaskNo,
                          pdatPostingDate, lcodDimension);
                    end;
                    lintRowNo := "Row No.";
                until Next = 0;

            // Insert lines on the journal
            if gintErrorLine = 0 then begin
                Reset;
                SetFilter("Row No.", '>=%1', pintFirstLine);
                grecGenJnlTempl.Get(grecBejoSetup."ADP Journal Template Name");
                grecGenJnlBatch.Get(grecBejoSetup."ADP Journal Template Name", grecBejoSetup."ADP Journal Batch Name");
                if FindSet then
                    repeat
                        if "Row No." <> lintRowNo then begin
                            Evaluate(lcodGLAccount, DelChr(GetExcelValue("Row No.", 8), '=', ',.'));
                            Evaluate(ltxtDescription, GetExcelValue("Row No.", 9));
                            Evaluate(ldecDebitAmount, GetExcelValue("Row No.", 12));
                            Evaluate(ldecCreditAmount, GetExcelValue("Row No.", 13));
                            Evaluate(lcodDimension[1], DelChr(GetExcelValue("Row No.", 10), '=', ',.'));
                            Evaluate(lcodDimension[2], '');
                            Evaluate(lcodDimension[3], '');
                            Evaluate(lcodDimension[4], '');
                            Evaluate(lcodJobNo, '');
                            Evaluate(lcodJobTaskNo, '');

                            InsertGenJnlLine(lintLineNo, pcodGenJnlTemplate, pcodGenJnlBatch,
                              pcodDocNo, lcodGLAccount, ltxtDescription, ldecDebitAmount, ldecCreditAmount, lcodJobNo, lcodJobTaskNo,
                              pdatPostingDate, lcodDimension);
                            lintLineNo += 10000
                        end;
                        lintRowNo := "Row No.";
                    until Next = 0;
                Message(txtMsgComplete);
                gbolHasRunImport := true;
                CurrPage.Close;
            end
            else begin
                Message(StrSubstNo(txtMsgErrors, gintErrorLine));
                CurrPage.Update;
            end;

        end;
    end;

    procedure ImportStandardDetailedExcel(ptxtFilename: Text[250]; ptxtSheetname: Text[30]; ptxtPostingDescription: Text[50]; pintFirstLine: Integer; pcodGenJnlTemplate: Code[20]; pcodGenJnlBatch: Code[20]; var pcodDocNo: Code[20]; pdatPostingDate: Date)
    var
        ldatiCurrentTimeStamp: DateTime;
        lcodGLAccount: Code[20];
        ltxtDescription: Text[100];
        ldecDebitAmount: Decimal;
        ldecCreditAmount: Decimal;
        lcodJobNo: Code[20];
        lcodJobTaskNo: Code[20];
        lcodDimension: array[4] of Code[30];
        lintRowNo: Integer;
        lintLineNo: Integer;
    begin
        lintLineNo := 10000;

        with grecExcelBufferCols do begin
            DeleteAll;
            FileBlob.Blob.Import(ptxtFilename);
            FileBlob.Blob.CreateInStream(FileInStream);
            OpenBookStream(FileInStream, ptxtSheetname);
            ReadSheet;
        end;

        with grecExcelBufferRows do begin
            DeleteAll;
            FileBlob.Blob.Import(ptxtFilename);
            FileBlob.Blob.CreateInStream(FileInStream);
            OpenBookStream(FileInStream, ptxtSheetname);
            ReadSheet;

            // Validate the fields
            Reset;
            SetFilter("Row No.", '>=%1', pintFirstLine);
            if FindSet then
                repeat
                    if "Row No." <> lintRowNo then begin
                        Evaluate(lcodGLAccount, DelChr(GetExcelValue("Row No.", 8), '=', ',.'));
                        Evaluate(ltxtDescription, GetExcelValue("Row No.", 9));
                        Evaluate(ldecDebitAmount, GetExcelValue("Row No.", 14));
                        Evaluate(ldecCreditAmount, GetExcelValue("Row No.", 15));
                        Evaluate(lcodDimension[1], DelChr(GetExcelValue("Row No.", 10), '=', ',.'));
                        Evaluate(lcodDimension[2], '');
                        Evaluate(lcodDimension[3], '');
                        Evaluate(lcodDimension[4], '');
                        Evaluate(lcodJobNo, '');
                        Evaluate(lcodJobTaskNo, '');

                        ValidateFields("Row No.", pcodGenJnlTemplate, pcodGenJnlBatch,
                          pcodDocNo, lcodGLAccount, ltxtDescription, ldecDebitAmount, ldecCreditAmount, lcodJobNo, lcodJobTaskNo,
                          pdatPostingDate, lcodDimension);
                    end;
                    lintRowNo := "Row No.";
                until Next = 0;

            // Insert lines on the journal
            if gintErrorLine = 0 then begin
                Reset;
                SetFilter("Row No.", '>=%1', pintFirstLine);
                grecGenJnlTempl.Get(grecBejoSetup."ADP Journal Template Name");
                grecGenJnlBatch.Get(grecBejoSetup."ADP Journal Template Name", grecBejoSetup."ADP Journal Batch Name");
                if FindSet then
                    repeat
                        if "Row No." <> lintRowNo then begin
                            Evaluate(lcodGLAccount, DelChr(GetExcelValue("Row No.", 8), '=', ',.'));
                            Evaluate(ltxtDescription, GetExcelValue("Row No.", 9));
                            Evaluate(ldecDebitAmount, GetExcelValue("Row No.", 14));
                            Evaluate(ldecCreditAmount, GetExcelValue("Row No.", 15));
                            Evaluate(lcodDimension[1], DelChr(GetExcelValue("Row No.", 10), '=', ',.'));
                            Evaluate(lcodDimension[2], '');
                            Evaluate(lcodDimension[3], '');
                            Evaluate(lcodDimension[4], '');
                            Evaluate(lcodJobNo, '');
                            Evaluate(lcodJobTaskNo, '');

                            InsertGenJnlLine(lintLineNo, pcodGenJnlTemplate, pcodGenJnlBatch,
                              pcodDocNo, lcodGLAccount, ltxtDescription, ldecDebitAmount, ldecCreditAmount, lcodJobNo, lcodJobTaskNo,
                              pdatPostingDate, lcodDimension);
                            lintLineNo += 10000
                        end;
                        lintRowNo := "Row No.";
                    until Next = 0;
                Message(txtMsgComplete);
                gbolHasRunImport := true;
                CurrPage.Close;
            end
            else begin
                Message(StrSubstNo(txtMsgErrors, gintErrorLine));
                CurrPage.Update;
            end;

        end;
    end;

    procedure ImportCustomExcel(ptxtFilename: Text[250]; ptxtSheetname: Text[30]; ptxtPostingDescription: Text[50]; pintFirstLine: Integer; pcodGenJnlTemplate: Code[20]; pcodGenJnlBatch: Code[20]; var pcodDocNo: Code[20]; pdatPostingDate: Date)
    var
        ldatiCurrentTimeStamp: DateTime;
        lcodGLAccount: Code[20];
        ltxtDescription: Text[100];
        ldecDebitAmount: Decimal;
        ldecCreditAmount: Decimal;
        lcodJobNo: Code[20];
        lcodJobTaskNo: Code[20];
        lcodDimension: array[4] of Code[30];
        lintRowNo: Integer;
        lintLineNo: Integer;
    begin
        lintLineNo := 10000;

        with grecExcelBufferCols do begin
            DeleteAll;
            FileBlob.Blob.Import(ptxtFilename);
            FileBlob.Blob.CreateInStream(FileInStream);
            OpenBookStream(FileInStream, ptxtSheetname);
            ReadSheet;
        end;

        with grecExcelBufferRows do begin
            DeleteAll;
            FileBlob.Blob.Import(ptxtFilename);
            FileBlob.Blob.CreateInStream(FileInStream);
            OpenBookStream(FileInStream, ptxtSheetname);
            ReadSheet;

            // Validate the fields
            Reset;
            SetFilter("Row No.", '>=%1', pintFirstLine);
            if FindSet then
                repeat
                    if "Row No." <> lintRowNo then begin
                        Evaluate(lcodGLAccount, DelChr(GetExcelValue("Row No.", 1), '=', ',.'));
                        Evaluate(ltxtDescription, GetExcelValue("Row No.", 2));
                        Evaluate(ldecDebitAmount, GetExcelValue("Row No.", 3));
                        Evaluate(ldecCreditAmount, CopyStr(GetExcelValue("Row No.", 4), 1, 50));
                        Evaluate(lcodDimension[1], DelChr(GetExcelValue("Row No.", 7), '=', ',.'));
                        Evaluate(lcodDimension[2], DelChr(GetExcelValue("Row No.", 8), '=', ',.'));
                        Evaluate(lcodDimension[3], DelChr(GetExcelValue("Row No.", 9), '=', ',.'));
                        Evaluate(lcodDimension[4], DelChr(GetExcelValue("Row No.", 10), '=', ',.'));
                        Evaluate(lcodJobNo, DelChr(GetExcelValue("Row No.", 12), '=', ',.'));
                        Evaluate(lcodJobTaskNo, DelChr(GetExcelValue("Row No.", 11), '=', ',.'));

                        ValidateFields("Row No.", pcodGenJnlTemplate, pcodGenJnlBatch,
                          pcodDocNo, lcodGLAccount, ltxtDescription, ldecDebitAmount, ldecCreditAmount, lcodJobNo, lcodJobTaskNo,
                          pdatPostingDate, lcodDimension);
                    end;
                    lintRowNo := "Row No.";
                until Next = 0;

            // Insert lines on the journal
            if gintErrorLine = 0 then begin
                Reset;
                SetFilter("Row No.", '>=%1', pintFirstLine);
                grecGenJnlTempl.Get(grecBejoSetup."ADP Journal Template Name");
                grecGenJnlBatch.Get(grecBejoSetup."ADP Journal Template Name", grecBejoSetup."ADP Journal Batch Name");
                if FindSet then
                    repeat
                        if "Row No." <> lintRowNo then begin
                            Evaluate(lcodGLAccount, DelChr(GetExcelValue("Row No.", 1), '=', ',.'));
                            Evaluate(ltxtDescription, GetExcelValue("Row No.", 2));
                            Evaluate(ldecDebitAmount, GetExcelValue("Row No.", 3));
                            Evaluate(ldecCreditAmount, GetExcelValue("Row No.", 4));
                            Evaluate(lcodDimension[1], DelChr(GetExcelValue("Row No.", 7), '=', ',.'));
                            Evaluate(lcodDimension[2], DelChr(GetExcelValue("Row No.", 8), '=', ',.'));
                            Evaluate(lcodDimension[3], DelChr(GetExcelValue("Row No.", 9), '=', ',.'));
                            Evaluate(lcodDimension[4], DelChr(GetExcelValue("Row No.", 10), '=', ',.'));
                            Evaluate(lcodJobNo, DelChr(GetExcelValue("Row No.", 12), '=', ',.'));
                            Evaluate(lcodJobTaskNo, DelChr(GetExcelValue("Row No.", 11), '=', ',.'));

                            InsertGenJnlLine(lintLineNo, pcodGenJnlTemplate, pcodGenJnlBatch,
                              pcodDocNo, lcodGLAccount, ltxtDescription, ldecDebitAmount, ldecCreditAmount, lcodJobNo, lcodJobTaskNo,
                              pdatPostingDate, lcodDimension);
                            lintLineNo += 10000
                        end;
                        lintRowNo := "Row No.";
                    until Next = 0;
                Message(txtMsgComplete);
                gbolHasRunImport := true;
                CurrPage.Close;
            end
            else begin
                Message(StrSubstNo(txtMsgErrors, gintErrorLine));
                CurrPage.Update;
            end;

        end;
    end;

    procedure GetExcelValue(pintRowNo: Integer; pintColNo: Integer) CellValue: Text[250]
    begin
        with grecExcelBufferCols do begin
            Reset;
            SetRange("Row No.", pintRowNo);
            SetRange("Column No.", pintColNo);
            if FindFirst then
                CellValue := "Cell Value as Text"
            else
                CellValue := '';
        end;
    end;

    procedure ValidateFields(RowNo: Integer; pcodGenJnlTempl: Code[20]; pcodGenJnlBatch: Code[20]; pcodDocNo: Code[50]; pcodGLAccount: Code[20]; ptxtDescription: Text[100]; pdecDebitAmount: Decimal; pdecCreditAmount: Decimal; pcodJobNo: Code[20]; pcodJobTaskNo: Code[20]; pdatPostingDate: Date; pcodDimension: array[4] of Code[30])
    var
        lrecGLAcc: Record "G/L Account";
        lrecDimVal: Record "Dimension Value";
        lrecJobTask: Record "Job Task";
        lrecJob: Record Job;
        ErrorAccNotExist: Label 'Account %1 does not exist.';
        ErrorAccNotPosting: Label 'Account %1 has Type %2.';
        ErrorAccNotDirectPost: Label 'Account %1 does not have Direct Posting enabled.';
        ErrorAccBlocked: Label 'Account %1 is blocked.';
        ErrorAmountNoZero: Label 'Both debit and credit amounts are different than zero.';
        ErrorAmountZero: Label 'Both debit and credit amounts are zero.';
        ErrorDimValNotExist: Label 'Dimension Value %1 does not exist for Dimension %2.';
        ErrorDimValNotPosting: Label 'Dimension Value %1 has Type %2.';
        ErrorDimValBlocked: Label 'Dimension Value %1 is blocked.';
        ErrorJobTaskNotExist: Label 'Job Task %1 does not exist for Job %2.';
        ErrorJobTaskNotPosting: Label 'Job Task %1 has Type %2.';
        ErrorJobNotExist: Label 'Job %1 doesn''t exist,';
        ErrorJobCompleted: Label 'Job %1 is completed.';
        ErrorJobBlocked: Label 'Job %1 is blocked.';
        AccountColumn: Text;
        DescriptionColumn: Text;
        AmountColumn: Text;
        Dim1Column: Text;
        Dim2Column: Text;
        Dim3Column: Text;
        Dim4Column: Text;
        JobTaskColumn: Text;
        JobColumn: Text;
    begin
        case grecBejoSetup."ADP Excel Format" of
            grecBejoSetup."ADP Excel Format"::Custom:
                begin
                    AccountColumn := 'A';
                    DescriptionColumn := 'B';
                    AmountColumn := 'C and D';
                    Dim1Column := 'G';
                    Dim2Column := 'H';
                    Dim3Column := 'I';
                    Dim4Column := 'J';
                    JobTaskColumn := 'K';
                    JobColumn := 'L';
                end;
            grecBejoSetup."ADP Excel Format"::Standard:
                begin
                    AccountColumn := 'H';
                    DescriptionColumn := 'I';
                    AmountColumn := 'L and M';
                    Dim1Column := 'J';
                end;
            grecBejoSetup."ADP Excel Format"::"Standard Detailed":
                begin
                    AccountColumn := 'H';
                    DescriptionColumn := 'I';
                    AmountColumn := 'N and O';
                    Dim1Column := 'J';
                end;
        end;

        // Validate the G/L Account
        with lrecGLAcc do begin
            if not Get(pcodGLAccount) then
                LogError(RowNo, AccountColumn, StrSubstNo(ErrorAccNotExist, pcodGLAccount))
            else begin
                if "Account Type" <> "Account Type"::Posting then
                    LogError(RowNo, AccountColumn, StrSubstNo(ErrorAccNotPosting, pcodGLAccount, "Account Type"));
                if not "Direct Posting" then
                    LogError(RowNo, AccountColumn, StrSubstNo(ErrorAccNotDirectPost, pcodGLAccount));
                if Blocked then
                    LogError(RowNo, AccountColumn, StrSubstNo(ErrorAccBlocked, pcodGLAccount));
            end;
        end;

        // Validate the amounts
        if (pdecDebitAmount <> 0) and (pdecCreditAmount <> 0) then
            LogError(RowNo, AmountColumn, ErrorAmountNoZero);
        if (pdecDebitAmount = 0) and (pdecCreditAmount = 0) then
            LogError(RowNo, AmountColumn, ErrorAmountZero);

        // Validate the Dimension Values
        with lrecDimVal do begin

            if pcodDimension[1] <> '' then begin
                if not Get(grecBejoSetup."ADP Shortcut Dimension 1 Code", pcodDimension[1]) then
                    LogError(RowNo, Dim1Column, StrSubstNo(ErrorDimValNotExist, pcodDimension[1], grecBejoSetup."ADP Shortcut Dimension 1 Code"))
                else
                    if "Dimension Value Type" <> "Dimension Value Type"::Standard then
                        LogError(RowNo, Dim1Column, StrSubstNo(ErrorDimValNotPosting, pcodDimension[1], "Dimension Value Type"));
                if Blocked then
                    LogError(RowNo, Dim1Column, StrSubstNo(ErrorDimValBlocked, pcodDimension[1]));
            end;

            if pcodDimension[2] <> '' then begin
                if not Get(grecBejoSetup."ADP Shortcut Dimension 2 Code", pcodDimension[2]) then
                    LogError(RowNo, Dim2Column, StrSubstNo(ErrorDimValNotExist, pcodDimension[2], grecBejoSetup."ADP Shortcut Dimension 2 Code"))
                else
                    if "Dimension Value Type" <> "Dimension Value Type"::Standard then
                        LogError(RowNo, Dim2Column, StrSubstNo(ErrorDimValNotPosting, pcodDimension[2], "Dimension Value Type"));
                if Blocked then
                    LogError(RowNo, Dim2Column, StrSubstNo(ErrorDimValBlocked, pcodDimension[2]));
            end;

            if pcodDimension[3] <> '' then begin
                if not Get(grecBejoSetup."ADP Shortcut Dimension 3 Code", pcodDimension[3]) then
                    LogError(RowNo, Dim3Column, StrSubstNo(ErrorDimValNotExist, pcodDimension[3], grecBejoSetup."ADP Shortcut Dimension 3 Code"))
                else
                    if "Dimension Value Type" <> "Dimension Value Type"::Standard then
                        LogError(RowNo, Dim3Column, StrSubstNo(ErrorDimValNotPosting, pcodDimension[3], "Dimension Value Type"));
                if Blocked then
                    LogError(RowNo, Dim3Column, StrSubstNo(ErrorDimValBlocked, pcodDimension[3]));
            end;

            if pcodDimension[4] <> '' then begin
                if not Get(grecBejoSetup."ADP Shortcut Dimension 4 Code", pcodDimension[4]) then
                    LogError(RowNo, Dim4Column, StrSubstNo(ErrorDimValNotExist, pcodDimension[4], grecBejoSetup."ADP Shortcut Dimension 4 Code"))
                else
                    if "Dimension Value Type" <> "Dimension Value Type"::Standard then
                        LogError(RowNo, Dim4Column, StrSubstNo(ErrorDimValNotPosting, pcodDimension[4], "Dimension Value Type"));
                if Blocked then
                    LogError(RowNo, Dim4Column, StrSubstNo(ErrorDimValBlocked, pcodDimension[4]));
            end;

        end;

        // Validate the Job
        if pcodJobNo <> '' then begin
            with lrecJob do begin
                if not Get(pcodJobNo) then
                    LogError(RowNo, JobColumn, StrSubstNo(ErrorJobNotExist, pcodJobNo))
                else begin
                    if (Status = Status::Completed) or (Complete) then
                        LogError(RowNo, JobColumn, StrSubstNo(ErrorJobCompleted, pcodJobNo));
                    if Blocked <> Blocked::" " then
                        LogError(RowNo, JobColumn, StrSubstNo(ErrorJobBlocked, pcodJobNo));
                end;
            end;
        end;

        // Validate the Job Task
        if pcodJobTaskNo <> '' then begin
            with lrecJobTask do begin
                if not Get(pcodJobNo, pcodJobTaskNo) then
                    LogError(RowNo, JobTaskColumn, StrSubstNo(ErrorJobTaskNotExist, pcodJobTaskNo, pcodJobNo))
                else
                    if "Job Task Type" <> "Job Task Type"::Posting then
                        LogError(RowNo, JobTaskColumn, StrSubstNo(ErrorJobTaskNotPosting, pcodJobTaskNo, "Job Task Type"));
            end;
        end;
    end;

    procedure InsertGenJnlLine(pintLineNo: Integer; pcodGenJnlTempl: Code[20]; pcodGenJnlBatch: Code[20]; pcodDocNo: Code[50]; pcodGLAccount: Code[20]; ptxtDescription: Text[100]; pdecDebitAmount: Decimal; pdecCreditAmount: Decimal; pcodJobNo: Code[20]; pcodJobTaskNo: Code[20]; pdatPostingDate: Date; pcodDimension: array[4] of Code[30])
    var
        lrecGenJnlLine: Record "Gen. Journal Line";
        DimMgmt: Codeunit DimensionManagement;
        lrecDimSetEntry: Record "Dimension Set Entry" temporary;
    begin

        with lrecGenJnlLine do begin
            Validate("Journal Template Name", pcodGenJnlTempl);
            Validate("Journal Batch Name", pcodGenJnlBatch);
            Validate("Line No.", pintLineNo);
            Validate("Posting Date", pdatPostingDate);
            Validate("Document Date", pdatPostingDate);
            if grecGenJnlBatch."Reason Code" <> '' then
                Validate("Reason Code", grecGenJnlBatch."Reason Code")
            else
                Validate("Reason Code", grecGenJnlTempl."Reason Code");
            Validate("Source Code", grecGenJnlTempl."Source Code");
            Validate("Document No.", pcodDocNo);
            Validate("Account No.", pcodGLAccount);
            if ptxtDescription <> '' then
                Validate(Description, ptxtDescription);
            if pdecDebitAmount <> 0 then
                Validate("Debit Amount", pdecDebitAmount);
            if pdecCreditAmount <> 0 then
                Validate("Credit Amount", pdecCreditAmount);
            if pcodJobNo <> '' then begin
                Validate("Job No.", pcodJobNo);
                Validate("Job Quantity", 1);
                if pcodJobTaskNo <> '' then
                    Validate("Job Task No.", pcodJobTaskNo);
            end;
            if pcodDimension[1] <> '' then
                InsertDimensions(grecBejoSetup."ADP Shortcut Dimension 1 Code", pcodDimension[1], lrecDimSetEntry);
            if pcodDimension[2] <> '' then
                InsertDimensions(grecBejoSetup."ADP Shortcut Dimension 2 Code", pcodDimension[2], lrecDimSetEntry);
            if pcodDimension[3] <> '' then
                InsertDimensions(grecBejoSetup."ADP Shortcut Dimension 3 Code", pcodDimension[3], lrecDimSetEntry);
            if pcodDimension[4] <> '' then
                InsertDimensions(grecBejoSetup."ADP Shortcut Dimension 4 Code", pcodDimension[4], lrecDimSetEntry);
            if (pcodDimension[1] <> '') or
               (pcodDimension[2] <> '') or
               (pcodDimension[3] <> '') or
               (pcodDimension[4] <> '') then
                "Dimension Set ID" := DimMgmt.GetDimensionSetID(lrecDimSetEntry);
            Insert;
        end;
    end;

    local procedure InsertDimensions(pcodDimCode: Code[30]; pcodDimVal: Code[30]; var precDimSetEntry: Record "Dimension Set Entry" temporary)
    begin
        with precDimSetEntry do begin
            Init;
            Validate("Dimension Code", pcodDimCode);
            Validate("Dimension Value Code", pcodDimVal);
            if Insert then;
        end;
    end;

    local procedure LogError(pintLine: Integer; ptxtColumn: Text; ptxtErrorText: Text[1000])
    begin
        gintErrorLine += 1;
        Init;
        "Journal Template Name" := grecBejoSetup."ADP Journal Template Name";
        "Journal Batch Name" := grecBejoSetup."ADP Journal Batch Name";
        "Journal Line No." := 0;
        "Line No." := gintErrorLine;
        "Support URL" := Format(pintLine);
        "Additional Information" := ptxtColumn;
        "Error Text" := ptxtErrorText;
        Insert;
    end;
}

