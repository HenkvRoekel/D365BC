page 50037 "Year Prognoses FactBox"
{
    PageType = CardPart;
    SourceTable = Varieties;

    layout
    {
        area(content)
        {
            group("Variety Details")
            {
                Caption = 'Variety Details';
                field(No; "No.")
                {
                    Caption = 'No';
                    Editable = false;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("Search Description"; "Search Description")
                {
                    Editable = false;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("Dutch description"; "Dutch description")
                {
                    Editable = false;
                    Importance = Promoted;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field(Desc2; Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Promo Status"; "Promo Status" + ':' + "Promo Status Description")
                {
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field(VarietyBlockDescription; gcuBlockingMgt.VarietyBlockDescription(Rec))
                {
                    Caption = 'Blocking Code';
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Year Prognosis in"; "Year Prognosis in")
                {
                    Caption = 'Year Prognosis in';
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field(Organic; Organic)
                {
                    RowSpan = 1;
                    ApplicationArea = All;
                }
                field("Date to be discontinued"; "Date to be discontinued")
                {
                    ApplicationArea = All;
                }
            }
            group("Market Potential")
            {
                Caption = 'Market Potential';
                field("Crop Variant Code"; "Crop Variant Code")
                {
                    ApplicationArea = All;
                }
                field("Crop Variant Description"; "Crop Variant Description")
                {
                    ApplicationArea = All;
                }
                field("Crop Type Code"; "Crop Type Code")
                {
                    ApplicationArea = All;
                }
                field("Crop Type Description"; "Crop Type Description")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    var
        gcuBlockingMgt: Codeunit "Blocking Management";
}

