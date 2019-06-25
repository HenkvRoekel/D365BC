page 50070 "Market Potential"
{

    Caption = 'Market Potential';
    DelayedInsert = true;
    DeleteAllowed = false;
    PageType = List;
    SaveValues = true;
    ShowFilter = false;
    SourceTable = "Market Potential";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                grid(Control9)
                {
                    ShowCaption = false;
                    group(Control7)
                    {
                        ShowCaption = false;
                        field(gYearFilter; gYearFilter)
                        {
                            Caption = 'Year';
                            Importance = Promoted;
                            ApplicationArea = All;

                            trigger OnValidate()
                            begin
                                gYearFilterOnAfterValidate;
                            end;
                        }
                    }
                    group(Control12)
                    {
                        ShowCaption = false;
                        field(gSalesPersonFilter; gSalesPersonFilter)
                        {
                            Caption = 'Salesperson No.';
                            TableRelation = "Salesperson/Purchaser";
                            ApplicationArea = All;

                            trigger OnValidate()
                            begin
                                ValidateSalesPersonFilter;
                                gSalesPersonFilterOnAfterValid;
                            end;
                        }
                    }
                    group(Control13)
                    {
                        ShowCaption = false;
                        field(gCustomerFilter; gCustomerFilter)
                        {
                            Caption = 'Customer No.';
                            TableRelation = Customer;
                            ApplicationArea = All;

                            trigger OnValidate()
                            begin
                                ValidateCustomerFilter;
                                gCustomerFilterOnAfterValidate;
                            end;
                        }
                    }
                    group(Control14)
                    {
                        ShowCaption = false;
                        field(gCropVariantFilter; gCropVariantFilter)
                        {
                            Caption = 'Crop Variant';
                            ApplicationArea = All;

                            trigger OnLookup(var Text: Text): Boolean
                            var
                                lcuBejoMngtEXT: Codeunit "Bejo Management";
                            begin
                                exit(lcuBejoMngtEXT.LookUpCrop(Text));
                            end;

                            trigger OnValidate()
                            begin
                                ValidateABSCropFilter;
                                gCropVariantFilterOnAfterValid;
                            end;
                        }
                    }
                    group(Control15)
                    {
                        ShowCaption = false;
                        field(gCropTypeFilter; gCropTypeFilter)
                        {
                            Caption = 'Crop Type';
                            ApplicationArea = All;

                            trigger OnLookup(var Text: Text): Boolean
                            var
                                lcuBejoMngtEXT: Codeunit "Bejo Management";
                            begin
                                exit(lcuBejoMngtEXT.LookUpCropType(gCropVariantFilter, Text));
                            end;

                            trigger OnValidate()
                            begin
                                ValidateABSCropTypeFilter;
                                gCropTypeFilterOnAfterValidate;
                            end;
                        }
                    }
                    group(Control11)
                    {
                        ShowCaption = false;
                        field(gHideEmtpyLines; gHideEmtpyLines)
                        {
                            Caption = 'Hide Empty Lines';
                            ApplicationArea = All;

                            trigger OnValidate()
                            begin
                                gHideEmtpyLinesOnAfterValidate;
                            end;
                        }
                    }
                }
                grid(Control3)
                {
                    ShowCaption = false;
                    group(Control16)
                    {
                        ShowCaption = false;
                        field("gSalesPersonName+'  '+gCustomerName+'  '+gCropVariantDescription+'  '+gCropTypeDescription"; gSalesPersonName + '  ' + gCustomerName + '  ' + gCropVariantDescription + '  ' + gCropTypeDescription)
                        {
                            Caption = 'Filter Name';
                            Importance = Promoted;
                            ApplicationArea = All;
                        }
                    }
                }
            }
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Crop Variant Code"; "Crop Variant Code")
                {
                    Editable = "Crop Variant CodeEditable";
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        lcuBejoMngtEXT: Codeunit "Bejo Management";
                    begin
                        exit(lcuBejoMngtEXT.LookUpCrop(Text));
                    end;
                }
                field("Crop Type"; "Crop Type")
                {
                    Editable = "Crop TypeEditable";
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        lcuBejoMngtEXT: Codeunit "Bejo Management";
                    begin
                        exit(lcuBejoMngtEXT.LookUpCropType("Crop Variant Code", Text));
                    end;
                }
                field(Year; Year)
                {
                    Editable = YearEditable;
                    ApplicationArea = All;
                }
                field("Crop Variant Description"; "Crop Variant Description")
                {
                    ApplicationArea = All;
                }
                field("Crop Type Description"; "Crop Type Description")
                {
                    ApplicationArea = All;
                }
                field("Salesperson Code"; "Salesperson Code")
                {
                    Editable = "Salesperson CodeEditable";
                    ApplicationArea = All;
                }
                field("Customer No."; "Customer No.")
                {
                    Editable = "Customer No.Editable";
                    ApplicationArea = All;
                }
                field("Conventional Acreage Current"; "Conventional Acreage Current")
                {
                    Editable = "Acreage CurrentEditable";
                    ApplicationArea = All;
                }
                field("Organic Acreage Current"; "Organic Acreage Current")
                {
                    ApplicationArea = All;
                }
                field("Sowing Ratio Current"; "Sowing Ratio Current")
                {
                    Editable = "Sowing Ratio CurrentEditable";
                    ApplicationArea = All;
                }
                field("Conventional Acreage Future"; "Conventional Acreage Future")
                {
                    Editable = "Acreage FutureEditable";
                    ApplicationArea = All;
                }
                field("Organic Acreage Future"; "Organic Acreage Future")
                {
                    ApplicationArea = All;
                }
                field("Sowing Ratio Future"; "Sowing Ratio Future")
                {
                    Editable = "Sowing Ratio FutureEditable";
                    ApplicationArea = All;
                }
                field(Remark; Remark)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Functions")
            {
                Caption = '&Functions';
                action("Export Market Potential Data")
                {
                    Caption = 'Export Market Potential Data';
                    Image = ExportToBank;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        lcduMarketPotentialMgt: Codeunit "Market Potential Mgt.";
                    begin
                        lcduMarketPotentialMgt.ExportMarketPotential;
                    end;
                }
                action("Create All for the Filters")
                {
                    Caption = 'Create All for the Filters';
                    Image = CreateInteraction;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin

                        CreateAllForCurrentFilter;

                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetEditable;
        OnAfterGetCurrRecord;
    end;

    trigger OnInit()
    begin
        "Sowing Ratio FutureEditable" := true;
        "Sowing Ratio CurrentEditable" := true;
        "Acreage FutureEditable" := true;
        "Acreage CurrentEditable" := true;
        "Customer No.Editable" := true;
        "Salesperson CodeEditable" := true;
        YearEditable := true;
        "Crop TypeEditable" := true;
        "Crop Variant CodeEditable" := true;
        "Seed Value CurrentEditable" := true;
        "Seed Value FutureEditable" := true;

        gYearFilter := gcduMarketPotential.ThisYear;

        gCustomerFilter := '';
        gSalesPersonFilter := '';
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        if gYearFilter <> 0 then
            Year := gYearFilter
        else

            Year := gcduMarketPotential.ThisYear;


        if gCustomerFilter <> '' then
            "Customer No." := gCustomerFilter;

        if gSalesPersonFilter <> '' then
            "Salesperson Code" := gSalesPersonFilter;
        OnAfterGetCurrRecord;
    end;

    trigger OnOpenPage()
    begin
        ApplyFilters;
    end;

    var
        gcduMarketPotential: Codeunit "Market Potential Mgt.";
        gYearFilter: Integer;
        gCustomerFilter: Code[20];
        gSalesPersonFilter: Code[10];
        gCropVariantFilter: Code[20];
        gCropTypeFilter: Code[20];
        gCustomerName: Text[50];
        gSalesPersonName: Text[50];
        gCropVariantDescription: Text[50];
        gCropTypeDescription: Text[50];
        gHideEmtpyLines: Boolean;
        [InDataSet]
        "Crop Variant CodeEditable": Boolean;
        [InDataSet]
        "Crop TypeEditable": Boolean;
        [InDataSet]
        YearEditable: Boolean;
        [InDataSet]
        "Salesperson CodeEditable": Boolean;
        [InDataSet]
        "Customer No.Editable": Boolean;
        [InDataSet]
        "Acreage CurrentEditable": Boolean;
        [InDataSet]
        "Acreage FutureEditable": Boolean;
        [InDataSet]
        "Sowing Ratio CurrentEditable": Boolean;
        [InDataSet]
        "Sowing Ratio FutureEditable": Boolean;
        "Seed Value CurrentEditable": Boolean;
        "Seed Value FutureEditable": Boolean;

    local procedure ApplyFilters()
    begin

        FilterGroup(100);

        if gYearFilter <> 0 then
            SetRange(Year, gYearFilter)
        else
            SetRange(Year);

        if gCustomerFilter <> '' then
            SetRange("Customer No.", gCustomerFilter)
        else
            SetRange("Customer No.");

        if gSalesPersonFilter <> '' then
            SetRange("Salesperson Code", gSalesPersonFilter)
        else
            SetRange("Salesperson Code");

        if gCropVariantFilter <> '' then
            SetRange("Crop Variant Code", gCropVariantFilter)
        else
            SetRange("Crop Variant Code");

        if gCropTypeFilter <> '' then
            SetRange("Crop Type", gCropTypeFilter)
        else
            SetRange("Crop Type");


        if gHideEmtpyLines then
            SetRange(EmptyLine, false)
        else
            SetRange(EmptyLine);


        FilterGroup(0);
    end;

    local procedure SetEditable()
    var
        lIsEditable: Boolean;
    begin

        lIsEditable := (Year = gcduMarketPotential.ThisYear);

        "Crop Variant CodeEditable" := lIsEditable;
        "Crop TypeEditable" := lIsEditable;
        YearEditable := lIsEditable and (gYearFilter = 0);
        "Salesperson CodeEditable" := lIsEditable and (gSalesPersonFilter = '');
        "Customer No.Editable" := lIsEditable and (gCustomerFilter = '');

        "Acreage CurrentEditable" := lIsEditable;
        "Acreage FutureEditable" := lIsEditable;
        "Sowing Ratio CurrentEditable" := lIsEditable;
        "Sowing Ratio FutureEditable" := lIsEditable;


        "Seed Value CurrentEditable" := lIsEditable;
        "Seed Value FutureEditable" := lIsEditable;

    end;

    procedure ValidateCustomerFilter()
    var
        lrecCustomer: Record Customer;
    begin
        if lrecCustomer.Get(gCustomerFilter) then
            gCustomerName := lrecCustomer.Name
        else
            gCustomerName := '';
    end;

    procedure ValidateSalesPersonFilter()
    var
        lrecSalesPerson: Record "Salesperson/Purchaser";
    begin
        if lrecSalesPerson.Get(gSalesPersonFilter) then
            gSalesPersonName := lrecSalesPerson.Name
        else
            gSalesPersonName := '';
    end;

    procedure ValidateABSCropFilter()
    var
        lrecVariety: Record Varieties;
    begin
        if not GetCropCropType(gCropVariantFilter, gCropTypeFilter) then
            gCropTypeFilter := '';

        gCropVariantDescription := lrecVariety.ABSCropDescription(gCropVariantFilter, '');
    end;

    procedure ValidateABSCropTypeFilter()
    var
        lrecVariety: Record Varieties;
    begin
        ValidateCropCropType(gCropVariantFilter, gCropTypeFilter);

        gCropTypeDescription := lrecVariety.ABSCropTypeDescription(gCropTypeFilter, '');
    end;

    procedure CreateAllForCurrentFilter()
    begin

        if QueryCreateAllForAppliedFilter(gYearFilter, gCustomerFilter, gSalesPersonFilter, gCropVariantFilter, gCropTypeFilter) then begin
            CreateAllForAppliedFilter(gYearFilter, gCustomerFilter, gSalesPersonFilter, gCropVariantFilter, gCropTypeFilter);
            CurrPage.Update;
        end;

    end;

    local procedure gYearFilterOnAfterValidate()
    begin
        ApplyFilters;
        CurrPage.Update(false);
    end;

    local procedure gCustomerFilterOnAfterValidate()
    begin
        ApplyFilters;
        CurrPage.Update(false);
    end;

    local procedure gSalesPersonFilterOnAfterValid()
    begin
        ApplyFilters;
        CurrPage.Update(false);
    end;

    local procedure gCropVariantFilterOnAfterValid()
    begin
        ApplyFilters;
        CurrPage.Update(false);
    end;

    local procedure gCropTypeFilterOnAfterValidate()
    begin
        ApplyFilters;
        CurrPage.Update(false);
    end;

    local procedure gHideEmtpyLinesOnAfterValidate()
    begin

        ApplyFilters;
        CurrPage.Update;

    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        SetEditable;
    end;
}

