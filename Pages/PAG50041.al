page 50041 "Sales Orders per Item"
{

    Caption = 'Sales orders per Item';
    DataCaptionFields = "No.";
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "Sales Line";
    SourceTableView = WHERE ("Document Type" = FILTER (Order));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field(Type; Type)
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("No."; "No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("B Lot No."; "B Lot No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Quantity; Quantity)
                {
                    BlankZero = true;
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("B Allocation Exceeded"; "B Allocation Exceeded")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Shipment Date"; "Shipment Date")
                {
                    ApplicationArea = All;
                }
                field("B Salesperson"; "B Salesperson")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Sell-to Customer No."; "Sell-to Customer No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("grecCustomer.Name"; grecCustomer.Name)
                {
                    Caption = 'Name';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Document Type"; "Document Type")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Document No."; "Document No.")
                {
                    DrillDown = true;
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        SalesHeaderPage: Page "Sales Order";
                    begin

                        SalesHeaderPage.SetRecord(SalesHeader);
                        SalesHeaderPage.Run;

                    end;
                }
                field("SalesHeader.""B OrderStatus"""; SalesHeader."B OrderStatus")
                {
                    Caption = 'Order Status';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("B Characteristic"; "B Characteristic")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Line Amount"; "Line Amount")
                {
                    BlankZero = true;
                    Editable = false;
                    ApplicationArea = All;
                }
                field("B Tracking Quantity"; "B Tracking Quantity")
                {
                    BlankZero = true;
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Outstanding Quantity"; "Outstanding Quantity")
                {
                    BlankZero = true;
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Currency Code"; "Currency Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Unit Price"; "Unit Price")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Line Discount %"; "Line Discount %")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Location Code"; "Location Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }

            }
        }
    }

    actions
    {
        area(processing)
        {
            action(All)
            {
                Caption = 'All';
                Image = AllLines;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    SetRange("B Tracking Quantity");
                end;
            }
            action("Not Reserved")
            {
                Caption = 'Not Reserved';
                Image = CancelAllLines;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    SetFilter("B Tracking Quantity", '=0');
                end;
            }
            action(Reserved)
            {
                Caption = 'Reserved';
                Image = Reserve;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    SetFilter("B Tracking Quantity", '<>0');
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        if not grecCustomer.Get("Sell-to Customer No.") then
            grecCustomer.Init;


        if not SalesHeader.Get("Document Type", "Document No.") then
            Clear(SalesHeader);

        ShipmentDateOnPageat;
    end;

    var
        grecCustomer: Record Customer;
        SalesHeader: Record "Sales Header";

    procedure update()
    begin
        CurrPage.Update;
    end;

    local procedure ShipmentDateOnPageat()
    begin
        if "Shipment Date" < Today then;
    end;
}

