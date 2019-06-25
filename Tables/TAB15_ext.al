tableextension 90015 GLAccountBTExt extends "G/L Account"
{

    fields
    {
        field(50010; "B Consolidation Line"; Code[5])
        {
            Caption = 'Consolidation Line';
        }
        field(50020; "B Consolidation Row"; Code[10])
        {
            Caption = 'Consolidation Row';
        }
        field(50030; "B Closing Entries Filter"; Boolean)
        {
            Caption = 'Closing Entries Filter';
            FieldClass = FlowFilter;
        }

        field(50040; "B Balance at Date"; Decimal)
        {
            Description = 'Balance at Date';
            FieldClass = FlowField;
            CalcFormula =
                Sum ("G/L Entry".Amount WHERE ("G/L Account No." = FIELD ("No."),
                                        "G/L Account No." = FIELD (FILTER (Totaling)),
                                        "Business Unit Code" = FIELD ("Business Unit Filter"),
                                        "Global Dimension 1 Code" = FIELD ("Global Dimension 1 Filter"),
                                        "Global Dimension 2 Code" = FIELD ("Global Dimension 2 Filter"),
                                        "Posting Date" = FIELD (UPPERLIMIT ("Date Filter")),
                                        "Dimension Set ID" = FIELD ("Dimension Set ID Filter"),
                                        "B Is Closing Entry" = FIELD ("B Closing Entries Filter")));

        }

        field(50050; "B Net Change"; Decimal)
        {
            Description = 'Net Change';
            FieldClass = FlowField;
            CalcFormula =
                Sum ("G/L Entry".Amount WHERE ("G/L Account No." = FIELD ("No."),
                                        "G/L Account No." = FIELD (FILTER (Totaling)),
                                        "Business Unit Code" = FIELD ("Business Unit Filter"),
                                        "Global Dimension 1 Code" = FIELD ("Global Dimension 1 Filter"),
                                        "Global Dimension 2 Code" = FIELD ("Global Dimension 2 Filter"),
                                        "Posting Date" = FIELD ("Date Filter"),
                                        "Dimension Set ID" = FIELD ("Dimension Set ID Filter"),
                                        "B Is Closing Entry" = FIELD ("B Closing Entries Filter")));

        }

    }
}

