page 50087 "Allocation Main Subform Sale"
{

    PageType = CardPart;
    SourceTable = Item;

    layout
    {
        area(content)
        {
            field("B Allocated"; "B Allocated")
            {
                Caption = 'Allocated';
                DecimalPlaces = 3 : 4;
                ApplicationArea = All;
            }
            field(gRest; gRest)
            {
                Caption = 'Rest';
                DecimalPlaces = 3 : 4;
                Editable = false;
                ApplicationArea = All;
            }
            field("Sales (Qty.)"; "Sales (Qty.)")
            {
                Caption = 'Sales (Qty.)';
                DecimalPlaces = 3 : 4;
                ApplicationArea = All;
            }
            field("B Qty. to Invoice"; "B Qty. to Invoice")
            {
                Caption = 'Qty. to Invoice';
                DecimalPlaces = 3 : 4;
                ApplicationArea = All;
            }
            field("Rest to Sell"; gRestToSell)
            {
                Caption = 'Rest to Sell';
                DecimalPlaces = 3 : 4;
                Editable = false;
                ApplicationArea = All;
            }
            field(gInvoicedLY; gInvoicedLY)
            {
                Caption = 'Sales (Qty.) LY';
                DecimalPlaces = 3 : 4;
                Editable = false;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        if grecUOM.Get("Base Unit of Measure") then;
        if not grecUOM."B Unit in Weight" then begin
            "Sales (Qty.)" := "Sales (Qty.)" / 1000000;
            "B Qty. to Invoice" := "B Qty. to Invoice" / 1000000;
        end;
    end;

    var
        gInvoicedLY: Decimal;
        gAllocated: Decimal;
        gSalesQty: Decimal;
        gQtyToInvoice: Decimal;
        gRestToSell: Decimal;
        gRest: Decimal;
        grecUOM: Record "Unit of Measure";

    procedure SetFilters(lRest: Decimal; lRestToSell: Decimal; lInvoicedLY: Decimal; var MainRec: Record Item)
    begin
        gInvoicedLY := lInvoicedLY;
        gRestToSell := lRestToSell;
        gRest := lRest;
        CurrPage.Update(false);
        CopyFilters(MainRec);
    end;

    procedure RefreshForm()
    begin
        CurrPage.Update(false);
    end;
}

