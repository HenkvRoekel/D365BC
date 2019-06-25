page 50029 "Varieties List"
{

    Caption = 'Varieties List';
    CardPageID = "Varieties Card";
    Editable = false;
    PageType = List;
    SourceTable = Varieties;

    layout
    {
        area(content)
        {
            repeater(List)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Promo Status"; "Promo Status")
                {
                    ApplicationArea = All;
                }
                field("Promo Status Description"; "Promo Status Description")
                {
                    ApplicationArea = All;
                }
                field(VarietyBlockDescription; lcuBlockingMgt.VarietyBlockDescription(Rec))
                {
                    Caption = 'Blocking Code';
                    ApplicationArea = All;
                }
                field(Organic; Organic)
                {
                    ApplicationArea = All;
                }
                field(Comment; Comment)
                {
                    ApplicationArea = All;
                }
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
                field("Sowing Ratio Current"; "Sowing Ratio Current")
                {
                    ApplicationArea = All;
                }
                field("Sowing Ratio In Future"; "Sowing Ratio In Future")
                {
                    ApplicationArea = All;
                }
                field("Dutch description"; "Dutch description")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Bejo)
            {
                Caption = 'Bejo';
                action("Stock Information")
                {
                    Caption = 'Stock Information';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 50018;
                    RunPageOnRec = true;
                    RunPageView = SORTING ("No.");
                    ApplicationArea = All;
                }
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
                action("Import Blocking & Promostatus")
                {
                    Caption = 'Import Blocking & Promostatus';
                    Image = ImportCodes;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Report 50006;
                    ApplicationArea = All;
                }
                action("Import Remarks")
                {
                    Caption = 'Import Remarks';
                    Image = ImportLog;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Report 50035;
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
        lcuBlockingMgt: Codeunit "Blocking Management";

}