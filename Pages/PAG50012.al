page 50012 "Promo Status Setup"
{


    Caption = 'Promo Status List';
    Editable = false;
    PageType = List;
    SourceTable = "Promo Status";

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

