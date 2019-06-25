page 50028 "Varieties Card"
{

    Caption = 'Varieties Card';
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = Varieties;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; "No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        lItem: Record Item;
                    begin

                        lItem.SETCURRENTKEY("B Variety");
                        lItem.SETRANGE("B Variety", "No.");
                        IF NOT lItem.FIND('-') THEN
                            ERROR(Text50000, "No.");

                    end;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Dutch description"; "Dutch description")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Promo Status Description"; "Promo Status Description")
                {
                    ApplicationArea = All;
                }
                field(VarietyBlockDescription; lcuBlockingMgt.VarietyBlockDescription(Rec))
                {
                    Caption = 'Blocking Code';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Comment; Comment)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Organic; Organic)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Crop Variant Code"; "Crop Variant Code")
                {
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        lcuBejoMngtEXT: Codeunit "Bejo Management";
                    begin

                        EXIT(lcuBejoMngtEXT.LookUpCrop(Text));

                    end;
                }
                field("Crop Variant Description"; "Crop Variant Description")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Crop Type Code"; "Crop Type Code")
                {
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        lcuBejoMngtEXT: Codeunit "Bejo Management";
                    begin

                        EXIT(lcuBejoMngtEXT.LookUpCropType("Crop Variant Code", Text));

                    end;
                }
                field("Crop Type Description"; "Crop Type Description")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Sowing Ratio Current"; "Sowing Ratio Current")
                {
                    ApplicationArea = All;
                }
                field("Sowing Ratio In Future"; "Sowing Ratio In Future")
                {
                    ApplicationArea = All;
                }
            }
            part(InternalPromoStatusEntries; 50092)
            {
                SubPageLink = "Variety Code" = FIELD ("No.");
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Variet&y")
            {
                Caption = 'Variet&y';
                action("Import Varieties")
                {
                    Caption = 'Import Varieties';
                    Image = Import;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Report 50008;
                    ApplicationArea = All;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 50091;
                    RunPageLink = "Table Name" = CONST (Item),
                                  "B Variety" = FIELD ("No."),
                                  "B Comment Type" = FILTER ("Var 5 pos" .. "Var 8 Pos");
                    ApplicationArea = All;
                }
            }
        }
    }

    var
        Text50000: Label 'There is no item with variety code %1, please insert first the new item.';
        lcuBlockingMgt: Codeunit "Blocking Management";
        grecMarketPotential: Record "Market Potential";
}

