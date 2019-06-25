page 50011 "Block Code Setup"
{

    Caption = 'Block Code List';
    Editable = false;
    PageType = List;
    SourceTable = "Block Code";

    layout
    {
        area(content)
        {
            repeater(List)
            {
                field(Code; Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
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
        OnAfterGetCurrRecord1;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord1;
    end;

    trigger OnOpenPage()
    begin
        CurrPage.EDITABLE(NOT CurrPage.LOOKUPMODE AND (GETFILTERS = ''));
    end;

    local procedure OnAfterGetCurrRecord1()
    begin
        xRec := Rec;
        CurrPage.EDITABLE(NOT CurrPage.LOOKUPMODE AND (GETFILTERS = ''));
    end;
}

