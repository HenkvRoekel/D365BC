report 50019 "Update Item Lead Time Calc."
{


    Caption = 'Update Item Lead Time Calc.';

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = SORTING ("No.") ORDER(Ascending);
            RequestFilterFields = "No.", "B Crop";

            trigger OnAfterGetRecord()
            begin

                case gUpdateOption of
                    gUpdateOption::"Base NAV Lead Time":
                        Item."Lead Time Calculation" := gDateFormula;
                    gUpdateOption::"Ship Date BZ Lead Time":
                        Item."B Purchase BZ Lead Time Calc" := gDateFormula;
                end;

                Item.Modify;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(gDateFormula; gDateFormula)
                    {
                        Caption = 'New Lead Time Calc. Formula';
                        ApplicationArea = All;
                        //DateFormula = true;

                        trigger OnValidate()
                        begin

                            if StrPos(Format(gDateFormula), '-') <> 0 then
                                Error(Text50001);

                        end;
                    }
                    field(gUpdateOption; gUpdateOption)
                    {
                        Caption = 'Update Option';
                        Description = 'BEJOWW5.01.012';
                        OptionCaption = 'Base NAV Lead Time,Purchase BZ Lead Time';
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin

            gUpdateOption := gUpdateOption::"Ship Date BZ Lead Time";

        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        if (Format(gDateFormula) = '') then begin
            Message(Text50000);
            CurrReport.Quit;
        end;
    end;

    var
        gDateFormula: DateFormula;
        Text50000: Label 'You must provide a date formula to run this report.';
        gcuBejoMgt: Codeunit "Bejo Management";
        gUpdateOption: Option "Base NAV Lead Time","Ship Date BZ Lead Time";
        Text50001: Label 'Please enter a positive data formula value.';
}

