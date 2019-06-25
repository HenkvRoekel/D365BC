page 50062 "Warehouse orders"
{

    Caption = 'Warehouse Orders';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "Sales Header";
    SourceTableView = SORTING ("Shipment Date", "No.")
                      WHERE ("Document Type" = CONST (Order),
                            Status = FILTER (Open | Released),
                            "B OrderStatus" = FILTER ("3.Released" .. "4.Prepared"));

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Shipment Date"; "Shipment Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("No."; "No.")
                {
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        SalesHeaderPage: Page "Sales Order";
                    begin

                        SalesHeaderPage.SetRecord(Rec);
                        SalesHeaderPage.Run;

                    end;
                }
                field("Ship-to Code"; "Ship-to Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Ship-to Name"; "Ship-to Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("B Print Picking List"; "B Print Picking List")
                {
                    ApplicationArea = All;
                }
                field("B OrderStatus"; "B OrderStatus")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Status; Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Sell-to Customer No."; "Sell-to Customer No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Sell-to Customer Name"; "Sell-to Customer Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(gIntNoOfLines; gIntNoOfLines)
                {
                    Caption = 'No. of Lines';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(gDecWeight; gDecWeight)
                {
                    Caption = 'Weight';
                    DecimalPlaces = 3 : 3;
                    Editable = false;
                    ApplicationArea = All;
                }
                field("B Warehouse Remark"; "B Warehouse Remark")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Shipping Agent Code"; "Shipping Agent Code")
                {
                    ApplicationArea = All;
                }

                field("Package Tracking No."; "Package Tracking No.")
                {
                    ApplicationArea = All;
                }
                field("B Packing Description"; "B Packing Description")
                {
                    ApplicationArea = All;
                }
                field("B Gross weight"; "B Gross weight")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Bejo")
            {
                Caption = '&Bejo';

                action("Pick List")
                {
                    Caption = 'Pick List';
                    Image = PickWorksheet;
                    RunObject = Page "Sales Actions Referrer";
                    RunPageLink = "B Page_Action ID" = CONST ('P42_50069');
                    RunPageOnRec = true;
                    ApplicationArea = All;
                }
            }
        }
        area(processing)
        {
            action(Ready)
            {
                Caption = 'Ready';
                Image = ReleaseDoc;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                var
                    SalesPost: Codeunit "Sales-Post";
                begin

                    if "B OrderStatus" <> "B OrderStatus"::"4.Prepared" then
                        Error(Text50000, "No.");

                    if not Confirm(Text50001, false, "No.") then
                        exit;

                    Validate("B OrderStatus", "B OrderStatus"::"5.Ready Warehouse");
                    Validate("Posting Date", Today);


                    gRecBejoSetup.Get;

                    if gRecBejoSetup."Post Warehouse Orders" = true then begin
                        Ship := true;
                        Invoice := false;
                        SalesPost.Run(Rec);
                        Modify;
                    end;


                end;
            }
            action(Print)
            {
                Caption = 'Print';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                var
                    lSalesHeader: Record "Sales Header";
                    lSalesHeader1: Record "Sales Header";
                begin

                    lSalesHeader.Reset;
                    lSalesHeader.SetRange("B OrderStatus", "B OrderStatus"::"3.Released");
                    lSalesHeader.SetRange("B Print Picking List", true);
                    if lSalesHeader.Find('-') then
                        repeat
                            lSalesHeader1.SetRange("No.", lSalesHeader."No.");
                            REPORT.RunModal(50007, false, false, lSalesHeader1);
                        until lSalesHeader.Next = 0;

                end;
            }
            action(Prepared)
            {
                Caption = 'Prepared';
                Image = PickLines;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                var
                    SalesPost: Codeunit "Sales-Post";
                begin

                    if "B OrderStatus" <> "B OrderStatus"::"3.Released" then
                        Error(Text50002, "No.");

                    if not Confirm(Text50003, false, "No.") then
                        exit;

                    Validate("B OrderStatus", "B OrderStatus"::"4.Prepared");
                    Modify;

                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin

        Clear(gIntNoOfLines);
        Clear(gDecWeight);

        gRecSalesLine.SetRange("Document Type", "Document Type");
        gRecSalesLine.SetRange("Document No.", "No.");
        gRecSalesLine.SetRange(Type, gRecSalesLine.Type::Item);
        if gRecSalesLine.Find('-') then
            repeat
                gIntNoOfLines += 1;
                gDecWeight := gDecWeight + (gRecSalesLine.Quantity * gRecSalesLine."Net Weight");
            until gRecSalesLine.Next = 0;

        ShipmentDateOnFormat;
    end;

    var
        Text50000: Label 'Orderstatus must be 4.Prepared, before you can say Ready Warehouse!';
        Text50001: Label 'Are you sure that the Sales Order is ready?';
        gIntNoOfLines: Integer;
        gDecWeight: Decimal;
        gRecSalesLine: Record "Sales Line";
        gRecBejoSetup: Record "Bejo Setup";
        Text50002: Label 'Orderstatus must be 3.Released, before you can say Prepared!';
        Text50003: Label 'Are you sure that the Sales Order is Prepared?';

    local procedure ShipmentDateOnFormat()
    begin

        if "Shipment Date" < Today then;

    end;
}

