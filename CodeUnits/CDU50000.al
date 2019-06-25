codeunit 50000 "Blocking Management"
{

    trigger OnRun()
    begin
    end;

    procedure ItemBlockCode(var TheItem: Record Item): Code[10]
    var
        aBlockEntry: Record "Block Entry";
    begin
        InitializeBlockEntry(aBlockEntry);

        SetContinentCountryCodeFilter(aBlockEntry);
        SetItemNoFilter(aBlockEntry, TheItem."No.");

        if aBlockEntry.FindFirst then
            exit(aBlockEntry."Block Code");
    end;

    procedure ItemBlockDescription(var TheItem: Record Item): Text[50]
    var
        aBlockCode: Record "Block Code";
        aBlockEntry: Record "Block Entry";
    begin
        InitializeBlockEntry(aBlockEntry);

        SetContinentCountryCodeFilter(aBlockEntry);
        SetItemNoFilter(aBlockEntry, TheItem."No.");

        if aBlockEntry.FindFirst then
            if aBlockCode.Get(aBlockEntry."Block Code") then
                exit(aBlockCode.Code + ': ' + aBlockCode.Description);

        exit(NotPresentText);
    end;


    procedure ItemUnitBlockCode(var TheItemUnit: Record "Item/Unit"): Code[10]
    var
        aBlockEntry: Record "Block Entry";
    begin
        InitializeBlockEntry(aBlockEntry);

        SetContinentCountryCodeFilter(aBlockEntry);
        SetVarietyCodeFilter(aBlockEntry, TheItemUnit.Variety);
        SetItemNoFilter(aBlockEntry, TheItemUnit."Item No.");
        SetUOMCodeFilter(aBlockEntry, TheItemUnit."Unit of Measure", TheItemUnit."Item No.");

        if aBlockEntry.FindFirst then
            exit(aBlockEntry."Block Code");
    end;

    procedure ItemUnitBlockDescription(var TheItemUnit: Record "Item/Unit"): Text[50]
    var
        aBlockCode: Record "Block Code";
        aBlockEntry: Record "Block Entry";
    begin
        InitializeBlockEntry(aBlockEntry);

        SetContinentCountryCodeFilter(aBlockEntry);
        SetVarietyCodeFilter(aBlockEntry, TheItemUnit.Variety);
        SetItemNoFilter(aBlockEntry, TheItemUnit."Item No.");
        SetUOMCodeFilter(aBlockEntry, TheItemUnit."Unit of Measure", TheItemUnit."Item No.");

        if aBlockEntry.FindFirst then
            if aBlockCode.Get(aBlockEntry."Block Code") then
                exit(aBlockCode.Code + ': ' + aBlockCode.Description);

        exit(NotPresentText);
    end;

    procedure VarietyBlockCode(var TheVariety: Record Varieties): Code[10]
    var
        aBlockEntry: Record "Block Entry";
    begin
        InitializeBlockEntry(aBlockEntry);

        SetContinentCountryCodeFilter(aBlockEntry);
        SetVarietyCodeFilter(aBlockEntry, TheVariety."No.");

        if aBlockEntry.FindFirst then
            exit(aBlockEntry."Block Code");
    end;

    procedure VarietyBlockDescription(var TheVariety: Record Varieties): Text[50]
    var
        aBlockCode: Record "Block Code";
        aBlockEntry: Record "Block Entry";
    begin
        InitializeBlockEntry(aBlockEntry);

        SetContinentCountryCodeFilter(aBlockEntry);
        SetVarietyCodeFilter(aBlockEntry, TheVariety."No.");

        if aBlockEntry.FindFirst then
            if aBlockCode.Get(aBlockEntry."Block Code") then
                exit(aBlockCode.Code + ': ' + aBlockCode.Description);

        exit(NotPresentText);
    end;

    procedure NotPresentText(): Text[1024]
    var
        ctNotPresent: Label 'Not present';
    begin
        exit(ctNotPresent);
    end;

    procedure CheckPurchaseLine(var ThePurchaseLine: Record "Purchase Line"): Text[50]
    var
        aPurchaseHeader: Record "Purchase Header";
        aBejoSetup: Record "Bejo Setup";
        aBlockEntry: Record "Block Entry";
    begin
        with ThePurchaseLine do begin

            aBejoSetup.Get;

            if not aBejoSetup."Variety Blocking" then
                exit;

            if "Document Type" <> "Document Type"::Order then
                exit;

            if Type <> Type::Item then
                exit;

            if not IsBejoItem("No.") then
                exit;


            if aBejoSetup."Vendor No. BejoNL" <> ThePurchaseLine."Buy-from Vendor No." then
                exit;

            InitializeBlockEntry(aBlockEntry);
            SetContinentCountryCodeFilter(aBlockEntry);

            if not aPurchaseHeader.Get("Document Type", "Document No.") then
                exit;

            SetItemNoFilter(aBlockEntry, "No.");
            SetUOMCodeFilter(aBlockEntry, "Unit of Measure Code", "No.");

            CheckMainLevelPresent(aBlockEntry, TableCaption);

            aBlockEntry.SetFilter("Block Code", '0|1|2');
            if aBlockEntry.FindFirst then
                Error(MessageText(TableCaption, aBlockEntry));

            aBlockEntry.SetFilter("Block Code", '3|4');
            if aBlockEntry.FindFirst then
                Message(MessageText(TableCaption, aBlockEntry));

        end;
    end;

    procedure CheckItemUnit(var TheItemUnit: Record "Item/Unit"): Text[50]
    var
        aBejoSetup: Record "Bejo Setup";
        aBlockEntry: Record "Block Entry";
    begin
        with TheItemUnit do begin

            aBejoSetup.Get;

            if not aBejoSetup."Variety Blocking" then
                exit;

            if not IsBejoItem("Item No.") then
                exit;

            InitializeBlockEntry(aBlockEntry);
            SetContinentCountryCodeFilter(aBlockEntry);

            SetVarietyCodeFilter(aBlockEntry, Variety);
            SetItemNoFilter(aBlockEntry, "Item No.");
            SetUOMCodeFilter(aBlockEntry, "Unit of Measure", "Item No.");

            CheckMainLevelPresent(aBlockEntry, TableCaption);

            aBlockEntry.SetFilter("Block Code", '0|1');
            if aBlockEntry.FindFirst then
                Error(MessageText(TableCaption, aBlockEntry));

        end;
    end;

    local procedure SkipBecauseOfExtension(TheItemNo: Code[20]): Boolean
    var
        aItem: Record Item;
        aItemExtension: Record "Item Extension";
    begin
        if not aItem.Get(TheItemNo) then
            exit;

        exit(aItem."B Extension" in ['3', '7', '8']);
    end;

    local procedure CheckMainLevelPresent(var TheBlockEntry: Record "Block Entry"; TheTableCaption: Text[250])
    var
        aBlockEntry: Record "Block Entry";
        aBejoSetup: Record "Bejo Setup";
        ctMissingMainLevel: Label 'Block Entry on main level not found %1.\';
    begin
        aBejoSetup.Get;

        aBlockEntry.CopyFilters(TheBlockEntry);
        aBlockEntry.SetFilter("Block Code", '<>%1', '');
        aBlockEntry.SetRange("Continent Code", '');
        aBlockEntry.SetRange("Country Code", '');
        aBlockEntry.SetRange("Customer No.", '');
        aBlockEntry.SetRange("Ship-to Code", '');
        aBlockEntry.SetRange("Web Account", aBlockEntry."Web Account"::" ");

        case true of
            not (TheBlockEntry.GetFilter("Unit of Measure Code") in ['', '''''']):
                aBlockEntry.SetRange("Unit of Measure Code", GetValueOfFilter(TheBlockEntry.GetFilter("Unit of Measure Code")));

            not (TheBlockEntry.GetFilter("Variety Code") in ['', '''''']):
                begin
                    aBlockEntry.SetRange("Item No.");
                    aBlockEntry.SetRange("Crop Code");
                    aBlockEntry.SetRange("Variety Code", GetValueOfFilter(TheBlockEntry.GetFilter("Variety Code")));
                end;

            not (TheBlockEntry.GetFilter("Crop Code") in ['', '''''']):
                begin
                    aBlockEntry.SetRange("Item No.");
                    aBlockEntry.SetRange("Crop Code", GetValueOfFilter(TheBlockEntry.GetFilter("Crop Code")));
                end;

        end;

        if aBlockEntry.IsEmpty then begin

            TheBlockEntry."Crop Code" := GetValueOfFilter(TheBlockEntry.GetFilter("Crop Code"));
            TheBlockEntry."Variety Code" := GetValueOfFilter(TheBlockEntry.GetFilter("Variety Code"));
            TheBlockEntry."Item No." := GetValueOfFilter(TheBlockEntry.GetFilter("Item No."));
            TheBlockEntry."Unit of Measure Code" := GetValueOfFilter(TheBlockEntry.GetFilter("Unit of Measure Code"));
            TheBlockEntry."Treatment Code" := GetValueOfFilter(TheBlockEntry.GetFilter("Treatment Code"));

            Error(
              StrSubstNo(ctMissingMainLevel, aBejoSetup."Country Code", TheTableCaption) +
              LocationMessageText(TheBlockEntry) +
              ItemMessageText(TheBlockEntry));
        end;
    end;

    local procedure InitializeBlockEntry(var TheBlockEntry: Record "Block Entry")
    var
        aBejoSetup: Record "Bejo Setup";
    begin
        aBejoSetup.Get;

        with TheBlockEntry do begin
            SetCurrentKey("Block Code Priority", Priority);
            SetFilter("Block Code", '<>%1', '');
            SetFilter("Country Code", '''''|' + aBejoSetup."Country Code");
            SetRange("Customer No.", '');
            SetRange("Ship-to Code", '');
            SetRange("Web Account", "Web Account"::" ");

            SetRange("Crop Code", '');
            SetRange("Variety Code", '');
            SetRange("Item No.", '');
            SetRange("Treatment Code", '');
            SetRange("Unit of Measure Code", '');
        end;
    end;

    procedure SetItemNoFilter(var TheBlockEntry: Record "Block Entry"; TheItemNo: Code[20])
    var
        aItem: Record Item;
    begin
        if TheItemNo <> '' then begin
            TheBlockEntry.SetFilter("Item No.", '''''|' + TheItemNo);
            if aItem.Get(CopyStr(TheItemNo, 1, MaxStrLen(aItem."No."))) then
                SetVarietyCodeFilter(TheBlockEntry, aItem."B Variety");
        end;
    end;

    procedure SetVarietyCodeFilter(var TheBlockEntry: Record "Block Entry"; TheVarietyCode: Code[20])
    var
        aVariety: Record Varieties;
    begin
        if TheVarietyCode <> '' then begin
            TheBlockEntry.SetFilter("Variety Code", '''''|' + TheVarietyCode);
            if aVariety.Get(CopyStr(TheVarietyCode, 1, MaxStrLen(aVariety."No."))) then
                SetCropCodeFilter(TheBlockEntry, aVariety."Crop Code");
        end;
    end;

    procedure SetCropCodeFilter(var TheBlockEntry: Record "Block Entry"; TheCropCode: Code[20])
    begin
        if TheCropCode <> '' then
            TheBlockEntry.SetFilter("Crop Code", '''''|' + TheCropCode);
    end;

    procedure SetUOMCodeFilter(var TheBlockEntry: Record "Block Entry"; TheUOMCode: Code[20]; TheItemNo: Code[20])
    begin

        if SkipBecauseOfExtension(TheItemNo) then
            exit;
        if TheUOMCode <> '' then
            TheBlockEntry.SetFilter("Unit of Measure Code", '''''|' + TheUOMCode);
    end;

    procedure SetCustomerNoFilter(var TheBlockEntry: Record "Block Entry"; TheCustomerNo: Text[250])
    begin
        if TheCustomerNo <> '' then
            TheBlockEntry.SetFilter("Customer No.", '''''|' + TheCustomerNo);
    end;

    procedure SetContinentCountryCodeFilter(var TheBlockEntry: Record "Block Entry")
    var
        aBejoSetup: Record "Bejo Setup";
    begin
        aBejoSetup.Get;
        TheBlockEntry.SetFilter("Country Code", '''''|' + aBejoSetup."Country Code");
    end;

    local procedure MessageText(TheTableCaption: Text[1024]; var TheBlockEntry: Record "Block Entry"): Text[1024]
    var
        aBlockCode: Record "Block Code";
        ctTableBlocked: Label '%1 is blocked.\\Block Code = %2 (%3)';
    begin
        if aBlockCode.Get(TheBlockEntry."Block Code") then
            ;

        exit(
          StrSubstNo(ctTableBlocked, TheTableCaption, aBlockCode.Description, aBlockCode.Code) +
          LocationMessageText(TheBlockEntry) +
          ItemMessageText(TheBlockEntry));
    end;

    local procedure LocationMessageText(var TheBlockEntry: Record "Block Entry"): Text[1024]
    var
        aCountryRegion: Record "Country/Region";
        aCustomer: Record Customer;
        aShiptoAddress: Record "Ship-to Address";
        aLocationCategory: Text[250];
        aLocationCode: Text[250];
        aLocationDescription: Text[250];
        ctBlockLine: Label '\%1 = %2 (%3)';
    begin
        with TheBlockEntry do
            case true of

                "Ship-to Code" <> '':
                    begin
                        if aCustomer.Get("Customer No.") then
                            ;
                        if aShiptoAddress.Get("Customer No.", "Ship-to Code") then
                            ;
                        aLocationCategory := aShiptoAddress.TableCaption;
                        aLocationDescription := aCustomer.Name + '-' + aShiptoAddress.Code;
                        aLocationCode := "Customer No." + '-' + "Ship-to Code";
                    end;

                "Customer No." <> '':
                    begin
                        if aCustomer.Get("Customer No.") then
                            ;
                        aLocationCategory := aCustomer.TableCaption;
                        aLocationDescription := aCustomer.Name;
                        aLocationCode := "Customer No.";
                    end;

                "Web Account" <> "Web Account"::" ":
                    begin
                        aLocationCategory := FieldCaption("Web Account");
                        aLocationDescription := Format("Web Account");
                        aLocationCode := Format("Web Account");
                    end;

                "Country Code" <> '':
                    begin
                        if aCountryRegion.Get("Country Code") then
                            ;
                        aLocationCategory := aCountryRegion.TableCaption;
                        aLocationDescription := aCountryRegion.Name;
                        aLocationCode := "Country Code";
                    end;

                "Continent Code" <> '':
                    begin
                        aLocationCategory := 'Continent';
                        aLocationDescription := "Continent Code";
                        aLocationCode := "Continent Code";
                    end;

            end;

        if aLocationCategory <> '' then
            exit(StrSubstNo(ctBlockLine, aLocationCategory, aLocationDescription, aLocationCode));
    end;

    local procedure ItemMessageText(var TheBlockEntry: Record "Block Entry") ExitValue: Text[1024]
    var
        aItem: Record Item;
        aUnitOfMeasure: Record "Unit of Measure";
        aItemUnitOfMeasure: Record "Item Unit of Measure";
        aTreatmentCode: Record "Lot No. Information";
        aVariety: Record Varieties;
        aCrop: Record Crops;
        aItemCategory: Text[250];
        aItemCode: Text[250];
        aItemDescription: Text[250];
        ctBlockLine: Label '\%1 = %2 (%3)';
    begin
        with TheBlockEntry do

            case true of

                "Treatment Code" <> '':
                    begin
                        aTreatmentCode.SetRange("Item No.", "Item No.");
                        aTreatmentCode.SetRange("Lot No.", "Treatment Code");
                        if aTreatmentCode.FindFirst then
                            ;

                        aItemCategory := aTreatmentCode.TableCaption;
                        aItemDescription := aTreatmentCode.Description;
                        aItemCode := "Item No." + '-' + "Treatment Code";
                    end;

                "Unit of Measure Code" <> '':
                    begin
                        if aItem.Get("Item No.") then
                            ;
                        if aUnitOfMeasure.Get("Unit of Measure Code") then
                            ;
                        aItemCategory := aItemUnitOfMeasure.TableCaption;
                        aItemDescription := aItem.Description + '-' + aUnitOfMeasure.Description;
                        aItemCode := "Item No." + '-' + "Unit of Measure Code";
                    end;

                "Item No." <> '':
                    begin
                        if aItem.Get("Item No.") then
                            ;
                        aItemCategory := aItem.TableCaption;
                        aItemDescription := aItem.Description;
                        aItemCode := "Item No.";
                    end;

                "Variety Code" <> '':
                    begin
                        if aVariety.Get("Variety Code") then
                            ;
                        aItemCategory := aVariety.TableCaption;
                        aItemDescription := aVariety."Dutch description";
                        aItemCode := "Variety Code";
                    end;

                "Crop Code" <> '':
                    begin
                        if aCrop.Get("Crop Code") then
                            ;
                        aItemCategory := aCrop.TableCaption;
                        aItemDescription := aCrop.Description;
                        aItemCode := "Crop Code";
                    end;

            end;

        if aItemCategory <> '' then
            exit(StrSubstNo(ctBlockLine, aItemCategory, aItemDescription, aItemCode));
    end;

    procedure GetValueOfFilter(TheFilter: Text[1024]): Text[1024]
    begin
        if StrPos(TheFilter, '|') > 0 then
            exit(CopyStr(TheFilter, StrPos(TheFilter, '|') + 1))
        else
            exit('');
    end;

    procedure CheckVarietyPrognose(var TheVariety: Record Varieties): Text[50]
    var
        aBejoSetup: Record "Bejo Setup";
        aBlockEntry: Record "Block Entry";
    begin
        with TheVariety do begin

            aBejoSetup.Get;

            if not aBejoSetup."Variety Blocking" then
                exit;

            InitializeBlockEntry(aBlockEntry);
            SetContinentCountryCodeFilter(aBlockEntry);

            SetVarietyCodeFilter(aBlockEntry, "No.");

            CheckMainLevelPresent(aBlockEntry, TableCaption);

            aBlockEntry.SetFilter("Block Code", '0|1');
            if aBlockEntry.FindFirst then
                Error(MessageText(TableCaption, aBlockEntry));

        end;
    end;

    procedure IsBejoItem(var TheItemNo: Code[20]): Boolean
    var
        lrecItem: Record Item;
        lcuBejoManagement: Codeunit "Bejo Management";
    begin
        if lrecItem.Get(TheItemNo) then

            exit((lrecItem."B Crop" <> '') and
                 (lrecItem."B Extension" <> '') and
                 lcuBejoManagement.BejoItem(TheItemNo));
    end;

    local procedure MainLevelPresent(var TheBlockEntry: Record "Block Entry"): Boolean
    var
        ctMissingMainLevel: Label 'Block Entry on main level not found %1.\';
        aBlockEntry: Record "Block Entry";
    begin
        aBlockEntry.CopyFilters(TheBlockEntry);
        aBlockEntry.SetRange("Continent Code", '');
        aBlockEntry.SetRange("Country Code", '');
        aBlockEntry.SetRange("Customer No.", '');
        aBlockEntry.SetRange("Ship-to Code", '');
        aBlockEntry.SetRange("Web Account", aBlockEntry."Web Account"::" ");

        case true of

            not (TheBlockEntry.GetFilter("Treatment Code") in ['', '''''']):
                aBlockEntry.SetRange("Treatment Code", GetValueOfFilter(TheBlockEntry.GetFilter("Treatment Code")));

            not (TheBlockEntry.GetFilter("Unit of Measure Code") in ['', '''''']):
                begin
                    aBlockEntry.SetCurrentKey("Item No.", "Unit of Measure Code");
                    aBlockEntry.SetRange("Unit of Measure Code", GetValueOfFilter(TheBlockEntry.GetFilter("Unit of Measure Code")));
                end;

            not (TheBlockEntry.GetFilter("Variety Code") in ['', '''''']):
                begin
                    aBlockEntry.SetRange("Item No.");
                    aBlockEntry.SetRange("Variety Code", GetValueOfFilter(TheBlockEntry.GetFilter("Variety Code")));
                end;

            not (TheBlockEntry.GetFilter("Crop Code") in ['', '''''']):
                begin
                    aBlockEntry.SetRange("Item No.");
                    aBlockEntry.SetRange("Crop Code", GetValueOfFilter(TheBlockEntry.GetFilter("Crop Code")));
                end;

        end;

        exit(not aBlockEntry.IsEmpty);
    end;

    procedure NoMainLevelText(): Text[1024]
    var
        ctNotPresent: Label 'No main level present';
    begin
        exit(ctNotPresent);
    end;

    procedure ImpPurchaseLineBlockDescr(var lrecImportedPurchaseLines: Record "Imported Purchase Lines"): Text[50]
    var
        aBlockCode: Record "Block Code";
        aBlockEntry: Record "Block Entry";
    begin
        InitializeBlockEntry(aBlockEntry);

        SetContinentCountryCodeFilter(aBlockEntry);

        SetItemNoFilter(aBlockEntry, lrecImportedPurchaseLines."No.");
        SetUOMCodeFilter(aBlockEntry, lrecImportedPurchaseLines."Unit of Measure Code"
                         , lrecImportedPurchaseLines."No.");
        if aBlockEntry.FindFirst then begin

            if not MainLevelPresent(aBlockEntry) then
                exit(NoMainLevelText);

            if aBlockCode.Get(aBlockEntry."Block Code") then
                exit(aBlockCode.Code + ': ' + aBlockCode.Description);

        end;

        exit(NotPresentText);
    end;

    procedure VarietyItemUoMIsBlocked(Variety: Code[5]; ItemNo: Code[20]; UoM: Code[10]) IsBlocked: Boolean
    var
        lrecBejoSetup: Record "Bejo Setup";
        lrecItemUnit: Record "Item/Unit";
        lrecItem: Record Item;
        lrecVariety: Record Varieties;
        lFoundBlockCode: Code[10];
    begin

        IsBlocked := false;
        lFoundBlockCode := '';

        lrecBejoSetup.Get;
        if lrecBejoSetup."Variety Blocking" then begin
            if UoM <> '' then begin
                lrecItemUnit.Init;
                lrecItemUnit."Item No." := ItemNo;
                lrecItemUnit."Unit of Measure" := UoM;
                lrecItemUnit.Variety := Variety;
                lFoundBlockCode := ItemUnitBlockCode(lrecItemUnit);
            end else begin
                if ItemNo <> '' then begin
                    lrecItem.Init;
                    lrecItem."No." := ItemNo;
                    lFoundBlockCode := ItemBlockCode(lrecItem);
                end else begin
                    if Variety <> '' then begin
                        lrecVariety.Init;
                        lrecVariety."No." := Variety;
                        lFoundBlockCode := VarietyBlockCode(lrecVariety);
                    end;
                end;
            end;

            IsBlocked := lFoundBlockCode in ['0', '1'];
        end;

    end;
}

