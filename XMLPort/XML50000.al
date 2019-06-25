xmlport 50000 "Import Sales Price"
{

    Caption = 'Import Sales Price';
    Direction = Import;
    Encoding = UTF8;
    FormatEvaluate = Xml;
    UseRequestPage = false;

    schema
    {
        textelement(Envelope)
        {
            textelement(Body)
            {
                textelement(LISTResponse)
                {
                    textelement(LISTResult)
                    {
                        tableelement("<sales price>"; "Sales Price")
                        {
                            MinOccurs = Zero;
                            XmlName = 'SalesPrice';
                            fieldelement(ItemNo; "<Sales Price>"."Item No.")
                            {
                                FieldValidate = no;

                                trigger OnAfterAssignField()
                                var
                                    lrecItem: Record Item;
                                begin
                                    lrecItem.SetCurrentKey("No.");
                                    lrecItem.SetRange("No.", "<Sales Price>"."Item No.");

                                    if not (lrecItem.FindFirst) then
                                        gSkipThisRecord_onItem := true
                                    else begin
                                        gSkipThisRecord_onItem := false;
                                    end;
                                end;
                            }
                            fieldelement(SalesCode; "<Sales Price>"."Sales Code")
                            {
                                FieldValidate = no;
                            }
                            fieldelement(SalesType; "<Sales Price>"."Sales Type")
                            {
                                FieldValidate = no;
                            }
                            textelement("<obsoletecurrencycode>")
                            {
                                XmlName = 'CurrencyCode';
                            }
                            fieldelement(UnitPrice; "<Sales Price>"."Unit Price")
                            {
                            }
                            fieldelement(MinimumQuantity; "<Sales Price>"."Minimum Quantity")
                            {
                            }
                            fieldelement(UOMBejoNLCode; "<Sales Price>"."Unit of Measure Code")
                            {
                                FieldValidate = no;

                                trigger OnAfterAssignField()
                                var
                                    lrecUnitofMeasure: Record "Unit of Measure";
                                    lrecItemUOM: Record "Item Unit of Measure";
                                begin
                                    lrecUnitofMeasure.SetCurrentKey(Code);
                                    lrecUnitofMeasure.SetRange("B Code BejoNL", "<Sales Price>"."Unit of Measure Code");

                                    if not (lrecUnitofMeasure.FindFirst) then
                                        gSkipThisRecord_onUOM := true
                                    else begin
                                        "<Sales Price>"."Unit of Measure Code" := lrecUnitofMeasure.Code;
                                        gSkipThisRecord_onUOM := false;
                                    end;


                                    if not lrecItemUOM.Get("<Sales Price>"."Item No.", "<Sales Price>"."Unit of Measure Code") then
                                        gSkipThisRecord_onItemUOM := true
                                    else
                                        gSkipThisRecord_onItemUOM := false

                                end;
                            }
                            fieldelement(StartingDate; "<Sales Price>"."Starting Date")
                            {
                            }
                            fieldelement(EndingDate; "<Sales Price>"."Ending Date")
                            {
                            }

                            trigger OnAfterInsertRecord()
                            begin
                                if gSkipRecordImport = true then begin
                                    "<Sales Price>".Delete;
                                    gSkipRecordImport := false;
                                end;
                            end;

                            trigger OnBeforeInsertRecord()
                            var
                                lrecItemUnitofMeasure: Record "Item Unit of Measure";
                            begin
                                if gSkipThisRecord_onUOM = true then begin
                                    gSkipRecordImport := true;
                                end;
                                if gSkipThisRecord_onItem = true then begin
                                    gSkipRecordImport := true;
                                end;

                                if gSkipThisRecord_onItemUOM = true then begin
                                    gSkipRecordImport := true;
                                end;

                            end;
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

    var
        gSkipThisRecord_onUOM: Boolean;
        gSkipThisRecord_onItem: Boolean;
        gSkipThisRecord_onItemUOM: Boolean;
        gSkipRecordImport: Boolean;

    procedure FormatDate(aDate: Text[30]) ResultDate: Date
    var
        lYear: Integer;
        lMonth: Integer;
        lDay: Integer;
    begin

    end;
}

