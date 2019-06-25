report 50069 "Prognoses List"
{

    DefaultLayout = RDLC;
    RDLCLayout = './RDLC/Prognoses List.rdlc';


    dataset
    {
        dataitem(Item; Item)
        {
            CalcFields = "B Country allocated";
            DataItemTableView = SORTING ("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", Blocked;
            dataitem("Item/Unit"; "Item/Unit")
            {
                DataItemLink = "Item No." = FIELD ("No.");
                DataItemTableView = SORTING ("Item No.", "Unit of Measure") WHERE ("Unit of Measure" = FILTER (<> ''));
                RequestFilterFields = "Sales Person Filter", "Customer Filter", "Date Filter", "Promo Status";
                column(TotalInvoiced1; TotalInvoiced[1])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(TotalInvoiced2; TotalInvoiced[2])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(TotalInvoiced3; TotalInvoiced[3])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(TotalInvoiced4; TotalInvoiced[4])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(TotalInvoiced5; TotalInvoiced[5])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(TotalInvoiced6; TotalInvoiced[6])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(TotalInvoiced7; TotalInvoiced[7])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(TotalInvoiced8; TotalInvoiced[8])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(TotalInvoiced9; TotalInvoiced[9])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(TotalInvoiced10; TotalInvoiced[10])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(TotalInvoiced11; TotalInvoiced[11])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(TotalInvoiced12; TotalInvoiced[12])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(TotalInvoiced13; TotalInvoiced[13])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(TotalInvoiced14; TotalInvoiced[14])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(TotalInvoiced15; TotalInvoiced[15])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(TotalInvoiced16; TotalInvoiced[16])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(TotalInvoiced17; TotalInvoiced[17])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(TotalInvoiced18; TotalInvoiced[18])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(TotalInvoiced19; TotalInvoiced[19])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(TotalPrognosis1; TotalPrognoses[1])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(TotalPrognosis2; TotalPrognoses[2])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(TotalPrognosis3; TotalPrognoses[3])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(TotalPrognosis4; TotalPrognoses[4])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(TotalPrognosis5; TotalPrognoses[5])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(TotalPrognosis6; TotalPrognoses[6])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(TotalPrognosis7; TotalPrognoses[7])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(TotalPrognosis8; TotalPrognoses[8])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(TotalPrognosis9; TotalPrognoses[9])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(TotalPrognosis10; TotalPrognoses[10])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(TotalPrognosis11; TotalPrognoses[11])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(TotalPrognosis12; TotalPrognoses[12])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(TotalPrognosis13; TotalPrognoses[13])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(TotalPrognosis14; TotalPrognoses[14])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(TotalPrognosis15; TotalPrognoses[15])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(TotalPrognosis16; TotalPrognoses[16])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(TotalPrognosis17; TotalPrognoses[17])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(TotalPrognosis18; TotalPrognoses[18])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(TotalPrognosis19; TotalPrognoses[19])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(gPrognosisTotalTotal; gPrognosisTotalTotal)
                {
                    DecimalPlaces = 2 : 4;
                }
                column(CustomerFilter; gCustomerFilter)
                {
                }
                column(UserId; UserId)
                {
                }
                column(CompanyName; CompanyName)
                {
                }
                column(OriginalPrognosisText; gOriginalPrognosisText)
                {
                }
                column(PerUnit; gPerUnit)
                {
                }
                column(gFromInvoiceDate; Format(gFromInvoiceDate, 0, 0))
                {
                }
                column(gUptoInvoiceDate; Format(gUptoInvoiceDate, 0, 0))
                {
                }
                column(StartDate2; Format(gPeriodStartDate[2], 0, 0))
                {
                }
                column(EndDate2; Format(gPeriodStartDate1[3] - 1, 0, 0))
                {
                }
                column(StartDate3; Format(gPeriodStartDate[3], 0, 0))
                {
                }
                column(EndDate3; Format(gPeriodStartDate1[4] - 1, 0, 0))
                {
                }
                column(StartDate4; Format(gPeriodStartDate[4], 0, 0))
                {
                }
                column(EndDate4; Format(gPeriodStartDate1[5] - 1, 0, 0))
                {
                }
                column(StartDate5; Format(gPeriodStartDate[5], 0, 0))
                {
                }
                column(EndDate5; Format(gPeriodStartDate1[6] - 1, 0, 0))
                {
                }
                column(StartDate6; Format(gPeriodStartDate[6], 0, 0))
                {
                }
                column(EndDate6; Format(gPeriodStartDate1[7] - 1, 0, 0))
                {
                }
                column(StartDate7; Format(gPeriodStartDate[7], 0, 0))
                {
                }
                column(EndDate7; Format(gPeriodStartDate1[8] - 1, 0, 0))
                {
                }
                column(StartDate8; Format(gPeriodStartDate[8], 0, 0))
                {
                }
                column(EndDate8; Format(gPeriodStartDate1[9] - 1, 0, 0))
                {
                }
                column(StartDate9; Format(gPeriodStartDate[9], 0, 0))
                {
                }
                column(EndDate9; Format(gPeriodStartDate1[10] - 1, 0, 0))
                {
                }
                column(StartDate10; Format(gPeriodStartDate[10], 0, 0))
                {
                }
                column(EndDate10; Format(gPeriodStartDate1[11] - 1, 0, 0))
                {
                }
                column(StartDate11; Format(gPeriodStartDate[11], 0, 0))
                {
                }
                column(EndDate11; Format(gPeriodStartDate1[12] - 1, 0, 0))
                {
                }
                column(StartDate12; Format(gPeriodStartDate[12], 0, 0))
                {
                }
                column(EndDate12; Format(gPeriodStartDate1[13] - 1, 0, 0))
                {
                }
                column(StartDate13; Format(gPeriodStartDate[13], 0, 0))
                {
                }
                column(EndDate13; Format(gPeriodStartDate1[14] - 1, 0, 0))
                {
                }
                column(StartDate14; Format(gPeriodStartDate[14], 0, 0))
                {
                }
                column(EndDate14; Format(gPeriodStartDate1[15] - 1, 0, 0))
                {
                }
                column(StartDate15; Format(gPeriodStartDate[15], 0, 0))
                {
                }
                column(EndDate15; Format(gPeriodStartDate1[16] - 1, 0, 0))
                {
                }
                column(StartDate16; Format(gPeriodStartDate[16], 0, 0))
                {
                }
                column(EndDate16; Format(gPeriodStartDate1[17] - 1, 0, 0))
                {
                }
                column(StartDate17; Format(gPeriodStartDate[17], 0, 0))
                {
                }
                column(EndDate17; Format(gPeriodStartDate1[18] - 1, 0, 0))
                {
                }
                column(StartDate18; Format(gPeriodStartDate[18], 0, 0))
                {
                }
                column(EndDate18; Format(gPeriodStartDate1[19] - 1, 0, 0))
                {
                }
                column(StartDate19; Format(gPeriodStartDate[19], 0, 0))
                {
                }
                column(EndDate19; Format(gPeriodStartDate1[20] - 1, 0, 0))
                {
                }
                column(ItemNo_ItemUnit; "Item/Unit"."Item No.")
                {
                    IncludeCaption = true;
                }
                column(Item_Description; gItem.Description)
                {
                    IncludeCaption = true;
                }
                column(Item_Description2; gItem."Description 2")
                {
                }
                column(gAllocation; gAllocation)
                {
                }
                column(UoM_DescriptionForPrognosis; grecUnitOfMeasure."B Description for Prognoses")
                {
                }
                column(gMillion; gMillion)
                {
                }
                column(gPromostatus; gPromostatus)
                {
                }
                column(gBlockingCode; gBlockingCode)
                {
                }
                column(gInvoiced1; gInvoiced[1])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(gPrognosis1; gPrognosis[1])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(gInvoiced2; gInvoiced[2])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(gPrognosis2; gPrognosis[2])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(gInvoiced3; gInvoiced[3])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(gPrognosis3; gPrognosis[3])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(gInvoiced4; gInvoiced[4])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(gPrognosis4; gPrognosis[4])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(gInvoiced5; gInvoiced[5])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(gPrognosis5; gPrognosis[5])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(gInvoiced6; gInvoiced[6])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(gPrognosis6; gPrognosis[6])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(gInvoiced7; gInvoiced[7])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(gPrognosis7; gPrognosis[7])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(gInvoiced8; gInvoiced[8])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(gPrognosis8; gPrognosis[8])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(gInvoiced9; gInvoiced[9])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(gPrognosis9; gPrognosis[9])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(gInvoiced10; gInvoiced[10])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(gPrognosis10; gPrognosis[10])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(gInvoiced11; gInvoiced[11])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(gPrognosis11; gPrognosis[11])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(gInvoiced12; gInvoiced[12])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(gPrognosis12; gPrognosis[12])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(gInvoiced13; gInvoiced[13])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(gPrognosis13; gPrognosis[13])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(gInvoiced14; gInvoiced[14])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(gPrognosis14; gPrognosis[14])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(gInvoiced15; gInvoiced[15])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(gPrognosis15; gPrognosis[15])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(gInvoiced16; gInvoiced[16])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(gPrognosis16; gPrognosis[16])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(gInvoiced17; gInvoiced[17])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(gPrognosis17; gPrognosis[17])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(gInvoiced18; gInvoiced[18])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(gPrognosis18; gPrognosis[18])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(gInvoiced19; gInvoiced[19])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(gPrognosis19; gPrognosis[19])
                {
                    DecimalPlaces = 2 : 4;
                }
                column(gPrognosisTotal2to19; gPrognosisTotal2to19)
                {
                    DecimalPlaces = 2 : 4;
                }
                column(gTotalInvoiced1; gTotalInvoiced[1])
                {
                    DecimalPlaces = 2 : 4;
                }
                dataitem("Salesperson/Purchaser"; "Salesperson/Purchaser")
                {
                    DataItemTableView = SORTING (Code) ORDER(Ascending);
                    column(gShowSplitBySalesperson; gShowSplitBySalesperson)
                    {
                    }
                    column(Code_SalespersonPurchaser; "Salesperson/Purchaser".Code)
                    {
                    }
                    column(gSalespersonSales1; gSalespersonSales[1])
                    {
                        DecimalPlaces = 2 : 4;
                    }
                    column(gSalespersonPrognosis1; gSalespersonPrognosis[1])
                    {
                        DecimalPlaces = 2 : 4;
                    }
                    column(gSalespersonSales2; gSalespersonSales[2])
                    {
                        DecimalPlaces = 2 : 4;
                    }
                    column(gSalespersonPrognosis2; gSalespersonPrognosis[2])
                    {
                        DecimalPlaces = 2 : 4;
                    }
                    column(gSalespersonSales3; gSalespersonSales[3])
                    {
                        DecimalPlaces = 2 : 4;
                    }
                    column(gSalespersonPrognosis3; gSalespersonPrognosis[3])
                    {
                        DecimalPlaces = 2 : 4;
                    }
                    column(gSalespersonSales4; gSalespersonSales[4])
                    {
                        DecimalPlaces = 2 : 4;
                    }
                    column(gSalespersonPrognosis4; gSalespersonPrognosis[4])
                    {
                        DecimalPlaces = 2 : 4;
                    }
                    column(gSalespersonSales5; gSalespersonSales[5])
                    {
                        DecimalPlaces = 2 : 4;
                    }
                    column(gSalespersonPrognosis5; gSalespersonPrognosis[5])
                    {
                        DecimalPlaces = 2 : 4;
                    }
                    column(gSalespersonSales6; gSalespersonSales[6])
                    {
                        DecimalPlaces = 2 : 4;
                    }
                    column(gSalespersonPrognosis6; gSalespersonPrognosis[6])
                    {
                        DecimalPlaces = 2 : 4;
                    }
                    column(gSalespersonSales7; gSalespersonSales[7])
                    {
                        DecimalPlaces = 2 : 4;
                    }
                    column(gSalespersonPrognosis7; gSalespersonPrognosis[7])
                    {
                        DecimalPlaces = 2 : 4;
                    }
                    column(gSalespersonSales8; gSalespersonSales[8])
                    {
                        DecimalPlaces = 2 : 4;
                    }
                    column(gSalespersonPrognosis8; gSalespersonPrognosis[8])
                    {
                        DecimalPlaces = 2 : 4;
                    }
                    column(gSalespersonSales9; gSalespersonSales[9])
                    {
                        DecimalPlaces = 2 : 4;
                    }
                    column(gSalespersonPrognosis9; gSalespersonPrognosis[9])
                    {
                        DecimalPlaces = 2 : 4;
                    }
                    column(gSalespersonSales10; gSalespersonSales[10])
                    {
                        DecimalPlaces = 2 : 4;
                    }
                    column(gSalespersonPrognosis10; gSalespersonPrognosis[10])
                    {
                        DecimalPlaces = 2 : 4;
                    }
                    column(gSalespersonSales11; gSalespersonSales[11])
                    {
                        DecimalPlaces = 2 : 4;
                    }
                    column(gSalespersonPrognosis11; gSalespersonPrognosis[11])
                    {
                        DecimalPlaces = 2 : 4;
                    }
                    column(gSalespersonSales12; gSalespersonSales[12])
                    {
                        DecimalPlaces = 2 : 4;
                    }
                    column(gSalespersonPrognosis12; gSalespersonPrognosis[12])
                    {
                        DecimalPlaces = 2 : 4;
                    }
                    column(gSalespersonSales13; gSalespersonSales[13])
                    {
                        DecimalPlaces = 2 : 4;
                    }
                    column(gSalespersonPrognosis13; gSalespersonPrognosis[13])
                    {
                        DecimalPlaces = 2 : 4;
                    }
                    column(gSalespersonSales14; gSalespersonSales[14])
                    {
                        DecimalPlaces = 2 : 4;
                    }
                    column(gSalespersonPrognosis14; gSalespersonPrognosis[14])
                    {
                        DecimalPlaces = 2 : 4;
                    }
                    column(gSalespersonSales15; gSalespersonSales[15])
                    {
                        DecimalPlaces = 2 : 4;
                    }
                    column(gSalespersonPrognosis15; gSalespersonPrognosis[15])
                    {
                        DecimalPlaces = 2 : 4;
                    }
                    column(gSalespersonSales16; gSalespersonSales[16])
                    {
                        DecimalPlaces = 2 : 4;
                    }
                    column(gSalespersonPrognosis16; gSalespersonPrognosis[16])
                    {
                        DecimalPlaces = 2 : 4;
                    }
                    column(gSalespersonSales17; gSalespersonSales[17])
                    {
                        DecimalPlaces = 2 : 4;
                    }
                    column(gSalespersonPrognosis17; gSalespersonPrognosis[17])
                    {
                        DecimalPlaces = 2 : 4;
                    }
                    column(gSalespersonSales18; gSalespersonSales[18])
                    {
                        DecimalPlaces = 2 : 4;
                    }
                    column(gSalespersonPrognosis18; gSalespersonPrognosis[18])
                    {
                        DecimalPlaces = 2 : 4;
                    }
                    column(gSalespersonSales19; gSalespersonSales[19])
                    {
                        DecimalPlaces = 2 : 4;
                    }
                    column(gSalespersonPrognosis19; gSalespersonPrognosis[19])
                    {
                        DecimalPlaces = 2 : 4;
                    }

                    trigger OnAfterGetRecord()
                    var
                        lrecItemUnit: Record "Item/Unit";
                    begin

                        Clear(gSalespersonSales);
                        Clear(gSalespersonPrognosis);

                        lrecItemUnit.Get("Item/Unit"."Item No.", "Item/Unit"."Unit of Measure");
                        for gColumnCounter := 1 to 25 do begin
                            if gColumnCounter = 1 then
                                lrecItemUnit.SetRange("Date Filter", gFromInvoiceDate, gUptoInvoiceDate)
                            else
                                lrecItemUnit.SetRange("Date Filter", gPeriodStartDate[gColumnCounter], gPeriodStartDate[gColumnCounter + 1] - 1);

                            lrecItemUnit.SetRange("Sales Person Filter", "Salesperson/Purchaser".Code);
                            lrecItemUnit.CalcFields(Invoiced);

                            gSalespersonSales[gColumnCounter] := -(lrecItemUnit.Invoiced);
                            if grecItemUnitOfMeasure."Qty. per Unit of Measure" >= 100 then
                                gSalespersonSales[gColumnCounter] := gSalespersonSales[gColumnCounter] / 1000000;

                            if gOriginalPrognosis then begin
                                grecPrognosisAllocationEntry1.SetCurrentKey("Entry Type", "Item No.", "Unit of Measure", "Sales Date"); // BEJOWW5.0.006
                                grecPrognosisAllocationEntry1.SetRange("Entry Type", grecPrognosisAllocationEntry1."Entry Type"::Prognoses);  // BEJOWW5.0.006
                                grecPrognosisAllocationEntry1.SetRange("Item No.", "Item/Unit"."Item No.");
                                grecPrognosisAllocationEntry1.SetRange("Unit of Measure", "Item/Unit"."Unit of Measure");
                                grecPrognosisAllocationEntry1.SetRange(Salesperson, "Salesperson/Purchaser".Code);
                                grecPrognosisAllocationEntry1.SetRange(Customer, "Item/Unit".GetFilter("Customer Filter"));

                                if gColumnCounter = 1 then
                                    grecPrognosisAllocationEntry1.SetRange("Sales Date", gFromInvoiceDate, gUptoInvoiceDate)
                                else

                                    grecPrognosisAllocationEntry1.SetRange("Sales Date", gPeriodStartDate1[gColumnCounter], gPeriodStartDate1[gColumnCounter + 1] - 1);
                                if grecPrognosisAllocationEntry1.Find('-') then begin
                                    gSalespersonPrognosis[gColumnCounter] := grecPrognosisAllocationEntry1.Prognoses;
                                end
                            end else begin

                                if gColumnCounter = 1 then
                                    lrecItemUnit.SetRange("Date Filter", gFromInvoiceDate, gUptoInvoiceDate)
                                else

                                    lrecItemUnit.SetRange("Date Filter", gPeriodStartDate1[gColumnCounter], gPeriodStartDate1[gColumnCounter + 1] - 1);
                                lrecItemUnit.CalcFields(Prognoses);
                                gSalespersonPrognosis[gColumnCounter] := lrecItemUnit.Prognoses;
                            end;

                            if gPerUnit then begin
                                if grecUnitOfMeasure."B Unit in Weight" and (grecItemUnitOfMeasure."Qty. per Unit of Measure" <> 0) then begin
                                    gSalespersonSales[gColumnCounter] := gSalespersonSales[gColumnCounter] / grecItemUnitOfMeasure."Qty. per Unit of Measure";
                                    gSalespersonPrognosis[gColumnCounter] := gSalespersonPrognosis[gColumnCounter] / grecItemUnitOfMeasure."Qty. per Unit of Measure";
                                end else begin
                                    gSalespersonSales[gColumnCounter] := gSalespersonSales[gColumnCounter] * (1000000 / grecItemUnitOfMeasure."Qty. per Unit of Measure");
                                    gSalespersonPrognosis[gColumnCounter] := gSalespersonPrognosis[gColumnCounter] * (1000000 / grecItemUnitOfMeasure."Qty. per Unit of Measure");
                                end;
                            end;
                        end;

                        gLineWithoutValues := Abs(gSalespersonSales[1]);
                        for gColumnCounter := 2 to 25 do
                            gLineWithoutValues := gLineWithoutValues + Abs(gSalespersonPrognosis[gColumnCounter]);

                        if gLineWithoutValues = 0 then
                            CurrReport.Skip;


                    end;

                    trigger OnPreDataItem()
                    begin


                        if not gShowSplitBySalesperson then
                            CurrReport.Break;
                    end;
                }

                trigger OnAfterGetRecord()
                begin


                    grecPrognosisAllocationEntry.Init;

                    CalcFields(Invoiced, Prognoses);
                    gInvoiced[1] := 0;

                    if grecItemUnitOfMeasure.Get("Item No.", "Unit of Measure") then;

                    if StrLen(Variety) < 5 then
                        Variety := CopyStr("Item No.", 1, 5);

                    gItem.SetRange("Date Filter", gFromDate, gUptoDate);
                    if gItem.Get("Item No.") then
                        if grecItemTranslation.Get("Item/Unit"."Item No.", '', gLanguageCode) then begin
                            gItem.Description := grecItemTranslation.Description;
                            gItem."Description 2" := grecItemTranslation."Description 2";
                        end;
                    gItem.CalcFields("B Country allocated");

                    if grecUnitOfMeasure.Get("Unit of Measure") then;
                    if grecUnitOfMeasureTranslation.Get("Item/Unit"."Unit of Measure", gLanguageCode) then begin

                    end;

                    if grecUnitOfMeasure."B Unit in Weight" then
                        gMillion := text50014
                    else
                        gMillion := text50011;

                    for gColumnCounter := 2 to 25 do begin
                        SetRange("Date Filter", gPeriodStartDate[gColumnCounter], gPeriodStartDate[gColumnCounter + 1] - 1);

                        CalcFields(Invoiced);

                        if gPerUnit = true then begin
                            if grecItemUnitOfMeasure.Get("Item No.", "Unit of Measure") then;
                            if (grecUnitOfMeasure."B Unit in Weight") and (grecItemUnitOfMeasure."Qty. per Unit of Measure" <> 0) then begin
                                Invoiced := Invoiced / grecItemUnitOfMeasure."Qty. per Unit of Measure";

                            end else begin
                                Invoiced := Invoiced * (1000000 / grecItemUnitOfMeasure."Qty. per Unit of Measure");


                            end;
                        end;

                        if grecItemUnitOfMeasure."Qty. per Unit of Measure" < 100 then begin

                            gInvoiced[gColumnCounter] := -(Invoiced);
                            TotalInvoiced[gColumnCounter] := TotalInvoiced[gColumnCounter] + gInvoiced[gColumnCounter];

                            if Variety = CopyStr("Item No.", 1, 5) then
                                gTotalInvoicedKG[gColumnCounter] := gTotalInvoicedKG[gColumnCounter] + (-(Invoiced));

                        end else begin

                            gInvoiced[gColumnCounter] := -(Invoiced) / 1000000;
                            TotalInvoiced[gColumnCounter] := TotalInvoiced[gColumnCounter] + gInvoiced[gColumnCounter];
                            gTotalInvoiced[gColumnCounter] := gTotalInvoiced[gColumnCounter] + (-(Invoiced)) / 1000000;

                        end;
                    end;

                    for gColumnCounter := 2 to 25 do begin
                        if gOriginalPrognosis = true then begin

                            grecPrognosisAllocationEntry1.SetCurrentKey("Entry Type", "Item No.", "Unit of Measure", "Sales Date"); // BEJOWW5.0.006
                                                                                                                                    // grecPrognosisAllocationEntry1.SETRANGE(Code,'PERIODE');   BEJOWW5.0.006
                            grecPrognosisAllocationEntry1.SetRange("Entry Type", grecPrognosisAllocationEntry1."Entry Type"::Prognoses);  // BEJOWW5.0.006
                            grecPrognosisAllocationEntry1.SetRange("Item No.", "Item/Unit"."Item No.");
                            grecPrognosisAllocationEntry1.SetRange("Unit of Measure", "Item/Unit"."Unit of Measure");


                            grecPrognosisAllocationEntry1.SetRange(Salesperson, "Item/Unit".GetFilter("Sales Person Filter"));
                            grecPrognosisAllocationEntry1.SetRange(Customer, "Item/Unit".GetFilter("Customer Filter"));

                            grecPrognosisAllocationEntry1.SetRange("Sales Date", gPeriodStartDate1[gColumnCounter], gPeriodStartDate1[gColumnCounter + 1] - 1);
                            if grecPrognosisAllocationEntry1.Find('-') then begin
                                gPrognosis[gColumnCounter] := grecPrognosisAllocationEntry1.Prognoses;
                            end;
                            if gPerUnit = true then begin
                                if grecItemUnitOfMeasure.Get("Item No.", "Unit of Measure") then;
                                if (grecUnitOfMeasure."B Unit in Weight") and (grecItemUnitOfMeasure."Qty. per Unit of Measure" <> 0) then begin
                                    gPrognosis[gColumnCounter] := gPrognosis[gColumnCounter] / grecItemUnitOfMeasure."Qty. per Unit of Measure";
                                end else begin
                                    gPrognosis[gColumnCounter] := gPrognosis[gColumnCounter] * (1000000 / grecItemUnitOfMeasure."Qty. per Unit of Measure");
                                end;
                            end;
                            ;

                        end else begin
                            ;

                            grecPrognosisAllocationEntry1.SetCurrentKey("Entry Type", "Item No.", "Unit of Measure", "Sales Date");// BEJOWW5.0.006
                                                                                                                                   // grecPrognosisAllocationEntry1.SETRANGE(Code,'PERIODE'); BEJOWW5.0.006
                            grecPrognosisAllocationEntry1.SetRange("Entry Type", grecPrognosisAllocationEntry1."Entry Type"::Prognoses);   // BEJOWW5.0.006
                            grecPrognosisAllocationEntry1.SetRange("Item No.", "Item/Unit"."Item No.");
                            grecPrognosisAllocationEntry1.SetRange("Unit of Measure", "Item/Unit"."Unit of Measure");

                            grecPrognosisAllocationEntry1.SetRange(Salesperson, "Item/Unit".GetFilter("Sales Person Filter"));
                            grecPrognosisAllocationEntry1.SetRange(Customer, "Item/Unit".GetFilter("Customer Filter"));
                            SetRange("Date Filter", gPeriodStartDate1[gColumnCounter], gPeriodStartDate1[gColumnCounter + 1] - 1);
                            CalcFields(Prognoses);
                            gPrognosis[gColumnCounter] := Prognoses;


                            if gPerUnit = true then begin
                                if grecItemUnitOfMeasure.Get("Item No.", "Unit of Measure") then;
                                if (grecUnitOfMeasure."B Unit in Weight") and (grecItemUnitOfMeasure."Qty. per Unit of Measure" <> 0) then begin
                                    gPrognosis[gColumnCounter] := gPrognosis[gColumnCounter] / grecItemUnitOfMeasure."Qty. per Unit of Measure";

                                end else begin
                                    gPrognosis[gColumnCounter] := gPrognosis[gColumnCounter] * (1000000 / grecItemUnitOfMeasure."Qty. per Unit of Measure");
                                end;
                            end;

                            if grecItemUnitOfMeasure."Qty. per Unit of Measure" < 100 then
                                gTotalPrognosiskg[gColumnCounter] := gTotalPrognosiskg[gColumnCounter] + Prognoses
                            else
                                gTotalPrognosis[gColumnCounter] := gTotalPrognosis[gColumnCounter] + Prognoses;
                        end;
                        TotalPrognoses[gColumnCounter] := TotalPrognoses[gColumnCounter] + gPrognosis[gColumnCounter];
                    end;

                    SetRange("Date Filter", gFromInvoiceDate, gUptoInvoiceDate);
                    CalcFields(Invoiced, Prognoses);
                    gPrognosis[1] := Prognoses;
                    if grecItemUnitOfMeasure."Qty. per Unit of Measure" < 100 then begin
                        gInvoiced[1] := -(Invoiced);

                        if Variety = CopyStr("Item No.", 1, 5) then
                            gTotalInvoicedKG[1] := gTotalInvoicedKG[1] + (-(Invoiced));
                    end else begin
                        gInvoiced[1] := -(Invoiced) / 1000000;

                        if gPerUnit = true then
                            gTotalInvoiced[1] := gTotalInvoiced[1] + (-(Invoiced)) / 1000000 / grecItemUnitOfMeasure."Qty. per Unit of Measure"
                        else
                            gTotalInvoiced[1] := gTotalInvoiced[1] + (-(Invoiced)) / 1000000;

                    end;

                    if gPerUnit = true then begin
                        if grecItemUnitOfMeasure.Get("Item No.", "Unit of Measure") then;
                        if (grecUnitOfMeasure."B Unit in Weight") and (grecItemUnitOfMeasure."Qty. per Unit of Measure" <> 0) then begin
                            gInvoiced[1] := gInvoiced[1] / grecItemUnitOfMeasure."Qty. per Unit of Measure";

                            gPrognosis[1] := gPrognosis[1] / grecItemUnitOfMeasure."Qty. per Unit of Measure";

                        end else begin
                            gInvoiced[1] := gInvoiced[1] * (1000000 / grecItemUnitOfMeasure."Qty. per Unit of Measure");

                            gPrognosis[1] := gPrognosis[1] * (1000000 / grecItemUnitOfMeasure."Qty. per Unit of Measure");
                        end;
                    end;

                    TotalInvoiced[1] := TotalInvoiced[1] + gInvoiced[1];
                    TotalPrognoses[1] := TotalPrognoses[1] + gPrognosis[1];

                    if gTotalInvoiced[1] <> 0 then
                        gMillion2 := text50011;
                    if gTotalInvoicedKG[1] <> 0 then
                        gMillion3 := text50014;

                    gLineWithoutValues := 0;
                    for gColumnCounter := 2 to 25 do begin
                        gLineWithoutValues := gLineWithoutValues + gPrognosis[gColumnCounter];
                    end;
                    gLineWithoutValues := gLineWithoutValues + gInvoiced[1];
                    if (gSkipLineWithoutValues = true) and (gLineWithoutValues = 0) then
                        CurrReport.Skip;


                    CalcFields("Promo Status");
                    gPromostatus := "Promo Status" + '.';
                    gBlockingCode := gcuBlockingMgt.ItemUnitBlockCode("Item/Unit") + '.';


                    for gColumnCounter := 2 to 19 do begin
                        gTotalInvoicedHelper[gColumnCounter] := gTotalInvoicedHelper[gColumnCounter] + gTotalInvoiced[gColumnCounter];
                    end;

                    gLineWithoutValues := 0;
                    for gColumnCounter := 2 to 19 do begin
                        gLineWithoutValues := gLineWithoutValues + gPrognosis[gColumnCounter];
                    end;
                    gLineWithoutValues := gLineWithoutValues + gInvoiced[1];

                    CalculatePrognosisTotals;


                end;

                trigger OnPreDataItem()
                begin
                    //CurrReport.CreateTotals(gInvoiced, gPrognosis, Invoiced);

                    Item.CalcFields("B Country allocated");
                    if (not grecBejoSetup."Prognoses per Salesperson") or ("Item/Unit".GetFilter("Sales Person Filter") = '') then
                        gAllocation := Item."B Country allocated"
                    else begin
                        Item.SetFilter("B Salespersonfilter", "Item/Unit".GetFilter("Sales Person Filter"));
                        Item.CalcFields("B Salesperson/cust. allocated");
                        gAllocation := Item."B Salesperson/cust. allocated";
                    end;

                    TotalInvoiced[1] := 0;
                    Clear(gTotalPrognosis);
                    Clear(gTotalInvoiced);
                    Clear(gTotalInvoicedKG);
                    Clear(gTotalPrognosiskg);
                    Clear(TotalInvoiced);
                    Clear(TotalPrognoses);
                    Clear(gPrognosisTotal2to19);
                    Clear(gPrognosisTotalTotal);

                end;
            }

            trigger OnAfterGetRecord()
            begin

                SetRange("Date Filter", gFromDate, gUptoDate);
                CalcFields("B Country allocated");
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
                    field(gHelperDate; gHelperDate)
                    {
                        Caption = 'Begin Date Prognosis';
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin

                            gDate5 := '<-1Y>';
                            gDate6 := '<-1D>';
                            gPeriodStartDate[2] := CalcDate(gDate5, gHelperDate);
                            gFromInvoiceDate := CalcDate(gDate5, gHelperDate);
                            gUptoInvoiceDate := CalcDate(gDate6, gHelperDate);
                        end;
                    }
                    field(gPeriodLength; gPeriodLength)
                    {
                        Caption = 'Period';
                        ApplicationArea = All;
                    }
                    field(gSkipLineWithoutValues; gSkipLineWithoutValues)
                    {
                        Caption = 'Only prognoses for items sold';
                        ApplicationArea = All;
                    }
                    field(gProgdj; gProgdj)
                    {
                        Caption = 'Prognoses and Sales in same period';
                        ApplicationArea = All;
                    }
                    field(gFromInvoiceDate; gFromInvoiceDate)
                    {
                        Caption = 'Begin Date Total Sales';
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin

                            gDate5 := '<-1Y>';
                            gPeriodStartDate[2] := CalcDate(gDate5, gHelperDate);
                        end;
                    }
                    field(gUptoInvoiceDate; gUptoInvoiceDate)
                    {
                        Caption = 'End Date Total Sales';
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin

                            gDate5 := '<-1Y>';
                            gPeriodStartDate[2] := CalcDate(gDate5, gHelperDate);
                        end;
                    }
                    field(gOriginalPrognosis; gOriginalPrognosis)
                    {
                        Caption = 'Original Prognoses';
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin


                            if gOriginalPrognosis then
                                gOriginalPrognosisText := text50015
                            else
                                gOriginalPrognosisText := '';

                        end;
                    }
                    field(gPerUnit; gPerUnit)
                    {
                        Caption = 'Per Unit';
                        ApplicationArea = All;
                    }
                    field(gShowSplitBySalesperson; gShowSplitBySalesperson)
                    {
                        Caption = 'Show details for Salespersons';
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

            if CopyStr(grecCompanyInformation."VAT Registration No.", 1, 2) <> 'NL' then begin
                gDate1 := '<1M>';
                gDate3 := '<0D>';
                gDate4 := CalcDate(gDate3);
            end;

            if CopyStr(grecCompanyInformation."VAT Registration No.", 1, 2) = 'NL' then begin
                gDate1 := '1M';
                gDate3 := '0D';
                gDate4 := CalcDate(gDate3);
            end;
            if gPeriodStartDate[2] = gDate4 then
                gPeriodStartDate[2] := WorkDate;
            if gPeriodLength = '' then
                gPeriodLength := gDate1;
        end;
    }

    labels
    {
        lblTotal = 'Total';
        lblPrognosisList = 'Prognoses List';
        lblPerUnit = 'Per unit';
        lblSales = 'Sales';
        lblPrognosis = 'Progn.';
        lblVarietyTotals = 'Variety Totals';
        lblPer = 'per';
        lblAllocation = 'Allocation';
        lblItemNo = 'Item No.';
        lblPS = 'PS:';
        lblBC = 'BC:';
        lblPage = 'Page:';
    }

    trigger OnInitReport()
    begin

        grecBejoSetup.Get;

    end;

    trigger OnPreReport()
    begin


        grecCompanyInformation.Get;

        if CopyStr(grecCompanyInformation."VAT Registration No.", 1, 2) <> 'NL' then begin
            gDate6 := '<-1Y>';
            gDate5 := '<+1Y>';
            gPeriodStartDate[2] := CalcDate(gDate6, gHelperDate);
        end;

        if CopyStr(grecCompanyInformation."VAT Registration No.", 1, 2) = 'NL' then begin
            gDate6 := '-1J';
            gDate5 := '+1J';
            gPeriodStartDate[2] := CalcDate(gDate6, gHelperDate);
        end;

        if gProgdj = false then
            gPeriodStartDate1[2] := CalcDate(gDate5, gPeriodStartDate[2])
        else
            gPeriodStartDate1[2] := gPeriodStartDate[2];

        gCustomerFilter := Item.GetFilters + ' ' + "Item/Unit".GetFilters;
        gFromDate := "Item/Unit".GetRangeMin("Date Filter");
        gUptoDate := "Item/Unit".GetRangeMax("Date Filter");
        for gColumnCounter := 2 to 25 do begin
            gPeriodStartDate[gColumnCounter + 1] := CalcDate(gPeriodLength, gPeriodStartDate[gColumnCounter]);
            gPeriodStartDate1[gColumnCounter + 1] := CalcDate(gPeriodLength, gPeriodStartDate1[gColumnCounter]);
        end;


        gPeriodStartDate[27] := DMY2Date(31, 12, 9999);

        Item.SetRange("Date Filter", gFromDate, gUptoDate);
        gItem.SetRange("Date Filter", gFromDate, gUptoDate);
    end;

    var
        grecCompanyInformation: Record "Company Information";
        gPeriodLength: Code[20];
        gCustomerFilter: Text[250];
        gPeriodStartDate: array[27] of Date;
        gPeriodStartDate1: array[26] of Date;
        gColumnCounter: Integer;
        gItem: Record Item;
        gInvoiced: array[26] of Decimal;
        TotalInvoiced: array[26] of Decimal;
        gTotalInvoicedHelper: array[26] of Decimal;
        gTotalInvoiced: array[26] of Decimal;
        gTotalInvoicedKG: array[26] of Decimal;
        gPrognosis: array[26] of Decimal;
        gTotalPrognosis: array[26] of Decimal;
        gTotalPrognosiskg: array[26] of Decimal;
        TotalPrognoses: array[26] of Decimal;
        grecItemUnitOfMeasure: Record "Item Unit of Measure";
        gMillion: Text[10];
        gMillion2: Text[10];
        gMillion3: Text[10];
        gLanguageCode: Code[10];
        grecItemTranslation: Record "Item Translation";
        grecUnitOfMeasureTranslation: Record "Unit of Measure Translation";
        grecUnitOfMeasure: Record "Unit of Measure";
        gProgdj: Boolean;
        gDate1: Text[30];
        gDate3: Text[30];
        gDate4: Date;
        gDate5: Text[30];
        gDate6: Text[30];
        grecPrognosisAllocationEntry: Record "Prognosis/Allocation Entry";
        gHelperDate: Date;
        gFromInvoiceDate: Date;
        gUptoInvoiceDate: Date;
        gExcelRow: Integer;
        gPrintToExcel: Boolean;
        gLineWithoutValues: Decimal;
        gFromDate: Date;
        gUptoDate: Date;
        gSkipLineWithoutValues: Boolean;
        gOriginalPrognosis: Boolean;
        gOriginalPrognosisText: Text[50];
        grecPrognosisAllocationEntry1: Record "Prognosis/Allocation Entry";
        grecLanguage: Record Language;
        gPromostatus: Text[30];
        gBlockingCode: Text[30];
        gPerUnit: Boolean;
        grecBejoSetup: Record "Bejo Setup";
        gcuBejoMgt: Codeunit "Bejo Management";
        gAllocation: Decimal;
        gcuBlockingMgt: Codeunit "Blocking Management";
        gShowSplitBySalesperson: Boolean;
        gSalespersonSales: array[26] of Decimal;
        gSalespersonPrognosis: array[26] of Decimal;
        gPrognosisTotal2to19: Decimal;
        gPrognosisTotalTotal: Decimal;
        text50001: Label 'Sales';
        text50002: Label 'Item No.';
        text50003: Label 'Description';
        text50005: Label 'Country';
        text50006: Label 'Unit of Measure';
        text50007: Label 'per';
        text50008: Label 'Allocation';
        text50009: Label 'Total';
        text50010: Label 'Sales';
        text50011: Label 'million';
        text50012: Label 'Promostatus';
        text50013: Label 'Blocking Code';
        text50014: Label 'KG';
        text50015: Label 'NB: This is the original prognosis!';

    local procedure CalculatePrognosisTotals()
    var
        i: Integer;
    begin


        gPrognosisTotal2to19 := 0;


        for i := 2 to ArrayLen(gPrognosis) do begin
            if i <= 19 then begin
                gPrognosisTotal2to19 := gPrognosisTotal2to19 + gPrognosis[i];

                gPrognosisTotalTotal := gPrognosisTotalTotal + gPrognosis[i];
            end;
        end;

    end;
}

