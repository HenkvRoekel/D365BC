pageextension 80044 SalesCreditMemoBTPageExt extends "Sales Credit Memo"
{


    layout
    {
        addafter("Responsibility Center")
        {
            field("<B Customer Price Group>"; "Customer Price Group")
            {
                Visible = false;
                ApplicationArea = All;
            }
        }
        addafter("Area")
        {
            field("<Reason Code Bejo>"; "Reason Code")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addfirst(Navigation)
        {
            group("&Bejo")
            {
                Caption = '&Bejo';
                action("Proforma Credit Memo")
                {
                    Caption = 'Proforma Credit Memo';
                    Image = PrintVoucher;
                    RunObject = Page "Sales Actions Referrer";
                    RunPageLink = "B Page_Action ID" = CONST ('P44_50025');
                    RunPageOnRec = true;
                    ApplicationArea = All;
                }
            }
        }
    }
}

