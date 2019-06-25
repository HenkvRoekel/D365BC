xmlport 50027 "Export Month Prognoses OBSOLE"
{


    Caption = 'Export Month Prognoses';
    Direction = Export;
    FormatEvaluate = Xml;

    schema
    {
        textelement(MonthPrognoses)
        {
            tableelement(prognallocentry; "Prognosis/Allocation Entry")
            {
                XmlName = 'MonthPrognosis';
                SourceTableView = SORTING ("Entry Type", "Item No.", "Unit of Measure", "Purchase Date", Exported) ORDER(Ascending) WHERE (Exported = CONST (false), "Entry Type" = CONST (Prognoses));
                fieldelement(Company_Entry_No; PrognAllocEntry."Internal Entry No.")
                {
                }
                fieldelement(Item_No; PrognAllocEntry."Item No.")
                {

                    trigger OnBeforePassField()
                    begin
                        gPreviousItemNo := PrognAllocEntry."Item No.";
                    end;
                }
                fieldelement(Date; PrognAllocEntry."Purchase Date")
                {

                    trigger OnBeforePassField()
                    begin

                        gPreviousDate := PrognAllocEntry."Purchase Date"

                    end;
                }
                fieldelement(Description; PrognAllocEntry.Description)
                {
                }
                textelement(guomcodebejo)
                {
                    XmlName = 'UOMCodeBejo';

                    trigger OnBeforePassVariable()
                    var
                        lrecUOM: Record "Unit of Measure";
                    begin
                        gUOMCodeBejo := '';

                        if lrecUOM.Get(PrognAllocEntry."Unit of Measure") then
                            gUOMCodeBejo := lrecUOM."B Code BejoNL";

                        gPreviousUoM := PrognAllocEntry."Unit of Measure";
                    end;
                }
                fieldelement(Quantity_in_KG; PrognAllocEntry."Quantity in KG")
                {
                }
                fieldelement(In_Sales_Order; PrognAllocEntry."In Sales Order")
                {
                }
                fieldelement(Variety; PrognAllocEntry.Variety)
                {
                }
                fieldelement(Modification_Date; PrognAllocEntry."Date Modified")
                {
                }
                fieldelement(Quantity_period; PrognAllocEntry.Prognoses)
                {

                    trigger OnBeforePassField()
                    var
                        lTstDec: Decimal;
                        lTstStr: Text[30];
                    begin
                    end;
                }
                fieldelement(Begin_Date; PrognAllocEntry."Begin Date")
                {
                }
                textelement(gcountrycode)
                {
                    XmlName = 'Exported_from';
                }

                trigger OnAfterGetRecord()
                var
                    lrecPrognosisAllocationEntry: Record "Prognosis/Allocation Entry";
                begin
                    // If the current record is processed in the sum for the same item/date/unit then skip
                    if (gPreviousItemNo = PrognAllocEntry."Item No.")

                        and (gPreviousDate = PrognAllocEntry."Purchase Date")
                        and (gPreviousUoM = PrognAllocEntry."Unit of Measure") then
                        currXMLport.Skip;

                    // Sum all prognoses for the same item/date/unit
                    lrecPrognosisAllocationEntry.SetCurrentKey("Entry Type", "Item No.", "Unit of Measure", "Purchase Date");
                    lrecPrognosisAllocationEntry.SetRange("Entry Type", PrognAllocEntry."Entry Type"::Prognoses);
                    lrecPrognosisAllocationEntry.SetRange("Item No.", PrognAllocEntry."Item No.");
                    lrecPrognosisAllocationEntry.SetRange("Purchase Date", PrognAllocEntry."Purchase Date");
                    lrecPrognosisAllocationEntry.SetRange("Unit of Measure", PrognAllocEntry."Unit of Measure");
                    lrecPrognosisAllocationEntry.SetRange(Exported, false);
                    lrecPrognosisAllocationEntry.CalcSums(Prognoses);

                    // Store the sum of prognoses in the record to be processed to XML, do not put to the DataBase
                    PrognAllocEntry.Prognoses := lrecPrognosisAllocationEntry.Prognoses;

                    if lrecPrognosisAllocationEntry.Prognoses = 0 then
                        currXMLport.Skip;
                end;
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
        if grecBejoSetup.Get then;
        grecBejoSetup.TestField("Country Code");
        gCountryCode := grecBejoSetup."Country Code";
    end;

    var
        gPreviousItemNo: Code[20];
        gPreviousDate: Date;
        gPreviousUoM: Code[10];
        grecBejoSetup: Record "Bejo Setup";
}

