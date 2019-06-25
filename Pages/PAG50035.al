page 50035 "Variety Price Classific. List"
{

    Caption = 'Variety Price Classification List';
    PageType = List;
    SourceTable = "Variety Price Classification";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Variety Price Group Code"; "Variety Price Group Code")
                {
                    ApplicationArea = All;
                }
                field("Sales Type"; "Sales Type")
                {
                    ApplicationArea = All;
                }
                field("Sales Code"; "Sales Code")
                {
                    ApplicationArea = All;
                }
                field("Variety No."; "Variety No.")
                {
                    ApplicationArea = All;
                }
                field("Variety Description"; "Variety Description")
                {
                    ApplicationArea = All;
                }
                field("Crop Code"; "Crop Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Functions")
            {
                Caption = '&Functions';
                action("Copy to &New record")
                {
                    Caption = 'Copy to &New record';
                    Image = Copy;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        fnCopyToNewRecord(Rec);
                    end;
                }
                action("Show Sales Prices")
                {
                    Caption = 'Show Sales Prices';
                    Image = SalesPrices;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        lrecSalesPrice: Record "Sales Price";
                        lrecVarietyPriceClass: Record "Variety Price Classification";
                        lVarietyFilter: Text[1020];
                        lformSalesPrice: Page "Sales Prices";
                    begin
                        lrecVarietyPriceClass.SetRange("Sales Type", "Sales Type");
                        lrecVarietyPriceClass.SetRange("Sales Code", "Sales Code");
                        lrecVarietyPriceClass.SetRange("Variety Price Group Code", "Variety Price Group Code");
                        if lrecVarietyPriceClass.FindFirst then
                            repeat

                                lVarietyFilter := lVarietyFilter + lrecVarietyPriceClass."Variety No." + '*|';
                            until lrecVarietyPriceClass.Next = 0;
                        lrecSalesPrice.SetRange("Sales Type", "Sales Type");
                        lrecSalesPrice.SetRange("Sales Code", "Sales Code");
                        lrecSalesPrice.SetFilter("Item No.", CopyStr(lVarietyFilter, 1, StrLen(lVarietyFilter) - 1));

                        if lrecSalesPrice.FindFirst then;

                        lformSalesPrice.SetTableView(lrecSalesPrice);
                        lformSalesPrice.RunModal;
                    end;
                }
            }
        }
    }

    procedure fnCopyToNewRecord(parVarietyPriceClass: Record "Variety Price Classification")
    var
        lrptCopyVarPriceClass: Report "Copy Variety Price Classificat";
        lrecVarietyPriceClass: Record "Variety Price Classification";
    begin
        lrecVarietyPriceClass.SetRange("Variety Price Group Code", parVarietyPriceClass."Variety Price Group Code");
        lrecVarietyPriceClass.SetRange("Sales Code", parVarietyPriceClass."Sales Code");
        lrptCopyVarPriceClass.SetTableView(lrecVarietyPriceClass);
        lrptCopyVarPriceClass.RunModal;
    end;
}

