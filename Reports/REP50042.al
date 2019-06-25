report 50042 "Import Allocation"
{

    DefaultLayout = RDLC;
    RDLCLayout = './RDLC/Import Allocation.rdlc';

    Caption = 'Import Allocation';

    dataset
    {
        dataitem("Prognosis/Allocation Entry"; "Prognosis/Allocation Entry")
        {
            DataItemTableView = SORTING ("Item No.", "Entry No.") ORDER(Ascending);
            column(USERID; UserId)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(PageCaption; PageCaptionLbl)
            {
            }
            column(New_and_changed_allocationsCaption; New_and_changed_allocationsCaptionLbl)
            {
            }
            column(gFilter; gFilter)
            {
            }
            column(Prognosis_Allocation_Entry__Item_No__; "Item No.")
            {
            }
            column(Prognosis_Allocation_Entry__Sales_Date_; "Sales Date")
            {
            }
            column(grecItem_Description; grecItem.Description)
            {
            }
            column(Prognosis_Allocation_Entry_Allocated; Allocated)
            {
            }
            column(gAllocationOld; gAllocationOld)
            {
            }
            column(gAllocationUpdated; gAllocationUpdated)
            {
            }
            column(Prognosis_Allocation_Entry__Prognosis_Last_Date_Modified_; "Date Modified")
            {
            }
            column(grecItem__Description_2_; grecItem."Description 2")
            {
            }
            column(grecItemExtension__Extension_Code_; grecItemExtension."Extension Code")
            {
            }
            column(Previous_allocationCaption; Previous_allocationCaptionLbl)
            {
            }
            column(Allocation_changeCaption; Allocation_changeCaptionLbl)
            {
            }
            column(grecItem_DescriptionCaption; grecItem_DescriptionCaptionLbl)
            {
            }
            column(Prognosis_Allocation_Entry__Sales_Date_Caption; FieldCaption("Sales Date"))
            {
            }
            column(Prognosis_Allocation_Entry__Item_No__Caption; FieldCaption("Item No."))
            {
            }
            column(Updated_allocationCaption; Updated_allocationCaptionLbl)
            {
            }
            column(Prognosis_Allocation_Entry__Prognosis_Last_Date_Modified_Caption; FieldCaption("Date Modified"))
            {
            }
            column(grecItem__Description_2_Caption; grecItem__Description_2_CaptionLbl)
            {
            }
            column(grecItemExtension__Extension_Code_Caption; grecItemExtension__Extension_Code_CaptionLbl)
            {
            }
            column(Prognosis_Allocation_Entry_Internal_Entry_No_; "Internal Entry No.")
            {
            }

            trigger OnAfterGetRecord()
            var
                lItemNo: Code[10];
                lrecPrognosisAllocationEntry: Record "Prognosis/Allocation Entry";
                lDoSkip: Boolean;
            begin
                // Initialise Variables
                gAllocationOld := 0;
                gAllocationChange := 0;
                gAllocationUpdated := 0;

                if ("Prognosis/Allocation Entry"."Sales Date" >= gStartingDate)
                    and ("Prognosis/Allocation Entry"."Sales Date" <= gEndingDate) then begin
                    // Find previous last allocation entry for current season to determine the changed allocation
                    lrecPrognosisAllocationEntry.SetCurrentKey("Item No.", "Entry No.");
                    lrecPrognosisAllocationEntry.SetRange("Item No.", "Prognosis/Allocation Entry"."Item No.");
                    lrecPrognosisAllocationEntry.SetRange("Sales Date", gStartingDate, gEndingDate);

                    lrecPrognosisAllocationEntry.SetFilter("Internal Entry No.", '<%1', "Prognosis/Allocation Entry"."Internal Entry No.");

                    if lrecPrognosisAllocationEntry.FindLast then begin
                        lrecPrognosisAllocationEntry.SetFilter("Date filter", '%1..%2', gStartingDate, gEndingDate);

                        lrecPrognosisAllocationEntry.SetFilter("Internal Entry No. filter", '<%1', "Prognosis/Allocation Entry"."Internal Entry No.");
                        lrecPrognosisAllocationEntry.CalcFields(Allocation);
                        gAllocationOld := lrecPrognosisAllocationEntry.Allocation;

                        lrecPrognosisAllocationEntry.SetFilter("Internal Entry No. filter", '<=%1', "Prognosis/Allocation Entry"."Internal Entry No.");
                        lrecPrognosisAllocationEntry.CalcFields(Allocation);
                        gAllocationUpdated := lrecPrognosisAllocationEntry.Allocation;

                        gAllocationChange := "Prognosis/Allocation Entry".Allocated;

                        // If no allocation change, do not show the item on the report
                        if gAllocationChange = 0 then begin
                            lDoSkip := true;
                        end;
                    end
                    else begin
                        // there is only the new allocation entry for current season
                        gAllocationOld := 0;
                        gAllocationChange := "Prognosis/Allocation Entry".Allocated;
                        gAllocationUpdated := "Prognosis/Allocation Entry".Allocated;
                    end;
                end;

                if "Prognosis/Allocation Entry"."Sales Date" > gEndingDate then begin
                    // Find previous last allocation entry for coming season to determine the changed allocation
                    lrecPrognosisAllocationEntry.SetCurrentKey("Item No.", "Entry No.");
                    lrecPrognosisAllocationEntry.SetRange("Item No.", "Prognosis/Allocation Entry"."Item No.");
                    lrecPrognosisAllocationEntry.SetFilter("Sales Date", '>%1', gEndingDate);
                    lrecPrognosisAllocationEntry.SetFilter("Internal Entry No.", '<%1', "Prognosis/Allocation Entry"."Internal Entry No.");

                    if lrecPrognosisAllocationEntry.FindLast then begin
                        lrecPrognosisAllocationEntry.SetFilter("Date filter", '>%1', gEndingDate);
                        lrecPrognosisAllocationEntry.SetFilter("Internal Entry No. filter", '<%1', "Prognosis/Allocation Entry"."Internal Entry No.");
                        lrecPrognosisAllocationEntry.CalcFields(Allocation);
                        gAllocationOld := lrecPrognosisAllocationEntry.Allocation;

                        lrecPrognosisAllocationEntry.SetFilter("Internal Entry No. filter", '<=%1', "Prognosis/Allocation Entry"."Internal Entry No.");
                        lrecPrognosisAllocationEntry.CalcFields(Allocation);
                        gAllocationUpdated := lrecPrognosisAllocationEntry.Allocation;

                        gAllocationChange := "Prognosis/Allocation Entry".Allocated;

                        // If no allocation change, do not show the item on the report
                        if gAllocationChange = 0 then begin
                            lDoSkip := true;
                        end;
                    end
                    else begin
                        // there is only the new allocation entry for coming season
                        gAllocationOld := 0;
                        gAllocationChange := "Prognosis/Allocation Entry".Allocated;
                        gAllocationUpdated := "Prognosis/Allocation Entry".Allocated;
                    end;
                end;

                if lDoSkip then
                    CurrReport.Skip;

                if not grecItem.Get("Item No.") then begin
                    grecItem.Init;
                    grecItem.Description := Text50005;
                end;

                if not grecItemExtension.Get(grecItem."B Extension", '') then
                    grecItemExtension.Init;

                if grecItem."B Organic" = true then
                    grecItemExtension."Extension Code" := '';


            end;

            trigger OnPreDataItem()
            var
                //lcuWebservice: Codeunit Webservices;
                lFilterString: Text[250];
                lrecItem: Record Item;
                lstrCounter: Text[2];
                lUpdateCounter: Integer;
                Crops: Record Crops;
            begin
                gdlgWindow.Open('@1@@@@@@@@@@@@@@@@@@@@');
                gCropsCount := Crops.Count;

                if Crops.FindSet then repeat
                                          //Clear(lcuWebservice);
                                          Clear(lFilterString);
                                          Clear(lrecItem);
                                          Clear(lstrCounter);
                                          Clear(lUpdateCounter);
                                          lrecItem.SetCurrentKey("No.");
                                          lrecItem.SetRange("B Crop", Crops."Crop Code");
                                          if Crops."Crop Code" <> '' then begin
                                              lFilterString := Crops."Crop Code" + '*';
                                              //lcuWebservice.GetAllocations(gCountryCode,gStartingDate,lFilterString);
                                          end;
                                          lstrCounter := IncStr(lstrCounter);
                                          gRecordCounter += 1;
                                          lUpdateCounter := Round((gRecordCounter / gCropsCount) * 10000, 1);
                                          gdlgWindow.Update(1, lUpdateCounter);
                    until Crops.Next = 0;
                gdlgWindow.Close;

                "Prognosis/Allocation Entry".SetRange("Export/Import Date", Today);
                "Prognosis/Allocation Entry".SetRange("Is Import from Bejo", true);
                gFilter := "Prognosis/Allocation Entry".GetFilters;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Control4)
                {
                    ShowCaption = false;
                    field(gCountryCode; gCountryCode)
                    {
                        Caption = 'Country Code';
                        Editable = false;
                        ApplicationArea = All;
                    }
                    field(gStartingDate; gStartingDate)
                    {
                        Caption = 'Begin Date';
                        Editable = false;
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
            if grecBejoSetup.Get then begin
                gStartingDate := grecBejoSetup."Begin Date";
                gEndingDate := grecBejoSetup."End Date";
                gCountryCode := grecBejoSetup."Country Code";
            end;
        end;
    }

    labels
    {
    }

    trigger OnPostReport()
    begin

        UpdateAllocationExceeded;


        Commit;
    end;

    var
        gStartingDate: Date;
        gEndingDate: Date;
        gCountryCode: Code[10];
        grecBejoSetup: Record "Bejo Setup";
        gdlgWindow: Dialog;
        gRecordCounter: Integer;
        gCropsCount: Integer;
        gAllocationOld: Decimal;
        gAllocationUpdated: Decimal;
        gAllocationChange: Decimal;
        gcuBejoMgt: Codeunit "Bejo Management";
        gFilter: Text[250];
        grecItem: Record Item;
        grecItemExtension: Record "Item Extension";
        Text50000: Label 'Import Allocation';
        Text50005: Label 'Item No. does not exist.';
        gExportToExcel: Boolean;
        gFilename: Text[250];
        gExcelRow: Integer;
        gHeaderWritten: Boolean;
        Text50050: Label 'Filename';
        Text50300: Label 'Incorrect Filename supplied for the export to excel';
        Text10000: Label 'New and changed allocations';
        Text19963: Label 'Recalculate ''Allocation Exceeded''';
        Text20003: Label 'Description';
        Text20004: Label 'Description 2';
        Text20005: Label 'Description 3';
        Text20007: Label 'Previous allocation';
        Text20008: Label 'Allocation change';
        Text20009: Label 'Updated allocation';
        gNumberFormat: Text[30];
        PageCaptionLbl: Label 'Page';
        New_and_changed_allocationsCaptionLbl: Label 'New and changed allocations';
        Previous_allocationCaptionLbl: Label 'Previous allocation';
        Allocation_changeCaptionLbl: Label 'Allocation change';
        grecItem_DescriptionCaptionLbl: Label 'Description';
        Updated_allocationCaptionLbl: Label 'Updated allocation';
        grecItem__Description_2_CaptionLbl: Label 'Description 2';
        grecItemExtension__Extension_Code_CaptionLbl: Label 'Description 3';

    procedure UpdateAllocationExceeded()
    var
        lrecPurchLine: Record "Purchase Line";
        lrecPurchLine2: Record "Purchase Line";
        lcuBejoMgt: Codeunit "Bejo Management";
    begin

        if GuiAllowed then
            gdlgWindow.Open(Text19963);

        lcuBejoMgt.SkipAllocationCheckMessages;
        lrecPurchLine.Reset;
        lrecPurchLine.SetRange(Type, lrecPurchLine.Type::Item);
        if lrecPurchLine.FindSet then repeat
                                          lrecPurchLine2.Get(lrecPurchLine."Document Type", lrecPurchLine."Document No.", lrecPurchLine."Line No.");
                                          lcuBejoMgt.PurchCheckAllocation(lrecPurchLine2);
                                          if lrecPurchLine."B Allocation exceeded" <> lrecPurchLine2."B Allocation exceeded" then
                                              lrecPurchLine2.Modify(true);
            until lrecPurchLine.Next = 0;

        if GuiAllowed then
            gdlgWindow.Close;

    end;
}

