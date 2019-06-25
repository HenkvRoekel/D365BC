xmlport 50022 "Export End Of Season Stock"
{

    Direction = Export;
    Encoding = UTF8;
    FormatEvaluate = Xml;

    schema
    {
        textelement(EndOfSeasonStock)
        {
            textelement(Country_Code)
            {

                trigger OnBeforePassVariable()
                begin
                    Country_Code := grecBejoSetup."Country Code";
                end;
            }
            textelement(Begin_Date)
            {

                trigger OnBeforePassVariable()
                begin
                    Begin_Date := Format(CalcDate('<+1Y>', grecBejoSetup."Begin Date"), 0, '<Standard Format,9>');
                end;
            }
            textelement(End_Date)
            {

                trigger OnBeforePassVariable()
                begin
                    End_Date := Format(CalcDate('<+1Y>', grecBejoSetup."End Date"), 0, '<Standard Format,9>');
                end;
            }
            textelement(Modified_Date)
            {

                trigger OnBeforePassVariable()
                begin
                    Modified_Date := Format(Today, 0, '<Standard Format,9>');
                end;
            }
            tableelement("EOSS per Item"; "EOSS per Item")
            {
                XmlName = 'EOSS_per_Item';
                fieldelement(Item_No; "EOSS per Item"."Item No.")
                {
                }
                fieldelement(Quantity; "EOSS per Item".Quantity)
                {
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
        grecBejoSetup.Get;
        grecBejoSetup.TestField("Begin Date");
        grecBejoSetup.TestField("End Date");
    end;

    var
        grecBejoSetup: Record "Bejo Setup";
}

