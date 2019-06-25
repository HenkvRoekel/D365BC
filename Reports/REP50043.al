report 50043 "Copy Prognoses to Allocation"
{

    DefaultLayout = RDLC;
    RDLCLayout = './RDLC/Copy Prognoses to Allocation.rdlc';

    Caption = 'Salesperson Prognoses to Allocation';

    dataset
    {
        dataitem("Item/Unit"; "Item/Unit")
        {
            CalcFields = Invoiced, Prognoses;
            DataItemTableView = SORTING ("Item No.", "Unit of Measure");
            RequestFilterFields = "Item No.", "Unit of Measure";
            column(Item_Unit__Item_No__; "Item No.")
            {
            }
            column(Item_Unit__Unit_of_Measure_; "Unit of Measure")
            {
            }
            column(Item_Unit_Invoiced; Invoiced)
            {
            }
            column(Item_Unit_Prognoses; Prognoses)
            {
            }
            column(Item_Unit_PrognosesCaption; FieldCaption(Prognoses))
            {
            }
            column(Item_Unit_InvoicedCaption; FieldCaption(Invoiced))
            {
            }
            column(Item_Unit__Unit_of_Measure_Caption; FieldCaption("Unit of Measure"))
            {
            }
            column(Item_Unit__Item_No__Caption; FieldCaption("Item No."))
            {
            }
            dataitem("Prognosis/Allocation Entry"; "Prognosis/Allocation Entry")
            {
                DataItemLink = "Item No." = FIELD ("Item No.");
                DataItemTableView = SORTING ("Entry Type", "Item No.", Salesperson) WHERE ("Entry Type" = CONST (Prognoses));

                trigger OnAfterGetRecord()
                begin
                    if ("Prognosis/Allocation Entry".Salesperson = '') and ("Prognosis/Allocation Entry".Customer = '') then
                        CurrReport.Skip;


                    if ((gSalesp <> "Prognosis/Allocation Entry".Salesperson) or (gCust <> "Prognosis/Allocation Entry".Customer)) and (gDoCreateAlloc = true) then begin
                        gSalesp := "Prognosis/Allocation Entry".Salesperson;
                        gCust := "Prognosis/Allocation Entry".Customer;

                        grecPrognAlloc1.Find('+');

                        grecPrognAlloc2.Reset;
                        grecPrognAlloc2.Init;
                        grecPrognAlloc2.SetCurrentKey("Entry Type", "Item No.", "Unit of Measure");
                        grecPrognAlloc2.SetRange("Entry Type", "Entry Type"::Prognoses);
                        grecPrognAlloc2.SetRange("Item No.", "Item No.");
                        grecPrognAlloc2.SetRange("Sales Date", gStartDate, gEndDate);
                        grecPrognAlloc2.SetRange(Salesperson, Salesperson);
                        grecPrognAlloc2.SetRange(Customer, Customer);
                        grecPrognAlloc2.CalcSums(grecPrognAlloc2.Prognoses);
                        gProgn := grecPrognAlloc2.Prognoses;

                        grecPrognAlloc2.SetRange("Entry Type", "Entry Type"::Allocation);


                        if ((not grecPrognAlloc2.Find('-')) and (gProgn <> 0)) then begin
                            grecPrognAlloc2.Init;
                            grecPrognAlloc2."Internal Entry No." := grecPrognAlloc1."Internal Entry No." + 1;
                            grecPrognAlloc2."Entry No." := grecPrognAlloc2."Internal Entry No.";
                            grecPrognAlloc2."Item No." := "Item/Unit"."Item No.";
                            grecPrognAlloc2."Sales Date" := gEndDate;
                            grecPrognAlloc2."Begin Date" := gStartDate;
                            grecPrognAlloc2.Salesperson := Salesperson;
                            grecPrognAlloc2.Customer := Customer;
                            grecPrognAlloc2."User-ID" := UserId;
                            grecPrognAlloc2."Unit of Measure" := '';
                            grecPrognAlloc2."Entry Type" := grecPrognAlloc2."Entry Type"::Allocation;
                            grecPrognAlloc2.Variety := CopyStr("Item No.", 1, 5);
                            grecPrognAlloc2."Date Modified" := Today;
                            if gWriteAllocation then
                                grecPrognAlloc2."Allocated Cust. Sales person" := gProgn;
                            grecPrognAlloc2.Insert;
                        end;
                    end;

                end;

                trigger OnPreDataItem()
                begin
                    "Prognosis/Allocation Entry".SetRange("Sales Date", gStartDate, gEndDate);

                    gSalesp := '';
                    gCust := '';

                end;
            }
            dataitem("Salesperson/Purchaser"; "Salesperson/Purchaser")
            {

                trigger OnAfterGetRecord()
                begin

                    if gCreateAll then begin
                        grecPrognAlloc1.Find('+');

                        grecPrognAlloc2.Reset;
                        grecPrognAlloc2.Init;
                        grecPrognAlloc2.SetCurrentKey("Entry Type", "Item No.", "Unit of Measure");
                        grecPrognAlloc2.SetRange("Entry Type", grecPrognAlloc2."Entry Type"::Prognoses);
                        grecPrognAlloc2.SetRange("Item No.", "Item/Unit"."Item No.");
                        grecPrognAlloc2.SetRange("Sales Date", gStartDate, gEndDate);
                        grecPrognAlloc2.SetRange(Salesperson, "Salesperson/Purchaser".Code);
                        grecPrognAlloc2.CalcSums(grecPrognAlloc2.Prognoses);
                        gProgn := grecPrognAlloc2.Prognoses;

                        grecPrognAlloc2.SetRange("Entry Type", grecPrognAlloc2."Entry Type"::Allocation);


                        if not grecPrognAlloc2.Find('-') then begin
                            grecPrognAlloc2.Init;
                            grecPrognAlloc2."Internal Entry No." := grecPrognAlloc1."Internal Entry No." + 1;
                            grecPrognAlloc2."Entry No." := grecPrognAlloc2."Internal Entry No.";
                            grecPrognAlloc2."Item No." := "Item/Unit"."Item No.";
                            grecPrognAlloc2."Sales Date" := gEndDate;
                            grecPrognAlloc2."Begin Date" := gStartDate;
                            grecPrognAlloc2.Salesperson := "Salesperson/Purchaser".Code;
                            grecPrognAlloc2."User-ID" := UserId;
                            grecPrognAlloc2."Unit of Measure" := '';
                            grecPrognAlloc2."Entry Type" := grecPrognAlloc2."Entry Type"::Allocation;
                            grecPrognAlloc2.Variety := CopyStr("Item/Unit"."Item No.", 1, 5);
                            grecPrognAlloc2."Date Modified" := Today;
                            if gWriteAllocation then
                                grecPrognAlloc2."Allocated Cust. Sales person" := gProgn;
                            grecPrognAlloc2.Insert;
                        end;
                    end;

                end;
            }

            trigger OnAfterGetRecord()
            begin

                if gFirstDeleteExistingEntries and (gItemNo <> "Item No.") then begin
                    grecPrognAlloc2.SetCurrentKey("Entry Type", "Item No.", "Unit of Measure");
                    grecPrognAlloc2.SetRange("Entry Type", grecPrognAlloc2."Entry Type"::Allocation);
                    grecPrognAlloc2.SetRange("Item No.", "Item No.");
                    grecPrognAlloc2.SetRange("Sales Date", gStartDate, gEndDate);
                    grecPrognAlloc2.SetFilter("User-ID", '<>%1', 'BEJONL');
                    grecPrognAlloc2.SetFilter(Salesperson, '<>%1', '');
                    grecPrognAlloc2.DeleteAll;
                    Clear(grecPrognAlloc2);
                    gItemNo := "Item No.";
                end;


                "Item/Unit".SetRange("Item/Unit"."Date Filter", gStartDate, gEndDate);
                "Item/Unit".CalcFields(Prognoses, Allocated);
                if not gCreateNoAllocation then
                    if "Item/Unit".Allocated = 0 then
                        CurrReport.Skip;

                grecItem.Get("Item/Unit"."Item No.");
                "Item/Unit".CopyFilter("Date Filter", grecItem."Date Filter");
                grecItem.CalcFields("B Prognoses", "B Country allocated");

                if not gCreateNoAllocation then
                    if grecItem."B Country allocated" = 0 then
                        CurrReport.Skip;


                if (grecItem."B Prognoses" <= grecItem."B Country allocated") and gDoCreateAlloc
                    then gWriteAllocation := true
                else gWriteAllocation := false;

                grecPrognAlloc3.Init;
                grecPrognAlloc3.SetCurrentKey("Entry Type", "Item No.", "Unit of Measure");
                grecPrognAlloc3.SetRange("Item No.", "Item No.");
                grecPrognAlloc3.SetRange("Sales Date", gStartDate, gEndDate);
                grecPrognAlloc3.SetFilter(Salesperson, '<>%1', '');
                grecPrognAlloc3.CalcSums("Allocated Cust. Sales person");

                if grecPrognAlloc3."Allocated Cust. Sales person" = 0 then begin
                    grecPrognAlloc3.SetRange(Salesperson);
                    grecPrognAlloc3.SetFilter(Customer, '<>%1', '');
                    grecPrognAlloc3.CalcSums("Allocated Cust. Sales person");
                end;

                if not gCreateNoAllocation then
                    if grecPrognAlloc3."Allocated Cust. Sales person" <> 0 then
                        CurrReport.Skip;
            end;

            trigger OnPreDataItem()
            begin
                if gStartDate = 0D then
                    Error(Text000);

                if gEndDate = 0D then
                    Error(Text001);
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
                    field(gDoCreateAlloc; gDoCreateAlloc)
                    {
                        Caption = 'Create Allocation';
                        ApplicationArea = All;
                    }
                    field(gStartDate; gStartDate)
                    {
                        Caption = 'Begin Date';
                        ApplicationArea = All;
                    }
                    field(gEndDate; gEndDate)
                    {
                        Caption = 'End Date';
                        ApplicationArea = All;
                    }
                    field(gCreateNoAllocation; gCreateNoAllocation)
                    {
                        Caption = 'Create Lines also for 0 Country Allocation';
                        ApplicationArea = All;
                    }
                    field(gCreateAll; gCreateAll)
                    {
                        Caption = 'Create Lines also for Salespersons without Progn.';
                        ApplicationArea = All;
                    }
                    field(gFirstDeleteExistingEntries; gFirstDeleteExistingEntries)
                    {
                        Caption = 'First Delete Existing Entries';
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin

            grecBejoSetup.Get;
            gStartDate := grecBejoSetup."Begin Date";
            gEndDate := grecBejoSetup."End Date";

        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        gDoCreateAlloc := true;
    end;

    var
        grecPrognAlloc1: Record "Prognosis/Allocation Entry";
        grecPrognAlloc2: Record "Prognosis/Allocation Entry";
        grecPrognAlloc3: Record "Prognosis/Allocation Entry";
        grecItem: Record Item;
        gDoCreateAlloc: Boolean;
        gEndDate: Date;
        gStartDate: Date;
        Text000: Label 'You must enter a Begin Date.';
        Text001: Label 'You must enter an End Date.';
        Text002: Label 'Prognoses %1 > Allocation %2 for Item No. %3.';
        grecBejoSetup: Record "Bejo Setup";
        gcuBejoMgt: Codeunit "Bejo Management";
        gFirstDeleteExistingEntries: Boolean;
        gCreateNoAllocation: Boolean;
        gCreateAll: Boolean;
        gItemNo: Code[20];
        gWriteAllocation: Boolean;
        gSalesp: Code[20];
        gCust: Code[20];
        gProgn: Decimal;
}

