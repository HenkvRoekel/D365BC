xmlport 50001 "Import Block Promo"
{

    Caption = 'Import Block Promo';
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
                        tableelement("<block entry>"; "Block Entry")
                        {
                            MinOccurs = Zero;
                            XmlName = 'BlockEntry';
                            fieldelement(Entry_No; "<Block Entry>"."Entry No.")
                            {
                                FieldValidate = no;

                                trigger OnAfterAssignField()
                                var
                                    lrecItem: Record Item;
                                begin

                                end;
                            }
                            fieldelement(Priority; "<Block Entry>".Priority)
                            {
                                FieldValidate = no;
                            }
                            fieldelement(Block_Code_Priority; "<Block Entry>"."Block Code Priority")
                            {
                                FieldValidate = no;
                            }
                            fieldelement(Blocking_Rule_No; "<Block Entry>"."Blocking Rule No.")
                            {
                                FieldValidate = yes;
                            }
                            fieldelement(Continent_Code; "<Block Entry>"."Continent Code")
                            {
                                FieldValidate = no;
                            }
                            fieldelement(Country_Code; "<Block Entry>"."Country Code")
                            {
                                FieldValidate = no;
                            }
                            fieldelement(Customer_No; "<Block Entry>"."Customer No.")
                            {
                                FieldValidate = no;

                                trigger OnAfterAssignField()
                                var
                                    lrecUnitofMeasure: Record "Unit of Measure";
                                begin
                                end;
                            }
                            fieldelement(Crop_Code; "<Block Entry>"."Crop Code")
                            {
                                FieldValidate = no;

                                trigger OnAfterAssignField()
                                var
                                    lrecCrop: Record Crops;
                                begin
                                    lrecCrop.SetCurrentKey("Crop Code");
                                    lrecCrop.SetRange("Crop Code", "<Block Entry>"."Crop Code");

                                    if ("<Block Entry>"."Crop Code" <> '') and (not (lrecCrop.FindFirst)) then // BEJOWW5.01.011
                                        gSkipThisRecord_onCrop := true
                                    else begin
                                        gSkipThisRecord_onCrop := false;
                                    end;
                                end;
                            }
                            fieldelement(Variety_Code; "<Block Entry>"."Variety Code")
                            {
                                FieldValidate = no;

                                trigger OnAfterAssignField()
                                var
                                    lrecVariety: Record Varieties;
                                begin
                                end;
                            }
                            fieldelement(Item_No; "<Block Entry>"."Item No.")
                            {
                                FieldValidate = no;
                            }
                            fieldelement(Treatment_Code; "<Block Entry>"."Treatment Code")
                            {
                                FieldValidate = no;

                                trigger OnAfterAssignField()
                                var
                                    lrecTreatmentCode: Record "Treatment Code";
                                begin
                                    lrecTreatmentCode.SetCurrentKey("Treatment Code");
                                    lrecTreatmentCode.SetRange("Treatment Code", "<Block Entry>"."Treatment Code");

                                    if ("<Block Entry>"."Treatment Code" <> '') and (not (lrecTreatmentCode.FindFirst)) then // BEJOWW5.01.011
                                        gSkipThisRecord_onTreatment := true
                                    else begin
                                        gSkipThisRecord_onTreatment := false;
                                    end;
                                end;
                            }
                            fieldelement(Block_Code; "<Block Entry>"."Block Code")
                            {
                                FieldValidate = no;
                            }
                            textelement(Promostatus_Country)
                            {

                                trigger OnAfterAssignVariable()
                                var
                                    lrecVariety: Record Varieties;
                                begin
                                    if "<Block Entry>".Priority = 290 then begin
                                        lrecVariety.SetRange("No.", "<Block Entry>"."Variety Code");
                                        if lrecVariety.FindFirst then begin
                                            lrecVariety."Promo Status" := Promostatus_Country;
                                            lrecVariety.Modify;
                                        end;
                                    end;
                                end;
                            }
                            textelement(UnitofMeasure)
                            {
                                MinOccurs = Zero;
                                textelement("<bejonl_code>")
                                {
                                    MinOccurs = Zero;
                                    XmlName = 'BejoNL_Code';

                                    trigger OnAfterAssignVariable()
                                    var
                                        lrecUnitofMeasure: Record "Unit of Measure";
                                    begin

                                        lrecUnitofMeasure.SetCurrentKey(Code);
                                        lrecUnitofMeasure.SetRange("B Code BejoNL", "<BejoNL_Code>");

                                        if ("<BejoNL_Code>" <> '') and (not (lrecUnitofMeasure.FindFirst)) then
                                            gSkipThisRecord_onUOM := true
                                        else begin
                                            "<Block Entry>"."Unit of Measure Code" := lrecUnitofMeasure.Code;
                                            gSkipThisRecord_onUOM := false;
                                        end;
                                    end;
                                }
                            }

                            trigger OnAfterInitRecord()
                            begin

                                "<Block Entry>"."Entry No." := 0;

                            end;

                            trigger OnAfterInsertRecord()
                            begin
                                if gSkipRecord then begin
                                    "<Block Entry>".Delete;
                                    gSkipRecord := false;
                                end;

                                gSkipThisRecord_onUOM := false;

                            end;

                            trigger OnBeforeInsertRecord()
                            begin
                                if gSkipThisRecord_onUOM = true then begin
                                    gSkipRecord := true;
                                end;

                                if gSkipThisRecord_onCrop = true then begin
                                    gSkipRecord := true;
                                end;

                                if gSkipThisRecord_onTreatment = true then begin
                                    gSkipRecord := true;
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
        gSkipThisRecord_onCrop: Boolean;
        gSkipThisRecord_onTreatment: Boolean;
        gSkipRecord: Boolean;
}

