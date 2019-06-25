xmlport 50030 "Get Item-UOMs"
{

    Caption = 'Get Item-UOMs';
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
                    textelement(LISTResult)
                    {
                        tableelement(tempitemuom; "Item Unit of Measure")
                        {
                            XmlName = 'Item_Unit_of_Measure';
                            UseTemporary = true;
                            textelement(Code)
                            {
                            }
                            fieldelement(Qty_per_Unit_of_Measure; TempItemUOM."Qty. per Unit of Measure")
                            {
                            }
                            textelement(Unit_of_Measure)
                            {
                                fieldelement(Bejo_Unit_of_Measure_Code; TempItemUOM.Code)
                                {
                                }
                            }

                            trigger OnAfterInsertRecord()
                            var
                                lcount: Integer;
                            begin
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

    procedure fnExposeImported(var lrecTempItemUOM: Record "Item Unit of Measure" temporary) bResult: Boolean
    begin
        Clear(lrecTempItemUOM);
        if TempItemUOM.FindSet then
            repeat
                lrecTempItemUOM.Copy(TempItemUOM);
                lrecTempItemUOM.Insert(false);
            until TempItemUOM.Next = 0;
        bResult := true;
    end;
}

