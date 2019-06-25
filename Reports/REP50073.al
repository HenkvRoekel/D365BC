report 50073 "Inventory per Unit of Measure"
{

    DefaultLayout = RDLC;
    RDLCLayout = './RDLC/Inventory per Unit of Measure.rdlc';


    dataset
    {
        dataitem(Item; Item)
        {
            CalcFields = Inventory;
            DataItemTableView = SORTING ("No.") WHERE (Inventory = FILTER (<> 0));
            RequestFilterFields = "No.";
            column(UserId; UserId)
            {
            }
            column(CompanyName; CompanyName)
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
            column(Inventory_Item; Item.Inventory)
            {
            }
            dataitem("Item Unit of Measure"; "Item Unit of Measure")
            {
                DataItemLink = "Item No." = FIELD ("No.");
                DataItemTableView = SORTING ("Item No.", Code);
                column(ExtCode_ItemExtension; ItemExtension."Extension Code")
                {
                }
                column(UnitAvailable_item; ItemLedgerEntry.Quantity - TrackingQuantity)
                {
                }
                column(Available_Item; Item.Inventory - TrackingQuantityPerItem)
                {
                }
                column(QuantityInunitofmeasure; QuantityInunitofmeasure)
                {
                }
                column(Perc; Perc)
                {
                }
                column(Code_ItemUnitofMeasure; "Item Unit of Measure".Code)
                {
                }
                column(FirstOfItem; FirstOfItem)
                {
                }

                trigger OnAfterGetRecord()
                begin

                    ItemLedgerEntry.SetCurrentKey("Item No.", "Unit of Measure Code");
                    ItemLedgerEntry.SetRange("Item No.", Item."No.");
                    ItemLedgerEntry.SetRange("Unit of Measure Code", Code);
                    ItemLedgerEntry.CalcSums(Quantity);

                    if (ItemLedgerEntry.Quantity = 0) then
                        CurrReport.Skip;

                    if (Item."No." = currentItem) and FirstOfItem then
                        FirstOfItem := false;
                    currentItem := Item."No.";

                    SalesLine.SetCurrentKey(Type, "No.");
                    SalesLine.SetRange(SalesLine.Type, SalesLine.Type::Item);
                    SalesLine.SetRange("No.", Item."No.");
                    SalesLine.SetFilter("Unit of Measure Code", Code);
                    TrackingQuantity := 0;
                    if SalesLine.Find('-') then
                        repeat
                            SalesLine.CalcFields("B Tracking Quantity");
                            TrackingQuantity := TrackingQuantity + (SalesLine."B Tracking Quantity" * "Item Unit of Measure"."Qty. per Unit of Measure");
                        until (SalesLine.Next = 0);

                    if (Item.Inventory - TrackingQuantityPerItem) <> 0 then
                        Perc := ((ItemLedgerEntry.Quantity - TrackingQuantity) / (Item.Inventory - TrackingQuantityPerItem)) * 100 else
                        Perc := 0;

                    if ("Qty. per Unit of Measure" <> 0) then
                        QuantityInunitofmeasure := (ItemLedgerEntry.Quantity - TrackingQuantity) / "Qty. per Unit of Measure" else
                        QuantityInunitofmeasure := 0;


                    if PrintToExcel and (ItemLedgerEntry.Quantity <> 0) then begin

                        ExcelBuf.NewRow;

                        ExcelBuf.AddColumn("Item No.", false, '', false, false, false, '#', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn(Item.Description, false, '', false, false, false, '#', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn(Item."Description 2", false, '', false, false, false, '#', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn(ItemExtension."Extension Code", false, '', false, false, false, '#', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn(Format(Item.Inventory), false, '', false, false, false, '#', ExcelBuf."Cell Type"::Number);
                        ExcelBuf.AddColumn(Format(Item.Inventory - TrackingQuantityPerItem), false, '', false, false, false, '#', ExcelBuf."Cell Type"::Number);


                        ExcelBuf.AddColumn(Format(ItemLedgerEntry.Quantity - TrackingQuantity), false, '', false, false, false, '#', ExcelBuf."Cell Type"::Number);
                        ExcelBuf.AddColumn(Format(QuantityInunitofmeasure), false, '', false, false, false, '#', ExcelBuf."Cell Type"::Number);
                        ExcelBuf.AddColumn(Code, false, '', false, false, false, '#', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn(Format(Round(Perc, 1, '>')) + '%', false, '', false, false, false, '#', ExcelBuf."Cell Type"::Text);
                    end;
                end;
            }

            trigger OnAfterGetRecord()
            var
                lSalesLine: Record "Sales Line";
            begin
                if ItemExtension.Get("B Extension") then;
                FirstOfItem := true;

                lSalesLine.SetCurrentKey(Type, "No.");
                lSalesLine.SetRange(lSalesLine.Type, SalesLine.Type::Item);
                lSalesLine.SetRange("No.", "No.");
                TrackingQuantityPerItem := 0;
                if lSalesLine.Find('-') then
                    repeat
                        lSalesLine.CalcFields("B Tracking Quantity");
                        TrackingQuantityPerItem := TrackingQuantityPerItem +
                                                   (lSalesLine."B Tracking Quantity" * lSalesLine."Qty. per Unit of Measure");
                    until (lSalesLine.Next = 0);
            end;

            trigger OnPostDataItem()
            begin


            end;

            trigger OnPreDataItem()
            var
                text50001: Label 'Item No.';
                text50002: Label 'Description';
                text50003: Label 'Description 2';
                text50004: Label 'Item Extension';
                text50005: Label 'Inventory';
                text50006: Label 'Not Reserved Inventory';
                text50007: Label 'Inventory per Unit of Measure (Base)';
                text50008: Label 'Inventory per Unit of Measure per Unit of Measure ';
                text50009: Label 'Unit of Measure';
                text50010: Label 'Percentage';
            begin
                LastFieldNo := FieldNo("No.");


                if PrintToExcel then begin
                    ExcelBuf.AddColumn(text50001, false, '', true, false, false, '#', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(text50002, false, '', true, false, false, '#', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(text50003, false, '', true, false, false, '#', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(text50004, false, '', true, false, false, '#', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(text50005, false, '', true, false, false, '#', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(text50006, false, '', true, false, false, '#', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(text50007, false, '', true, false, false, '#', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(text50008, false, '', true, false, false, '#', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(text50009, false, '', true, false, false, '#', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(text50010, false, '', true, false, false, '#', ExcelBuf."Cell Type"::Text);
                end;
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
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
        lblReportName = 'Item Stocklist per Unit of Measure';
        lblDesc3 = 'Descr. 3';
        lblItemTotal = 'Item Total';
        lblItemAvail = 'Item Available';
        lblUnitAvail = 'Unit Available';
        lblQty = 'Quantity';
        lblunit = 'Unit';
        lblPercentage = 'Percentage';
    }

    trigger OnInitReport()
    begin
        ExcelBuf.DeleteAll;

        BejoSetup.Get;


    end;

    trigger OnPostReport()
    begin
        if PrintToExcel then begin
            ExcelBuf.CreateNewBook(text50000);
            ExcelBuf.WriteSheet(text50000, CompanyName, UserId);
            ExcelBuf.CloseBook;
            ExcelBuf.OpenExcel();
        end;
    end;

    var
        LastFieldNo: Integer;
        ItemLedgerEntry: Record "Item Ledger Entry";
        SalesLine: Record "Sales Line";
        TrackingQuantity: Decimal;
        ItemExtension: Record "Item Extension";
        Perc: Decimal;
        FirstOfItem: Boolean;
        QuantityInunitofmeasure: Decimal;
        PrintToExcel: Boolean;
        Row: Integer;
        TrackingQuantityPerItem: Decimal;
        BejoSetup: Record "Bejo Setup";
        FileName: Text[250];
        gcuBejoMgt: Codeunit "Bejo Management";
        text50000: Label 'Inventory list';
        Text50050: Label 'File Name';
        currentItem: Code[30];
        ExcelBuf: Record "Excel Buffer" temporary;
}

