table 50014 "Year Prognoses"
{

    Caption = 'Year Prognoses';
    DrillDownPageID = "Year Prognoses List";
    LookupPageID = "Year Prognoses List";

    fields
    {
        field(1; "Internal Entry No."; Integer)
        {
            Caption = 'Internal Entry No.';
        }
        field(3; Variety; Code[20])
        {
            Caption = 'Variety';
            TableRelation = Varieties;
        }
        field(4; Date; Date)
        {
            Caption = 'Date';
            ClosingDates = true;
        }
        field(6; Country; Code[10])
        {
            Caption = 'Country';
            TableRelation = "Country/Region".Code;
        }
        field(11; "User-ID"; Code[20])
        {
            Caption = 'User-ID';
            Description = 'BEJOWW5.01.011';
            TableRelation = "User Setup";
        }
        field(30; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Normal,Total,Prognose,Allocation,Temporary Allocation';
            OptionMembers = Normal,Total,Prognose,Allocation,"Temporary Allocation";
        }
        field(50; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(51; "Variety Filter"; Code[10])
        {
            Caption = 'Variety Filter';
            FieldClass = FlowFilter;
        }
        field(54; "Country Filter"; Code[10])
        {
            Caption = 'Country Filter';
            FieldClass = FlowFilter;
            TableRelation = "Country/Region";
        }
        field(55; "Type Filter"; Option)
        {
            Caption = 'Type Filter';
            FieldClass = FlowFilter;
            OptionCaption = 'Normal,Total';
            OptionMembers = Normal,Total;
        }
        field(101; Exported; Boolean)
        {
            Caption = 'Exported';
        }
        field(102; "Date Exported"; Date)
        {
            Caption = 'Date Exported';
        }
        field(118; "Modification date"; Date)
        {
            Caption = 'Modification date';
        }
        field(201; "Quantity(period)"; Decimal)
        {
            Caption = 'Quantity(period)';
        }
        field(230; Begindate; Date)
        {
            Caption = 'Begin Date';
        }
    }

    keys
    {
        key(Key1; "Internal Entry No.")
        {
        }
        key(Key2; Variety, Date, Country)
        {
            SumIndexFields = "Quantity(period)";
        }
        key(Key3; Country)
        {
        }
        key(Key4; Variety, Country, Date)
        {
            SumIndexFields = "Quantity(period)";
        }
        key(Key5; Date)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "User-ID" := UserId;
        Type := Type::Prognose;
        Date := CalcDate('<+8M>', Date);
        Begindate := Date;
        "User-ID" := UserId;
        "Modification date" := Today;
        if grecBejoSetup.Get then
            Country := grecBejoSetup."Country Code";
    end;

    trigger OnModify()
    begin
        "User-ID" := UserId;
        "Modification date" := Today;
    end;

    var
        grecBejoSetup: Record "Bejo Setup";
}

