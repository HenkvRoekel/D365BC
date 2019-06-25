page 50025 "Stock Information Entries"
{

    Caption = 'Stock Information Entries';
    DataCaptionExpression = GetCaption;
    DataCaptionFields = "Item No.";
    Editable = false;
    PageType = List;
    SourceTable = "Item Ledger Entry";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Lot No."; "Lot No.")
                {
                    ApplicationArea = All;
                }
                field("Entry Type"; "Entry Type")
                {
                    ApplicationArea = All;
                }
                field("Document No."; "Document No.")
                {
                    ApplicationArea = All;
                }
                field("Source No."; "Source No.")
                {
                    ApplicationArea = All;
                }
                field("B Salesperson"; "B Salesperson")
                {
                    ApplicationArea = All;
                }
                field("Item No."; "Item No.")
                {
                    ApplicationArea = All;
                }
                field("Variant Code"; "Variant Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Return Reason Code"; "Return Reason Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Serial No."; "Serial No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Lot No.2"; "Lot No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Location Code"; "Location Code")
                {
                    ApplicationArea = All;
                }

                field(Quantity; Quantity)
                {
                    ApplicationArea = All;
                }
                field("Invoiced Quantity"; "Invoiced Quantity")
                {
                    Visible = true;
                    ApplicationArea = All;
                }
                field("Remaining Quantity"; "Remaining Quantity")
                {
                    Visible = true;
                    ApplicationArea = All;
                }
                field("Qty. per Unit of Measure"; "Qty. per Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field("Remaining Units"; gUnits)
                {
                    BlankZero = true;
                    Caption = 'Units';
                    DecimalPlaces = 0 : 2;
                    Visible = true;
                    ApplicationArea = All;
                }
                field("Reserved Quantity"; "Reserved Quantity")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("B Tracking Qty. on Lot"; "B Tracking Qty. on Lot")
                {
                    BlankZero = true;
                    ApplicationArea = All;
                }
                field("Sales Amount (Expected)"; "Sales Amount (Expected)")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Sales Amount (Actual)"; "Sales Amount (Actual)")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Cost Amount (Expected)"; "Cost Amount (Expected)")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Cost Amount (Actual)"; "Cost Amount (Actual)")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Cost Amount (Non-Invtbl.)"; "Cost Amount (Non-Invtbl.)")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Cost Amount (Expected) (ACY)"; "Cost Amount (Expected) (ACY)")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Cost Amount (Actual) (ACY)"; "Cost Amount (Actual) (ACY)")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Cost Amount (Non-Invtbl.)(ACY)"; "Cost Amount (Non-Invtbl.)(ACY)")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Completely Invoiced"; "Completely Invoiced")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Open; Open)
                {
                    ApplicationArea = All;
                }
                field("Drop Shipment"; "Drop Shipment")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Applied Entry to Adjust"; "Applied Entry to Adjust")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Order No."; "Order No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Order Line No."; "Order Line No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Prod. Order Comp. Line No."; "Prod. Order Comp. Line No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Entry No."; "Entry No.")
                {
                    ApplicationArea = All;
                }
            }
            part(Control1000000010; "Stock information Quotes")
            {
                SubPageLink = "No." = FIELD ("Item No.");
                SubPageView = SORTING ("Document Type", "Document No.", "Line No.")
                              WHERE ("Document Type" = CONST (Quote));
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        gUnits := 0;
        if "Qty. per Unit of Measure" <> 0 then
            gUnits := "Remaining Quantity" / "Qty. per Unit of Measure";
    end;

    var
        gUnits: Decimal;

    procedure GetCaption(): Text[250]
    var
        lrecObjectTranslation: Record "Object Translation";
        lSourceTableName: Text[100];
        lSourceFilter: Text[200];
        lrecItem: Record Item;
        lrecProductionOrder: Record "Production Order";
        lDescription: Text[100];
    begin
        lDescription := '';

        case true of
            GetFilter("Item No.") <> '':
                begin
                    lSourceTableName := lrecObjectTranslation.TranslateObject(lrecObjectTranslation."Object Type"::Table, 27);
                    lSourceFilter := GetFilter("Item No.");
                    if lrecItem.Get(lSourceFilter) then
                        lDescription := lrecItem.Description;
                end;

            GetFilter("Order No.") <> '':

                begin
                    lSourceTableName := lrecObjectTranslation.TranslateObject(lrecObjectTranslation."Object Type"::Table, 5405);

                    lSourceFilter := GetFilter("Order No.");

                    if lrecProductionOrder.Get(lrecProductionOrder.Status::Released, lSourceFilter) or
                       lrecProductionOrder.Get(lrecProductionOrder.Status::Finished, lSourceFilter)
                    then begin
                        lSourceTableName := StrSubstNo('%1 %2', lrecProductionOrder.Status, lSourceTableName);
                        lDescription := lrecProductionOrder.Description;
                    end;
                end;
        end;
        exit(StrSubstNo('%1 %2 %3', lSourceTableName, lSourceFilter, lDescription));
    end;
}

