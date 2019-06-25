report 50084 "Allocation per Salesperson"
{

    DefaultLayout = RDLC;
    RDLCLayout = './RDLC/Allocation per Salesperson.rdlc';


    dataset
    {
        dataitem(Item; Item)
        {
            CalcFields = "B Prognoses", "B Country allocated", "Sales (Qty.)", "B Qty. to Invoice", "B Allocated";
            DataItemTableView = SORTING ("No.");
            RequestFilterFields = "No.", "Date Filter";
            column(COMPANYNAME; CompanyName)
            {
            }
            column(gItemFilter; gItemFilter)
            {
            }
            column(grReqformfilter; grReqformfilter)
            {
            }
            column(TodayDate; Format(Today, 0, 4))
            {
            }
            column(USERID; UserId)
            {
            }
            column(Prognoses_Item; Item."B Prognoses")
            {
                IncludeCaption = true;
            }
            column(Countryallocated_Item; Item."B Country allocated")
            {
            }
            column(No_Item; Item."No.")
            {
                IncludeCaption = true;
            }
            column(Description_Item; Item.Description)
            {
                IncludeCaption = true;
            }
            column(Description2_Item; Item."Description 2")
            {
                IncludeCaption = true;
            }
            column(gItemInvQty; gItemInvQty)
            {
            }
            column(gRemainingAllocation; gRemainingAllocation)
            {
            }
            column(TxtPromoStatus; TxtPromoStatus)
            {
            }
            column(TxtBlockingCode; TxtBlockingCode)
            {
            }
            column(gShowTotal; gShowTotal)
            {
            }
            dataitem("Salesperson/Purchaser"; "Salesperson/Purchaser")
            {
                RequestFilterFields = "Code";
                column(Name_SalespersonPurchaser; "Salesperson/Purchaser".Name)
                {
                }
                column(Code_SalespersonPurchaser; "Salesperson/Purchaser".Code)
                {
                }
                column(vert_klantrogn; "vert/klantprogn")
                {
                }
                column(gSalespAllocated; gSalespAllocated)
                {
                }
                column(gInOrder; gInOrder)
                {
                }
                column(gInvoiced; gInvoiced)
                {
                }
                column(gRemainder; gRemainder)
                {
                }
                column(gPercentageUsed; gPercentageUsed)
                {
                }
                column(gInvoicedLY; gInvoicedLY)
                {
                }
                column(dTotal; dTotal)
                {
                }
                dataitem(CommentLine; "Integer")
                {
                    DataItemTableView = SORTING (Number);
                    column(TableNo_CommentLine; TempCommentLine."Table Name")
                    {
                    }
                    column(No_CommentLine; TempCommentLine."No.")
                    {
                    }
                    column(LineNo_CommentLine; TempCommentLine."Line No.")
                    {
                    }
                    column(Comment_CommentLine; TempCommentLine.Comment)
                    {
                    }
                    column(CreationDate_CommentLine; Format(TempCommentLine."B Creation Date", 0, 0))
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        if Number = 1 then
                            TempCommentLine.FindFirst
                        else
                            TempCommentLine.Next;
                    end;

                    trigger OnPreDataItem()
                    begin
                        SetRange(Number, 1, TempCommentLine.Count);
                    end;
                }

                trigger OnAfterGetRecord()
                var
                    lUnitofMeasure: Record "Unit of Measure";
                begin

                    gInOrder := 0;
                    gInvoiced := 0;
                    gInvoicedLY := 0;
                    "vert/klantprogn" := 0;
                    gPercentageUsed := 0;

                    gInOrder := 0;
                    grecSalesLine.Init;
                    grecSalesLine.SetCurrentKey("Document Type", Type, "No.");
                    grecSalesLine.SetRange(grecSalesLine."Document Type", grecSalesLine."Document Type"::Order);
                    grecSalesLine.SetRange(grecSalesLine.Type, grecSalesLine.Type::Item);
                    grecSalesLine.SetRange(grecSalesLine."No.", Item."No.");
                    grecSalesLine.SetRange("B Salesperson", "Salesperson/Purchaser".Code);
                    if grecSalesLine.Find('-') then
                        repeat

                            gInOrder := gInOrder + grecSalesLine."Qty. to Invoice (Base)";

                        until grecSalesLine.Next = 0;

                    recrasbudgetpost.Reset;

                    recrasbudgetpost.SetCurrentKey("Entry Type", "Item No.", "Unit of Measure", "Sales Date", Salesperson);


                    recrasbudgetpost.SetRange(recrasbudgetpost."Item No.", Item."No.");
                    recrasbudgetpost.SetRange("Sales Date", gStartCY, gEndCY);
                    recrasbudgetpost.SetRange(recrasbudgetpost.Salesperson, "Salesperson/Purchaser".Code);
                    recrasbudgetpost.CalcSums("Allocated Cust. Sales person", Prognoses);
                    "vert/klantprogn" := recrasbudgetpost.Prognoses;
                    gSalespAllocated := recrasbudgetpost."Allocated Cust. Sales person";

                    grecILE.Reset;
                    grecILE.SetCurrentKey(grecILE."Entry Type", grecILE."Item No.");
                    grecILE.SetRange(grecILE."Entry Type", grecILE."Entry Type"::Sale);

                    grecILE.SetRange("Posting Date", grecBejoSetup."Begin Date", grecBejoSetup."End Date");
                    grecILE.SetRange(grecILE."Item No.", Item."No.");
                    grecILE.SetRange("B Salesperson", "Salesperson/Purchaser".Code);
                    if grecILE.Find('-') then
                        repeat
                            if grecILE."B Salesperson" = "Salesperson/Purchaser".Code then
                                gInvoiced := gInvoiced + grecILE."Invoiced Quantity";
                        until grecILE.Next = 0;
                    grecILE.SetRange("Posting Date", gStartLY, gEndLY);
                    if grecILE.Find('-') then
                        repeat
                            if grecILE."B Salesperson" = "Salesperson/Purchaser".Code then
                                gInvoicedLY := gInvoicedLY + grecILE."Invoiced Quantity";
                        until grecILE.Next = 0;


                    lUnitofMeasure.Get(Item."Base Unit of Measure");

                    if not lUnitofMeasure."B Unit in Weight" then begin
                        gInvoiced := -gInvoiced / 1000000;
                        gInvoicedLY := -gInvoicedLY / 1000000;
                        gInOrder := gInOrder / 1000000;
                    end else begin
                        gInvoiced := -gInvoiced;
                        gInvoicedLY := -gInvoicedLY;
                    end;
                    gRemainder := 0;
                    gRemainder := gSalespAllocated - gInOrder - gInvoiced;

                    if gSalespAllocated <> 0 then
                        gPercentageUsed := -((gInvoiced + gInOrder) / gSalespAllocated) * -100;

                    dTotal := "vert/klantprogn" + gRemainder + gInOrder + gSalespAllocated + gInvoiced + gInvoicedLY;



                end;
            }

            trigger OnAfterGetRecord()
            begin

                gInvoiced := 0;
                gInvoicedLY := 0;
                gInOrder := 0;
                gRemainder := 0;
                gRemainingAllocation := 0;


                CalcFields(Inventory);
                gItemInvQty := Inventory;


                if grecUOM.Get(Item."Base Unit of Measure") then;

                if not grecUOM."B Unit in Weight" then begin
                    "Sales (Qty.)" := "Sales (Qty.)" / 1000000;

                    "B Qty. to Invoice" := "B Qty. to Invoice" / 1000000;

                    gItemInvQty := gItemInvQty / 1000000;

                end;

                gInvoiced := Item."Sales (Qty.)";

                gInOrder := Item."B Qty. to Invoice";


                grecItem.Get("No.");
                grecItem.SetRange("Date Filter", gStartLY, gEndLY);
                grecItem.CalcFields("Sales (Qty.)");

                if not grecUOM."B Unit in Weight" then
                    gInvoicedLY := grecItem."Sales (Qty.)" / 1000000
                else
                    gInvoicedLY := grecItem."Sales (Qty.)";

                gRemainder := 0;
                gRemainder := "B Country allocated" - gInOrder - gInvoiced;
                gPercentageUsed := 0;
                if "B Country allocated" <> 0 then
                    gPercentageUsed := -((gInvoiced + gInOrder) / "B Country allocated") * -100;
                if (gUsed > 0) and (gUsed > gPercentageUsed) then
                    CurrReport.Skip;

                if gPrintAllLines = false then begin
                    if Item."B Prognoses" + Item."B Country allocated" = 0 then
                        CurrReport.Skip;
                end else begin
                    if Item."B Prognoses" + Item."B Country allocated" + gInOrder + gInvoiced + gInvoicedLY = 0 then
                        CurrReport.Skip;
                end;

                if ((Round("B Allocated")) >= (Round("B Prognoses"))) and (gToAllocatePrognosis = true) then
                    CurrReport.Skip;

                if (gPrognosisYesAllocatedNo = true) then begin
                    if ("B Prognoses" = 0) then
                        CurrReport.Skip;
                    if "B Country allocated" <> 0 then
                        CurrReport.Skip;
                end;

                gRemainingAllocation := "B Country allocated" - "B Allocated";


                CalcFields("B Promo Status");

                TxtBlockingCode := gcuBlockingMgt.ItemBlockCode(Item) + '.';
                TxtPromoStatus := Item."B Promo Status" + '.';


                TempCommentLine.DeleteAll;

                if (int5 or ext5) then begin

                    CommentLine1.Reset;
                    CommentLine1.SetRange("Table Name", CommentLine1."Table Name"::Item);
                    CommentLine1.SetRange("B Variety", Item."B Variety");
                    CommentLine1.SetRange("B Comment Type", CommentLine1."B Comment Type"::"Var 5 pos");
                    CommentLine1.SetRange("B End Date", Today, DMY2Date(31, 12, 9999));
                    if not (int5 and ext5) then begin

                        if int5 then
                            CommentLine1.SetRange("B Show", CommentLine1."B Show"::Internal);
                        if ext5 then
                            CommentLine1.SetRange("B Show", CommentLine1."B Show"::External);

                    end;

                    if CommentLine1.FindSet then repeat

                                                     TempCommentLine.Init;
                                                     TempCommentLine := CommentLine1;
                                                     TempCommentLine.Insert;

                        until CommentLine1.Next = 0;

                end;

                if (int7 or ext7) then begin

                    CommentLine2.Reset;
                    CommentLine2.SetRange("Table Name", CommentLine2."Table Name"::Item);
                    CommentLine2.SetRange("B Comment Type", CommentLine2."B Comment Type"::Salesperson);
                    CommentLine2.SetRange("No.", Item."No.");
                    CommentLine2.SetRange("B End Date", Today, DMY2Date(31, 12, 9999));
                    if not (int7 and ext7) then begin

                        if int7 then
                            CommentLine2.SetRange("B Show", CommentLine2."B Show"::Internal);
                        if ext7 then
                            CommentLine2.SetRange("B Show", CommentLine2."B Show"::External);

                    end;

                    if CommentLine2.FindSet then repeat

                                                     TempCommentLine.Init;
                                                     TempCommentLine := CommentLine2;
                                                     TempCommentLine.Insert;

                        until CommentLine2.Next = 0;

                end;



            end;

            trigger OnPostDataItem()
            begin


            end;

            trigger OnPreDataItem()
            begin

                grecBejoSetup.Get;
                gItemFilter := Item.GetFilters;

                if gPrognosisYesAllocatedNo = true then
                    grReqformfilter := text50000;
                if gToAllocatePrognosis = true then
                    grReqformfilter := text50001;


                gStartCY := grecBejoSetup."Begin Date";
                gEndCY := grecBejoSetup."End Date";

                gStartLY := CalcDate('<-1Y>', gStartCY);
                gEndLY := CalcDate('<-1Y>', gEndCY);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(gToAllocatePrognosis; gToAllocatePrognosis)
                    {
                        Caption = 'Prognoses > Allocation';
                        ApplicationArea = All;
                    }
                    field(gPrognosisYesAllocatedNo; gPrognosisYesAllocatedNo)
                    {
                        Caption = 'No Allocation';
                        ApplicationArea = All;
                    }
                    field(gPrintAllLines; gPrintAllLines)
                    {
                        Caption = 'Print All Lines';
                        ApplicationArea = All;
                    }
                    field(gUsed; gUsed)
                    {
                        Caption = 'Print % used';
                        ApplicationArea = All;
                    }
                    field(gLanguage; gLanguage)
                    {
                        Caption = 'Language';
                        TableRelation = Language;
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin

                            CurrReport.Language := grecLanguage.GetLanguageID(gLanguage);
                        end;
                    }
                    field(gShowTotal; gShowTotal)
                    {
                        Caption = 'Print Item Total';
                        ApplicationArea = All;
                    }
                    field(int5; int5)
                    {
                        Caption = 'Print internal comments variety';
                        ApplicationArea = All;
                    }
                    field(int7; int7)
                    {
                        Caption = 'Print internal comments salesperson';
                        ApplicationArea = All;
                    }
                    field(ext5; ext5)
                    {
                        Caption = 'Print external comments variety';
                        ApplicationArea = All;
                    }
                    field(ext7; ext7)
                    {
                        Caption = 'Print external comments salesperson';
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin

            int5 := true;
            int7 := true;
            ext5 := true;
            ext7 := true;
        end;
    }

    labels
    {
        ReportName = 'Allocation per Salesperson';
        lblAllocation = 'Allocation';
        lblInOrder = 'In Order';
        lblSales = 'Sales';
        lblRestToSell = 'Rest to sell';
        lblInventory = 'Inventory';
        lblUsed = '% Used';
        lblSalesLY = 'Sales LY';
        lblRestAllocation = 'Rest allocation';
        lblPS = 'PS';
        lblBC = 'BC';
    }

    trigger OnInitReport()
    begin
        //IF grecUser.GET(USERID) THEN;
        gShowTotal := true;
        // - BEJOWW5.0.006 ---
        grecBejoSetup.Get;
        // - BEJOW18.00.019 ---
        // gFileNameX := grecBejoSetup.ExportPath + text50002+'.xls';
        // + BEJOW18.00.019 +++
    end;

    trigger OnPreReport()
    begin
        gSalespersonFilter := "Salesperson/Purchaser".GetFilter(Code);
    end;

    var
        gLanguage: Code[10];
        grecUOM: Record "Unit of Measure";
        grecUser: Record User;
        gInvoiced: Decimal;
        gInvoicedLY: Decimal;
        gItemInvQty: Decimal;
        gToAllocatePrognosis: Boolean;
        recrasbudgetpost: Record "Prognosis/Allocation Entry";
        gSalespAllocated: Decimal;
        gPrintToExcel: Boolean;
        gPrognosisYesAllocatedNo: Boolean;
        gUsed: Decimal;
        gPercentageUsed: Decimal;
        gItemFilter: Text[300];
        gSalespersonFilter: Text[10];
        k: Integer;
        gInOrder: Decimal;
        "vert/klantprogn": Decimal;
        gStartCY: Date;
        gStartLY: Date;
        gEndCY: Date;
        gEndLY: Date;
        grecILE: Record "Item Ledger Entry";
        gRemainder: Decimal;
        grecSalesLine: Record "Sales Line";
        grecItem: Record Item;
        grReqformfilter: Text[100];
        gShowTotal: Boolean;
        int5: Boolean;
        int7: Boolean;
        ext5: Boolean;
        ext7: Boolean;
        grecLanguage: Record Language;
        gRemainingAllocation: Decimal;
        TxtPromoStatus: Text[30];
        TxtBlockingCode: Text[30];
        gPrintAllLines: Boolean;
        grecBejoSetup: Record "Bejo Setup";
        gcuBejoMgt: Codeunit "Bejo Management";
        gcuBlockingMgt: Codeunit "Blocking Management";
        text50000: Label 'No Allocation';
        text50001: Label 'Prognoses > Allocation';
        text50003: Label 'Item No.';
        text50004: Label 'Description';
        text50005: Label 'Prognoses';
        text50006: Label 'Allocation';
        text50007: Label 'In Sales Order';
        text50008: Label 'Sales';
        text50009: Label 'Rest';
        text50010: Label '% used';
        text50011: Label 'Sales LY';
        text50012: Label 'to sell';
        text50013: Label 'Promo Status';
        text50014: Label 'Blocking Code';
        Text50050: Label 'File Name';
        Text50015: Label 'Inventory';
        dTotal: Decimal;
        igInvoiced: Decimal;
        igInvoicedLY: Decimal;
        igInOrder: Decimal;
        igRemainder: Decimal;
        igRemainingAllocation: Decimal;
        igItemInvQty: Decimal;
        igPercentageUsed: Decimal;
        txtCommentLine1: Text[1024];
        txtCommentLine2: Text[1024];
        RECCommentLine1: Record "Comment Line";
        iLength: Integer;
        CommentLine2: Record "Comment Line";
        CommentLine1: Record "Comment Line";
        TempCommentLine: Record "Comment Line" temporary;
}

