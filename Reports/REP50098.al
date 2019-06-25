report 50098 "Change Purchase Date"
{

    Caption = 'Change Purchase Date';
    ProcessingOnly = true;

    dataset
    {
        dataitem(recAux; "Prognosis/Allocation Entry")
        {
            DataItemTableView = SORTING ("Entry Type", "Item No.", "Unit of Measure", "Purchase Date", Exported, Salesperson, Customer, "Sales Date") WHERE ("Entry Type" = CONST (Prognoses), Adjusted = CONST (false), Blocked = CONST (false));
            RequestFilterFields = "Item No.", "Unit of Measure", "Sales Date", "Purchase Date", Salesperson, Customer;

            trigger OnAfterGetRecord()
            var
                lQtyToUse: Decimal;
            begin

                grecPrognosisAllocation.SetFilter(Prognoses, '<%1', 0);
                grecPrognosisAllocation.SetRange("Entry Type", "Entry Type");
                grecPrognosisAllocation.SetRange("Item No.", "Item No.");
                grecPrognosisAllocation.SetRange("Unit of Measure", "Unit of Measure");
                grecPrognosisAllocation.SetRange("Purchase Date", "Purchase Date");
                grecPrognosisAllocation.SetRange("Sales Date", "Sales Date");
                grecPrognosisAllocation.SetRange(Salesperson, Salesperson);
                grecPrognosisAllocation.SetRange(Customer, Customer);
                if grecPrognosisAllocation.FindFirst then begin
                    grecPrognosisAllocation.SetRange(Prognoses);
                    grecPrognosisAllocation.CalcSums(Prognoses);
                    if grecPrognosisAllocation.Find('-') then
                        repeat
                            lQtyToUse += grecPrognosisAllocation.Prognoses;
                            grecauxPrognoses.Get(grecPrognosisAllocation."Internal Entry No.");
                            grecauxPrognoses.Adjusted := true;
                            grecauxPrognoses.Modify;
                        until grecPrognosisAllocation.Next = 0;
                    if (lQtyToUse <> 0) then begin

                        grecPrognosisAllocation.Init;
                        grecPrognosisAllocation := recAux;
                        gLineNo := gLineNo + 1;
                        grecPrognosisAllocation."Internal Entry No." := gLineNo;
                        grecPrognosisAllocation.Prognoses := -lQtyToUse;
                        grecPrognosisAllocation."User-ID" := UserId;
                        grecPrognosisAllocation."Date Modified" := Today;
                        grecPrognosisAllocation."Export/Import Date" := 0D;
                        grecPrognosisAllocation."BZ Original Prognoses" := false;
                        grecPrognosisAllocation.Exported := false;
                        grecPrognosisAllocation.Adjusted := true;
                        grecPrognosisAllocation.Insert;


                        grecPrognosisAllocation.Init;
                        grecPrognosisAllocation := recAux;
                        gLineNo := gLineNo + 1;
                        grecPrognosisAllocation."Internal Entry No." := gLineNo;
                        grecPrognosisAllocation.Prognoses := lQtyToUse;
                        grecPrognosisAllocation."User-ID" := UserId;
                        grecPrognosisAllocation."Date Modified" := Today;
                        grecPrognosisAllocation."Export/Import Date" := 0D;
                        grecPrognosisAllocation.Exported := false;
                        grecPrognosisAllocation.Adjusted := false;
                        grecPrognosisAllocation."BZ Original Prognoses" := false;
                        grecPrognosisAllocation.Insert;
                    end;
                end


            end;

            trigger OnPreDataItem()
            begin

                grecPrognosisAllocation.FindLast;
                gLineNo := grecPrognosisAllocation."Internal Entry No.";
                grecPrognosisAllocation.SetCurrentKey("Entry Type", "Item No.", Salesperson, Customer,
                                                        "Unit of Measure", "Sales Date", "Purchase Date");
                grecPrognosisAllocation.CopyFilters(recAux);
                grecPrognosisAllocation.SetRange(Adjusted, false);
                grecPrognosisAllocation.SetRange(Blocked, false);

            end;
        }
        dataitem("Prognosis/Allocation Entry"; "Prognosis/Allocation Entry")
        {
            DataItemTableView = SORTING ("Entry Type", "Item No.", "Unit of Measure", "Purchase Date", Exported, Salesperson, Customer, "Sales Date") WHERE ("Entry Type" = CONST (Prognoses));

            trigger OnAfterGetRecord()
            begin

                if Exported then Validate("Purchase Date", gNewPurchDate)
                else "Purchase Date" := gNewPurchDate;

                Modify;
            end;

            trigger OnPreDataItem()
            begin
                CopyFilters(recAux);

                SetRange(Adjusted, false);
                SetRange(Blocked, false);
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
                    field(gNewPurchDate; gNewPurchDate)
                    {
                        Caption = 'New Purchase Date';
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        if gNewPurchDate = 0D then Error(Text50000);
    end;

    var
        gNewPurchDate: Date;
        Text50000: Label 'New Purchase Date cannot be empty. Please fill it in (Option Tab). ';
        grecPrognosisAllocation: Record "Prognosis/Allocation Entry";
        gLineNo: Integer;
        grecauxPrognoses: Record "Prognosis/Allocation Entry";
}

