xmlport 50005 "Import Item Remarks"
{

    Caption = 'Import Item Remarks';
    Direction = Import;
    FormatEvaluate = Xml;

    schema
    {
        textelement(Envelope)
        {
            textelement(Body)
            {
                textelement(LISTResponse)
                {
                    textelement(ListResult)
                    {
                        textelement(CommentLine)
                        {
                            textelement("<table_name>")
                            {
                                XmlName = 'Table_Name';
                            }
                            textelement("<no>")
                            {
                                XmlName = 'No';
                            }
                            textelement("<line_no>")
                            {
                                XmlName = 'Line_No';
                            }
                            textelement("<date>")
                            {
                                XmlName = 'Date';
                            }
                            textelement("<code>")
                            {
                                XmlName = 'Code';
                            }
                            textelement("<comment>")
                            {
                                XmlName = 'Comment';
                            }
                            textelement("<comment_type>")
                            {
                                XmlName = 'Comment_Type';
                            }
                            textelement("<end_date>")
                            {
                                XmlName = 'End_Date';
                            }
                            textelement("<variety>")
                            {
                                XmlName = 'Variety';
                            }
                            textelement("<show>")
                            {
                                XmlName = 'Show';
                            }
                            textelement("<entry_no>")
                            {
                                XmlName = 'Entry_No';
                            }
                            textelement("<creation_date>")
                            {
                                XmlName = 'Creation_Date';
                            }
                            textelement("<last_date_modified>")
                            {
                                XmlName = 'Last_Date_Modified';

                                trigger OnAfterAssignVariable()
                                var
                                    lrecCommentLineTemp: Record "Comment Line" temporary;
                                    lrecCommentLineExisting: Record "Comment Line";
                                    lrecCommentLineNew: Record "Comment Line";
                                    lLineNo: Integer;
                                begin
                                    with lrecCommentLineTemp do begin
                                        Init();
                                        Evaluate("Table Name", "<Table_Name>");
                                        "No." := "<No>";
                                        Evaluate("Line No.", "<Line_No>");
                                        Date := FormatDate("<Date>");
                                        Code := "<Code>";
                                        Comment := "<Comment>";
                                        Evaluate("B Comment Type", "<Comment_Type>");
                                        "B End Date" := FormatDate("<End_Date>");
                                        "B Variety" := "<Variety>";
                                        Evaluate("B Show", "<Show>");
                                        Evaluate("B Entry No.", "<Entry_No>");
                                        "B Creation Date" := FormatDate("<Creation_Date>");
                                        "B Last Date Modified" := FormatDate("<Last_Date_Modified>");
                                        "B Import Modification Date" := Today;
                                    end;

                                    // If this is a Modified record then update the record.
                                    lrecCommentLineExisting.SetCurrentKey("B Entry No.");
                                    lrecCommentLineExisting.SetRange("B Entry No.", lrecCommentLineTemp."B Entry No.");
                                    lrecCommentLineExisting.SetRange("B Show", lrecCommentLineTemp."B Show");
                                    if lrecCommentLineExisting.FindFirst then begin
                                        if lrecCommentLineExisting."B Last Date Modified" < lrecCommentLineTemp."B Last Date Modified" then begin
                                            lLineNo := lrecCommentLineExisting."Line No."; // BEJOWW5.01.012
                                            lrecCommentLineExisting := lrecCommentLineTemp;
                                            lrecCommentLineExisting."Line No." := lLineNo;  // BEJOWW5.01.012
                                            lrecCommentLineExisting.Modify;
                                        end;
                                    end else begin // this is a new record.
                                                   // Find hightest Line No. for this Item No.
                                        lrecCommentLineExisting.SetRange("B Entry No.");
                                        lrecCommentLineExisting.SetRange("B Show");
                                        lrecCommentLineExisting.SetCurrentKey("Table Name", "No.", "Line No.");
                                        lrecCommentLineExisting.SetRange("Table Name", lrecCommentLineTemp."Table Name");
                                        lrecCommentLineExisting.SetRange("No.", lrecCommentLineTemp."No.");
                                        if lrecCommentLineExisting.FindLast then
                                            lrecCommentLineTemp."Line No." := lrecCommentLineExisting."Line No." + 10000;

                                        lrecCommentLineNew.Init();
                                        lrecCommentLineNew := lrecCommentLineTemp;
                                        lrecCommentLineNew.Insert;
                                    end;
                                end;
                            }
                        }
                    }
                }
            }
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

    procedure FormatDate(aDate: Text[30]) ResultDate: Date
    var
        lYear: Integer;
        lMonth: Integer;
        lDay: Integer;
    begin
        if StrLen(aDate) = 10 then begin
            Evaluate(lYear, CopyStr(aDate, 1, 4));
            Evaluate(lMonth, CopyStr(aDate, 6, 2));
            Evaluate(lDay, CopyStr(aDate, 9, 2));
            ResultDate := DMY2Date(lDay, lMonth, lYear);
        end else begin
            ResultDate := 0D;
        end;
    end;
}

