page 50086 "Prognoses List"
{

    Caption = 'Prognoses List';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Prognosis/Allocation Entry";
    SourceTableView = WHERE ("Entry Type" = FILTER (Prognoses));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Item No."; "Item No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("grecItem.Description"; grecItem.Description)
                {
                    Caption = 'Description';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("grecItem.""Description 2"""; grecItem."Description 2")
                {
                    Caption = 'Description 2';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Customer; Customer)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Salesperson; Salesperson)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Unit of Measure"; "Unit of Measure")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Sales Date"; "Sales Date")
                {
                    Caption = 'Sales Date';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Purchase Date"; "Purchase Date")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        PurchaseDateOnAfterValidate;
                    end;
                }
                field("Export/Import Date"; "Export/Import Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("User-ID"; "User-ID")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Date Modified"; "Date Modified")
                {
                    Caption = 'Prognosis Last Date Modified';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Prognoses; Prognoses)
                {
                    BlankZero = true;
                    DecimalPlaces = 4 : 4;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        PrognosesOnAfterValidate;
                    end;
                }
                field("Entry Type"; "Entry Type")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field(orgprognose; gOrgPrognose)
                {
                    BlankZero = true;
                    Caption = 'Internal Initial Prognosis';
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("BZ Original Prognoses"; "BZ Original Prognoses")
                {
                    ApplicationArea = All;
                }
                field("Prognosis Remark"; "Prognosis Remark")
                {
                    Caption = 'Prognosis Remark';
                    ApplicationArea = All;
                }
                field(Adjusted; Adjusted)
                {
                    Editable = false;
                    Visible = false;
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
    }

    trigger OnAfterGetRecord()
    var
        lcuBejoMgmt: Codeunit "Bejo Management";
        lrecProgAllocEntry: Record "Prognosis/Allocation Entry";
    begin


        gOrgPrognose := false;
        if "Internal Entry No." > 3000000 then begin
            Clear(lrecProgAllocEntry);
            lrecProgAllocEntry.SetRange("Item No.", "Item No.");
            lrecProgAllocEntry.SetRange("Sales Date", "Sales Date");
            lrecProgAllocEntry.SetRange("Unit of Measure", "Unit of Measure");
            lcuBejoMgmt.FindBestAllocationEntry(lrecProgAllocEntry, Salesperson, Customer);
            if lrecProgAllocEntry."Internal Entry No." = "Internal Entry No." then
                gOrgPrognose := true
        end;


        if not grecItem.Get("Item No.") then
            grecItem.Init;
        gOrgPrognoseOnFormat;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

        grecProgAllocEntry.FindFirst;
        "Entry No." := grecProgAllocEntry."Entry No.";
        "Sales Date" := Today;
        "Entry No." := grecProgAllocEntry."Entry No." + 1;

        "Entry Type" := grecProgAllocEntry."Entry Type";
    end;

    var
        grecProgAllocEntry: Record "Prognosis/Allocation Entry";
        gOrgPrognose: Boolean;
        grecItem: Record Item;

    local procedure PurchaseDateOnAfterValidate()
    begin
        CurrPage.Update;
    end;

    local procedure PrognosesOnAfterValidate()
    begin

        CurrPage.Update;

    end;

    local procedure gOrgPrognoseOnFormat()
    begin
        if gOrgPrognose = true then;
    end;
}

