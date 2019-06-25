xmlport 50004 "Import Allocation"
{

    Caption = 'Import Sales Price';
    Direction = Import;
    Encoding = UTF8;
    FormatEvaluate = Xml;

    schema
    {
        textelement(Envelope)
        {
            textelement(Body)
            {
                textelement(LIST_ALLOCResponse)
                {
                    textelement(LIST_ALLOCResult)
                    {
                        tableelement("<allocation>"; "Prognosis/Allocation Entry")
                        {
                            MinOccurs = Zero;
                            XmlName = 'Allocation';
                            fieldelement(Entry_No; "<Allocation>"."Entry No.")
                            {
                            }
                            fieldelement(Item_No; "<Allocation>"."Item No.")
                            {
                                FieldValidate = no;

                                trigger OnAfterAssignField()
                                var
                                    lrecItem: Record Item;
                                begin
                                end;
                            }
                            fieldelement(Date; "<Allocation>"."Sales Date")
                            {
                                FieldValidate = no;
                            }
                            textelement(gcountry)
                            {
                                XmlName = 'Country';
                            }
                            fieldelement(Description; "<Allocation>".Description)
                            {
                            }
                            fieldelement(User_ID; "<Allocation>"."User-ID")
                            {

                                trigger OnAfterAssignField()
                                begin
                                    "<Allocation>"."User-ID" := 'BEJONL';
                                    "<Allocation>"."Is Import from Bejo" := true;
                                end;
                            }
                            fieldelement(Quantity_KG; "<Allocation>"."Quantity in KG")
                            {
                                FieldValidate = no;

                                trigger OnAfterAssignField()
                                var
                                    lrecUnitofMeasure: Record "Unit of Measure";
                                begin
                                end;
                            }
                            fieldelement(Internal_Comment; "<Allocation>"."Internal Comment")
                            {
                            }
                            fieldelement(External_Comment; "<Allocation>"."External Comment")
                            {
                            }
                            fieldelement(Type; "<Allocation>"."Entry Type")
                            {
                            }
                            fieldelement(Variety_Short; "<Allocation>".Variety)
                            {
                            }
                            fieldelement(Modification_Date; "<Allocation>"."Date Modified")
                            {
                            }
                            fieldelement(Allocated; "<Allocation>".Allocated)
                            {
                            }
                            fieldelement(Begin_Date; "<Allocation>"."Begin Date")
                            {
                            }

                            trigger OnAfterInsertRecord()
                            var
                                lrecAllocationEntry: Record "Prognosis/Allocation Entry";
                            begin
                                lrecAllocationEntry.SetCurrentKey("Item No.", "Entry No.");

                                lrecAllocationEntry.SetRange("Entry No.", "<Allocation>"."Entry No.");

                                lrecAllocationEntry.SetFilter("Internal Entry No.", '<>%1', "<Allocation>"."Internal Entry No.");
                                if lrecAllocationEntry.FindSet(false, false) then
                                    "<Allocation>".Delete;

                            end;

                            trigger OnBeforeInsertRecord()
                            var
                                lrecItemUnitofMeasure: Record "Item Unit of Measure";
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
}

