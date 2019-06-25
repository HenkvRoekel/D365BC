page 50091 "Comment Sheet Bejo"
{

    AutoSplitKey = true;
    Caption = 'Comment Sheet Bejo';
    DataCaptionFields = "No.";
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Comment Line";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field("Code"; Code)
                {
                    Caption = 'Unit of Measure';
                    Lookup = true;
                    Visible = CodeVisible;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        lrecItemUnitOfMeasure: Record "Item Unit of Measure";
                    begin

                        lrecItemUnitOfMeasure.SetFilter("Item No.", "No.");
                        lrecItemUnitOfMeasure."Item No." := "No.";
                        if PAGE.RunModal(PAGE::"Item Units of Measure", lrecItemUnitOfMeasure) = ACTION::LookupOK then
                            Code := lrecItemUnitOfMeasure.Code

                    end;
                }
                field(Date; Date)
                {
                    ApplicationArea = All;
                }
                field("B End Date"; "B End Date")
                {
                    ApplicationArea = All;
                }
                field("B Comment Type"; "B Comment Type")
                {
                    OptionCaption = ',Sales,Warehouse,Expedition,Export,Variety,Item,Manager,Available,Salesperson';
                    ValuesAllowed = "Var 5 pos", Salesperson;
                    ApplicationArea = All;
                }
                field("B Show"; "B Show")
                {
                    ApplicationArea = All;
                }
                field("B Creation Date"; "B Creation Date")
                {
                    Editable = false;
                    Visible = "Creation DateVisible";
                    ApplicationArea = All;
                }
                field(Comment; Comment)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        SetFilter("Table Name", '3');
    end;

    trigger OnInit()
    begin
        "Creation DateVisible" := true;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        grecCommentLine.SetRange(grecCommentLine."Table Name", "Table Name");
        grecCommentLine.SetRange(grecCommentLine."No.", "No.");
        if grecCommentLine.Find('+') then
            "Line No." := grecCommentLine."Line No." + 10000;
    end;

    trigger OnOpenPage()
    var
        strFilters: Text[1024];
        lformaat: Text[30];
    begin


        if gShowVarietyComments then begin

            CodeVisible := false;

            "Creation DateVisible" := true;
        end
        else begin

            CodeVisible := true;

            "Creation DateVisible" := false;
        end;


    end;

    var
        grecCommentLine: Record "Comment Line";
        gShowVarietyComments: Boolean;
        [InDataSet]
        CodeVisible: Boolean;
        [InDataSet]
        "Creation DateVisible": Boolean;

    procedure fncVarietyComment(parShowVarietyComments: Boolean)
    begin

        gShowVarietyComments := parShowVarietyComments;
    end;
}

