page 50180 ValueEntryExtended
{


    PageType = List;
    SourceTable = "Value Entry";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item No."; "Item No.")
                {
                    ApplicationArea = All;
                }
                field("Item Ledger Entry Type"; "Item Ledger Entry Type")
                {
                    ApplicationArea = All;
                }
                field("Source No. (Customer/Vendor)"; "Source No.")
                {
                    Caption = '<Source No. (Customer / Vendor)>';
                    ApplicationArea = All;
                }
                field("Document No."; "Document No.")
                {
                    ApplicationArea = All;
                }
                field("Item Description"; Description)
                {
                    Caption = 'Item Description';
                    ApplicationArea = All;
                }
                field("Location Code"; "Location Code")
                {
                    ApplicationArea = All;
                }
                field("Inventory Posting Group"; "Inventory Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Valued Quantity"; "Valued Quantity")
                {
                    ApplicationArea = All;
                }
                field("Item Ledger Entry Quantity"; "Item Ledger Entry Quantity")
                {
                    ApplicationArea = All;
                }
                field("Invoiced Quantity"; "Invoiced Quantity")
                {
                    ApplicationArea = All;
                }
                field("Sales Amount (Actual)"; "Sales Amount (Actual)")
                {
                    ApplicationArea = All;
                }
                field("Source Code"; "Source Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Source_Type (Customer/Vendor)"; "Source Type")
                {
                    Caption = 'Source_Type (Customer/Vendor)';
                    ApplicationArea = All;
                }
                field("Reason Code"; "Reason Code")
                {
                    ApplicationArea = All;
                }
                field("Drop Shipment"; "Drop Shipment")
                {
                    ApplicationArea = All;
                }
                field("Gen. Bus. Posting Group"; "Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("CostAmount(Actual)"; -1 * "Cost Amount (Actual)")
                {
                    ApplicationArea = All;
                }
                field("Item Charge No."; "Item Charge No.")
                {
                    ApplicationArea = All;
                }
                field("Variant Code"; "Variant Code")
                {
                    ApplicationArea = All;
                }
                field("Return Reason Code"; "Return Reason Code")
                {
                    ApplicationArea = All;
                }
                field("Purchase Amount (Actual)"; "Purchase Amount (Actual)")
                {
                    ApplicationArea = All;
                }
                field("Cost per Unit"; "Cost per Unit")
                {
                    ApplicationArea = All;
                }
                field("Discount Amount"; "Discount Amount")
                {
                    ApplicationArea = All;
                }
                field("Salespers./Purch. Code"; "Salespers./Purch. Code")
                {
                    ApplicationArea = All;
                }
                field("Sales person name"; gRecSalesperson.Name)
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Calendar Year"; Date2DWY("Posting Date", 3))
                {
                    ApplicationArea = All;
                }
                field(Week; Date2DWY("Posting Date", 2))
                {
                    ApplicationArea = All;
                }
                field(Month; Date2DMY("Posting Date", 2))
                {
                    ApplicationArea = All;
                }
                field("Current Month"; Date2DMY(Today, 2))
                {
                    ApplicationArea = All;
                }
                field("Last Month"; Date2DMY(Today, 2) - 1)
                {
                    ApplicationArea = All;
                }
                field("Current Fiscal Year"; gTextCFY)
                {
                    ApplicationArea = All;
                }
                field("Current Calender Year"; Date2DWY(Today, 3))
                {
                    ApplicationArea = All;
                }
                field("Last Fiscal Year"; gTextLFY)
                {
                    ApplicationArea = All;
                }
                field("Last Calender Year"; Date2DWY(Today, 3) - 1)
                {
                    ApplicationArea = All;
                }
                field(Margin; "Sales Amount (Actual)" - "Cost Amount (Actual)")
                {
                    ApplicationArea = All;
                }
                field(YYYYMM; gTextYYYYMM)
                {
                    ApplicationArea = All;
                }
                field("Fiscal Year"; gTextFY)
                {
                    ApplicationArea = All;
                }
                field(YTDTO; gDateYTDTO)
                {
                    ApplicationArea = All;
                }
                field(QuantityBase; -1 * "Item Ledger Entry Quantity")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; gRecILE."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Qty. per Unit of Measure"; gRecILE."Qty. per Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field("Remaining Quantity"; gRecILE."Remaining Quantity")
                {
                    ApplicationArea = All;
                }
                field("Best used by"; gRecLot."B Best used by")
                {
                    ApplicationArea = All;
                }
                field(OrganicText; gTextOrganic)
                {
                    ApplicationArea = All;
                }
                field("Sell to Customer_No"; gRecCustomer."No.")
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; gRecCustomer.Name)
                {
                    ApplicationArea = All;
                }
                field("Customer City"; gRecCustomer.City)
                {
                    ApplicationArea = All;
                }
                field("Customer Post Code"; gRecCustomer."Post Code")
                {
                    ApplicationArea = All;
                }
                field("Customer Posting Group"; gRecCustomer."Customer Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Customer Payment Terms Code"; gRecCustomer."Payment Terms Code")
                {
                    ApplicationArea = All;
                }
                field("Item Description 2"; fnDescription2("Item No."))
                {
                    ApplicationArea = All;
                }
                field("Crop Description"; gRecCrop.Description)
                {
                    ApplicationArea = All;
                }
                field("Crop Code"; gRecCrop."Crop Code")
                {
                    ApplicationArea = All;
                }
                field("Variety No"; gRecVariety."No.")
                {
                    ApplicationArea = All;
                }
                field("Variety Description"; gRecVariety.Description)
                {
                    ApplicationArea = All;
                }
                field("Item Category Code"; gRecItem."Item Category Code")
                {
                    ApplicationArea = All;
                }
                field("Item Category Description"; gRecItemCategory.Description)
                {
                    ApplicationArea = All;
                }
                field("Region Code"; gRegionCode)
                {
                    ApplicationArea = All;
                }
                field("Region Name"; gRegionName)
                {
                    ApplicationArea = All;
                }
                field(Customer_Price_Group_Salesline; gRecSIL."Customer Price Group")
                {
                    ApplicationArea = All;
                }
                field(Reason_Salesline; gRecSIL."B Reason Code")
                {
                    ApplicationArea = All;
                }
                field(Org_Conv_Type; gTextOrg_Conv_Type)
                {
                    ApplicationArea = All;
                }
                field(Treatment; gTextTreatment)
                {
                    ApplicationArea = All;
                }
                field(CRINV; gTextCRINV)
                {
                    ApplicationArea = All;
                }
                field(UOM; gRecUOM.Code)
                {
                    ApplicationArea = All;
                }
                field(Fiscal_Sales; gDecFiscal_Sales)
                {
                    ApplicationArea = All;
                }
                field(Fiscal_Date; gTextFiscal_Date)
                {
                    ApplicationArea = All;
                }
                field(YTDFR; gDateYTDFR)
                {
                    ApplicationArea = All;
                }
                field(SalesAmt_Credit; gDecSalesAmt_CR)
                {
                    ApplicationArea = All;
                }
                field(SalesAmt_Invoice; gDecSalesAmt_INV)
                {
                    ApplicationArea = All;
                }
                field(SalesAmt_Adjusted; gDecSalesAmt_ADJ)
                {
                    ApplicationArea = All;
                }
                field(KG; gDecKG)
                {
                    ApplicationArea = All;
                }
                field(Seeds; gDecSeeds)
                {
                    ApplicationArea = All;
                }
                field(SalesUnits; gDecSalesUnits)
                {
                    ApplicationArea = All;
                }
                field(Season; gTextPeriod)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    var
        lYear: Integer;
        lMonth: Integer;
        lDay: Integer;
        lNextFlag: Boolean;
        lFiscalYearEnd: Date;
    begin


        if gRecILE.Get("Item Ledger Entry No.") then;

        if StrLen(Format(Date2DMY("Posting Date", 2))) = 1 then
            gTextYYYYMM := Format(Date2DWY("Posting Date", 3)) + '0' + Format(Date2DMY("Posting Date", 2))
        else
            gTextYYYYMM := Format(Date2DWY("Posting Date", 3)) + Format(Date2DMY("Posting Date", 2));


        gTextPeriod := '';

        if Date2DMY("Posting Date", 2) >= 9 then begin
            gTextFY := Format(Date2DMY("Posting Date", 3) + 1);
            gDateYTDTO := DMY2Date(Date2DMY(Today, 1), Date2DMY(Today, 2), Date2DMY("Posting Date", 3) + 1);
            gDateYTDFR := DMY2Date(1, 9, Date2DMY("Posting Date", 3));
            gTextPeriod := Format(Date2DMY("Posting Date", 3)) + '-' + Format(Date2DMY("Posting Date", 3) + 1);
        end
        else begin
            gTextFY := Format(Date2DMY("Posting Date", 3));
            gDateYTDTO := DMY2Date(Date2DMY(Today, 1), Date2DMY(Today, 2), Date2DMY("Posting Date", 3));
            gDateYTDFR := DMY2Date(1, 9, Date2DMY("Posting Date", 3) - 1);
            gTextPeriod := Format(Date2DMY("Posting Date", 3) - 1) + '-' + Format(Date2DMY("Posting Date", 3));
        end;


        if Date2DMY(Today, 2) >= 9 then begin
            gTextCFY := Format(Date2DMY(Today, 3) + 1);
            gTextLFY := Format(Date2DMY(Today, 3));
        end
        else begin
            gTextCFY := Format(Date2DMY(Today, 3));
            gTextLFY := Format(Date2DMY(Today, 3) - 1);
        end;


        gRecCustomer.Reset;
        if ("Source Type" = "Source Type"::Customer) and ("Source No." <> '') then begin
            if gRecCustomer.Get("Source No.") then;
        end;


        if StrLen("Item No.") = 8 then begin

            gRecCrop.Reset;
            if gRecCrop.Get(CopyStr("Item No.", 1, 2)) then;
            gRecVariety.Reset;

            gTextOrg_Conv_Type := '';
            if gRecVariety.Get(CopyStr("Item No.", 1, 5)) then begin
                if gRecVariety.Organic then
                    gTextOrg_Conv_Type := 'Organic'
                else
                    gTextOrg_Conv_Type := 'Conventional';


            end;

            gTextOrganic := '';
            gTextOrganic := fnOrganicCheckMark(Rec);

            gTextTreatment := '';
            gRecExtension.Reset;
            gRecUOM.Reset;
            gRecItem.Reset;
            gRecItemCategory.Reset;
            gDecKG := 0;
            gDecSeeds := 0;
            gDecSalesUnits := 0;


            if (gRecItem.Get("Item No.")) and (StrLen(gRecItem."No.") = 8) then begin
                if (CopyStr(gRecItem."No.", StrLen(gRecItem."No.") - 1, 1) = '7') and (not gRecItem."B Organic") then
                    gTextTreatment := 'TC'
                else
                    if (CopyStr(gRecItem."No.", StrLen(gRecItem."No.") - 1, 1) = '8') and (not gRecItem."B Organic") then
                        gTextTreatment := 'TC+HWT'
                    else
                        if (CopyStr(gRecItem."No.", StrLen(gRecItem."No.") - 1, 1) = '0') and (not gRecItem."B Organic") then
                            gTextTreatment := 'Treated'
                        else
                            if (CopyStr(gRecItem."No.", StrLen(gRecItem."No.") - 1, 1) = '1') and (not gRecItem."B Organic") then
                                gTextTreatment := 'NCT'
                            else
                                if (CopyStr(gRecItem."No.", StrLen(gRecItem."No.") - 1, 1) = '3') and (not gRecItem."B Organic") then
                                    gTextTreatment := 'NCT'
                                else begin
                                    gRecExtension.SetRange(Extension, gRecItem."B Extension");
                                    if gRecExtension.Find('-') then
                                        gTextTreatment := gRecExtension.Description;
                                end;

                if gRecUOM.Get(gRecItem."Base Unit of Measure") then begin
                    if gRecUOM."B Code BejoNL" = '1' then begin
                        gDecKG := -1 * "Item Ledger Entry Quantity";
                        gDecSalesUnits := gDecKG;
                    end
                    else begin
                        gDecSeeds := -1 * "Item Ledger Entry Quantity" / 1000000;
                        gDecSalesUnits := gDecSeeds;
                    end;

                end;

                if gRecItemCategory.Get(gRecItem."Item Category Code") then;



            end;


        end;


        gRegionCode := '';
        gRegionName := '';
        gRecDimensionSet.Reset;
        gRecGenSetup.Get;
        if "Dimension Set ID" <> 0 then begin
            if gRecDimensionSet.Get("Dimension Set ID", gRecGenSetup."Global Dimension 2 Code") then begin
                gRegionCode := gRecDimensionSet."Dimension Value Code";
                gRecDimensionSet.CalcFields("Dimension Value Name");
                gRegionName := gRecDimensionSet."Dimension Value Name";
            end;

        end
        else begin

            if "Global Dimension 2 Code" <> '' then begin
                if gRecDimensionValue.Get(gRecGenSetup."Global Dimension 2 Code", "Global Dimension 2 Code") then begin
                    gRegionCode := "Global Dimension 2 Code";
                    gRegionName := gRecDimensionValue.Name;
                end;
            end;
        end;



        gRecSIL.Reset;
        gRecSIL.SetRange("Document No.", "Document No.");
        gRecSIL.SetRange("Line No.", "Document Line No.");
        gRecSIL.SetRange("No.", "Item No.");
        if gRecSIL.Find('-') then;

        gTextCRINV := '';
        if "Document Type" = "Document Type"::"Sales Invoice" then
            gTextCRINV := 'Invoice'
        else
            if "Document Type" = "Document Type"::"Sales Credit Memo" then
                gTextCRINV := 'Credit Memo'
            else
                gTextCRINV := 'Other';



        lYear := Date2DMY(Today, 3);
        lMonth := Date2DMY(Today, 2);
        lDay := Date2DMY(Today, 1);

        if lMonth >= 9 then begin
            lNextFlag := true;
            lFiscalYearEnd := DMY2Date(31, 8, lYear + 1);
        end
        else begin
            lNextFlag := false;
            lFiscalYearEnd := DMY2Date(31, 8, lYear)
        end;

        lYear := Date2DMY(lFiscalYearEnd, 3);





        if ("Posting Date" >= DMY2Date(1, 9, lYear - 5)) and ("Posting Date" <= DMY2Date(31, 8, lYear)) then
            gDecFiscal_Sales := "Sales Amount (Actual)"
        else
            gDecFiscal_Sales := 0;

        gTextFiscal_Date := '';
        if ("Posting Date" >= DMY2Date(1, 9, lYear - 5)) and ("Posting Date" <= DMY2Date(31, 8, lYear - 4)) then
            gTextFiscal_Date := 'FY' + Format(lYear - 4)
        else
            if ("Posting Date" >= DMY2Date(1, 9, lYear - 4)) and ("Posting Date" <= DMY2Date(31, 8, lYear - 3)) then
                gTextFiscal_Date := 'FY' + Format(lYear - 3)
            else
                if ("Posting Date" >= DMY2Date(1, 9, lYear - 3)) and ("Posting Date" <= DMY2Date(31, 8, lYear - 2)) then
                    gTextFiscal_Date := 'FY' + Format(lYear - 2)
                else
                    if ("Posting Date" >= DMY2Date(1, 9, lYear - 2)) and ("Posting Date" <= DMY2Date(31, 8, lYear - 1)) then
                        gTextFiscal_Date := 'FY' + Format(lYear - 1)
                    else
                        if ("Posting Date" >= DMY2Date(1, 9, lYear - 1)) and ("Posting Date" <= DMY2Date(31, 8, lYear)) then
                            gTextFiscal_Date := 'FY' + Format(lYear)
                        else
                            gTextFiscal_Date := 'NA';


        gDecSalesAmt_CR := 0;
        gDecSalesAmt_INV := 0;
        gDecSalesAmt_ADJ := 0;

        if "Document Type" = "Document Type"::"Sales Invoice" then
            gDecSalesAmt_INV := "Sales Amount (Actual)";

        if "Document Type" = "Document Type"::"Sales Credit Memo" then
            gDecSalesAmt_CR := "Sales Amount (Actual)";

        if "Item Charge No." <> '' then
            gDecSalesAmt_ADJ := "Sales Amount (Actual)";


        gRecLot.Reset;
        if gRecSalesperson.Get("Salespers./Purch. Code") then;
        if gRecLot.Get(gRecILE."Lot No.") then;

    end;

    trigger OnOpenPage()
    begin


        SetFilter("Posting Date", '>=%1', CalcDate('-5Y', WorkDate));

    end;

    var
        gRecILE: Record "Item Ledger Entry";
        gRecCustomer: Record Customer;
        gRecCrop: Record Crops;
        gTextOrganic: Text[10];
        gRecVariety: Record Varieties;
        gRecItem: Record Item;
        gRegionCode: Code[10];
        gRegionName: Text[50];
        gRecDimensionSet: Record "Dimension Set Entry";
        gRecSIL: Record "Sales Invoice Line";
        gTextOrg_Conv_Type: Text[20];
        gTextYYYYMM: Text[20];
        gTextFY: Text[20];
        gTextCFY: Text[20];
        gTextLFY: Text[20];
        gRecExtension: Record "Item Extension";
        gTextTreatment: Text[60];
        gTextCRINV: Text[20];
        gDateYTDTO: Date;
        gRecUOM: Record "Unit of Measure";
        gDecFiscal_Sales: Decimal;
        gTextFiscal_Date: Text[10];
        gDateYTDFR: Date;
        gRecItemCategory: Record "Item Category";
        gDecSalesAmt_CR: Decimal;
        gDecSalesAmt_INV: Decimal;
        gDecSalesAmt_ADJ: Decimal;
        gDecKG: Decimal;
        gDecSeeds: Decimal;
        gDecSalesUnits: Decimal;
        gTextPeriod: Text[30];
        gRecSalesperson: Record "Salesperson/Purchaser";
        gRecLot: Record "Lot No. Information";
        gRecGenSetup: Record "General Ledger Setup";
        gRecDimensionValue: Record "Dimension Value";

    local procedure fnOrganicCheckMark(arecTempValueEntry: Record "Value Entry") Result: Text[1]
    var
        lrecItem: Record Item;
        lrecVariety: Record Varieties;
    begin
        case arecTempValueEntry."Item Ledger Entry Type" of
            1: // Item

                if lrecItem.Get(arecTempValueEntry."Item No.") then begin
                    if not lrecVariety.Get(lrecItem."B Variety") then lrecVariety.Init;
                    Result := lrecVariety.OrganicCheckmarkText;
                end
                else begin
                    Result := '';
                end;

            2: // Variety
                begin
                    if not lrecVariety.Get(arecTempValueEntry."Source No.") then lrecVariety.Init;
                    Result := lrecVariety.OrganicCheckmarkText;
                end;
        end;
    end;

    local procedure fnDescription2(aItemNo: Code[20]) Result: Text[50]
    var
        lrecItem: Record Item;
    begin
        if lrecItem.Get(aItemNo) then begin
            Result := lrecItem."Description 2";
        end else begin
            Result := '';
        end;
    end;
}

