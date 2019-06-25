page 50110 "Sales Actions Referrer"
{

    Caption = 'Sales Actions Referrer';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    LinksAllowed = false;
    ModifyAllowed = false;
    ShowFilter = false;
    SourceTable = "Sales Header";

    layout
    {
        area(content)
        {
            group("Sales Header ")
            {
                Caption = 'Sales Header';
            }
            field("Document Type"; "Document Type")
            {
                ApplicationArea = All;
            }
            field("No."; "No.")
            {
                ApplicationArea = All;
            }
            field("Sell-to Customer No."; "Sell-to Customer No.")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        CurrPage.Close;
    end;

    trigger OnOpenPage()
    var
        lPage_ActionID: Text[30];
        lcuBTAOEvents: Codeunit "Bejo Trade Add-On Events";
    begin
        Rec.SetRange("Document Type", "Document Type");
        Rec.SetRange("No.", "No.");

        lPage_ActionID := GetFilter(Rec."B Page_Action ID");

        if (lPage_ActionID <> '') then begin
            Rec.SetRange("B Page_Action ID");

            case lPage_ActionID of
                'P42_50057':
                    lcuBTAOEvents.P42_OnAfterAction_50057(Rec);
                'P42_50069':
                    lcuBTAOEvents.P42_OnAfterAction_50069(Rec);
                'P42_50071':
                    lcuBTAOEvents.P42_OnAfterAction_50071(Rec);
                'P42_50085':
                    lcuBTAOEvents.P42_OnAfterAction_50085(Rec);
                'P42_50088':
                    lcuBTAOEvents.P42_OnAfterAction_50088(Rec);
                'P42_50090':
                    lcuBTAOEvents.P42_OnAfterAction_50090(Rec);
                'P42_50091':
                    lcuBTAOEvents.P42_OnAfterAction_50091(Rec);
                'P42_50093':
                    lcuBTAOEvents.P42_OnAfterAction_50093(Rec);
                'P42_50096':
                    lcuBTAOEvents.P42_OnAfterAction_50096(Rec);

                'P44_50025':
                    lcuBTAOEvents.P44_OnAfterAction_50025(Rec);
                else

                    Message('Page Action ID not processed' + lPage_ActionID);
            end;
        end else
            Message('No Page Action ID supplied');
    end;
}

