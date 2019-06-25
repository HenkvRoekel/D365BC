page 50113 "Lot No. Info. Actions Referrer"
{

    Caption = 'Lot No. Info. Actions Referrer';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    LinksAllowed = false;
    ModifyAllowed = false;
    ShowFilter = false;
    SourceTable = "Lot No. Information";

    layout
    {
        area(content)
        {
            group("Lot No. Information")
            {
                Caption = 'Lot No. Information';
            }
            field("Item No."; "Item No.")
            {
                ApplicationArea = All;
            }
            field("Variant Code"; "Variant Code")
            {
                ApplicationArea = All;
            }
            field("Lot No."; "Lot No.")
            {
                ApplicationArea = All;
            }
            field(Description; Description)
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
        Rec.SetRange("Item No.", Rec."Item No.");
        Rec.SetRange("Variant Code", Rec."Variant Code");
        Rec.SetRange("Lot No.", Rec."Lot No.");

        lPage_ActionID := GetFilter(Rec."B Page_Action ID");

        if (lPage_ActionID <> '') then begin
            Rec.SetRange("B Page_Action ID");

            case lPage_ActionID of
                'P6505_50055':
                    lcuBTAOEvents.P6505_OnAfterAction_50055(Rec);
                'P6505_50057':
                    lcuBTAOEvents.P6505_OnAfterAction_50057(Rec);

                else

                    Message('Page Action ID not processed' + lPage_ActionID);
            end;
        end else
            Message('No Page Action ID supplied');
    end;
}

