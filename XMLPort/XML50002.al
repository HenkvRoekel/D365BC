xmlport 50002 "Import Varieties"
{

    Caption = 'Import Varieties';
    Direction = Import;
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
                        tableelement(tmpvariety; Varieties)
                        {
                            XmlName = 'Varieties';
                            UseTemporary = true;
                            fieldelement("Var"; tmpVariety."No.")
                            {
                            }
                            fieldelement(Descr; tmpVariety."Dutch description")
                            {
                            }
                            fieldelement(S_Rem; tmpVariety."Sales Comment")
                            {
                            }
                            fieldelement(Date_TB_Disc; tmpVariety."Date to be discontinued")
                            {
                            }
                            fieldelement(Org; tmpVariety.Organic)
                            {
                            }
                            fieldelement(S_Name; tmpVariety."Search Description")
                            {
                            }
                            fieldelement(Y_Prog_In; tmpVariety."Year Prognosis in")
                            {
                            }
                            fieldelement(Crop_Code; tmpVariety."Crop Code")
                            {
                            }
                            fieldelement(TSW; tmpVariety.TSW)
                            {
                            }
                            fieldelement(Crop_Variant_Code; tmpVariety."Crop Variant Code")
                            {
                            }
                            fieldelement(Crop_Variant_Descr; tmpVariety."Crop Variant Description")
                            {
                            }
                            fieldelement(Crop_Type; tmpVariety."Crop Type Code")
                            {
                            }
                            fieldelement(Crop_Type_Descr; tmpVariety."Crop Type Description")
                            {
                            }
                            fieldelement(Sowing_Ratio_Curr; tmpVariety."Sowing Ratio Current")
                            {
                            }
                            fieldelement(Sowing_Ratio_Fut; tmpVariety."Sowing Ratio In Future")
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

    trigger OnPostXmlPort()
    begin
        UpsertVariety();
    end;

    var
        gVarietyNo: Code[20];
        gDescription: Text[50];
        gSalesRemark: Text[50];
        gDateToBeDiscontinued: Date;
        gOrganic: Boolean;
        gYearPrognosisIn: Integer;
        gSearchDescription: Text[20];
        gCropCode: Code[10];
        gTSW: Decimal;

    procedure FormatDate(aDate: Text[30]) ResultDate: Date
    var
        lYear: Integer;
        lMonth: Integer;
        lDay: Integer;
    begin

    end;

    procedure UpsertVariety()
    var
        lrecVariety: Record Varieties;
    begin

        tmpVariety.Reset();
        if tmpVariety.FindSet(false, false) then
            repeat

                lrecVariety.SetRange("No.", tmpVariety."No.");
                if lrecVariety.FindFirst then begin
                    lrecVariety."Dutch description" := tmpVariety."Dutch description";
                    lrecVariety."Sales Comment" := tmpVariety."Sales Comment";
                    lrecVariety."Date to be discontinued" := tmpVariety."Date to be discontinued";
                    lrecVariety.Organic := tmpVariety.Organic;
                    lrecVariety."Year Prognosis in" := tmpVariety."Year Prognosis in";
                    lrecVariety."Year Prognosis Available" := false;
                    lrecVariety."Search Description" := tmpVariety."Search Description";


                    if tmpVariety."Crop Code" <> '' then lrecVariety."Crop Code" := tmpVariety."Crop Code";

                    lrecVariety.TSW := tmpVariety.TSW;
                    lrecVariety."Crop Variant Code" := tmpVariety."Crop Variant Code";
                    lrecVariety."Crop Variant Description" := tmpVariety."Crop Variant Description";
                    lrecVariety."Crop Type Code" := tmpVariety."Crop Type Code";
                    lrecVariety."Crop Type Description" := tmpVariety."Crop Type Description";
                    if lrecVariety."Sowing Ratio Current" = 0 then lrecVariety."Sowing Ratio Current" := tmpVariety."Sowing Ratio Current";
                    if lrecVariety."Sowing Ratio In Future" = 0 then lrecVariety."Sowing Ratio In Future" := tmpVariety."Sowing Ratio In Future";
                    lrecVariety.Modify;
                end
                else begin
                    lrecVariety.Init;
                    lrecVariety."No." := tmpVariety."No.";
                    lrecVariety."Dutch description" := tmpVariety."Dutch description";
                    lrecVariety."Sales Comment" := tmpVariety."Sales Comment";
                    lrecVariety."Date to be discontinued" := tmpVariety."Date to be discontinued";
                    lrecVariety.Organic := tmpVariety.Organic;
                    lrecVariety."Year Prognosis in" := tmpVariety."Year Prognosis in";
                    lrecVariety."Year Prognosis Available" := false;
                    lrecVariety."Search Description" := tmpVariety."Search Description";


                    if tmpVariety."Crop Code" <> '' then lrecVariety."Crop Code" := tmpVariety."Crop Code";

                    lrecVariety.TSW := tmpVariety.TSW;
                    lrecVariety."Crop Variant Code" := tmpVariety."Crop Variant Code";
                    lrecVariety."Crop Variant Description" := tmpVariety."Crop Variant Description";
                    lrecVariety."Crop Type Code" := tmpVariety."Crop Type Code";
                    lrecVariety."Crop Type Description" := tmpVariety."Crop Type Description";
                    lrecVariety."Sowing Ratio Current" := tmpVariety."Sowing Ratio Current";
                    lrecVariety."Sowing Ratio In Future" := tmpVariety."Sowing Ratio In Future";
                    lrecVariety.Insert;
                end;
            until tmpVariety.Next = 0;

    end;
}

