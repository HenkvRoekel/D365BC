page 50111 "Purchase Actions Referrer"
{

    Caption = 'Purchase Actions Referrer';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    LinksAllowed = false;
    ModifyAllowed = false;
    ShowFilter = false;
    SourceTable = "Purchase Header";

    layout
    {
        area(content)
        {
            group("Purchase Header")
            {
                Caption = 'Purchase Header';
            }
            field("Document Type"; "Document Type")
            {
                ApplicationArea = All;
            }
            field("No."; "No.")
            {
                ApplicationArea = All;
            }
            field("Buy-from Vendor No."; "Buy-from Vendor No.")
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
                'P50_50035':
                    lcuBTAOEvents.P50_OnAfterAction_50035(Rec);
                'P50_50037':
                    lcuBTAOEvents.P50_OnAfterAction_50037(Rec);

                'P52_50023':
                    lcuBTAOEvents.P52_OnAfterAction_50023(Rec);
                'P52_50025':
                    lcuBTAOEvents.P52_OnAfterAction_50025(Rec);
                'P52_50027':
                    lcuBTAOEvents.P52_OnAfterAction_50027(Rec);
                'P52_50031':
                    lcuBTAOEvents.P52_OnAfterAction_50031(Rec);
                else

                    Message('Page Action ID not processed' + lPage_ActionID);
            end;
        end else
            Message('No Page Action ID supplied');
    end;
}

