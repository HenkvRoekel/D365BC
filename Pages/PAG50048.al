page 50048 "Confirm Create New Line"
{

    Caption = 'Confirm Create New Line';
    PageType = Card;
    SourceTable = "Lot No. Information";

    layout
    {
        area(content)
        {
            field(Qty; Qty)
            {
                Caption = 'Item Tracking for';
                DecimalPlaces = 0 : 2;
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    if Qty > OrigQty then
                        Error(Text003, OrigQty);
                end;
            }
            field(CreateNewLine; CreateNewLine)
            {
                Caption = 'Create a new line for the remaining qty.?';
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        CurrPage.LookupMode := false;
        CreateNewLine := true;
    end;

    trigger OnOpenPage()
    begin
        SetRange("Lot No.", LotNo);  //BEJOW18.00.016
    end;

    var
        Text000: Label 'Not sufficient remaining for lot no. %1.';
        LotNo: Code[20];
        Qty: Decimal;
        OrigQty: Decimal;
        CreateNewLine: Boolean;
        Text001: Label 'Item Tracking for';
        Text002: Label 'units of lot %1?';
        Text003: Label 'Quantity may not be larger than %1!';

    procedure SetLotNo(lotNoPar: Code[20])
    begin
        LotNo := lotNoPar;
    end;

    procedure SetQuantity(qtyPar: Decimal)
    begin
        Qty := qtyPar;
        OrigQty := qtyPar;
    end;

    procedure GetQuantity(): Decimal
    begin
        exit(Qty)
    end;

    procedure GetCreateNewLine(): Boolean
    begin
        exit(CreateNewLine)
    end;
}

