table 50018 "Prognosis/Allocation Entry"
{


    Caption = 'Prognosis/Allocation Entry';
    DrillDownPageID = "Prognoses List";
    LookupPageID = "Prognoses List";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(3; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;
        }
        field(4; "Sales Date"; Date)
        {
            Caption = 'Sales Date';
            ClosingDates = true;

            trigger OnValidate()
            var
                lReversedSDBZLeadTime: DateFormula;
                lrecPrognosesAllocEntry: Record "Prognosis/Allocation Entry";
            begin

                if not grecItem.Get("Item No.") then
                    grecItem.Init;

                if (xRec.Prognoses = Prognoses) and ("Purchase Date" = 0D) then begin
                    lrecPrognosesAllocEntry.SetRange("Entry Type", "Entry Type"::Prognoses);
                    lrecPrognosesAllocEntry.SetRange("Item No.", "Item No.");
                    lrecPrognosesAllocEntry.SetRange("Sales Date", "Sales Date");
                    lrecPrognosesAllocEntry.SetRange(Salesperson, Salesperson);
                    lrecPrognosesAllocEntry.SetRange(Customer, Customer);
                    lrecPrognosesAllocEntry.SetRange("Unit of Measure", "Unit of Measure");
                    lrecPrognosesAllocEntry.SetRange(Adjusted, false);
                    if lrecPrognosesAllocEntry.FindLast then
                        "Purchase Date" := lrecPrognosesAllocEntry."Purchase Date";
                end;

                if "Purchase Date" = 0D then begin
                    Evaluate(lReversedSDBZLeadTime, ReverseSign(Format(grecItem."B Purchase BZ Lead Time Calc")));
                    "Purchase Date" := CalcDate(lReversedSDBZLeadTime, "Sales Date");
                end;

            end;
        }
        field(9; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(11; "User-ID"; Code[20])
        {
            Caption = 'User-ID';
            TableRelation = "User Setup";

        }
        field(13; Salesperson; Code[10])
        {
            Caption = 'Salesperson';
            TableRelation = "Salesperson/Purchaser";
        }
        field(14; Customer; Code[20])
        {
            Caption = 'Customer';
            TableRelation = Customer;

            trigger OnValidate()
            begin

                TestField(Salesperson);

            end;
        }
        field(15; "Unit of Measure"; Code[10])
        {
            Caption = 'Unit of Measure';
            TableRelation = "Item Unit of Measure".Code WHERE ("Item No." = FIELD ("Item No."));
        }
        field(17; "Quantity in KG"; Boolean)
        {
            Caption = 'Quantity in KG';
        }
        field(18; "Internal Comment"; Text[1])
        {
            Caption = 'Internal Comment';
        }
        field(19; "External Comment"; Text[1])
        {
            Caption = 'External Comment';
        }
        field(30; "Entry Type"; Option)
        {
            Caption = 'Entry Type';
            Description = 'Option Normal,Total not in use BEJOWW5.0.006';
            OptionCaption = 'Normal,Total,Prognoses,Allocation';
            OptionMembers = Normal,Total,Prognoses,Allocation;
        }
        field(51; "In Sales Order"; Decimal)
        {
            CalcFormula = Sum ("Sales Line"."Outstanding Quantity" WHERE ("Document Type" = CONST (Order),
                                                                         Type = CONST (Item),
                                                                         "B Line type" = CONST (Normal),
                                                                         "No." = FIELD ("Item No.")));
            Caption = 'In Sales Order';
            Description = 'Flowfield';
            Editable = false;
            FieldClass = FlowField;
        }
        field(103; Variety; Code[5])
        {
            Caption = 'Variety';
        }
        field(118; "Date Modified"; Date)
        {
            Caption = 'Date Modified';
            Description = 'BEJOWW6.00.016';
        }
        field(120; "Last Date Modified"; Date)
        {
            CalcFormula = Max ("Prognosis/Allocation Entry"."Date Modified" WHERE ("Item No." = FIELD ("Item No."),
                                                                                  Salesperson = FIELD (Salesperson),
                                                                                  Customer = FIELD (Customer)));
            Caption = 'Last Date Modified';
            Description = 'Flowfield BEJOWW6.00.016';
            FieldClass = FlowField;
        }
        field(200; "Internal Entry No."; Integer)
        {
            Caption = 'Internal Entry No.';
        }
        field(201; Prognoses; Decimal)
        {
            Caption = 'Prognoses';

            trigger OnValidate()
            var
                lrecPrognosesAllocEntry: Record "Prognosis/Allocation Entry";
            begin

                TestField(Adjusted, false);
                TestField(Blocked, false);
                if Prognoses <> xRec.Prognoses then begin
                    if Prognoses < 0 then
                        FieldError(Prognoses);
                    if xRec.Prognoses < 0 then
                        Error(text50001, xRec.Prognoses);
                    ChangeShipDatePrognQty;
                    Prognoses := xRec.Prognoses;
                    Adjusted := true;
                end;

            end;
        }
        field(210; "Date filter"; Date)
        {
            Caption = 'Date Filter';
            Description = 'Flowfilter';
            FieldClass = FlowFilter;
        }
        field(211; Allocated; Decimal)
        {
            Caption = 'Allocated';
            Description = '(from bejo NL= same as field 218)';
        }
        field(219; "Allocated Cust. Sales person"; Decimal)
        {
            Caption = 'Allocated Customer Sales Person';

            trigger OnValidate()
            var
                restant: Decimal;
                lrecItem: Record Item;
            begin

                if lrecItem.Get("Item No.") then
                    if lrecItem.Blocked then begin
                        Message(text50000, "Item No.");
                        "Allocated Cust. Sales person" := xRec."Allocated Cust. Sales person";
                    end;


                TestField(Salesperson);

                GetBejoSetup;

                lrecItem.Reset;
                lrecItem.SetRange("No.", "Item No.");
                lrecItem.SetRange("Date Filter", grecBejoSetup."Begin Date", grecBejoSetup."End Date");
                lrecItem.CalcFields("B Country allocated", "B Allocated", "B To be allocated", "B Country allocated", "B Salesperson/cust. allocated");

                restant := lrecItem."B Country allocated" - lrecItem."B Allocated" - "Allocated Cust. Sales person" +
                  xRec."Allocated Cust. Sales person";

                if xRec."Internal Entry No." <> "Internal Entry No." then
                    xRec."Allocated Cust. Sales person" := 0;

                if restant < 0 then begin

                    if "Allocated Cust. Sales person" > 0 then begin
                        Error(text50001, lrecItem."B Country allocated" - lrecItem."B Allocated");
                        "Allocated Cust. Sales person" := xRec."Allocated Cust. Sales person"
                    end;

                end;


                SendMailAtAllocating(Rec, xRec, restant, lrecItem);

            end;
        }
        field(221; "Customer Allocation"; Decimal)
        {
            CalcFormula = Sum ("Prognosis/Allocation Entry"."Allocated Cust. Sales person" WHERE ("Entry Type" = CONST (Allocation),
                                                                                                 "Item No." = FIELD ("Item No."),
                                                                                                 Customer = FIELD (Customer),
                                                                                                 "Sales Date" = FIELD ("Sales Date")));
            Caption = 'Customer allocation';
            Description = 'Flowfield';
            Editable = false;
            FieldClass = FlowField;
        }
        field(222; "Salesperson Allocation"; Decimal)
        {
            CalcFormula = Sum ("Prognosis/Allocation Entry"."Allocated Cust. Sales person" WHERE ("Entry Type" = CONST (Allocation),
                                                                                                 "Item No." = FIELD ("Item No."),
                                                                                                 Salesperson = FIELD (Salesperson),
                                                                                                 Customer = FIELD (Customer),
                                                                                                 "Sales Date" = FIELD ("Date filter")));
            Caption = 'Salesperson allocation';
            Description = 'Flowfield';
            Editable = false;
            FieldClass = FlowField;
        }
        field(224; "Variety Salesperson Allocation"; Decimal)
        {
            CalcFormula = Sum ("Prognosis/Allocation Entry"."Allocated Cust. Sales person" WHERE ("Entry Type" = CONST (Allocation),
                                                                                                 Variety = FIELD (Variety),
                                                                                                 Salesperson = FIELD (Salesperson),
                                                                                                 Customer = FIELD (Customer),
                                                                                                 "Sales Date" = FIELD ("Date filter")));
            Caption = 'Variety Salesperson Allocation';
            Description = 'Flowfield BEJOWW6.00.016';
            FieldClass = FlowField;
        }
        field(230; "Begin Date"; Date)
        {
            Caption = 'Begin Date';
        }
        field(50010; "Prognosis Remark"; Text[50])
        {
            Caption = 'Remark';
            Description = 'BEJOWW6.00.014';
        }
        field(50011; "Handled Last Modified Date"; Date)
        {
            Caption = 'Handled Last Modified Date';
            Description = 'BEJOWW6.00.014';
        }
        field(50012; "Handled Remark"; Text[50])
        {
            Caption = 'Handled Remark';
            Description = 'BEJOWW6.00.014';
        }
        field(50022; Allocation; Decimal)
        {
            CalcFormula = Sum ("Prognosis/Allocation Entry".Allocated WHERE ("Item No." = FIELD ("Item No."),
                                                                            "Sales Date" = FIELD ("Date filter"),
                                                                            "Internal Entry No." = FIELD ("Internal Entry No. filter")));
            Caption = 'Allocation';
            Description = 'BEJOWW5.01.010';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50024; "Internal Entry No. filter"; Integer)
        {
            Caption = 'Internal Entry No. filter';
            Description = 'BEJOWW5.01.010, Flowfilter';
            FieldClass = FlowFilter;
        }
        field(50100; "Secundary Allocation"; Boolean)
        {
            Caption = 'Secundary Allocation';
            Description = 'BEJOWW6.00.014';
        }
        field(50201; Exported; Boolean)
        {
            Caption = 'Exported';
        }
        field(50202; "Export/Import Date"; Date)
        {
            Caption = 'Export/Import Date';
        }
        field(50203; Blocked; Boolean)
        {
            Caption = 'Blocked';
            Description = 'BEJOWW5.01.007';
        }
        field(50204; Handled; Boolean)
        {
            Caption = 'Handled';
            Description = 'BEJOWW5.01.007';

            trigger OnValidate()
            begin

                "Handled Last Modified Date" := Today;

            end;
        }
        field(50205; "Purchase Date"; Date)
        {
            Caption = 'Purchase Date';
            Description = 'BEJOWW5.01.010';

            trigger OnValidate()
            begin

                TestField(Adjusted, false);
                TestField(Blocked, false);

                if "Purchase Date" <> xRec."Purchase Date" then begin
                    if Prognoses < 0 then
                        FieldError(Prognoses);
                    ChangeShipDatePrognQty;
                    "Purchase Date" := xRec."Purchase Date";

                    Adjusted := true;

                end;

            end;
        }
        field(50206; "Is Import from Bejo"; Boolean)
        {
            Caption = 'Is Import from Bejo';
            Description = 'BEJOWW5.01.010';
        }
        field(50207; Adjusted; Boolean)
        {
            Caption = 'Adjusted';
            Description = 'BEJOWW5.01.012';
        }
        field(50208; "BZ Original Prognoses"; Boolean)
        {
            Caption = 'BZ Original Prognoses';
            Description = 'BEJOWW5.01.012';
            Editable = false;
        }
        field(50209; "Filter Text"; Text[50])
        {
            Caption = 'Filter text';
            Description = 'BEJOW18.00.016';
        }
    }

    keys
    {
        key(Key1; "Internal Entry No.")
        {
        }
        key(Key2; "Item No.", "Entry No.")
        {
        }
        key(Key3; "Entry No.")
        {
        }
        key(Key4; "Entry Type", "Item No.", "Sales Date")
        {
            SumIndexFields = Prognoses;
        }
        key(Key5; "Entry Type", "Item No.", "Unit of Measure", "Sales Date", Salesperson, Exported, Customer)
        {
            SumIndexFields = Prognoses, Allocated, "Allocated Cust. Sales person";
        }
        key(Key6; "Entry Type", Variety, "Unit of Measure", "Sales Date", Salesperson, Customer)
        {
            SumIndexFields = Prognoses, Allocated, "Allocated Cust. Sales person";
        }
        key(Key7; "Entry Type", "Item No.", "Unit of Measure", "Sales Date", Salesperson, Customer)
        {
        }
        key(Key8; "Entry Type", "Item No.", "Sales Date", Salesperson, Customer, "Unit of Measure")
        {
            SumIndexFields = Prognoses, Allocated, "Allocated Cust. Sales person";
        }
        key(Key9; "Entry Type", "Item No.", "Sales Date", "Unit of Measure", Salesperson)
        {
            SumIndexFields = Prognoses, Allocated, "Allocated Cust. Sales person";
        }
        key(Key10; "Entry Type", Exported, "Sales Date")
        {
        }
        key(Key11; "Entry Type", "Item No.", Salesperson, Customer, "Unit of Measure", "Sales Date", "Purchase Date", Adjusted, Blocked, Handled)
        {
            SumIndexFields = Prognoses, Allocated, "Allocated Cust. Sales person";
        }
        key(Key12; "Item No.", "Unit of Measure", Salesperson, "Sales Date")
        {
            SumIndexFields = Prognoses, Allocated, "Allocated Cust. Sales person";
        }
        key(Key13; "Item No.", Customer, Salesperson)
        {
            SumIndexFields = Prognoses, Allocated, "Allocated Cust. Sales person";
        }
        key(Key14; "Entry Type", "Item No.", "Unit of Measure", "Purchase Date", Exported, Salesperson, Customer, "Sales Date")
        {
            SumIndexFields = Prognoses, Allocated, "Allocated Cust. Sales person";
        }
        key(Key15; "Entry Type", Salesperson, "Date Modified", Customer, "Item No.")
        {
        }
        key(Key16; "Item No.", "Purchase Date", "Unit of Measure")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin

        GetBejoSetup;

        "Allocated Cust. Sales person" := 0;

    end;

    trigger OnInsert()
    var
        lrecPrognosisAllocationEntry: Record "Prognosis/Allocation Entry";
    begin

        if not ("Is Import from Bejo") then "User-ID" := UserId;

        if grecItem2.Get("Item No.") then;
        if Prognoses <> 0 then
            "Entry Type" := "Entry Type"::Prognoses;

        Variety := CopyStr("Item No.", 1, 5);

        if not ("Is Import from Bejo") then begin
            if grecItem2.Blocked then
                Error(text50000, "Item No.");
        end;

        if not ("Is Import from Bejo") then begin
            if "Date Modified" <> Today then
                "Date Modified" := Today;
        end;

        if "Is Import from Bejo" then "Export/Import Date" := Today;

        TestField("Sales Date");


        if "Internal Entry No." = 0 then begin
            Clear(grecPrognosisAllocationEntry);
            if not grecPrognosisAllocationEntry.Find('+') then;
            "Internal Entry No." := grecPrognosisAllocationEntry."Internal Entry No." + 1;
            if "Entry No." = 0 then
                "Entry No." := "Internal Entry No.";
        end;

        if "Entry Type" = "Entry Type"::Allocation then begin
            FilterSalespersCustAllocation(lrecPrognosisAllocationEntry);
            "Secundary Allocation" := not lrecPrognosisAllocationEntry.IsEmpty;
        end;

    end;

    trigger OnModify()
    begin

        "Date Modified" := Today;

    end;

    var
        grecItem2: Record Item;
        grecPrognosisAllocationEntry: Record "Prognosis/Allocation Entry";
        text50000: Label 'Item %1 is blocked.';
        grecItem: Record Item;
        grecBejoSetup: Record "Bejo Setup";
        text50001: Label 'There is only %1 left.';
        gHasBejoSetup: Boolean;
        text50002: Label 'This will result in a net change of %1. Continue?';
        text50003: Label 'Click OK or press Enter and then ''Esc'', to Continue. ';
        text50004: Label 'Net prognosis quantity is too low, to allow Shipment Date BZ to be changed for this record. ';

    local procedure ChangeShipDatePrognQty()
    var
        lrecPrognosisAllocation: Record "Prognosis/Allocation Entry";
        lrecPrognosisAllocationMod: Record "Prognosis/Allocation Entry";
        lLineNo: Integer;
        lrecItemUnit: Record "Item/Unit";
        lQtyToUse: Decimal;
        lDifferent: Boolean;
    begin

        lQtyToUse := 0;
        lrecItemUnit.SetRange("Item No.", "Item No.");
        lrecItemUnit.SetRange("Unit of Measure", "Unit of Measure");
        lrecItemUnit.SetRange("Date Filter", xRec."Purchase Date");
        lrecItemUnit.SetRange("Sales Person Filter", Salesperson);
        lrecItemUnit.SetRange("Customer Filter", Customer);
        lrecItemUnit.SetRange("Date Filter Previous Year", "Sales Date");
        if lrecItemUnit.FindFirst then begin
            lrecItemUnit.CalcFields("Prognoses to Order");
            lQtyToUse += lrecItemUnit."Prognoses to Order";
        end;
        if xRec.Prognoses <> Prognoses then begin
            if xRec.Prognoses > 0 then
                if not Confirm(text50002, false, Format(Prognoses - lQtyToUse)) then
                    Error(text50003);
        end
        else
            if lQtyToUse < Prognoses then
                Error(text50004)
            else lQtyToUse := Prognoses;


        lrecPrognosisAllocation.Init;
        lrecPrognosisAllocation.FindLast;
        lLineNo := lrecPrognosisAllocation."Internal Entry No.";

        lrecPrognosisAllocation := xRec;
        lrecPrognosisAllocation."Internal Entry No." := lLineNo + 1;

        lrecPrognosisAllocation.Prognoses := -lQtyToUse;

        lrecPrognosisAllocation."User-ID" := UserId;
        lrecPrognosisAllocation."Date Modified" := Today;

        lrecPrognosisAllocation."Export/Import Date" := 0D;
        lrecPrognosisAllocation.Exported := false;
        lrecPrognosisAllocation.Adjusted := true;

        lrecPrognosisAllocation.Insert;


        if Prognoses <> 0 then begin

            lrecPrognosisAllocationMod := Rec;
            lrecPrognosisAllocationMod."Internal Entry No." := lLineNo + 2;
            lrecPrognosisAllocationMod."User-ID" := UserId;
            lrecPrognosisAllocationMod."Date Modified" := Today;

            lrecPrognosisAllocationMod."Export/Import Date" := 0D;
            lrecPrognosisAllocationMod.Exported := false;

            lrecPrognosisAllocationMod.Insert;

        end;


        if lrecItemUnit.FindFirst then
            lrecItemUnit.CalcFields("Prognoses to Order");
        if (xRec.Prognoses <> Prognoses) or (lrecItemUnit."Prognoses to Order" = 0) then begin
            Clear(lrecPrognosisAllocation);
            lrecPrognosisAllocation.SetRange("Item No.", "Item No.");
            lrecPrognosisAllocation.SetRange("Unit of Measure", "Unit of Measure");
            lrecPrognosisAllocation.SetRange("Purchase Date", xRec."Purchase Date");
            lrecPrognosisAllocation.SetRange("Sales Date", "Sales Date");
            lrecPrognosisAllocation.SetRange(Salesperson, Salesperson);
            lrecPrognosisAllocation.SetRange(Customer, Customer);
            lrecPrognosisAllocation.SetFilter("Internal Entry No.", '<>%1&<>%2', lrecPrognosisAllocationMod."Internal Entry No.",
                                              "Internal Entry No.");
            if lrecPrognosisAllocation.FindSet then;
            lrecPrognosisAllocation.ModifyAll(Adjusted, true);
        end;

    end;

    local procedure GetBejoSetup()
    begin

        if not gHasBejoSetup then begin
            grecBejoSetup.Get;
            gHasBejoSetup := true;
        end;

    end;

    procedure ReverseSign(DateFormulaExpr: Text[30]): Text[30]
    var
        NewDateFormulaExpr: Text[30];
    begin

        NewDateFormulaExpr := ConvertStr(DateFormulaExpr, '+-', '-+');
        if not (DateFormulaExpr[1] in ['+', '-']) then
            NewDateFormulaExpr := '-' + NewDateFormulaExpr;
        if NewDateFormulaExpr = '-' then
            NewDateFormulaExpr := '';
        exit(NewDateFormulaExpr);

    end;

    procedure FilterSalespersCustAllocation(var lrecPrognosisAllocationEntry: Record "Prognosis/Allocation Entry"): Decimal
    begin

        lrecPrognosisAllocationEntry.Reset;
        lrecPrognosisAllocationEntry.SetCurrentKey("Entry Type", "Item No.", "Unit of Measure", "Sales Date", Salesperson);
        lrecPrognosisAllocationEntry.SetRange("Entry Type", "Entry Type"::Allocation);
        lrecPrognosisAllocationEntry.SetRange("Item No.", "Item No.");
        lrecPrognosisAllocationEntry.SetRange("Sales Date", "Begin Date", "Sales Date");
        lrecPrognosisAllocationEntry.SetRange(Customer, Customer);
        lrecPrognosisAllocationEntry.SetRange(Salesperson, Salesperson);

    end;

    procedure FilterSalespersCustVarAlloc(var lrecPrognosisAllocationEntry: Record "Prognosis/Allocation Entry"): Decimal
    begin

        lrecPrognosisAllocationEntry.Reset;
        lrecPrognosisAllocationEntry.SetCurrentKey("Entry Type", "Item No.", "Unit of Measure", "Sales Date", Salesperson);
        lrecPrognosisAllocationEntry.SetRange("Entry Type", "Entry Type"::Allocation);
        lrecPrognosisAllocationEntry.SetRange(Variety, Variety);
        lrecPrognosisAllocationEntry.SetRange("Sales Date", "Begin Date", "Sales Date");
        lrecPrognosisAllocationEntry.SetRange(Customer, Customer);
        lrecPrognosisAllocationEntry.SetRange(Salesperson, Salesperson);

    end;

    [BusinessEvent(false)]
    local procedure SendMailAtAllocating(Rec: Record "Prognosis/Allocation Entry"; xRec: Record "Prognosis/Allocation Entry"; Leftover: Decimal; Item: Record Item)
    begin
    end;
}

