page 50094 "Allocation List"
{
    Caption = 'Allocation List';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Prognosis/Allocation Entry";
    SourceTableView = SORTING ("Entry Type", "Item No.", "Unit of Measure", "Sales Date", Salesperson, Customer)
                      WHERE ("Entry Type" = CONST (Allocation));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Item No."; "Item No.")
                {
                    ApplicationArea = All;
                }
                field(Salesperson; Salesperson)
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field(Customer; Customer)
                {
                    ApplicationArea = All;
                }
                field("Begin Date"; "Begin Date")
                {
                    Caption = 'Begin Date';
                    ApplicationArea = All;
                }
                field("Sales Date"; "Sales Date")
                {
                    ApplicationArea = All;
                }
                field("User-ID"; "User-ID")
                {
                    ApplicationArea = All;
                }
                field("Allocated Cust. Sales person"; "Allocated Cust. Sales person")
                {
                    BlankZero = true;
                    Caption = 'Allocation';
                    DecimalPlaces = 3 : 4;
                    ApplicationArea = All;
                }
                field(Allocated; Allocated)
                {
                    BlankZero = true;
                    Caption = 'Country Allocation';
                    DecimalPlaces = 3 : 4;
                    ApplicationArea = All;
                }
                field("Allocated Cust. Sales person2"; "Allocated Cust. Sales person")
                {
                    ApplicationArea = All;
                }
                field("Date Modified"; "Date Modified")
                {
                    ApplicationArea = All;
                }
                field("Export/Import Date"; "Export/Import Date")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("Rest to sell"; gRestToSell)
                {
                    AutoFormatType = 3;
                    DecimalPlaces = 3 : 4;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Prognosis Remark"; "Prognosis Remark")
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
        lInvoiced: Decimal;
        lItemLedgerEntry: Record "Item Ledger Entry";
        lItem: Record Item;
        lUnitofMeasure: Record "Unit of Measure";
    begin
        lInvoiced := 0;

        lItemLedgerEntry.Reset;
        if not lItemLedgerEntry.SetCurrentKey("Item No.", "Entry Type") then
            lItemLedgerEntry.SetCurrentKey(lItemLedgerEntry."Entry Type", lItemLedgerEntry."Item No.");
        lItemLedgerEntry.SetRange(lItemLedgerEntry."Entry Type", lItemLedgerEntry."Entry Type"::Sale);
        lItemLedgerEntry.SetRange("Posting Date", "Begin Date", "Sales Date");
        lItemLedgerEntry.SetRange(lItemLedgerEntry."Item No.", "Item No.");
        if Customer <> '' then
            lItemLedgerEntry.SetRange("Source No.", Customer);
        if Salesperson <> '' then
            lItemLedgerEntry.SetRange("B Salesperson", Salesperson);

        if lItemLedgerEntry.Find('-') then begin
            lItem.Get(lItemLedgerEntry."Item No.");
            repeat
                lInvoiced := lInvoiced + -lItemLedgerEntry."Invoiced Quantity";
            until lItemLedgerEntry.Next = 0;
        end;

        lItem.Get("Item No.");
        lUnitofMeasure.Get(lItem."Base Unit of Measure");

        if not lUnitofMeasure."B Unit in Weight" then
            lInvoiced := lInvoiced / 1000000;


        if Allocated <> 0 then
            gRestToSell := Allocated - lInvoiced - "In Sales Order"
        else
            gRestToSell := "Allocated Cust. Sales person" - lInvoiced - "In Sales Order";
        ItemNoOnFormat;
        SalespersonOnFormat;
        CustomerOnFormat;
        BeginDateOnFormat;
        SalesDateOnFormat;
        UserIDOnFormat;
        AllocatedCustSalespersonC10000;
        AllocatedOnFormat;
        PrognosisLastDateModifiedOnFor;
        gRestToSellOnFormat;
        PrognosisRemarkOnFormat;
    end;

    var
        gRestToSell: Decimal;
        [InDataSet]
        "Item No.Emphasize": Boolean;
        [InDataSet]
        SalespersonEmphasize: Boolean;
        [InDataSet]
        CustomerEmphasize: Boolean;
        [InDataSet]
        "Begin DateEmphasize": Boolean;
        [InDataSet]
        "Sales DateEmphasize": Boolean;
        [InDataSet]
        "User-IDEmphasize": Boolean;
        [InDataSet]
        AllocatedCustSalespersonEmphas: Boolean;
        [InDataSet]
        AllocatedEmphasize: Boolean;
        [InDataSet]
        PrognosisLastDateModifiedEmpha: Boolean;
        [InDataSet]
        "Rest to sellEmphasize": Boolean;
        [InDataSet]
        "Prognosis RemarkEmphasize": Boolean;

    local procedure ItemNoOnFormat()
    begin

        if Allocated <> 0 then
            "Item No.Emphasize" := true;
    end;

    local procedure SalespersonOnFormat()
    begin

        if Allocated <> 0 then
            SalespersonEmphasize := true;
    end;

    local procedure CustomerOnFormat()
    begin

        if Allocated <> 0 then
            CustomerEmphasize := true;
    end;

    local procedure BeginDateOnFormat()
    begin

        if Allocated <> 0 then
            "Begin DateEmphasize" := true;
    end;

    local procedure SalesDateOnFormat()
    begin

        if Allocated <> 0 then
            "Sales DateEmphasize" := true;
    end;

    local procedure UserIDOnFormat()
    begin

        if Allocated <> 0 then
            "User-IDEmphasize" := true;
    end;

    local procedure AllocatedCustSalespersonC10000()
    begin

        if Allocated <> 0 then
            AllocatedCustSalespersonEmphas := true;
    end;

    local procedure AllocatedOnFormat()
    begin

        if Allocated <> 0 then

            AllocatedEmphasize := true;
    end;

    local procedure PrognosisLastDateModifiedOnFor()
    begin

        if Allocated <> 0 then
            PrognosisLastDateModifiedEmpha := true;
    end;

    local procedure gRestToSellOnFormat()
    begin

        if Allocated <> 0 then
            "Rest to sellEmphasize" := true;
    end;

    local procedure PrognosisRemarkOnFormat()
    begin

        if Allocated <> 0 then
            "Prognosis RemarkEmphasize" := true;
    end;
}

