page 50071 "Mkt.Pot. Crop/Crop Type Lookup"
{

    Caption = 'Mkt.Pot. Crop/Crop Type Lookup';
    PageType = List;
    SourceTable = Varieties;
    SourceTableTemporary = true;
    SourceTableView = SORTING ("Crop Variant Code", "Crop Type Code")
                      ORDER(Ascending);

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                Editable = false;
                ShowCaption = false;
                field("Crop Variant Code"; "Crop Variant Code")
                {
                    Caption = 'Code';
                    ApplicationArea = All;
                }
                field("Crop Variant Description"; "Crop Variant Description")
                {
                    Caption = 'Description';
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
        CurrPage.LookupMode := true;
    end;

    var
        grecVariety: Record Varieties;

    procedure GetCrops()
    begin
        Reset;
        DeleteAll;
        Init;

        grecVariety.Reset;
        grecVariety.SetCurrentKey("Crop Variant Code");
        grecVariety.SetFilter("Crop Variant Code", '<>%1', '');
        if grecVariety.FindSet then repeat
                                        if "Crop Variant Code" <> grecVariety."Crop Variant Code" then begin
                                            Init;
                                            "No." := grecVariety."No.";
                                            "Crop Variant Code" := grecVariety."Crop Variant Code";
                                            "Crop Variant Description" := grecVariety."Crop Variant Description";
                                            Insert;
                                        end;
            until grecVariety.Next = 0;
    end;

    procedure GetCropTypesForCrop(CropCode: Code[20])
    begin
        Reset;
        DeleteAll;
        Init;

        grecVariety.Reset;
        if CropCode <> '' then begin
            grecVariety.SetCurrentKey("Crop Variant Code", "Crop Type Code");
            grecVariety.SetRange("Crop Variant Code", CropCode);
        end else begin
            grecVariety.SetCurrentKey("Crop Type Code");
        end;
        grecVariety.SetFilter("Crop Type Code", '<>%1', '');
        if grecVariety.FindSet then repeat
                                        if "Crop Variant Code" <> grecVariety."Crop Type Code" then begin
                                            Init;
                                            "No." := grecVariety."No.";
                                            "Crop Variant Code" := grecVariety."Crop Type Code";
                                            "Crop Variant Description" := grecVariety."Crop Type Description";
                                            Insert;
                                        end;
            until grecVariety.Next = 0;
    end;

    procedure FindText(Text: Text[1024])
    begin
        if Count > 0 then begin
            "Crop Variant Code" := CopyStr(Text, 1, MaxStrLen("Crop Variant Code"));
            if not Find('=<>') then
                Find('-');
        end;
    end;
}

