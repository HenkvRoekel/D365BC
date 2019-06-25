xmlport 50029 "Get Variety-Items"
{

    Caption = 'Get Variety-Items';
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
                        tableelement(tempitem; Item)
                        {
                            XmlName = 'Item';
                            UseTemporary = true;
                            fieldelement(No; TempItem."No.")
                            {
                            }
                            fieldelement(Description; TempItem.Description)
                            {
                            }
                            fieldelement(Description2; TempItem."Description 2")
                            {
                            }
                            fieldelement(Organic; TempItem."B Organic")
                            {
                            }
                            fieldelement(Search_Description; TempItem."Search Description")
                            {
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

    trigger OnPreXmlPort()
    begin
        Clear(TempItem);
    end;

    procedure fnExposeImported(var lrecTempItem: Record Item temporary) bResult: Boolean
    var
        lCount: Integer;
        lCount1: Integer;
    begin
        Clear(lrecTempItem);
        if TempItem.FindSet then
            repeat
                lrecTempItem.Copy(TempItem);
                lrecTempItem.Insert(false);
            until TempItem.Next = 0;

        bResult := true;
    end;
}

