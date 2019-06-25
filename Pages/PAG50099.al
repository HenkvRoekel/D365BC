page 50099 "Allocation FactBox"
{

    PageType = CardPart;
    SourceTable = Item;

    layout
    {
        area(content)
        {
            field("No."; "No.")
            {
                Caption = 'No.';
                ApplicationArea = All;
            }
            field(Description; Description)
            {
                Caption = 'Description';
                ApplicationArea = All;
            }
            field("Description 2"; "Description 2")
            {
                Caption = 'Description 2';
                Editable = false;
                ShowCaption = true;
                ApplicationArea = All;
            }
            field("grecItemExtension.""Extension Code"""; grecItemExtension."Extension Code")
            {
                Caption = 'Extension Code';
                Editable = false;
                ApplicationArea = All;
            }
            field(gQuantityPer; gQuantityPer)
            {
                Caption = 'Quantity Per';
                Editable = false;
                ApplicationArea = All;
            }
            field(PromoStatus; PromoStatus)
            {
                Caption = 'Promo Status';
                ApplicationArea = All;
            }
            field("lcuBlockingMgt.ItemBlockDescription(Rec)"; lcuBlockingMgt.ItemBlockDescription(Rec))
            {
                Caption = 'Blocking Code';
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
        if not grecItemExtension.Get("B Extension", '') then
            grecItemExtension.Init;

        if grecUOM.Get("Base Unit of Measure") then;
        if grecUOM."B Unit in Weight" then
            gQuantityPer := text50001
        else
            gQuantityPer := text50000;



        CalcFields("B Promo Status");
        CalcFields("B Promo Status Description");
        PromoStatus := "B DisplayPromoStatus";

    end;

    var
        grecItemExtension: Record "Item Extension";
        text50000: Label 'Million';
        text50001: Label 'KG';
        Text50002: Label 'Nothing found.';
        grecUOM: Record "Unit of Measure";
        gQuantityPer: Text;
        "Blocking Management": Codeunit "Blocking Management";
        PromoStatus: Text;
        lcuBlockingMgt: Codeunit "Blocking Management";
}

