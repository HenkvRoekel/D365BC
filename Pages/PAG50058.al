page 50058 "Overview Prognosis List"
{

    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Prognosis/Allocation Entry";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Filter Text"; "Filter Text")
                {
                    Caption = 'Date Filter';
                    ApplicationArea = All;
                }
                field("Item No."; "Item No.")
                {
                    Caption = 'Item No.';
                    Editable = false;
                    TableRelation = Item;
                    ApplicationArea = All;
                }
                field("Unit of Measure"; "Unit of Measure")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            repeater(Group)
            {
                field("Internal Entry No."; "Internal Entry No.")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Item No.2"; "Item No.")
                {
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = "Item No.Emphasize";
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    Editable = false;
                    Style = Strong;
                    StyleExpr = DescriptionEmphasize;
                    ApplicationArea = All;
                }
                field(Salesperson; Salesperson)
                {
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = SalesPersonStyle;
                    ApplicationArea = All;
                }
                field(Customer; Customer)
                {
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = CustomerStyle;
                    ApplicationArea = All;
                }
                field("Unit of Measure2"; "Unit of Measure")
                {
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = UOMStyle;
                    ApplicationArea = All;
                }
                field("Sales Date"; "Sales Date")
                {
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = DateStyle;
                    ApplicationArea = All;
                }
                field("User-ID"; "User-ID")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Purchase Date"; "Purchase Date")
                {
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = shipstyle;
                    ApplicationArea = All;
                }
                field("Date Modified"; "Date Modified")
                {
                    Caption = 'Prognosis Last Date Modified';
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = LastStyle;
                    ApplicationArea = All;
                }
                field(Prognoses; Prognoses)
                {
                    BlankZero = true;
                    DecimalPlaces = 4 : 4;
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = ProgStyle;
                    ApplicationArea = All;
                }
                field(Adjusted; Adjusted)
                {
                    ApplicationArea = All;
                }
                field(Exported; Exported)
                {
                    ApplicationArea = All;
                }
                field("BZ Original Prognoses"; "BZ Original Prognoses")
                {
                    ApplicationArea = All;
                }
                field(OrigPrognoses; gOrigProg)
                {
                    BlankZero = true;
                    Caption = 'Internal Initial Prognoses';
                    Description = 'BEJOWW5.01.011';
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Prognosis Remark"; "Prognosis Remark")
                {
                    Caption = 'Prognosis Remark';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Blocked; Blocked)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Handled; Handled)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Handled Last Modified Date"; "Handled Last Modified Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Handled Remark"; "Handled Remark")
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
            action(EditLines)
            {
                Caption = 'Edit';
                Image = EditLines;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    lrecPrognosisAllocation: Record "Prognosis/Allocation Entry";
                begin
                    lrecPrognosisAllocation.SetRange("Entry Type", lrecPrognosisAllocation."Entry Type"::Prognoses);
                    lrecPrognosisAllocation.SetRange("Item No.", "Item No.");
                    lrecPrognosisAllocation.SetRange("Unit of Measure", "Unit of Measure");
                    lrecPrognosisAllocation.SetRange("Sales Date", "Sales Date");
                    PAGE.RunModal(50086, lrecPrognosisAllocation);
                    CurrPage.Update;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        ItemNoC1100509000OnFormat;
        DescriptionOnFormat;
        SalespersonOnFormat;
        CustomerOnFormat;
        UnitofMeasureC1100509006OnForm;
        SalesDateOnFormat;
        PurchaseDateOnFormat;
        PrognosisLastDateModifiedOnFor;
        PrognosesOnFormat;
        gOrigProgOnFormat;
    end;

    var
        [InDataSet]
        "Item No.Emphasize": Boolean;
        [InDataSet]
        DescriptionEmphasize: Boolean;
        [InDataSet]
        SalesPersonStyle: Boolean;
        [InDataSet]
        CustomerStyle: Boolean;
        [InDataSet]
        UOMStyle: Boolean;
        [InDataSet]
        DateStyle: Boolean;
        ShipStyle: Boolean;
        [InDataSet]
        LastStyle: Boolean;
        [InDataSet]
        ProgStyle: Boolean;
        xx: Integer;
        gOrigProg: Boolean;
        gDate: Date;
        gMaxDate: Date;

    local procedure ItemNoC1100509000OnFormat()
    begin
        "Item No.Emphasize" := false;
        if "Internal Comment" = '1' then
            "Item No.Emphasize" := true;
    end;

    local procedure DescriptionOnFormat()
    begin
        DescriptionEmphasize := false;
        if "Entry Type" = "Entry Type"::Total then
            DescriptionEmphasize := true;

        if "Internal Comment" = '1' then;
    end;

    local procedure SalespersonOnFormat()
    begin
        SalesPersonStyle := false;
        if "Internal Comment" = '1' then
            SalesPersonStyle := true;
    end;

    local procedure CustomerOnFormat()
    begin
        CustomerStyle := false;
        if "Internal Comment" = '1' then
            CustomerStyle := true;
    end;

    local procedure UnitofMeasureC1100509006OnForm()
    begin
        UOMStyle := false;
        if "Internal Comment" = '1' then
            UOMStyle := true;
    end;

    local procedure SalesDateOnFormat()
    begin
        DateStyle := false;
        if "Internal Comment" = '1' then
            DateStyle := true;
    end;

    local procedure PurchaseDateOnFormat()
    begin
        ShipStyle := false;
        if "Internal Comment" = '1' then
            ShipStyle := true;
    end;

    local procedure PrognosisLastDateModifiedOnFor()
    begin
        LastStyle := false;
        if "Internal Comment" = '1' then
            LastStyle := true;

    end;

    local procedure PrognosesOnFormat()
    begin
        ProgStyle := false;
        if "Internal Comment" = '1' then
            ProgStyle := true;
    end;

    local procedure gOrigProgOnFormat()
    begin

        if gOrigProg then;

    end;

    procedure GetDateFilter(pMinDate: Date; pMaxDate: Date)
    begin
        gDate := pMinDate;
        gMaxDate := pMaxDate;
    end;
}

