page 50181 PJobExtended
{


    PageType = List;
    SourceTable = Job;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Job No."; "No.")
                {
                    Caption = 'Job No.';
                    ApplicationArea = All;
                }
                field("Profit Centre"; "Global Dimension 1 Code")
                {
                    Caption = 'Profit Centre';
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    Caption = 'Global Dimension 2 Code';
                    ApplicationArea = All;
                }
                field(Revenue; gDecRevenue)
                {
                    ApplicationArea = All;
                }
                field(Expenses; gDecExpense)
                {
                    ApplicationArea = All;
                }
                field(Direct; gDecDirectExpense)
                {
                    ApplicationArea = All;
                }
                field(Overhead; gDecOverheadExpense)
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
    begin
        gRecJobLedgerEntry.Reset;
        Clear(gDecExpense);
        Clear(gDecRevenue);
        Clear(gDecDirectExpense);
        Clear(gDecOverheadExpense);
        gRecBejoSetup.Get;

        gRecJobLedgerEntry.Reset;
        gRecJobLedgerEntry.SetCurrentKey("Job No.", "Job Task No.");
        gRecJobLedgerEntry.SetRange("Job No.", "No.");
        if (gRecBejoSetup."Direct Expense Start Task No." <> '') or (gRecBejoSetup."Direct Expense End Task No." <> '') then
            gRecJobLedgerEntry.SetFilter("Job Task No.", gRecBejoSetup."Direct Expense Start Task No." + '..' + gRecBejoSetup."Direct Expense End Task No.");
        gRecJobLedgerEntry.CalcSums("Total Cost (LCY)");

        gDecDirectExpense := gRecJobLedgerEntry."Total Cost (LCY)";

        gRecJobLedgerEntry.SetRange("Job Task No.");

        if (gRecBejoSetup."Overhead Expense Start TaskNo." <> '') or (gRecBejoSetup."Overhead Expense End Task No." <> '') then
            gRecJobLedgerEntry.SetFilter("Job Task No.", gRecBejoSetup."Overhead Expense Start TaskNo." + '..' + gRecBejoSetup."Overhead Expense End Task No.");
        gRecJobLedgerEntry.CalcSums("Total Cost (LCY)");

        gDecOverheadExpense := gRecJobLedgerEntry."Total Cost (LCY)";

        gRecJobLedgerEntry.Reset;
        gRecJobLedgerEntry.SetCurrentKey("Job No.", "Entry Type");
        gRecJobLedgerEntry.SetRange("Job No.", "No.");
        gRecJobLedgerEntry.SetRange("Entry Type", gRecJobLedgerEntry."Entry Type"::Usage, gRecJobLedgerEntry."Entry Type"::Sale);
        if gRecJobLedgerEntry.Find('-') then
            repeat
                gDecExpense += gRecJobLedgerEntry."Total Cost (LCY)";
                gDecRevenue += gRecJobLedgerEntry."Total Price (LCY)";
            until gRecJobLedgerEntry.Next = 0;
    end;

    var
        gDecRevenue: Decimal;
        gDecExpense: Decimal;
        gRecJobLedgerEntry: Record "Job Ledger Entry";
        gDecDirectExpense: Decimal;
        gDecOverheadExpense: Decimal;
        gRecBejoSetup: Record "Bejo Setup";
}

