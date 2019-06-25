codeunit 50007 "Bejo Management"
{

    trigger OnRun()
    begin
    end;

    var
        Text50000: Label 'Item %1, Prognose = %5\Allocated = %2\Received = %3\On purchase order = %4\Deficit = %6';
        Text50001: Label 'Allocation exceeded:\Item %1 \Scope = %2 %7 \Allocated = %3\Invoiced = %4\In Sales Order = %5\Prognoses = %6';
        ctNoSalesPersAllocationFound: Label 'There is no allocation for Sales person %1 and Item %2.';
        gSkipAllocationCheckMessages: Boolean;
        Text50003: Label 'Purchase Order %1 has been exported.';
        Text50002: Label 'Purchase Credit Memo %1 has been exported.';

    procedure PurchCheckAllocation(var Rec: Record "Purchase Line")
    var
        lrecUnitOfMeasure: Record "Unit of Measure";
        faktor: Decimal;
        lrecBejoSetup: Record "Bejo Setup";
        lrecItem: Record Item;
        lrecItemAlternative: Record Item;
        lrecOldPurchLine: Record "Purchase Line";
        OldOutstanding: Decimal;
        CountryAllocated: Decimal;
        PurchasesQty: Decimal;
        QtyPurchOrder: Decimal;
        QtyPurchQuot: Decimal;
        OutstandingQtyBase: Decimal;
        AlternativeItemNo: Code[20];
        AltCountryAllocated: Decimal;
        AltPurchasesQty: Decimal;
        AltQtyPurchOrder: Decimal;
        AltQtyPurchQuot: Decimal;
        ItemHasAlternative: Boolean;
    begin
        Rec."B Allocation exceeded" := false;

        if Rec.Quantity = 0 then
            exit;

        if not BejoItem(Rec."No.") then
            exit;

        lrecBejoSetup.Get;
        if not lrecBejoSetup."Purchase Allocation Check" then
            exit;

        if not lrecItem.Get(Rec."No.") then
            exit;

        if not lrecUnitOfMeasure.Get(Rec."Unit of Measure Code") then
            exit;

        OldOutstanding := 0;
        lrecOldPurchLine := Rec;
        if lrecOldPurchLine.Find then
            if (lrecOldPurchLine."Document Type" = lrecOldPurchLine."Document Type"::Order) and
               (lrecOldPurchLine."No." = Rec."No.") and
               (lrecOldPurchLine."Variant Code" = Rec."Variant Code") and
               (lrecOldPurchLine."Location Code" = Rec."Location Code") and
               (lrecOldPurchLine."Bin Code" = Rec."Bin Code") and
               not lrecOldPurchLine."Drop Shipment"
            then
                OldOutstanding := -lrecOldPurchLine."Outstanding Qty. (Base)";

        lrecItem.SetRange("Date Filter", lrecBejoSetup."Begin Date", lrecBejoSetup."End Date");
        lrecItem.CalcFields("Purchases (Qty.)", "Qty. on Purch. Order", "B Country allocated", "B Prognoses", "B Qty. on Purch. Quote");

        if lrecUnitOfMeasure."B Unit in Weight" then
            faktor := 1 else
            faktor := 1000000;


        ItemHasAlternative := false;
        AltCountryAllocated := 0;
        AltPurchasesQty := 0;
        AltQtyPurchOrder := 0;
        AltQtyPurchQuot := 0;

        GetAlternativeItemNo(lrecItem."No.", AlternativeItemNo);


        if lrecItemAlternative.Get(AlternativeItemNo) then begin
            ItemHasAlternative := true;

            lrecItemAlternative.SetRange("Date Filter", lrecBejoSetup."Begin Date", lrecBejoSetup."End Date");
            lrecItemAlternative.CalcFields("Purchases (Qty.)", "Qty. on Purch. Order",
                                            "B Country allocated", "B Prognoses", "B Qty. on Purch. Quote");

            AltCountryAllocated := lrecItemAlternative."B Country allocated";
            AltPurchasesQty := lrecItemAlternative."Purchases (Qty.)";
            AltQtyPurchOrder := lrecItemAlternative."Qty. on Purch. Order";
            AltQtyPurchQuot := lrecItemAlternative."B Qty. on Purch. Quote";


        end;

        CountryAllocated := lrecItem."B Country allocated";
        PurchasesQty := lrecItem."Purchases (Qty.)";
        QtyPurchOrder := lrecItem."Qty. on Purch. Order";
        QtyPurchQuot := lrecItem."B Qty. on Purch. Quote";
        OutstandingQtyBase := Rec."Outstanding Qty. (Base)";


        if ItemHasAlternative then begin
            CountryAllocated := CountryAllocated + AltCountryAllocated;
            PurchasesQty := PurchasesQty + AltPurchasesQty;
            QtyPurchOrder := QtyPurchOrder + AltQtyPurchOrder;
            QtyPurchQuot := QtyPurchQuot + AltQtyPurchQuot;
        end;

        if (CountryAllocated -
            ((PurchasesQty + QtyPurchOrder + OldOutstanding + QtyPurchQuot + OutstandingQtyBase) / faktor) < 0) then begin
            Rec."B Allocation exceeded" := true;

            if not gSkipAllocationCheckMessages then begin

                Message(Text50000,
                        Rec."No.",
                        CountryAllocated,
                        (PurchasesQty + QtyPurchQuot) / faktor,
                        Round((QtyPurchOrder + OutstandingQtyBase + OldOutstanding) / faktor, 0.0001),
                        lrecItem."B Prognoses",
                        CountryAllocated - (PurchasesQty + QtyPurchQuot) / faktor -
                        Round((QtyPurchOrder + OutstandingQtyBase + OldOutstanding) / faktor, 0.0001)
                       );

            end;


        end;

    end;

    procedure SalesCheckAllocation(var lrecSalesLine: Record "Sales Line")
    var
        UnitOfMeasure: Record "Unit of Measure";
        lrecItem: Record Item;
        SalesLine: Record "Sales Line";
        ItemLedgerEntry: Record "Item Ledger Entry";
        BejoSetup: Record "Bejo Setup";
        lrecSalesPersPrognAllocEntry: Record "Prognosis/Allocation Entry";
        PrognosisAllocationEntry: Record "Prognosis/Allocation Entry";
        TmpPrognosisAllocationEntry: Record "Prognosis/Allocation Entry" temporary;
        ActivePrognosisAllocationEntry: Record "Prognosis/Allocation Entry";
        ItemFilter: Text[100];
        AlternativeItemNo: Code[20];
        Factor: Decimal;
        TotalQtyToShip: Decimal;
        TotalQtyShipped: Decimal;
        ActiveRecordEntry: Integer;
        TotalAllocatedCustSalesp: Decimal;
        lAllocationScope: Text[30];
        lAllocated: Decimal;
        lPrognoses: Decimal;
        lTotalCountryAllocation: Decimal;
        SalesHeader: Record "Sales Header";
        BeginDatePeriod: Date;
        EndDatePeriod: Date;
    begin

        with lrecSalesLine do begin
            "B Allocation Exceeded" := false;

            if not BejoItem("No.") then
                exit;

            BejoSetup.Get;
            if not BejoSetup."Sales Allocation Check" then
                exit;

            if not lrecItem.Get("No.") then
                exit;

            if not UnitOfMeasure.Get("Unit of Measure Code") then
                exit;

            if UnitOfMeasure."B Unit in Weight" then
                Factor := 1
            else
                Factor := 1000000;

            if GetAlternativeItemNo("No.", AlternativeItemNo) then
                ItemFilter := "No." + '|' + AlternativeItemNo
            else
                ItemFilter := "No.";


            SalesHeader.Get("Document Type", "Document No.");
            BeginDatePeriod := BejoSetup."Begin Date";
            EndDatePeriod := BejoSetup."End Date";
            if (SalesHeader."Shipment Date" <> 0D) and (SalesHeader."Shipment Date" > BejoSetup."End Date") then begin
                BeginDatePeriod := CalcDate('<+1Y>', BejoSetup."Begin Date");
                EndDatePeriod := CalcDate('<+1Y>', BejoSetup."End Date");
            end;
            if (SalesHeader."Shipment Date" <> 0D) and (SalesHeader."Shipment Date" < BejoSetup."Begin Date") then begin
                BeginDatePeriod := CalcDate('<-1Y>', BejoSetup."Begin Date");
                EndDatePeriod := CalcDate('<-1Y>', BejoSetup."End Date");
            end;

            lrecSalesPersPrognAllocEntry.SetFilter("Item No.", ItemFilter);
            lrecSalesPersPrognAllocEntry.SetRange("Sales Date", BeginDatePeriod, EndDatePeriod);
            lrecSalesPersPrognAllocEntry.SetRange("Entry Type", PrognosisAllocationEntry."Entry Type"::Allocation);
            lrecSalesPersPrognAllocEntry.SetRange(Salesperson, "B Salesperson");
            if not (lrecSalesPersPrognAllocEntry.FindFirst) then begin
                if GuiAllowed then Message(ctNoSalesPersAllocationFound, "B Salesperson", "No.");
                "B Allocation Exceeded" := true;
                exit;
            end;


            PrognosisAllocationEntry.SetFilter("Item No.", ItemFilter);
            PrognosisAllocationEntry.SetRange("Sales Date", BeginDatePeriod, EndDatePeriod);
            PrognosisAllocationEntry.SetRange("Entry Type", PrognosisAllocationEntry."Entry Type"::Allocation);
            if PrognosisAllocationEntry.FindSet then
                repeat
                    TmpPrognosisAllocationEntry.SetRange(Salesperson, PrognosisAllocationEntry.Salesperson);
                    TmpPrognosisAllocationEntry.SetRange(Customer, PrognosisAllocationEntry.Customer);
                    if TmpPrognosisAllocationEntry.FindFirst then begin
                        TmpPrognosisAllocationEntry.Allocated += PrognosisAllocationEntry.Allocated;
                        TmpPrognosisAllocationEntry."Allocated Cust. Sales person" += PrognosisAllocationEntry."Allocated Cust. Sales person";
                        TmpPrognosisAllocationEntry.Modify;
                    end else begin
                        TmpPrognosisAllocationEntry := PrognosisAllocationEntry;
                        TmpPrognosisAllocationEntry.Insert;
                    end;
                    lTotalCountryAllocation += PrognosisAllocationEntry.Allocated;
                    TotalAllocatedCustSalesp += PrognosisAllocationEntry."Allocated Cust. Sales person";
                until PrognosisAllocationEntry.Next = 0;

            TmpPrognosisAllocationEntry.SetRange(Salesperson);
            TmpPrognosisAllocationEntry.SetRange(Customer);
            FindBestAllocationEntry(TmpPrognosisAllocationEntry, "B Salesperson", "Sell-to Customer No.");
            ActivePrognosisAllocationEntry := TmpPrognosisAllocationEntry;
            ActiveRecordEntry := TmpPrognosisAllocationEntry."Internal Entry No.";

            SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
            SalesLine.SetRange(Type, SalesLine.Type::Item);
            SalesLine.SetFilter("No.", ItemFilter);
            SalesLine.SetRange("Shipment Date", BeginDatePeriod, EndDatePeriod);
            if SalesLine.FindSet then
                repeat
                    if ("Document Type" = SalesLine."Document Type") and
                       ("Document No." = SalesLine."Document No.") and
                       ("Line No." = SalesLine."Line No.") then
                        SalesLine := lrecSalesLine;

                    FindBestAllocationEntry(TmpPrognosisAllocationEntry, SalesLine."B Salesperson", SalesLine."Sell-to Customer No.");
                    if TmpPrognosisAllocationEntry."Internal Entry No." = ActiveRecordEntry then
                        TotalQtyToShip += SalesLine."Qty. to Ship (Base)";
                until SalesLine.Next = 0;

            ItemLedgerEntry.SetCurrentKey("Entry Type", "Item No.");
            ItemLedgerEntry.SetRange("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
            ItemLedgerEntry.SetFilter("Item No.", ItemFilter);
            ItemLedgerEntry.SetRange("Posting Date", BeginDatePeriod, EndDatePeriod);
            if ActivePrognosisAllocationEntry.Salesperson <> '' then
                ItemLedgerEntry.SetRange("B Salesperson", ActivePrognosisAllocationEntry.Salesperson);
            if ActivePrognosisAllocationEntry.Customer <> '' then
                ItemLedgerEntry.SetRange("Source No.", ActivePrognosisAllocationEntry.Customer);
            if ItemLedgerEntry.FindSet then
                repeat
                    FindBestAllocationEntry(TmpPrognosisAllocationEntry,
                                              ItemLedgerEntry."B Salesperson",
                                              ItemLedgerEntry."Source No.");
                    if TmpPrognosisAllocationEntry."Internal Entry No." = ActiveRecordEntry then
                        TotalQtyShipped -= ItemLedgerEntry.Quantity;
                until ItemLedgerEntry.Next = 0;


            lAllocationScope := ActivePrognosisAllocationEntry.Customer;
            lAllocated := ActivePrognosisAllocationEntry."Allocated Cust. Sales person";


            Clear(TmpPrognosisAllocationEntry);
            PrognosisAllocationEntry.SetFilter("Item No.", ItemFilter);
            PrognosisAllocationEntry.SetRange("Sales Date", BeginDatePeriod, EndDatePeriod);
            PrognosisAllocationEntry.SetRange("Entry Type", PrognosisAllocationEntry."Entry Type"::Prognoses);
            if PrognosisAllocationEntry.FindSet then begin
                repeat
                    TmpPrognosisAllocationEntry.SetRange(Salesperson, PrognosisAllocationEntry.Salesperson);
                    TmpPrognosisAllocationEntry.SetRange(Customer, PrognosisAllocationEntry.Customer);
                    if TmpPrognosisAllocationEntry.FindFirst then begin
                        TmpPrognosisAllocationEntry.Prognoses += PrognosisAllocationEntry.Prognoses;
                        TmpPrognosisAllocationEntry.Modify;
                    end else begin
                        TmpPrognosisAllocationEntry := PrognosisAllocationEntry;
                        TmpPrognosisAllocationEntry.Insert;
                    end;
                until PrognosisAllocationEntry.Next = 0;
            end;
            if TmpPrognosisAllocationEntry.FindSet then begin
                FindBestAllocationEntry(TmpPrognosisAllocationEntry, "B Salesperson", "Sell-to Customer No.");
                lPrognoses := TmpPrognosisAllocationEntry.Prognoses;
            end;

            if lAllocated < ((TotalQtyToShip + TotalQtyShipped) / Factor) then begin
                if GuiAllowed then Message(Text50001,
                  "No.",                                                 // %1
                  "B Salesperson",                                       // %2
                  lAllocated,                                            // %3
                  Round(TotalQtyShipped / Factor, 0.01),                 // %4
                  Round(TotalQtyToShip / Factor, 0.01),                  // %5
                  lPrognoses,                                            // %6
                  lAllocationScope);                                     // %7

                "B Allocation Exceeded" := true;
            end;

        end;
    end;

    procedure FindBestAllocationEntry(var pRecPrognosisAllocationEntry: Record "Prognosis/Allocation Entry"; SalespersonCode: Code[20]; CustomerNo: Code[20]): Boolean
    begin

        with pRecPrognosisAllocationEntry do begin

            SetRange(Salesperson, SalespersonCode);
            SetRange(Customer, CustomerNo);
            if FindFirst then
                exit;

            SetFilter(Salesperson, '%1', '');
            SetRange(Customer, CustomerNo);
            if FindFirst then
                exit;

            SetRange(Salesperson, SalespersonCode);
            SetFilter(Customer, '%1', '');
            if FindFirst then
                exit;

            SetFilter(Salesperson, '%1', '');
            SetFilter(Customer, '%1', '');
            if FindFirst then
                exit;

        end;
    end;

    //procedure ReportID(aReportID: Text[50]) IDstr: Text[50]
    //var
    //    lIDNo: Integer;
    //    lRecObject: Record "Object";
    //    lSubString: Text[100];
    //begin
    //    Evaluate(lIDNo, CopyStr(aReportID, 8, 5));
    //    IDstr := Format(lIDNo);
    //end;

    procedure GetAlternativeItemNo(ItemNo: Code[20]; var AlternativeItemNo: Code[20]): Boolean
    var
        lrecItem: Record Item;
        lExtension: Text[1];
    begin

        lrecItem.Get(ItemNo);

        lExtension := CopyStr(lrecItem."No.", StrLen(lrecItem."No."), 1);
        case lExtension of
            '0':
                AlternativeItemNo := CopyStr(lrecItem."No.", 1, StrLen(lrecItem."No.") - 1) + '4';
            '4':
                AlternativeItemNo := CopyStr(lrecItem."No.", 1, StrLen(lrecItem."No.") - 1) + '0';
            '1':
                AlternativeItemNo := CopyStr(lrecItem."No.", 1, StrLen(lrecItem."No.") - 1) + '5';
            '5':
                AlternativeItemNo := CopyStr(lrecItem."No.", 1, StrLen(lrecItem."No.") - 1) + '1';
        end;

        exit((AlternativeItemNo <> ''));
    end;

    procedure BejoItem("No.": Code[20]) BejoItemOK: Boolean
    var
        lVarInteger: Integer;
    begin

        if ("No." > '00000000') and ("No." < '92999999') and
           (StrLen("No.") = 8) and
           Evaluate(lVarInteger, "No.") then
            BejoItemOK := true;
    end;

    // procedure SendMailAtShipping(var lrecSalesHeader: Record "Sales Header")
    // var
    //     lcuMail: Codeunit Mail;
    //     lcuSMTPMail: Codeunit "SMTP Mail";
    //     lrecSalespersonPurchaser: Record "Salesperson/Purchaser";
    //     lrecBejoSetup: Record "Bejo Setup";
    //     lrecCompanyInformation: Record "Company Information";
    //     Subject: Text[1024];
    //     Body: Text[1024];
    //     CrLf: Text[20];
    //     ctSubject: Label 'Sales Order %1 for Customer %2 with Shipment Date %3 has been shipped!';
    //     ctDear: Label 'Dear %1';
    // begin

    //     if not lrecSalesHeader.Ship then
    //         exit;

    //     if not lrecSalespersonPurchaser.Get(lrecSalesHeader."Salesperson Code") then
    //         exit;

    //     if lrecSalespersonPurchaser."E-Mail" = '' then
    //         exit;

    //     Subject :=
    //       StrSubstNo(ctSubject,
    //         lrecSalesHeader."No.",
    //         lrecSalesHeader."Sell-to Customer Name",
    //         lrecSalesHeader."Shipment Date");

    //     CrLf[1] := 13;
    //     CrLf[2] := 10;

    //     Body :=
    //       StrSubstNo(ctDear, lrecSalespersonPurchaser.Name) + ',' + CrLf +
    //       CrLf +
    //       Subject;


    //     lrecBejoSetup.Get;
    //     if lrecBejoSetup."Use SMTP Mail" then begin
    //         lrecCompanyInformation.Get;
    //         lcuSMTPMail.CreateMessage(
    //           lrecCompanyInformation.Name,
    //           lrecBejoSetup."SMTP E-Mail",
    //           lrecSalespersonPurchaser."E-Mail",
    //           Subject, Body, false);
    //         lcuSMTPMail.Send;
    //     end else begin
    //         lcuMail.NewMessage(lrecSalespersonPurchaser."E-Mail", '', '', Subject, Body, '', false);
    //     end;

    // end;

    // procedure SendMailAtAllocating(var lrecPrognosisAllocationEntry: Record "Prognosis/Allocation Entry"; var xRec: Record "Prognosis/Allocation Entry")
    // var
    //     lcuMail: Codeunit Mail;
    //     lcuSMTPMail: Codeunit "SMTP Mail";
    //     lrecSalespersonPurchaser: Record "Salesperson/Purchaser";
    //     lrecBejoSetup: Record "Bejo Setup";
    //     lrecCompanyInformation: Record "Company Information";
    //     Subject: Text[1024];
    //     Body: Text[1024];
    //     ctSubject: Label 'The allocation for Item No. %1 has been changed from %2 to %3.';
    //     ctDear: Label 'Dear %1';
    //     CrLf: Text[20];
    //     ctSubjectWithCustNo: Label 'The allocation for Item No. %1 has been changed from %2 to %3 for Customer %4.';
    //     lRecCustomer: Record Customer;
    //     lrecItem: Record Item;
    // begin
    //     // - BEJOWW5.01.010 ---
    //     if lrecPrognosisAllocationEntry."Entry Type" <> lrecPrognosisAllocationEntry."Entry Type"::Allocation then
    //         exit;

    //     if not lrecSalespersonPurchaser.Get(lrecPrognosisAllocationEntry.Salesperson) then
    //         exit;

    //     if lrecSalespersonPurchaser."E-Mail" = '' then
    //         exit;

    //     // - BEJOWW6.00.014 --- Issue 18613
    //     if not lrecItem.Get(lrecPrognosisAllocationEntry."Item No.") then
    //         lrecItem.Init;
    //     // + BEJOWW6.00.014 +++ Issue 18613

    //     if xRec.Customer = '' then begin
    //         Subject :=
    //           // - BEJOWW6.00.014 --- Issue 18613
    //           // STRSUBSTNO(ctSubject,
    //           // lrecPrognosisAllocationEntry."Item No.",
    //           // xRec."Allocated Cust. Sales person",
    //           // lrecPrognosisAllocationEntry."Allocated Cust. Sales person");
    //           StrSubstNo(ctSubject,
    //                      lrecPrognosisAllocationEntry."Item No.",
    //                      lrecItem.Description,
    //                      xRec."Allocated Cust. Sales person",
    //                      lrecPrognosisAllocationEntry."Allocated Cust. Sales person");
    //         // + BEJOWW6.00.014 +++ Issue 18613
    //         CrLf[1] := 13;
    //         CrLf[2] := 10;

    //         Body :=
    //           StrSubstNo(ctDear, lrecSalespersonPurchaser.Name) + ',' + CrLf +
    //           CrLf +
    //           Subject;

    //     end else begin

    //         if not lRecCustomer.Get(xRec.Customer) then
    //             Clear(lRecCustomer);
    //         Subject :=
    //           // - BEJOWW6.00.014 --- Issue 18613
    //           // STRSUBSTNO(ctSubjectWithCustNo,
    //           // lrecPrognosisAllocationEntry."Item No.",
    //           // xRec."Allocated Cust. Sales person",
    //           // lrecPrognosisAllocationEntry."Allocated Cust. Sales person",
    //           // lRecCustomer."No.");
    //           StrSubstNo(ctSubjectWithCustNo,
    //                      lrecPrognosisAllocationEntry."Item No.",
    //                      lrecItem.Description,
    //                      xRec."Allocated Cust. Sales person",
    //                      lrecPrognosisAllocationEntry."Allocated Cust. Sales person",
    //                      lRecCustomer."No.");
    //         // + BEJOWW6.00.014 +++ Issue 18613
    //         CrLf[1] := 13;
    //         CrLf[2] := 10;

    //         Body :=
    //           StrSubstNo(ctDear, lrecSalespersonPurchaser.Name) + ',' + CrLf +
    //           CrLf +
    //           Subject +
    //           CrLf +
    //           lRecCustomer.Name +
    //           CrLf +
    //           lRecCustomer.Address +
    //           CrLf +
    //           lRecCustomer.City +
    //           CrLf +
    //           lRecCustomer.Contact +
    //           CrLf +
    //           lRecCustomer."Phone No." +
    //           CrLf +
    //           lRecCustomer."E-Mail" +
    //           CrLf;
    //     end;

    //     // - BEJOWW6.00.014 --- Issue 18613
    //     // lcuMail.NewMessage(lrecSalespersonPurchaser."E-Mail", '', Subject, Body, '', FALSE);
    //     lrecBejoSetup.Get;
    //     if lrecBejoSetup."Use SMTP Mail" then begin
    //         lrecCompanyInformation.Get;
    //         lcuSMTPMail.CreateMessage(
    //           lrecCompanyInformation.Name,
    //           lrecBejoSetup."SMTP E-Mail",
    //           lrecSalespersonPurchaser."E-Mail",
    //           Subject, Body, false);
    //         lcuSMTPMail.Send;
    //     end else begin
    //         lcuMail.NewMessage(lrecSalespersonPurchaser."E-Mail", '', '', Subject, Body, '', false);
    //     end;
    //     // + BEJOWW6.00.014 +++ Issue 18613
    // end;

    // procedure SendMailAllocationChangeDaily(ForDate: Date)
    // var
    //     ctSubject: Label 'Allocation changes for date %1';
    //     ctDear: Label 'Dear %1,';
    //     lcuMail: Codeunit Mail;
    //     lcuSMTPMail: Codeunit "SMTP Mail";
    //     lrecPrognosisAllocationEntry: Record "Prognosis/Allocation Entry";
    //     lrecSalespersonPurchaser: Record "Salesperson/Purchaser";
    //     lrecBejoSetup: Record "Bejo Setup";
    //     lrecCompanyInformation: Record "Company Information";
    //     Subject: Text[1024];
    //     CrLf: Text[20];
    //     lRecCustomer: Record Customer;
    //     lrecItem: Record Item;
    //     ctCustItemLines: Label 'Item No. %1 %2 %3- new allocation: %4';
    // begin
    //     // - BEJOWW6.00.014 --- 18613
    //     if ForDate = 0D then
    //         exit;

    //     CrLf[1] := 13;
    //     CrLf[2] := 10;
    //     lrecBejoSetup.Get;
    //     lrecCompanyInformation.Get;

    //     lrecSalespersonPurchaser.Reset;
    //     lrecSalespersonPurchaser.SetFilter("E-Mail", '<>%1', '');
    //     if lrecSalespersonPurchaser.FindSet then repeat
    //                                                  lrecPrognosisAllocationEntry.Reset;
    //                                                  lrecPrognosisAllocationEntry.SetCurrentKey("Entry Type", Salesperson, "Date Modified", Customer, "Item No.");
    //                                                  lrecPrognosisAllocationEntry.SetRange("Entry Type", lrecPrognosisAllocationEntry."Entry Type"::Allocation);
    //                                                  lrecPrognosisAllocationEntry.SetRange(Salesperson, lrecSalespersonPurchaser.Code);
    //                                                  lrecPrognosisAllocationEntry.SetRange("Date Modified", ForDate);

    //                                                  if lrecPrognosisAllocationEntry.FindSet then begin
    //                                                      lRecCustomer."No." := '';
    //                                                      Subject := StrSubstNo(ctSubject, Format(ForDate));

    //                                                      if lrecBejoSetup."Use SMTP Mail" then begin
    //                                                          Clear(lcuSMTPMail);
    //                                                          lcuSMTPMail.CreateMessage(
    //                                                            lrecCompanyInformation.Name,
    //                                                            lrecBejoSetup."SMTP E-Mail",
    //                                                            lrecSalespersonPurchaser."E-Mail",
    //                                                            Subject, '', false);
    //                                                          lcuSMTPMail.AppendBody(StrSubstNo(ctDear, lrecSalespersonPurchaser.Name) + CrLf + CrLf);
    //                                                      end else begin
    //                                                          Clear(lcuMail);
    //                                                          lcuMail.AddBodyline(StrSubstNo(ctDear, lrecSalespersonPurchaser.Name) + CrLf + CrLf);
    //                                                      end;

    //                                                      repeat

    //                                                          if not lrecItem.Get(lrecPrognosisAllocationEntry."Item No.") then
    //                                                              lrecItem.Init;

    //                                                          if lrecBejoSetup."Use SMTP Mail" then begin
    //                                                              lcuSMTPMail.AppendBody(StrSubstNo(ctCustItemLines,
    //                                                                                                lrecPrognosisAllocationEntry."Item No.",
    //                                                                                                lrecItem.Description,
    //                                                                                                lrecItem."Description 2",
    //                                                                                                lrecPrognosisAllocationEntry."Allocated Cust. Sales person") +
    //                                                                                     CrLf);
    //                                                          end else begin
    //                                                              lcuMail.AddBodyline(StrSubstNo(ctCustItemLines,
    //                                                                                             lrecPrognosisAllocationEntry."Item No.",
    //                                                                                             lrecItem.Description,
    //                                                                                             lrecItem."Description 2",
    //                                                                                             lrecPrognosisAllocationEntry."Allocated Cust. Sales person") +
    //                                                                                  CrLf);
    //                                                          end;

    //                                                      until lrecPrognosisAllocationEntry.Next = 0;

    //                                                      if lrecBejoSetup."Use SMTP Mail" then begin
    //                                                          lcuSMTPMail.Send;
    //                                                          Clear(lcuSMTPMail);
    //                                                      end else begin
    //                                                          lcuMail.NewMessage(lrecSalespersonPurchaser."E-Mail", '', '', Subject, '', '', false);
    //                                                          Clear(lcuMail);
    //                                                      end;
    //                                                  end;
    //         until lrecSalespersonPurchaser.Next = 0;
    //     // + BEJOWW6.00.014 +++ 18613
    // end;

    // procedure GetDomainUserSID(var parUserSID: Text[119]) result: Boolean
    // var
    //     lrecUser: Record User;
    //     lrecSIDConversion: Record "SID - Account ID";
    //     lText000: Label '%1 %2 does not exist.';
    // begin

    //     if UserId <> '' then

    //         lrecUser.Reset;
    //     lrecUser.SetRange("User Name", UserId);

    //     if lrecUser.FindSet then begin
    //         parUserSID := lrecUser."User Security ID";
    //         result := true;
    //     end else
    //         result := false;
    // end;

    procedure FindUoMFromCodeBejoNL(var pUoMCode: Code[10]) Result: Boolean
    var
        lrecUnitOfMeasure: Record "Unit of Measure";
    begin

        Result := false;
        if pUoMCode <> '' then begin
            lrecUnitOfMeasure.SetRange("B Code BejoNL", pUoMCode);
            if lrecUnitOfMeasure.FindFirst then
                if lrecUnitOfMeasure.Next = 0 then begin
                    pUoMCode := lrecUnitOfMeasure.Code;
                    Result := true;
                end;
        end;

    end;

    procedure SkipAllocationCheckMessages()
    begin

        gSkipAllocationCheckMessages := true;

    end;

    procedure FillLotTextForSales(var SalesLine: Record "Sales Line"; TextSales: Text[100])
    var
        lrecToSalesLine: Record "Sales Line";
        LineSpacing: Integer;
        NextLineNo: Integer;
        lText50000: Label 'There is not enough space to insert extended text lines.';
    begin

        lrecToSalesLine.SetRange("Document Type", SalesLine."Document Type");
        lrecToSalesLine.SetRange("Document No.", SalesLine."Document No.");

        lrecToSalesLine := SalesLine;
        if lrecToSalesLine.Find('>') then begin
            LineSpacing :=
              (lrecToSalesLine."Line No." - SalesLine."Line No.") div 2;
            if LineSpacing = 0 then
                Error(lText50000);
        end else
            LineSpacing := 10000;

        NextLineNo := SalesLine."Line No." + LineSpacing;

        lrecToSalesLine.Reset();
        lrecToSalesLine.SetRange("Document Type");
        lrecToSalesLine.SetRange("Document No.");
        lrecToSalesLine.Init;
        lrecToSalesLine."Document Type" := SalesLine."Document Type";
        lrecToSalesLine."Document No." := SalesLine."Document No.";
        lrecToSalesLine."Line No." := NextLineNo;
        lrecToSalesLine.Description := CopyStr(TextSales, 1, 50);
        lrecToSalesLine."Description 2" := CopyStr(TextSales, 51, 100);
        lrecToSalesLine."Attached to Line No." := SalesLine."Line No.";
        lrecToSalesLine.Validate("B Ship-to Code", SalesLine."B Ship-to Code");
        lrecToSalesLine.Insert;

    end;

    // procedure CreatePurchaseOrderXML(PurchaseOrderNo: Code[20])
    // var
    //     lrecPurchaseLine: Record "Purchase Line";
    //     LineText: Record "Purch. Comment Line";
    //     lrecBejoSetup: Record "Bejo Setup";
    //     lOutstrXML: OutStream;
    //     XMLFile: File;
    //     lServerFilename: Text[1024];
    //     lServerFilename_textline: Text[1024];
    //     lFilename: Text[1024];
    //     lFilename_textline: Text[1024];
    //     lErrTxt: Text[1024];
    //     lFileMgt: Codeunit "File Management";
    //     lIntstrXML: InStream;
    //     lReturnValue: Boolean;
    // begin

    //     lrecBejoSetup.Get;

    //     lFilename := lrecBejoSetup.ExportPath() + PurchaseOrderNo + '.xml';
    //     lFilename_textline := lrecBejoSetup.ExportPath() + PurchaseOrderNo + '_linetext.xml'; // 022

    //     lrecPurchaseLine.SetRange("Document Type", lrecPurchaseLine."Document Type"::Order);
    //     lrecPurchaseLine.SetRange("Document No.", PurchaseOrderNo);
    //     lrecPurchaseLine.FindSet(false, false);

    //     ClearLastError();

    //     lServerFilename := lFileMgt.ServerTempFileName('xml');
    //     XMLFile.Create(lServerFilename);
    //     XMLFile.CreateOutStream(lOutstrXML);
    //     XMLPORT.Export(XMLPORT::"Export Purch. Order", lOutstrXML, lrecPurchaseLine);
    //     XMLFile.Close;
    //     lFileMgt.DownloadToFile(lServerFilename, lFilename);

    //     lErrTxt := GetLastErrorText();
    //     if lErrTxt = '' then begin
    //         LineText.SetRange("No.", PurchaseOrderNo);
    //         LineText.SetRange(LineText."Document Type", LineText."Document Type"::Order);
    //         if LineText.FindSet then begin
    //             lServerFilename_textline := lFileMgt.ServerTempFileName('xml');
    //             XMLFile.Create(lServerFilename_textline);
    //             XMLFile.CreateOutStream(lOutstrXML);
    //             XMLPORT.Export(XMLPORT::"Export Purch. Line Text", lOutstrXML, LineText);
    //             XMLFile.Close;
    //             lFileMgt.DownloadToFile(lServerFilename_textline, lFilename_textline);

    //         end;
    //         Message(StrSubstNo(Text50003, PurchaseOrderNo));
    //     end;
    // end;

    // procedure CreatePurchaseCreditMemoXML(PurchaseOrderNo: Code[20])
    // var
    //     lrecPurchaseLine: Record "Purchase Line";
    //     LineText: Record "Purch. Comment Line";
    //     lrecBejoSetup: Record "Bejo Setup";
    //     lOutstrXML: OutStream;
    //     XMLFile: File;
    //     lServerFilename: Text[1024];
    //     lServerFilename_textline: Text[1024];
    //     lFilename: Text[1024];
    //     lFilename_textline: Text[1024];
    //     lErrTxt: Text[1024];
    //     lFileMgt: Codeunit "File Management";
    //     lIntstrXML: InStream;
    //     lReturnValue: Boolean;
    // begin
    //     lrecBejoSetup.Get;

    //     lFilename := lrecBejoSetup.ExportPath() + PurchaseOrderNo + '.xml';
    //     lFilename_textline := PurchaseOrderNo + '_linetext.xml';

    //     lrecPurchaseLine.SetRange("Document Type", lrecPurchaseLine."Document Type"::"Credit Memo");
    //     lrecPurchaseLine.SetRange("Document No.", PurchaseOrderNo);
    //     lrecPurchaseLine.FindSet(false, false);

    //     ClearLastError();

    //     lServerFilename := lFileMgt.ServerTempFileName('xml');
    //     XMLFile.Create(lServerFilename);
    //     XMLFile.CreateOutStream(lOutstrXML);
    //     XMLPORT.Export(XMLPORT::"Export Purch. Order", lOutstrXML, lrecPurchaseLine);
    //     XMLFile.Close;
    //     lFileMgt.DownloadToFile(lServerFilename, lFilename);

    //     lErrTxt := GetLastErrorText();
    //     if lErrTxt = '' then begin
    //         LineText.SetRange("No.", PurchaseOrderNo);

    //         if LineText.FindSet then begin
    //             lServerFilename_textline := lFileMgt.ServerTempFileName('xml');
    //             XMLFile.Create(lServerFilename_textline);
    //             XMLFile.CreateOutStream(lOutstrXML);
    //             XMLPORT.Export(XMLPORT::"Export Purch. Line Text", lOutstrXML, LineText);
    //             XMLFile.Close;
    //             lFileMgt.DownloadToFile(lServerFilename_textline, lFilename_textline);

    //         end;
    //         Message(StrSubstNo(Text50002, PurchaseOrderNo));
    //     end;
    // end;

    // procedure ProcessEOSS(PostingDate: Date; DocumentNo: Code[20])
    // var
    //     lrecBejoSetup: Record "Bejo Setup";
    //     ctEOSSlinesCreated: Label 'End of season stock lines created. (%1, %2)';
    //     ctEOSSAllocCreated: Label 'End of season allocation created.';
    // begin

    //     FillEOSSJournalLines(PostingDate, DocumentNo);
    //     FillEOSSperItem(PostingDate, DocumentNo);
    //     Message(ctEOSSlinesCreated, DocumentNo, PostingDate);

    //     lrecBejoSetup.Get;
    //     if lrecBejoSetup."Prognoses per Salesperson" then begin
    //         CreateEOSSAllocation(PostingDate, DocumentNo);
    //         CreateEOSSPurchaseQuote(PostingDate, DocumentNo);
    //         Message(ctEOSSAllocCreated, DocumentNo, PostingDate);
    //     end;
    // end;

    // local procedure FillEOSSJournalLines(PostingDate: Date; DocumentNo: Code[20])
    // var
    //     lrecEOSSJournalLine: Record "EOSS Journal Line";
    //     lrecItemJnlLine: Record "Item Journal Line";
    // begin
    //     lrecItemJnlLine.SetRange("Posting Date", PostingDate);
    //     lrecItemJnlLine.SetRange("Document No.", DocumentNo);
    //     if lrecItemJnlLine.FindSet(false, false) then
    //         repeat
    //             Clear(lrecEOSSJournalLine);
    //             lrecEOSSJournalLine.TransferFields(lrecItemJnlLine);
    //             lrecEOSSJournalLine.Insert(true);
    //         until lrecItemJnlLine.Next = 0;
    // end;

    // local procedure FillEOSSperItem(PostingDate: Date; DocumentNo: Code[20])
    // var
    //     lrecEOSSperItem: Record "EOSS per Item";
    //     lqQEOSSperItem: Query QEOSSperItem;
    //     lrecEOSSJournalLine: Record "EOSS Journal Line";
    //     lrecUOM: Record "Unit of Measure";
    //     lLastProcessedItemNo: Code[20];
    // begin
    //     if IsServiceTier then begin
    //         lqQEOSSperItem.SetRange(Posting_Date, PostingDate);
    //         lqQEOSSperItem.SetRange(Document_No, DocumentNo);
    //         lqQEOSSperItem.Open();
    //         while lqQEOSSperItem.Read do begin
    //             lrecEOSSperItem.Init;
    //             lrecEOSSperItem."Posting Date" := lqQEOSSperItem.Posting_Date;
    //             lrecEOSSperItem."Document No." := lqQEOSSperItem.Document_No;
    //             lrecEOSSperItem."Item No." := lqQEOSSperItem.Item_No;
    //             lrecEOSSperItem."Quantity in kg" := lqQEOSSperItem.B_Unit_in_Weight;
    //             if lrecEOSSperItem."Quantity in kg" then begin
    //                 lrecEOSSperItem.Quantity := lqQEOSSperItem.Sum_Quantity_Base;
    //             end
    //             else begin
    //                 lrecEOSSperItem.Quantity := lqQEOSSperItem.Sum_Quantity_Base / 1000000;
    //             end;
    //             lrecEOSSperItem.Insert(true);
    //         end;
    //         lqQEOSSperItem.Close();
    //     end

    //     else begin // NAV 2009
    //         lrecEOSSJournalLine.SetRange("Posting Date", PostingDate);
    //         lrecEOSSJournalLine.SetRange("Document No.", DocumentNo);
    //         lrecEOSSJournalLine.SetCurrentKey("Item No.");
    //         if lrecEOSSJournalLine.FindSet(false, false) then
    //             repeat
    //                 if lrecEOSSJournalLine."Item No." <> lLastProcessedItemNo then begin
    //                     lrecEOSSperItem.Init;
    //                     lrecEOSSperItem."Posting Date" := lrecEOSSJournalLine."Posting Date";
    //                     lrecEOSSperItem."Document No." := lrecEOSSJournalLine."Document No.";
    //                     lrecEOSSperItem."Item No." := lrecEOSSJournalLine."Item No.";
    //                     if lrecUOM.Get(lrecEOSSJournalLine."Unit of Measure Code") then begin
    //                         lrecEOSSperItem."Quantity in kg" := lrecUOM."B Unit in Weight";
    //                     end;
    //                     lrecEOSSJournalLine.CalcFields("Quantity per Item");
    //                     if lrecEOSSperItem."Quantity in kg" then begin
    //                         lrecEOSSperItem.Quantity := lrecEOSSJournalLine."Quantity per Item";
    //                     end
    //                     else begin
    //                         lrecEOSSperItem.Quantity := lrecEOSSJournalLine."Quantity per Item" / 1000000;
    //                     end;
    //                     if lrecEOSSperItem.Insert(true) then begin
    //                         lLastProcessedItemNo := lrecEOSSperItem."Item No.";
    //                     end;
    //                 end;
    //             until lrecEOSSJournalLine.Next = 0;
    //     end;
    // end;

    // local procedure CreateEOSSAllocation(PostingDate: Date; DocumentNo: Code[20])
    // var
    //     lrecPrognAllocEntry: Record "Prognosis/Allocation Entry";
    //     lrecBejoSetup: Record "Bejo Setup";
    //     lNewInternalEntryNo: Integer;
    //     lrecEOSSperItem: Record "EOSS per Item";
    // begin
    //     lrecBejoSetup.Get;
    //     lrecBejoSetup.TestField("Begin Date");
    //     lrecBejoSetup.TestField("End Date");

    //     lrecPrognAllocEntry.FindLast();
    //     lNewInternalEntryNo := lrecPrognAllocEntry."Internal Entry No." + 1;
    //     lrecEOSSperItem.SetRange("Posting Date", PostingDate);
    //     lrecEOSSperItem.SetRange("Document No.", DocumentNo);
    //     if lrecEOSSperItem.FindSet(true, false) then
    //         repeat
    //             with lrecPrognAllocEntry do begin
    //                 Init;
    //                 "Internal Entry No." := lNewInternalEntryNo;
    //                 lNewInternalEntryNo += 1;
    //                 "Item No." := lrecEOSSperItem."Item No.";
    //                 "Sales Date" := CalcDate('<+1Y>', lrecBejoSetup."End Date");
    //                 "User-ID" := 'BEJONL';
    //                 "Quantity in KG" := lrecEOSSperItem."Quantity in kg";
    //                 "Entry Type" := "Entry Type"::Allocation;
    //                 "Last Date Modified" := Today;
    //                 Allocated := lrecEOSSperItem.Quantity;
    //                 "Begin Date" := CalcDate('<+1Y>', lrecBejoSetup."Begin Date");
    //                 Description := 'End of Season Stock';
    //                 "Is Import from Bejo" := true;

    //                 if lrecPrognAllocEntry.Insert(true) then begin
    //                     lrecEOSSperItem."Allocation Created" := true;
    //                     lrecEOSSperItem."Allocation Date" := Today;
    //                     lrecEOSSperItem.Modify;
    //                 end;
    //             end;
    //         until lrecEOSSperItem.Next = 0;
    // end;

    // local procedure CreateEOSSPurchaseQuote(PostingDate: Date; DocumentNo: Code[20])
    // var
    //     lrecBejoSetup: Record "Bejo Setup";
    //     lrecPurchHeader: Record "Purchase Header";
    //     lrecPurchLine: Record "Purchase Line";
    //     lrecEOSSJournalLine: Record "EOSS Journal Line";
    // begin
    //     lrecBejoSetup.Get;
    //     lrecBejoSetup.TestField("Begin Date");
    //     lrecBejoSetup.TestField("Vendor No. BejoNL");

    //     lrecEOSSJournalLine.SetRange("Posting Date", PostingDate);
    //     lrecEOSSJournalLine.SetRange("Document No.", DocumentNo);
    //     if lrecEOSSJournalLine.FindSet(true, false) then begin
    //         lrecPurchHeader.Init;
    //         lrecPurchHeader."Document Type" := lrecPurchHeader."Document Type"::Quote;
    //         lrecPurchHeader.Validate("Buy-from Vendor No.", lrecBejoSetup."Vendor No. BejoNL");
    //         lrecPurchHeader.Validate("Requested Receipt Date", CalcDate('<+1Y>', lrecBejoSetup."Begin Date"));
    //         lrecPurchHeader.Validate("Posting Description", CopyStr(lrecEOSSJournalLine."Document No." + 'EOSS', 1, 50));
    //         if lrecPurchHeader.Insert(true) then
    //             repeat
    //                 lrecPurchLine.Init;
    //                 lrecPurchLine.Validate("Document Type", lrecPurchHeader."Document Type");
    //                 lrecPurchLine.Validate("Document No.", lrecPurchHeader."No.");
    //                 lrecPurchLine.Validate("Line No.", lrecEOSSJournalLine."Line No.");
    //                 lrecPurchLine.Validate("Buy-from Vendor No.", lrecPurchHeader."Buy-from Vendor No.");
    //                 lrecPurchLine.Validate(Type, lrecPurchLine.Type::Item);
    //                 lrecPurchLine.Validate("No.", lrecEOSSJournalLine."Item No.");
    //                 lrecPurchLine.Validate(Quantity, lrecEOSSJournalLine."Qty. (Phys. Inventory)");
    //                 lrecPurchLine.Validate("Unit of Measure Code", lrecEOSSJournalLine."Unit of Measure Code");
    //                 lrecPurchLine.Validate("Requested Receipt Date", lrecPurchHeader."Requested Receipt Date");
    //                 if lrecPurchLine.Insert(true) then begin
    //                     lrecEOSSJournalLine."Quote Created" := true;
    //                     lrecEOSSJournalLine."Quote Document No." := lrecPurchHeader."No.";
    //                     lrecEOSSJournalLine."Quote Date" := Today;
    //                     lrecEOSSJournalLine.Modify;
    //                 end;
    //             until lrecEOSSJournalLine.Next = 0;
    //     end;
    // end;

    // procedure ExportEOSS(PostingDate: Date; DocumentNo: Code[20])
    // var
    //     lXMLEOSS: XMLport "Export End Of Season Stock";
    //     lrecEOSSperItem: Record "EOSS per Item";
    //     ctNoRecFound: Label 'No records found to export. (%1, %2)';
    // begin
    //     lrecEOSSperItem.SetRange("Posting Date", PostingDate);
    //     lrecEOSSperItem.SetRange("Document No.", DocumentNo);
    //     if lrecEOSSperItem.FindSet(false, false) then begin
    //         lXMLEOSS.SetTableView(lrecEOSSperItem);
    //         lXMLEOSS.Run;
    //     end
    //     else
    //         Message(ctNoRecFound, DocumentNo, PostingDate);
    // end;

    procedure AllocationCheckSales(var ThePrognosisAllocationEntry: Record "Prognosis/Allocation Entry"; AllocatedCustSalesperson: Decimal)
    var
        UnitOfMeasure: Record "Unit of Measure";
        lrecItem: Record Item;
        SalesLine: Record "Sales Line";
        ItemLedgerEntry: Record "Item Ledger Entry";
        BejoSetup: Record "Bejo Setup";
        lrecSalesPersPrognAllocEntry: Record "Prognosis/Allocation Entry";
        PrognosisAllocationEntry: Record "Prognosis/Allocation Entry";
        TmpPrognosisAllocationEntry: Record "Prognosis/Allocation Entry" temporary;
        ActivePrognosisAllocationEntry: Record "Prognosis/Allocation Entry";
        ItemFilter: Text[100];
        AlternativeItemNo: Code[20];
        Factor: Decimal;
        TotalQtyToShip: Decimal;
        TotalQtyShipped: Decimal;
        ActiveRecordEntry: Integer;
        TotalAllocatedCustSalesp: Decimal;
        lAllocationScope: Text[30];
        lAllocated: Decimal;
        lPrognoses: Decimal;
        lTotalCountryAllocation: Decimal;
        AllocationExceeded: Boolean;
        ctModifySalesLine: Label 'Allocation Exceeded on the related sales lines has been modified. ';
    begin
        //BEJOW19.00.022 113688
        BejoSetup.Get;
        if not BejoSetup."Sales Allocation Check" then
            exit;

        if UnitOfMeasure.Get(ThePrognosisAllocationEntry."Unit of Measure") then begin

            if UnitOfMeasure."B Unit in Weight" then
                Factor := 1
            else
                Factor := 1000000;

        end else
            Factor := 1000000;

        if GetAlternativeItemNo(ThePrognosisAllocationEntry."Item No.", AlternativeItemNo) then
            ItemFilter := ThePrognosisAllocationEntry."Item No." + '|' + AlternativeItemNo
        else
            ItemFilter := ThePrognosisAllocationEntry."Item No.";

        SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
        SalesLine.SetRange(Type, SalesLine.Type::Item);
        SalesLine.SetFilter("No.", ItemFilter);
        SalesLine.SetRange("Shipment Date", BejoSetup."Begin Date", BejoSetup."End Date");
        if ThePrognosisAllocationEntry.Salesperson <> '' then
            SalesLine.SetRange("B Salesperson", ThePrognosisAllocationEntry.Salesperson);
        if ThePrognosisAllocationEntry.Customer <> '' then
            SalesLine.SetRange("Sell-to Customer No.", ThePrognosisAllocationEntry.Customer);
        if SalesLine.FindSet then repeat
                                      TotalQtyToShip += SalesLine."Qty. to Ship (Base)";
            until SalesLine.Next = 0;

        ItemLedgerEntry.SetCurrentKey("Entry Type", "Item No.");
        ItemLedgerEntry.SetRange("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
        ItemLedgerEntry.SetFilter("Item No.", ItemFilter);
        ItemLedgerEntry.SetRange("Posting Date", BejoSetup."Begin Date", BejoSetup."End Date");
        if ThePrognosisAllocationEntry.Salesperson <> '' then
            ItemLedgerEntry.SetRange("B Salesperson", ThePrognosisAllocationEntry.Salesperson);
        if ThePrognosisAllocationEntry.Customer <> '' then
            ItemLedgerEntry.SetRange("Source No.", ThePrognosisAllocationEntry.Customer);
        if ItemLedgerEntry.FindSet then repeat
                                            TotalQtyShipped -= ItemLedgerEntry.Quantity;
            until ItemLedgerEntry.Next = 0;

        AllocatedCustSalesperson := AllocatedCustSalesperson * Factor;

        AllocationExceeded := true;
        if AllocatedCustSalesperson >= (TotalQtyToShip + TotalQtyShipped) then
            AllocationExceeded := false;

        if not AllocationExceeded then begin

            Clear(SalesLine);
            SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
            SalesLine.SetRange(Type, SalesLine.Type::Item);
            SalesLine.SetFilter("No.", ItemFilter);
            SalesLine.SetRange("Shipment Date", BejoSetup."Begin Date", BejoSetup."End Date");
            if ThePrognosisAllocationEntry.Salesperson <> '' then
                SalesLine.SetRange("B Salesperson", ThePrognosisAllocationEntry.Salesperson);
            if ThePrognosisAllocationEntry.Customer <> '' then
                SalesLine.SetRange("Sell-to Customer No.", ThePrognosisAllocationEntry.Customer);
            SalesLine.SetFilter("B Allocation Exceeded", '<>%1', AllocationExceeded);

            if SalesLine.FindSet then begin

                Message(ctModifySalesLine);
                repeat
                    SalesLine."B Allocation Exceeded" := AllocationExceeded;
                    SalesLine.Modify;
                until SalesLine.Next = 0;

            end;

        end;
    end;

    procedure PrintProformaInvoice(SalesHeader: Record "Sales Header")
    var
        ReportSelection: Record "Report Selections";
    begin
       
        //ReportSelection.PrintWithGUIYesNo(ReportSelection.Usage::"92", SalesHeader, GuiAllowed, SalesHeader.FieldNo("Bill-to Customer No."));
    end;

    procedure PrintPickList(SalesHeader: Record "Sales Header")
    var
        ReportSelection: Record "Report Selections";
    begin
        
        //ReportSelection.PrintWithGUIYesNo(ReportSelection.Usage::"93", SalesHeader, GuiAllowed, SalesHeader.FieldNo("Bill-to Customer No."));
    end;

    procedure PrintPackingList(SalesHeader: Record "Sales Header")
    var
        ReportSelection: Record "Report Selections";
    begin
        
        //ReportSelection.PrintWithGUIYesNo(ReportSelection.Usage::"94", SalesHeader, GuiAllowed, SalesHeader.FieldNo("Bill-to Customer No."));
    end;

    procedure PrintProformaSlsCreditMemo(SalesHeader: Record "Sales Header")
    var
        ReportSelection: Record "Report Selections";
    begin
 
        //ReportSelection.PrintWithGUIYesNo(ReportSelection.Usage::"95", SalesHeader, GuiAllowed, SalesHeader.FieldNo("Bill-to Customer No."));
    end;

    procedure PrintProformaPurCreditMemo(PurchHeader: Record "Purchase Header")
    var
        ReportSelection: Record "Report Selections";
    begin

        //ReportSelection.PrintWithGUIYesNo(ReportSelection.Usage::"96", PurchHeader, GuiAllowed, PurchHeader.FieldNo("Buy-from Vendor No."));
    end;

    procedure LookUpCrop(var Text: Text[1024]): Boolean
    var
        lrecVariety: Record Varieties;
        lPageCropCropTypeLookup: Page "Mkt.Pot. Crop/Crop Type Lookup";
    begin
        
        lPageCropCropTypeLookup.GetCrops;
        lPageCropCropTypeLookup.FindText(Text);
        if lPageCropCropTypeLookup.RunModal = ACTION::LookupOK then begin
            lPageCropCropTypeLookup.GetRecord(lrecVariety);
            Text := lrecVariety."Crop Variant Code";
            exit(true);
        end;
    end;

    procedure LookUpCropType(CropCode: Code[20]; var Text: Text[1024]): Boolean
    var
        lrecVariety: Record Varieties;
        lPageCropCropTypeLookup: Page "Mkt.Pot. Crop/Crop Type Lookup";
    begin
        
        lPageCropCropTypeLookup.GetCropTypesForCrop(CropCode);
        lPageCropCropTypeLookup.FindText(Text);
        if lPageCropCropTypeLookup.RunModal = ACTION::LookupOK then begin
            lPageCropCropTypeLookup.GetRecord(lrecVariety);
            Text := lrecVariety."Crop Variant Code"; // form uses Crop to show Crop Type !
            exit(true);
        end;
    end;
}

