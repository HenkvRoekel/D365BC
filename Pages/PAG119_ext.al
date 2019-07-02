pageextension 90119 UserSetupBTPageExt extends "User Setup"
{
    //Comment
    layout
    {
        addafter(Email)
        {
            field("B Allow Block Prognosis"; "B Allow Block Prognosis")
            {
                ApplicationArea = All;
            }
            field("B Allow Marking Progn Handled"; "B Allow Marking Progn Handled")
            {
                ApplicationArea = All;
            }
            field("B Allow Modify Sales Alloc.Exc"; "B Allow Modify Sales Alloc.Exc")
            {
                ApplicationArea = All;
            }
            field("B Initials"; "B Initials")
            {
                ApplicationArea = All;
            }
            field("B Department"; "B Department")
            {
                ApplicationArea = All;
            }
        }
    }
}

