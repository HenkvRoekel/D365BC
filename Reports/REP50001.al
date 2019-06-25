report 50001 "Import Sales Price"
{

    ProcessingOnly = true;

    dataset
    {
        dataitem(Crops; Crops)
        {
            DataItemTableView = SORTING ("Crop Code") ORDER(Ascending) WHERE ("Crop Code" = FILTER ('00' .. '99'));

            trigger OnAfterGetRecord()
            var
                //lcuWebservice: Codeunit Webservices;
                lFilterString: Text[250];
                lrecItem: Record Item;
                lstrCounter: Text[2];
                lUpdateCounter: Integer;
            begin
                lrecItem.SetCurrentKey("No.");
                lrecItem.SetRange("B Crop", "Crop Code");

                lstrCounter := '00';

                while lstrCounter <> '99' do begin
                    lrecItem.SetFilter("No.", '%1', "Crop Code" + lstrCounter + '*');

                    if lrecItem.FindFirst then
                        lFilterString := lrecItem."No.";

                    if lrecItem.FindLast then
                        lFilterString := lFilterString + '..' + lrecItem."No.";


                    //if not (lFilterString = '') then
                    //    lcuWebservice.GetSalesPrice(lFilterString, gStartingDate, gEndingDate, gSalesCode, '');

                    lstrCounter := IncStr(lstrCounter);
                    lFilterString := '';
                end;

                gRecordCounter += 1;
                lUpdateCounter := Round((gRecordCounter / gCropsCount) * 10000, 1);
                gdlgWindow.Update(1, lUpdateCounter);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Control1)
                {
                    ShowCaption = false;
                    field(gStartingDate; gStartingDate)
                    {
                        Caption = 'Starting Date';
                        Editable = false;
                        ApplicationArea = All;
                    }
                    field(gEndingDate; gEndingDate)
                    {
                        Caption = 'Ending Date';
                        Editable = false;
                        ApplicationArea = All;
                    }
                    field(gSalesCode; gSalesCode)
                    {
                        Caption = 'Sales Code';
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
            end;
            if grecWebservice.Get('SALESPRICE') then begin
                gSalesCode := grecWebservice.FilterDefault4;
            end;
        end;
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        gdlgWindow.Close;
    end;

    trigger OnPreReport()
    var
        lrecCustPriceGroup: Record "Customer Price Group";
    begin
        if not (lrecCustPriceGroup.Get('BASE')) then begin
            Message(Text50002 + '\\' + Text50001);
            CurrReport.Quit;
            exit;
        end;

        if Confirm(Text50000) then begin
            grecSalesPrice.SetRange("Starting Date", gStartingDate);
            grecSalesPrice.SetRange("Ending Date", gEndingDate);
            grecSalesPrice.SetRange("Sales Code", 'Base');

            if grecSalesPrice.FindSet(true, true) then
                grecSalesPrice.DeleteAll(false);
        end
        else begin
            Message(Text50001);
            CurrReport.Quit;
        end;

        gdlgWindow.Open('@1@@@@@@@@@@@@@@@@@@@@');
        gCropsCount := Crops.Count
    end;

    var
        gStartingDate: Date;
        gEndingDate: Date;
        gSalesCode: Code[10];
        grecBejoSetup: Record "Bejo Setup";
        grecWebservice: Record Webservice;
        grecSalesPrice: Record "Sales Price";
        gRecordCounter: Integer;
        gCropsCount: Integer;
        gdlgWindow: Dialog;
        Text50000: Label 'All existing BASE ''Sales Price'' records within the filter will be deleted first.\Continue?';
        Text50001: Label 'No data has been changed.\The operation has finished.';
        Text50002: Label 'No "Customer Price Group" with code BASE found.';
}

