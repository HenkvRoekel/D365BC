report 50083 "Total Country Allocation"
{

    DefaultLayout = RDLC;
    RDLCLayout = './RDLC/Total Country Allocation.rdlc';

    Caption = 'Total Country Allocation';

    dataset
    {
        dataitem(Item; Item)
        {
            CalcFields = "B Prognoses", "B Country allocated", "Sales (Qty.)", "Qty. on Sales Order", "Qty. on Purch. Order", "Purchases (Qty.)";
            DataItemTableView = SORTING ("No.");
            RequestFilterFields = "No.", "Date Filter";
            column(COMPANYNAME; CompanyName)
            {
            }
            column(gItemFilter; gItemFilter)
            {
            }
            column(gListType; gListType)
            {
            }
            column(USERID; UserId)
            {
            }
            column(TodayDate; Format(Today, 0, 4))
            {
            }
            column(OrganicCheckmarkText; grecVariety.OrganicCheckmarkText)
            {
            }
            column(gInvoiced; gInvoiced)
            {
            }
            column(Countryallocated_Item; Item."B Country allocated")
            {
            }
            column(Prognoses_Item; Item."B Prognoses")
            {
                IncludeCaption = true;
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
            column(gInOrder; gInOrder)
            {
            }
            column(gRemainder; gRemainder)
            {
            }
            column(gItemInvQty; gItemInvQty)
            {
            }
            column(verbruikt; "%verbruikt")
            {
            }
            column(gefactvj; gefactvj)
            {
            }
            column(TxtPromoStatus; TxtPromoStatus)
            {
            }
            column(TxtBlockingCode; TxtBlockingCode)
            {
            }
            dataitem(CommentLine; "Integer")
            {
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
            begin

                gInvoiced := 0;
                gefactvj := 0;
                gInOrder := 0;
                gRemainder := 0;

                if grecUOM.Get(Item."Base Unit of Measure") then;

                Item.CalcFields("Purchases (Qty.)", "Qty. on Purch. Order", "B Country allocated", "B Prognoses", "B Qty. on Purch. Quote");


                CalcFields(Inventory);
                gItemInvQty := Inventory;



                if not grecVariety.Get("B Variety") then
                    grecVariety.Init;



                if not grecUOM."B Unit in Weight" then begin
                    "Purchases (Qty.)" := "Purchases (Qty.)" / 1000000;
                    "Qty. on Purch. Order" := "Qty. on Purch. Order" / 1000000;
                    "B Qty. on Purch. Quote" := "B Qty. on Purch. Quote" / 1000000;


                    gItemInvQty := gItemInvQty / 1000000;

                end;

                gInvoiced := Item."Purchases (Qty.)" + "B Qty. on Purch. Quote";
                gInOrder := Item."Qty. on Purch. Order";

                Art.Get("No.");
                Art.SetRange("Date Filter", gStartLY, gEndLY);
                Art.CalcFields("Purchases (Qty.)");

                if not grecUOM."B Unit in Weight" then
                    gefactvj := Art."Purchases (Qty.)" / 1000000
                else
                    gefactvj := Art."Purchases (Qty.)";

                gRemainder := 0;
                gRemainder := "B Country allocated" - gInOrder - gInvoiced;
                "%verbruikt" := 0;
                if "B Country allocated" <> 0 then
                    "%verbruikt" := -((gInvoiced + gInOrder) / "B Country allocated") * -100;
                if (gUsed > 0) and (gUsed > "%verbruikt") then
                    CurrReport.Skip;

                if PrintAllLines = false then begin
                    if Item."B Prognoses" + Item."B Country allocated" = 0 then
                        CurrReport.Skip;
                end else begin
                    if Item."B Prognoses" + Item."B Country allocated" + gInOrder + gInvoiced + gefactvj = 0 then
                        CurrReport.Skip;
                end;


                if ((Round("B Country allocated")) >= (Round("B Prognoses"))) and (gToAllocatePrognosis = true) then
                    CurrReport.Skip;


                if (gProgosisYesAllocatedNo = true) then begin
                    if ("B Prognoses" = 0) then
                        CurrReport.Skip;
                    if "B Country allocated" <> 0 then
                        CurrReport.Skip;
                end;


                CalcFields("B Promo Status");

                TxtBlockingCode := lcuBlockingMgt.ItemBlockCode(Item) + '.';
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
                    CommentLine2.SetRange("No.", Item."No.");
                    CommentLine2.SetRange("B Comment Type", CommentLine2."B Comment Type"::Salesperson);
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

                gItemFilter := Item.GetFilters;


                grecBejoSetup.Get;


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
                    field(gProgosisYesAllocatedNo; gProgosisYesAllocatedNo)
                    {
                        Caption = 'No Allocation';
                        ApplicationArea = All;
                    }
                    field(PrintAllLines; PrintAllLines)
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
        ReportName = 'Total Country Allocation';
        lblAllocation = 'Allocation';
        lblInOrder = 'In Order';
        lblInPurchOrder = 'In Purch. Order';
        lblPurchases = 'Purchases';
        lblRest = 'Rest';
        lblInventory = 'Inventory';
        lblUses = '% Used';
        lblPurchaseLY = 'Purchase LY';
        lblPS = 'PS';
        lblBC = 'BC';
    }

    trigger OnInitReport()
    begin

        if grecUser.Get(UserId) then;


        grecBejoSetup.Get;


    end;

    var
        gLanguage: Code[10];
        grecUOM: Record "Unit of Measure";
        grecUser: Record "User Setup";
        gInvoiced: Decimal;
        gefactvj: Decimal;
        gItemInvQty: Decimal;
        gToAllocatePrognosis: Boolean;
        gPrintToExcel: Boolean;
        gListType: Text[30];
        gProgosisYesAllocatedNo: Boolean;
        gUsed: Decimal;
        "%verbruikt": Decimal;
        gItemFilter: Text[80];
        k: Integer;
        gInOrder: Decimal;
        gStartCY: Date;
        gStartLY: Date;
        gEndCY: Date;
        gEndLY: Date;
        gRemainder: Decimal;
        Art: Record Item;
        int5: Boolean;
        int7: Boolean;
        ext5: Boolean;
        ext7: Boolean;
        grecLanguage: Record Language;
        TxtPromoStatus: Text[30];
        TxtBlockingCode: Text[30];
        PrintAllLines: Boolean;
        grecBejoSetup: Record "Bejo Setup";
        FileName: Text[250];
        gcuBejoMgt: Codeunit "Bejo Management";
        lcuBlockingMgt: Codeunit "Blocking Management";
        grecVariety: Record Varieties;
        text50000: Label 'Item no.';
        text50001: Label 'Description';
        text50002: Label 'Prognoses';
        text50003: Label 'Allocation';
        text50004: Label 'In Purchase Order';
        text50005: Label 'Purchases';
        text50006: Label 'Rest';
        text50007: Label '% used';
        text50008: Label 'Purchases LY';
        text50009: Label 'Promostatus';
        text50010: Label 'Blocking Code';
        Text50011: Label 'Inventory';
        Text50050: Label 'File Name';
        Text50012: Label 'ORG';
        RECCommentLine1: Record "Comment Line";
        txtCommentLine1: Text[1024];
        txtCommentLine2: Text[1024];
        iLength: Integer;
        CommentLine2: Record "Comment Line";
        CommentLine1: Record "Comment Line";
        TempCommentLine: Record "Comment Line" temporary;
}

