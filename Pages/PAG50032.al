page 50032 "Create Item Wizard"
{

    Caption = 'Create Item Wizard';
    LinksAllowed = false;
    PageType = NavigatePage;

    layout
    {
        area(content)
        {
            group(Step2)
            {
                Caption = 'Step 2';
                InstructionalText = 'You can create a new item, or create a new Unit of Measure for an existing item.';
                Visible = Step2Visible;
                field(gItemNo; gItemNo)
                {
                    Caption = 'Select an Item';
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        exit(LookUpItemNo(Text));
                    end;

                    trigger OnValidate()
                    begin
                        CheckItemBaseUoM(gItemNo);
                    end;
                }
                field(gBaseUoMtextbox; gBaseUoM)
                {
                    Caption = 'Base Unit of Measure';
                    Enabled = gBaseUoMtextboxEnable;
                    OptionCaption = 'PCS,KG';
                    Visible = false;
                    ApplicationArea = All;
                }
            }
            group(Step3)
            {
                Caption = 'Step 3';
                InstructionalText = 'Select the Units of Measure to be created. The Base Unit of Measure will allways be created, even if not selected here.\Multiple lines can be selected using Ctrl+F1';
                Visible = Step3Visible;
                part(Subform1; "Create Item Wizard subform 1")
                {
                    Caption = 'Create Item Wizard';
                    ShowFilter = false;
                    SubPageView = SORTING (Number)
                                  ORDER(Ascending);
                    Visible = Subform1Visible;
                    ApplicationArea = All;
                }
            }
            group(Step1)
            {
                Caption = 'Step 1';
                InstructionalText = 'This wizard enables you to create new Items with default settings.';
                Visible = Step1Visible;
                field(SelectTemplate; gTemplateName)
                {
                    Caption = 'Select a Template';
                    Enabled = SelectTemplateEnable;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        exit(LookUpTemplateName(Text));
                    end;
                }
                field(gVarietyCode; gVarietyCode)
                {
                    Caption = 'Select a Variety';
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin

                        exit(LookUpVariety(Text));

                    end;

                    trigger OnValidate()
                    begin

                        if gVarietyCode <> '' then
                            grecVarietyTEMP.Get(gVarietyCode);

                    end;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Back)
            {
                Caption = 'Back';
                Enabled = BackEnable;
                Image = PreviousRecord;
                InFooterBar = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    ShowStep(false);
                    PerformPrevWizardStatus;
                    ShowStep(true);
                    CurrPage.Update(true);
                end;
            }
            action(Next)
            {
                Caption = 'Next';
                Enabled = NextEnable;
                Image = NextRecord;
                InFooterBar = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    CheckStatus;
                    ShowStep(false);
                    PerformNextWizardStatus;
                    ShowStep(true);
                    SetTopTexts;
                    CurrPage.Update(true);
                end;
            }
            action(Finish)
            {
                Caption = 'Finish';
                Enabled = FinishEnable;
                Image = Approve;
                InFooterBar = true;
                ApplicationArea = All;

                trigger OnAction()
                begin

                    FinishWizard;
                    CurrPage.Close;
                end;
            }
        }
    }

    trigger OnInit()
    begin
        SelectTemplateEnable := true;
        NextEnable := true;
        gBaseUoMtextboxEnable := true;
        Subform1Visible := true;
        Step1Visible := true;
    end;

    trigger OnOpenPage()
    begin
        gPageWidth := CancelXPos + CancelWidth + 220;

        FrmHeight := CancelYPos + CancelHeight + 220;
        FrmWidth := gPageWidth;

        StartWizard;
    end;

    var
        gcuItemMgt: Codeunit "Item Management";
        gcuBejoMgt: Codeunit "Bejo Management";
        grecTemplateListTEMP: Record "Config. Template Header" temporary;
        grecVarietyTEMP: Record Varieties temporary;
        grecItemTEMP: Record Item temporary;
        grecItemUoMTEMP: Record "Item Unit of Measure" temporary;
        gPageWidth: Integer;
        gStep: Integer;
        gTemplateName: Code[10];
        gVarietyCode: Code[5];
        Text00001: Label 'You need to set up at least one Master Template for the Item table.';
        Text00002: Label 'There are no varieties available. Items cannot be created using this wizard.';
        Text01001: Label 'This wizard enables you to create new Items with default settings.';
        gItemNo: Code[20];
        Text01002: Label 'No Items available for Variety=%1.';
        Text01003: Label 'Please fill all fields.';
        Text02001: Label 'You can create a new item, or create a new Unit of Measure for an existing item.';
        Text02002: Label 'Item No. %1 is not valid.';
        Text03001: Label 'Select the Units of Measure to be created. The Base UoM will allways be created, even if not selected here.\Multiple lines can be selected using Ctrl+F1';
        Text03002: Label 'No new Units of Measure available for Item No.=%1';
        Text09000: Label 'Error creating Item No. %2, Unit of Measure Code %3, Variety %4 using template %1';
        gCreatedItemNo: Code[20];
        gBaseUoM0: Code[10];
        gBaseUoM1: Code[10];
        gBaseUoM: Option PCS,KG;
        CancelXPos: Integer;
        CancelYPos: Integer;
        CancelHeight: Integer;
        CancelWidth: Integer;
        FrmHeight: Integer;
        FrmWidth: Integer;
        [InDataSet]
        Step1Visible: Boolean;
        [InDataSet]
        Step2Visible: Boolean;
        [InDataSet]
        Step3Visible: Boolean;
        [InDataSet]
        Subform1Visible: Boolean;
        [InDataSet]
        gBaseUoMtextboxEnable: Boolean;
        [InDataSet]
        BackEnable: Boolean;
        [InDataSet]
        NextEnable: Boolean;
        [InDataSet]
        FinishEnable: Boolean;
        [InDataSet]
        SelectTemplateEnable: Boolean;

    procedure PerformPrevWizardStatus()
    begin
        if gStep > 1 then
            gStep -= 1;
    end;

    procedure PerformNextWizardStatus()
    var
        Variety: Record Varieties;
    begin
        case gStep of
            1:
                begin

                    if grecTemplateListTEMP.Get(gTemplateName) and grecVarietyTEMP.Get(gVarietyCode) then begin

                        if gcuItemMgt.GetAvailableItems(grecItemTEMP, '', gVarietyCode) = 0 then begin
                            Message(Text01002, gVarietyCode);
                            exit;
                        end;
                        gStep := 2;
                    end else
                        Message(Text01003);
                end;
            2:
                begin
                    if gItemNo <> '' then begin
                        if not grecItemTEMP.Get(gItemNo) then begin
                            Message(Text02002, gItemNo);
                            exit;
                        end;

                        if gcuItemMgt.GetAvailableItemUoMs(grecItemUoMTEMP, gVarietyCode, gItemNo, '') = 0 then begin

                            Message(Text03002, gItemNo);
                            exit;
                        end;
                        gStep := 3;
                    end else
                        Message(Text01003);
                end;
        end;
    end;

    procedure SetTopTexts()
    begin
    end;

    procedure ShowStep(SetVisible: Boolean)
    begin
        Step1Visible := false;
        Step2Visible := false;
        Step3Visible := false;
        Subform1Visible := false;

        if SetVisible then
            case gStep of
                1:
                    begin
                        Step1Visible := true;
                        ShowButtons(false, true, false);
                    end;
                2:
                    begin
                        Step2Visible := true;
                        ShowButtons(true, true, false);
                    end;
                3:
                    begin
                        Step3Visible := true;
                        Subform1Visible := true;
                        CurrPage.Subform1.PAGE.CreateDataset(grecItemUoMTEMP);
                        ShowButtons(true, false, true);
                    end;
            end;
    end;

    procedure ShowButtons(ShowBack: Boolean; ShowNext: Boolean; ShowFinish: Boolean)
    begin
        BackEnable := ShowBack;
        NextEnable := ShowNext;
        FinishEnable := ShowFinish;
    end;

    procedure StartWizard()
    var
        lUoMCode: Code[10];
    begin
        gStep := 1;

        case gcuItemMgt.GetAvailableTemplates(grecTemplateListTEMP, '') of
            0:
                Error(Text00001);
            1:
                begin
                    grecTemplateListTEMP.FindFirst;
                    gTemplateName := grecTemplateListTEMP.Code;
                    SelectTemplateEnable := false;
                end;
            else
                SelectTemplateEnable := true;
        end;

        gVarietyCode := '';
        gItemNo := '';
        Clear(grecItemTEMP);
        Clear(grecItemUoMTEMP);


        Clear(grecVarietyTEMP);
        if gcuItemMgt.GetAvailableVarieties(grecVarietyTEMP) = 0 then
            Error(Text00002);


        gBaseUoM0 := 'PCS';
        gBaseUoM1 := 'KG';


        lUoMCode := '1';
        if gcuBejoMgt.FindUoMFromCodeBejoNL(lUoMCode) then
            gBaseUoM1 := lUoMCode;

        lUoMCode := '2';
        if gcuBejoMgt.FindUoMFromCodeBejoNL(lUoMCode) then
            gBaseUoM0 := lUoMCode;

        ShowStep(true);
    end;

    procedure CheckStatus()
    begin
    end;

    procedure FinishWizard()
    var
        lBaseUoM: Code[10];
    begin

        case gBaseUoM of
            gBaseUoM::KG:
                lBaseUoM := gBaseUoM1;
            gBaseUoM::PCS:
                lBaseUoM := gBaseUoM0;
        end;


        CurrPage.Subform1.PAGE.GetSelectedRecords(grecItemUoMTEMP);
        grecItemUoMTEMP.MarkedOnly(true);
        if grecItemUoMTEMP.FindSet then repeat
                                            if not gcuItemMgt.CreateItemFromTemplate(gTemplateName, gItemNo,
                                                                           grecItemUoMTEMP.Code, gVarietyCode, lBaseUoM) then

                                                error(Text09000, gTemplateName, grecItemUoMTEMP."Item No.", grecItemUoMTEMP.Code, gVarietyCode);
            until grecItemUoMTEMP.Next = 0;
        gCreatedItemNo := gItemNo;
    end;

    procedure LookUpTemplateName(var Text: Text[1024]): Boolean
    begin
        if Text <> '' then begin
            grecTemplateListTEMP.SetFilter(Code, '@%1*', Text);
            if not grecTemplateListTEMP.FindFirst then begin
                grecTemplateListTEMP.SetRange(Code);
                grecTemplateListTEMP.Init;
                grecTemplateListTEMP.Code := Text;
                if not grecTemplateListTEMP.Find('=<>') then
                    grecTemplateListTEMP.FindFirst;
            end;
        end;
        grecTemplateListTEMP.Reset;
        if PAGE.RunModal(0, grecTemplateListTEMP) = ACTION::LookupOK then begin
            Text := grecTemplateListTEMP.Code;
            exit(true);
        end;
    end;

    procedure LookUpVariety(var Text: Text[1024]): Boolean
    begin

        if Text <> '' then begin
            grecVarietyTEMP.SetFilter("No.", '@%1*', Text);
            if not grecVarietyTEMP.FindFirst then begin
                grecVarietyTEMP.SetRange("No.");
                grecVarietyTEMP.Init;
                grecVarietyTEMP."No." := Text;
            end;
        end else
            grecVarietyTEMP."No." := '';
        if not grecVarietyTEMP.Find('=><') then
            grecVarietyTEMP.FindFirst;
        grecVarietyTEMP.Reset;
        if PAGE.RunModal(50029, grecVarietyTEMP) = ACTION::LookupOK then begin
            Text := grecVarietyTEMP."No.";
            exit(true);
        end;

    end;

    procedure LookUpItemNo(var Text: Text[1024]): Boolean
    begin
        if Text <> '' then begin
            grecItemTEMP.SetFilter("No.", '@%1*', Text);
            if not grecItemTEMP.FindFirst then begin
                grecItemTEMP.SetRange("No.");
                grecItemTEMP.Init;
                grecItemTEMP."No." := Text;
                if not grecItemTEMP.Find('=<>') then
                    grecItemTEMP.FindFirst;
            end;
        end;
        grecItemTEMP.Reset;
        if PAGE.RunModal(0, grecItemTEMP) = ACTION::LookupOK then begin
            Text := grecItemTEMP."No.";
            CheckItemBaseUoM(Text);
            CurrPage.Update(false);
            exit(true);
        end;
    end;

    procedure CheckItemBaseUoM(ItemNo: Code[20])
    var
        lrecItem: Record Item;
    begin
        if grecItemTEMP.Get(ItemNo) then begin
            if lrecItem.Get(ItemNo) then
                grecItemTEMP.TransferFields(lrecItem);
            case grecItemTEMP."Base Unit of Measure" of
                gBaseUoM0:
                    begin
                        gBaseUoM := gBaseUoM::PCS;
                        gBaseUoMtextboxEnable := false;
                    end;
                gBaseUoM1:
                    begin
                        gBaseUoM := gBaseUoM::KG;
                        gBaseUoMtextboxEnable := false;
                    end;
                else
                    gBaseUoMtextboxEnable := true;
            end;
        end else
            gBaseUoMtextboxEnable := true;
    end;

    procedure GetCreatedItemNo(): Code[20]
    begin
        exit(gCreatedItemNo);
    end;
}

