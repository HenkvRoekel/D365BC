report 50006 "Import Block Promo"
{

    DefaultLayout = RDLC;
    RDLCLayout = './RDLC/Import Block Promo.rdlc';


    dataset
    {
        dataitem("Block Entry"; "Block Entry")
        {
            DataItemTableView = SORTING ("Variety Code") ORDER(Ascending);
            column(CompanyName; CompanyName)
            {
            }
            column(Text50009; Text50009)
            {
            }
            column(UserId; UserId)
            {
            }
            column(gOldNew; gOldNew)
            {
            }
            column(gPromostatusChanged; gPromostatusChanged)
            {
            }
            column(gBlockEntryChanged; gBlockEntryChanged)
            {
            }
            column(VarieryCode_BlockEntry; "Block Entry"."Variety Code")
            {
            }
            column(No_grecItem; grecItem."No.")
            {
            }
            column(Description_grecItem; grecItem.Description)
            {
            }
            column(Description2_grecItem; grecItem."Description 2")
            {
            }
            column(grecItemExtension_ExtensionCode; grecItemExtension."Extension Code")
            {
            }
            column(grecBlockEntryTemp_BlockCode; grecBlockEntryTemp."Block Code")
            {
            }
            column(grecBlockEntryTemp_BlockDescription; grecBlockEntryTemp."Block Description")
            {
            }
            column(grecVarietyTemp_PromoStatus; grecVarietyTemp."Promo Status")
            {
            }
            column(grecVarietyTemp_PromoStatusDescription; grecVarietyTemp."Promo Status Description")
            {
            }
            column(BlockEntry_Priority; "Block Entry".Priority)
            {
            }
            column(BlockEntry_ContinentCode; "Block Entry"."Continent Code")
            {
            }
            column(BlockEntry_CountryCode; "Block Entry"."Country Code")
            {
            }
            column(BlockEntry_CropCode; "Block Entry"."Crop Code")
            {
            }
            column(BlockEntry_UoM; "Block Entry"."Unit of Measure Code")
            {
            }
            column(BlockEntry_TreatmentCode; "Block Entry"."Treatment Code")
            {
            }
            column(BlockEntry_BlockCode; "Block Entry"."Block Code")
            {
            }
            column(BlockEntry_BlockDescription; "Block Entry"."Block Description")
            {
            }
            column(BlockEntry_PromoStatus; "Block Entry"."Promo Status")
            {
            }
            column(BlockEntry_PromoStatusDescription; "Block Entry"."Promo Status Description")
            {
            }

            trigger OnAfterGetRecord()
            begin

                gPromostatusChanged := false;
                gBlockEntryChanged := false;

                gNewBlockEntry := false;


                // Test for changed Block Entry
                if grecBlockEntryTemp.Get("Block Entry"."Entry No.") then begin
                    // Get old description value with calcfield
                    grecBlockEntryTemp.CalcFields("Block Description");

                    // compare imported to existing
                    if "Block Entry"."Block Code" <> grecBlockEntryTemp."Block Code" then begin
                        gBlockEntryChanged := true;
                    end;
                end else begin

                    Clear(grecBlockEntryTemp);
                    gNewBlockEntry := true;

                    gBlockEntryChanged := true;

                end;


                if not grecItem.Get("Item No.") then
                    Clear(grecItem);


                if not grecItemExtension.Get(grecItem."B Extension", '') then

                    Clear(grecItemExtension);


                // Test for changed Promo Status
                "Block Entry".CalcFields("Promo Status", "Promo Status Description");
                if grecVarietyTemp.Get("Block Entry"."Variety Code") then begin
                    // Get old description value with calcfield
                    grecVarietyTemp.CalcFields("Promo Status Description");

                    if grecVarietyTemp."Promo Status" <> "Block Entry"."Promo Status" then begin
                        gPromostatusChanged := true;
                    end;
                end

                else
                    Clear(grecVarietyTemp);

                if grecItem.Description = '' then
                    grecItem.Description := CopyStr(grecVarietyTemp.Description, 1, 35);



                if gNewBlockEntry then
                    gOldNew := Text50005
                else
                    gOldNew := Text50004;



                if not (gShowAllRecs) then
                    if "Block Entry"."Country Code" = '' then
                        CurrReport.Skip;
            end;

            trigger OnPostDataItem()
            begin

                gdlgWindow.Update(1, 7000);
            end;
        }
        dataitem("Integer"; "Integer")
        {
            DataItemTableView = SORTING (Number) ORDER(Ascending);
            column(Text50008; Text50008)
            {
            }
            column(grecBlockEntryTemp_VarietyCode; grecBlockEntryTemp."Variety Code")
            {
            }
            column(No_grecItem2; grecItem."No.")
            {
            }
            column(Description2_grecItem2; grecItem."Description 2")
            {
            }
            column(Description_grecItem2; grecItem.Description)
            {
            }
            column(grecItemExtension_ExtensionCode2; grecItemExtension."Extension Code")
            {
            }
            column(grecBlockEntryTemp_BlockCode2; grecBlockEntryTemp."Block Code")
            {
            }
            column(grecBlockEntryTemp_BlockDescription2; grecBlockEntryTemp."Block Description")
            {
            }
            column(grecVarietyTemp_PromoStatus2; grecVarietyTemp."Promo Status")
            {
            }
            column(grecVarietyTemp_PromoStatusDescription2; grecVarietyTemp."Promo Status Description")
            {
            }
            column(grecBlockEntryTemp_Priority2; grecBlockEntryTemp.Priority)
            {
            }
            column(grecBlockEntryTemp_ContinentCode; grecBlockEntryTemp."Continent Code")
            {
            }
            column(grecBlockEntryTemp_CountryCode; grecBlockEntryTemp."Country Code")
            {
            }
            column(grecBlockEntryTemp_CropCode; grecBlockEntryTemp."Crop Code")
            {
            }
            column(grecBlockEntryTemp_UoM; grecBlockEntryTemp."Unit of Measure Code")
            {
            }
            column(grecBlockEntryTemp_TreatmentCode; grecBlockEntryTemp."Treatment Code")
            {
            }
            column(gShowDeleted; gShowDeleted)
            {
            }

            trigger OnAfterGetRecord()
            begin

                if Number = 1 then
                    grecBlockEntryTemp.FindFirst
                else
                    grecBlockEntryTemp.Next;
                if "Block Entry".Get(grecBlockEntryTemp."Entry No.") then
                    CurrReport.Skip;

                grecBlockEntryTemp.CalcFields("Block Description");


                if not grecItem.Get(grecBlockEntryTemp."Item No.") then
                    Clear(grecItem);

                if not grecItemExtension.Get(grecItem."B Extension", '') then
                    Clear(grecItemExtension);

                // Test for changed Promo Status
                grecBlockEntryTemp.CalcFields("Promo Status", "Promo Status Description");
                if grecVarietyTemp.Get(grecBlockEntryTemp."Variety Code") then
                    // Get old description value with calcfield
                    grecVarietyTemp.CalcFields("Promo Status Description")
                else
                    Clear(grecVarietyTemp);

                if grecItem.Description = '' then
                    grecItem.Description := CopyStr(grecVarietyTemp.Description, 1, 35);

                // Do not show / print records without Country Code
                if not (gShowAllRecs) then
                    if grecBlockEntryTemp."Country Code" = '' then
                        CurrReport.Skip;




                gShowDeleted := true;
            end;

            trigger OnPreDataItem()
            begin

                SetRange(Number, 1, grecBlockEntryTemp.Count);
                grecBlockEntryTemp.Reset;

                grecBlockEntry.SetCurrentKey("Variety Code");

            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Control2)
                {
                    ShowCaption = false;
                    field(gCreatePSSnapshot; gCreatePSSnapshot)
                    {
                        Caption = 'Create Promo Status Snapshot';
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin

                            if gCreatePSSnapshot then
                                if not (Confirm(Text50006)) then
                                    gCreatePSSnapshot := false;

                        end;
                    }
                    field(gShowAllRecs; gShowAllRecs)
                    {
                        Caption = 'Show Non-Country Specific Records';
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin



                            if gCreatePSSnapshot then
                                if not (Confirm(Text50006)) then
                                    gCreatePSSnapshot := false;

                        end;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin


            gCreatePSSnapshot := false;

        end;
    }

    labels
    {
        lblReportName = 'Changed Blocking Entries and Variety Promostatus';
        lblVarietyCode = 'Variety Code';
        lblItemNo = 'Item No. / Pri-Con-Cty';
        lblDescription = 'Description / Crop-UOM-Treatment';
        lblBlockCode = 'Block Code';
        lblBlockDescription = 'Block Description';
        lblPromoStatus = 'Promo Status';
        lblPromoDescription = 'Promo Status Description';
    }

    trigger OnInitReport()
    begin
        if not (grecWebservice.Get('BLOCKPROMO')) then begin
            Message(Text50002);
            CurrReport.Quit;
        end;

        if grecBejoSetup.Get then;

        if not (grecBejoSetup."Country Code" <> '') then begin
            Message(Text50003);
            CurrReport.Quit;
        end;
    end;

    trigger OnPostReport()
    begin

        gdlgWindow.Update(1, 10000);
        Sleep(1000);
        gdlgWindow.Close;
    end;

    trigger OnPreReport()
    begin

        if gCreatePSSnapshot then
            if grecVariety.FindSet then begin
                gdlgWindow.Open(Text50007);
                grecBlockChangeLog.SetRange("Log Date", Today);
                grecBlockChangeLog.SetRange("Action Type", 0);
                grecBlockChangeLog.DeleteAll;
                grecBlockChangeLog.Reset;
                repeat
                    Clear(grecBlockChangeLog);  // Need this to have AutoIncrement work
                    grecBlockChangeLog.AddVarietyRecord(grecVariety, grecVarietyTemp, 0);
                until grecVariety.Next = 0;
                gdlgWindow.Close;
            end;



        grecBlockEntry.SetRange("Entry No.");

        gdlgWindow.Open('@1@@@@@@@@@@@@@@@@@@@@');
        gdlgWindow.Update(1, 0);

        if grecBlockEntry.FindSet(true, true) then begin
            repeat
                // Copy old records to Temp table
                grecBlockEntryTemp.Copy(grecBlockEntry);
                grecBlockEntryTemp.Insert;

            until grecBlockEntry.Next = 0;

            // Delete records from table to upload the new
            grecBlockEntry.DeleteAll(false);
        end;

        grecVariety.SetRange("No.");
        if grecVariety.FindSet(true, true) then begin
            repeat
                // Copy old records to Temp table
                grecVarietyTemp.Copy(grecVariety);
                grecVarietyTemp.Insert;

            until grecVariety.Next = 0;
        end;

        gdlgWindow.Update(1, 500);


        //gcuWebservice.GetBlockPromostatus(grecBejoSetup."Country Code", 1);
        gdlgWindow.Update(1, 1000);

        //gcuWebservice.GetBlockPromostatus(grecBejoSetup."Country Code", 2);
        gdlgWindow.Update(1, 3000);

        //gcuWebservice.GetBlockPromostatus(grecBejoSetup."Country Code", 3);
        gdlgWindow.Update(1, 6000);


    end;

    var
        grecWebservice: Record Webservice;
        grecBlockEntry: Record "Block Entry";
        //gcuWebservice: Codeunit Webservices;
        grecBejoSetup: Record "Bejo Setup";
        grecBlockEntryTemp: Record "Block Entry" temporary;
        grecVariety: Record Varieties;
        grecVarietyTemp: Record Varieties temporary;
        gBlockEntryChanged: Boolean;
        gPromostatusChanged: Boolean;
        gcuBejoMgt: Codeunit "Bejo Management";
        gdlgWindow: Dialog;
        grecItem: Record Item;
        grecItemExtension: Record "Item Extension";
        gNewBlockEntry: Boolean;
        gOldNew: Text[10];
        gCreatePSSnapshot: Boolean;
        grecBlockChangeLog: Record "Block Change Log";
        gShowAllRecs: Boolean;
        Text50002: Label 'The Webservice record does not exist.';
        Text50003: Label 'The Bejo Setup ''Country Code'' does not exist.';
        Text50004: Label 'Old';
        Text50005: Label 'New';
        Text50006: Label 'This will replace any existing snapshot for today''s date.\Click ''Yes'' to confirm.';
        Text50007: Label 'Creating Promo Status snapshot.....';
        Text50008: Label 'Del';
        Text50009: Label 'All second line fields may not be present for all records.';
        gShowDeleted: Boolean;
}

