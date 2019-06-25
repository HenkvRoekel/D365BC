xmlport 50011 "Export Purch. Line Text"
{

    Caption = 'Export Purch. Line Text';
    FormatEvaluate = Xml;

    schema
    {
        textelement(LineTexts)
        {
            tableelement("Purch. Comment Line"; "Purch. Comment Line")
            {
                XmlName = 'LineText';
                fieldelement(Document_No; "Purch. Comment Line"."No.")
                {
                }
                fieldelement(Number; "Purch. Comment Line"."Line No.")
                {
                }
                fieldelement(Text; "Purch. Comment Line".Comment)
                {
                }
                fieldelement(Line_No; "Purch. Comment Line"."Document Line No.")
                {
                }
                textelement(gtype)
                {
                    XmlName = 'Type';

                    trigger OnBeforePassVariable()
                    begin

                        gType := StrSubstNo(Text10000, 0, 'Extern');
                    end;
                }
                textelement(gordertype)
                {
                    XmlName = 'Order_Type';

                    trigger OnBeforePassVariable()
                    begin

                        gOrderType := StrSubstNo(Text10000, 0, 'SalesQuote');
                    end;
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
        Text10000: Label '%1,%2';
}

