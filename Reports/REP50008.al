report 50008 "Import Varieties"
{

    ProcessingOnly = true;

    dataset
    {
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

    labels
    {
    }

    trigger OnPostReport()
    begin
        gdlgWindow.Close;
    end;

    trigger OnPreReport()
    var
        //lcuWebservice: Codeunit Webservices;
        lCropCount: Integer;
        lCount: Integer;
        lUpdateCounter: Integer;
        lCrops: Record Crops;
        lFromCropCode: Text[10];
        lToCropCode: Text[10];
        lCropCodeFilter: Text[10];
    begin

        lFromCropCode := '00';

        lCount := 1;
        lCrops.SetRange(lCrops."Crop Code", '00', '99');
        gdlgWindow.Open('@1@@@@@@@@@@@@@@@@@@@@');
        lUpdateCounter := 100;
        gdlgWindow.Update(1, lUpdateCounter);

        lCropCount := lCrops.Count;

        if lCrops.FindFirst then begin
            lFromCropCode := lCrops."Crop Code";
            lCrops.Next(Round((lCropCount / 10), 1));
            repeat
                lToCropCode := lCrops."Crop Code";
                lCropCodeFilter := lFromCropCode + '..' + lToCropCode;

                //lcuWebservice.GetVarieties(lCropCodeFilter);
                lUpdateCounter := Round((lCount / 12) * 10000, 1);
                gdlgWindow.Update(1, lUpdateCounter);

                lFromCropCode := lToCropCode;
                lCount += 1;
            until lCrops.Next(Round((lCropCount / 10), 1)) = 0;
        end;

        //lcuWebservice.GetVarietyCountry('');
        lUpdateCounter := Round((lCount / 12) * 10000, 1);
        gdlgWindow.Update(1, lUpdateCounter);
    end;

    var
        gdlgWindow: Dialog;
}

