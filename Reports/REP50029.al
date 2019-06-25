report 50029 "Copy Variety Price Classificat"
{

    Caption = 'Copy Variety Price Classification';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Variety Price Classification"; "Variety Price Classification")
        {
            DataItemTableView = SORTING ("Variety Price Group Code", "Sales Type", "Sales Code", "Variety No.") ORDER(Ascending);
            RequestFilterFields = "Variety Price Group Code", "Sales Type", "Sales Code";

            trigger OnAfterGetRecord()
            var
                lrecVarietyPriceClass: Record "Variety Price Classification";
            begin
                with lrecVarietyPriceClass do begin
                    Init;
                    if ToVarietyPriceGroup <> '' then
                        "Variety Price Group Code" := ToVarietyPriceGroup
                    else
                        "Variety Price Group Code" := "Variety Price Classification"."Variety Price Group Code";

                    "Sales Code" := ToSalesCode;
                    "Sales Type" := ToSalesType;
                    "Variety No." := "Variety Price Classification"."Variety No.";
                    "Variety Description" := "Variety Price Classification"."Variety Description";
                    "Crop Code" := "Variety Price Classification"."Crop Code";
                    if Insert(false) then
                        gInsertedRecordCounter += 1;
                end;
            end;

            trigger OnPreDataItem()
            var
                lrecVarietyPriceGroup: Record "Variety Price Group";
                lFilter1: Code[30];
                lFilter2: Code[30];
            begin
                lFilter1 := GetFilter("Variety Price Group Code");
                lFilter2 := GetFilter("Sales Code");


                if (lFilter2 = '') then
                    Error(Text50000);


                if (ToSalesCode = '') then
                    Error(Text50001);
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
                    group("Copy to other Variety Price Classification")
                    {
                        Caption = 'Copy to other Variety Price Classification';
                        field(ToVarietyPriceGroup; ToVarietyPriceGroup)
                        {
                            Caption = 'Variety Price Group';
                            TableRelation = "Variety Price Group";
                            ApplicationArea = All;

                            trigger OnLookup(var Text: Text): Boolean
                            var
                                lfrmVarietyPriceGroupList: Page "Variety Price Group List";
                                lrecVarietyPricegroup: Record "Variety Price Group";
                            begin
                                lfrmVarietyPriceGroupList.LookupMode := true;
                                if lfrmVarietyPriceGroupList.RunModal = ACTION::LookupOK then begin
                                    lfrmVarietyPriceGroupList.GetRecord(lrecVarietyPricegroup);
                                    ToVarietyPriceGroup := lrecVarietyPricegroup.Code;
                                end;
                            end;
                        }
                        field(ToSalesType; ToSalesType)
                        {
                            Caption = 'Sales Type';
                            OptionCaption = 'Customer,Customer Price Group,All Customers,Campaign';
                            ApplicationArea = All;

                            trigger OnValidate()
                            begin
                                SalesCodeCtrlEnable := ToSalesType <> ToSalesType::"All Customers";

                                ToSalesCode := '';
                            end;
                        }
                        field(SalesCodeCtrl; ToSalesCode)
                        {
                            Caption = 'Sales Code';
                            Enabled = SalesCodeCtrlEnable;
                            ApplicationArea = All;

                            trigger OnLookup(var Text: Text): Boolean
                            var
                                CustList: Page "Customer List";
                                CustPriceGrList: Page "Customer Price Groups";
                                CampaignList: Page "Campaign List";
                            begin
                                case ToSalesType of
                                    ToSalesType::Customer:
                                        begin
                                            CustList.LookupMode := true;
                                            CustList.SetRecord(ToCust);
                                            if CustList.RunModal = ACTION::LookupOK then begin
                                                CustList.GetRecord(ToCust);
                                                ToSalesCode := ToCust."No.";
                                            end;
                                        end;
                                    ToSalesType::"Customer Price Group":
                                        begin
                                            CustPriceGrList.LookupMode := true;
                                            CustPriceGrList.SetRecord(ToCustPriceGr);
                                            if CustPriceGrList.RunModal = ACTION::LookupOK then begin
                                                CustPriceGrList.GetRecord(ToCustPriceGr);
                                                ToSalesCode := ToCustPriceGr.Code;
                                            end;
                                        end;
                                    ToSalesType::Campaign:
                                        begin
                                            CampaignList.LookupMode := true;
                                            CampaignList.SetRecord(ToCampaign);
                                            if CampaignList.RunModal = ACTION::LookupOK then begin
                                                CampaignList.GetRecord(ToCampaign);
                                                ToSalesCode := ToCampaign."No.";
                                            end;
                                        end;
                                end;
                            end;

                            trigger OnValidate()
                            var
                                lInputValid: Boolean;
                                lrecCustomerPriceGroup: Record "Customer Price Group";
                                lrecCustomer: Record Customer;
                                lrecCampaign: Record Campaign;
                            begin
                                case ToSalesType of
                                    ToSalesType::Customer:
                                        begin
                                            if lrecCustomer.Get(ToSalesCode) then begin
                                                lInputValid := true;
                                            end;
                                        end;

                                    ToSalesType::"Customer Price Group":
                                        begin
                                            if lrecCustomerPriceGroup.Get(ToSalesCode) then begin
                                                lInputValid := true;
                                            end;
                                        end;

                                    ToSalesType::Campaign:
                                        begin
                                            if lrecCampaign.Get(ToSalesCode) then begin
                                                lInputValid := true;
                                            end;
                                        end;
                                end;
                                if not lInputValid then begin
                                    Message(Text50010, ToSalesCode);
                                    ToSalesCode := '';
                                end;
                            end;
                        }
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin
            SalesCodeCtrlEnable := true;
        end;
    }

    labels
    {
    }

    trigger OnPostReport()
    var
        lVarietyPriceGroupText: Text[30];
    begin
        if ToVarietyPriceGroup = '' then
            lVarietyPriceGroupText := ' '
        else
            lVarietyPriceGroupText := ToVarietyPriceGroup;

        Message(Text50020, gInsertedRecordCounter, lVarietyPriceGroupText, ToSalesType, ToSalesCode);
    end;

    var
        ToVarietyPriceGroup: Code[30];
        ToSalesCode: Code[20];
        ToSalesType: Option Customer,"Customer Price Group","All Customers",Campaign;
        ToCust: Record Customer;
        ToCustPriceGr: Record "Customer Price Group";
        ToCampaign: Record Campaign;
        Text50000: Label 'Sales Code filter must be set.';
        Text50001: Label 'Destination Sales Code must be set.';
        Text50010: Label 'The Sales Code: %1 is not valid.';
        gInsertedRecordCounter: Integer;
        Text50020: Label '%1 records created for Variety Price Group: %2, Sales Type: %3, Sales Code: %4.';
        [InDataSet]
        SalesCodeCtrlEnable: Boolean;
}

