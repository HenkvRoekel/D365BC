tableextension 90091 UserSetupBTExt extends "User Setup"
{

    fields
    {
        field(50000; "B Initials"; Code[10])
        {
            Caption = 'Initials';

            TableRelation = "Salesperson/Purchaser".Code WHERE (Code = FIELD ("B Initials"));
        }
        field(50002; "B Department"; Code[10])
        {
            Caption = 'Department';

        }
        field(50003; "B Allow Block Prognosis"; Boolean)
        {
            Caption = 'Allow Block Prognosis from Salesperson';

        }
        field(50004; "B Allow Marking Progn Handled"; Boolean)
        {
            Caption = 'Allow Marking Progn as Handled';

        }
        field(50005; "B Allow Modify Sales Alloc.Exc"; Boolean)
        {
            Caption = 'Allow Modify Sales Alloc.Exceeded';

        }
    }
}

