codeunit 50013 "Internal Promo Status Mgt."
{

    trigger OnRun()
    begin
    end;

    var
        Text001: Label 'Internal PromoStatus %1 : %2 is different than BZ PromoStatus %3 : %4. Do you want to continue?';
        Text002: Label '(%1: %2) is blocked for sales';

    procedure CheckSalesLine(var SalesLine: Record "Sales Line")
    var
        lrecInternalPromoStatusEntry: Record "Internal Promostatus Entry";
        lrecCustomer: Record Customer;
        lrecVariety: Record Varieties;
        lrecBejoSetup: Record "Bejo Setup";
    begin
        if lrecInternalPromoStatusEntry.IsEmpty or not GuiAllowed then
            exit;

        with SalesLine do begin
            if (Type = Type::Item) and ("No." <> '') then begin
                lrecCustomer.Get("Sell-to Customer No.");
                lrecVariety.Get("B Variety");
                if GetInternalPromoStatusEntry(
                  lrecInternalPromoStatusEntry, "B Variety", "No.", lrecCustomer."Region Filter", "B Salesperson", "Sell-to Customer No.") then begin
                    if lrecInternalPromoStatusEntry."Internal Promo Status Code" = '9' then begin
                        lrecBejoSetup.Get;
                        if lrecBejoSetup."Block Sales on Int.PromoStatus" then
                            with lrecInternalPromoStatusEntry do begin
                                CalcFields("Internal Promo Status Descr.");
                                FieldError("Internal Promo Status Code",
                                  StrSubstNo(Text002, "Internal Promo Status Code",
                                    "Internal Promo Status Descr."));
                            end;
                    end;
                    if lrecInternalPromoStatusEntry."Internal Promo Status Code" <> lrecVariety."Promo Status" then

                        with lrecInternalPromoStatusEntry do begin
                            CalcFields("Internal Promo Status Descr.");
                            lrecVariety.CalcFields("Promo Status Description");
                            if not Confirm(Text001, false, "Internal Promo Status Code", "Internal Promo Status Descr.",
                                           lrecVariety."Promo Status", lrecVariety."Promo Status Description") then
                                Error('');
                        end;

                end;
            end;
        end;
    end;

    local procedure GetInternalPromoStatusEntry(var precInternalPromoStatusEntry: Record "Internal Promostatus Entry"; pVarietyCode: Code[5]; pItemNo: Code[20]; pRegionFilter: Code[100]; pSalesperson: Code[10]; pCustomerNo: Code[20]) Found: Boolean
    begin
        Found := false;
        with precInternalPromoStatusEntry do begin
            SetRange("Variety Code", pVarietyCode);
            SetRange(Salesperson, pSalesperson);
            SetRange("Customer No.", pCustomerNo);
            Found := TryWithOrWithoutItemFilter(precInternalPromoStatusEntry, pItemNo);

            if not Found then begin
                SetRange("Customer No.", '');
                Found := TryWithOrWithoutItemFilter(precInternalPromoStatusEntry, pItemNo);
            end;

            if not Found then begin
                SetRange(Salesperson, '');
                Found := TryWithOrWithoutItemFilter(precInternalPromoStatusEntry, pItemNo);
            end;

            if not Found then begin

                Found := TryWithOrWithoutItemFilter(precInternalPromoStatusEntry, pItemNo);
            end;
        end;
    end;

    local procedure TryWithOrWithoutItemFilter(var precInternalPromoStatusEntry: Record "Internal Promostatus Entry"; pItemNo: Code[20]) Found: Boolean
    begin
        with precInternalPromoStatusEntry do begin
            SetRange("Item No.", pItemNo);
            Found := FindFirst;
            if not Found then begin
                SetRange("Item No.", '');
                Found := FindFirst;
            end;
        end;
    end;
}

