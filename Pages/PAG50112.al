page 50112 "Item Jnl. Actions Referrer"
{

    Caption = 'Item Jnl. Actions Referrer';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    LinksAllowed = false;
    ModifyAllowed = false;
    ShowFilter = false;
    SourceTable = "Item Journal Line";

    layout
    {
        area(content)
        {
            group("Item Jnl. Line")
            {
                Caption = 'Item Jnl. Line';

            }
            field("Line No."; "Line No.")
            {
                ApplicationArea = All;
            }
            field("Item No."; "Item No.")
            {
                ApplicationArea = All;
            }
            field("Document No."; "Document No.")
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
        Rec.SetRange("Journal Template Name", Rec."Journal Template Name");
        Rec.SetRange("Journal Batch Name", Rec."Journal Batch Name");
        Rec.SetRange("Line No.", Rec."Line No.");

        lPage_ActionID := GetFilter(Rec."B Page_Action ID");

        if (lPage_ActionID <> '') then begin
            Rec.SetRange("B Page_Action ID");

            case lPage_ActionID of

                'P392_50007':
                    lcuBTAOEvents.P392_OnAfterAction_50007(Rec); // Create EOSS Stock Lines
                'P392_50011':
                    lcuBTAOEvents.P392_OnAfterAction_50011(Rec); // Export EOSS XML
                else

                    Message('Page Action ID not processed' + lPage_ActionID);
            end;
        end else
            Message('No Page Action ID supplied');
    end;
}

