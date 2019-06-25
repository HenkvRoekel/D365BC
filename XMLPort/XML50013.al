xmlport 50013 "Import Invoice Bejo NL"
{

    Caption = 'Import Invoice Bejo NL';
    Direction = Import;
    FormatEvaluate = Xml;
    UseRequestPage = false;

    schema
    {
        textelement(PostedInvoiceEntries)
        {
            textelement(gdecimalsymbol)
            {
                XmlName = 'Decimal_Symbol';
            }
            textelement(gdigitgroupingsymbol)
            {
                XmlName = 'Digit_Grouping_Symbol';
            }
            tableelement("Imported Purchase Lines"; "Imported Purchase Lines")
            {
                XmlName = 'ValueEntry';
                UseTemporary = true;
                fieldelement(Document_No; "Imported Purchase Lines"."Document No.")
                {

                    trigger OnAfterAssignField()
                    begin
                        "Imported Purchase Lines"."Document Type" := "Imported Purchase Lines"."Document Type"::Order;
                    end;
                }
                textelement(glineno)
                {
                    XmlName = 'Line_No';

                    trigger OnAfterAssignVariable()
                    begin
                        Evaluate("Imported Purchase Lines"."Line No.", gLineno);
                    end;
                }
                fieldelement(Source_No; "Imported Purchase Lines"."Sell-to Customer No.")
                {

                    trigger OnAfterAssignField()
                    begin
                        with "Imported Purchase Lines" do begin
                            if "Sell-to Customer No." <> grecBejoSetup."Customer No. BejoNL" then
                                Error(text50000, FieldCaption("Sell-to Customer No."), "Sell-to Customer No.", grecBejoSetup."Customer No. BejoNL")
                            else
                                "Customer No. BejoNL" := "Sell-to Customer No.";
                        end;
                    end;
                }
                fieldelement(Item_No; "Imported Purchase Lines"."No.")
                {
                }
                textelement(ginvoicedqty)
                {
                    XmlName = 'Invoiced_Quantity';

                    trigger OnAfterAssignVariable()
                    begin
                        Evaluate("Imported Purchase Lines"."Qty. to Receive (Base)", ConvertValue(gInvoicedQty));
                    end;
                }
                textelement(gqty)
                {
                    XmlName = 'Qty_per_Unit_of_Measure';

                    trigger OnAfterAssignVariable()
                    begin
                        Evaluate("Imported Purchase Lines"."Qty. per Unit of Measure", ConvertValue(gQty));
                    end;
                }
                textelement(guomcode)
                {
                    XmlName = 'Unit_of_Measure';

                    trigger OnAfterAssignVariable()
                    begin
                        Evaluate("Imported Purchase Lines"."Unit of Measure Code", gUOMCode);
                    end;
                }
                fieldelement(Order_No; "Imported Purchase Lines"."Receipt No.")
                {
                }
                fieldelement(External_Document_No; "Imported Purchase Lines"."External Document No.")
                {
                }
                textelement(gunitprice)
                {
                    XmlName = 'Unit_Price';

                    trigger OnAfterAssignVariable()
                    begin
                        Evaluate("Imported Purchase Lines"."Direct Unit Cost", ConvertValue(gUnitPrice));
                    end;
                }
                textelement(gsalesamountactual)
                {
                    XmlName = 'Sales_Amount_Actual';

                    trigger OnAfterAssignVariable()
                    begin
                        Evaluate("Imported Purchase Lines".Amount, ConvertValue(gSalesAmountActual));
                    end;
                }
                textelement(guomcodebejo)
                {
                    XmlName = 'Unit_of_Measure_Code_Bejo';

                    trigger OnAfterAssignVariable()
                    begin
                        if gUoMCodeBejo <> '' then begin
                            grecUnitOfMeasure.SetRange("B Code BejoNL", gUoMCodeBejo);
                            if grecUnitOfMeasure.FindFirst then begin
                                "Imported Purchase Lines"."Unit of Measure Code" := grecUnitOfMeasure.Code;

                                CreateItemUnit("Imported Purchase Lines"."No.", "Imported Purchase Lines"."Unit of Measure Code");
                            end;
                        end;
                    end;
                }
                textelement(glinetype)
                {
                    XmlName = 'Line_type';

                    trigger OnAfterAssignVariable()
                    begin
                        Evaluate("Imported Purchase Lines"."Line type", SelectStr(1, gLineType));
                    end;
                }
                textelement(gtestdate)
                {
                    XmlName = 'Test_Date';

                    trigger OnAfterAssignVariable()
                    begin
                        "Imported Purchase Lines"."Test Date" := GetDate(gTestDate);
                    end;
                }
                fieldelement(Ship_to_code; "Imported Purchase Lines"."Order Address Code")
                {
                }
                fieldelement(Box_No; "Imported Purchase Lines"."Box No.")
                {
                }
                fieldelement(Type; "Imported Purchase Lines".Type)
                {

                    trigger OnAfterAssignField()
                    begin
                        with "Imported Purchase Lines" do begin
                            if Type = Type::Item then begin
                                "Qty. to Receive" := "Qty. to Receive (Base)" / "Qty. per Unit of Measure";
                                Clear(Description);
                                Clear("Description 2");
                                if grecItem.Get("No.") then begin
                                    Description := grecItem.Description;
                                    "Description 2" := grecItem."Description 2";
                                end;
                            end else
                                "Qty. to Receive" := "Qty. to Receive (Base)";

                            if Type = Type::"G/L Account" then begin
                                case "No." of
                                    grecBejoSetup."Bejo Zaden Freight Accounts":
                                        begin
                                            if grecBejoSetup."Freight Item Charge No." <> '' then begin
                                                Type := Type::"Charge (Item)";
                                                "No." := grecBejoSetup."Freight Item Charge No.";
                                            end else
                                                if grecBejoSetup."Freight G/L Account" <> '' then
                                                    "No." := grecBejoSetup."Freight G/L Account";
                                        end;
                                    grecBejoSetup."Bejo Zaden Custom Tax.Accounts":
                                        begin
                                            Type := Type::"Charge (Item)";
                                            "No." := grecBejoSetup."Custom Taxes Item Charge No.";
                                        end;
                                    grecBejoSetup."Bejo Zaden Handling Accounts":
                                        begin
                                            Type := Type::"Charge (Item)";
                                            "No." := grecBejoSetup."Handling Item Charge No.";
                                        end;
                                    else begin
                                            Type := Type::"Charge (Item)";
                                            "No." := grecBejoSetup."Default Item Charge No.";
                                        end;
                                end;
                            end;

                            Variety := CopyStr("No.", 1, 5);

                            if "Line type" <> "Line type"::"Market introduction" then begin
                                "Location Code" := grecBejoSetup."Commercial Location";
                                "Bin Code" := grecBejoSetup."Commercial Bin";
                            end else begin
                                "Location Code" := grecBejoSetup."Sample Location";
                                "Bin Code" := grecBejoSetup."Sample Bin";
                            end;
                        end;
                    end;
                }
                textelement(goriginallyordereditemno)
                {
                    XmlName = 'Originally_Ordered_Item_No';
                }
                textelement(gnetweight)
                {
                    XmlName = 'Net_Weight';

                    trigger OnAfterAssignVariable()
                    begin
                        Evaluate("Imported Purchase Lines"."Net Weight", ConvertValue(gNetWeight));
                    end;
                }
                textelement(LotNoInformation)
                {
                    MinOccurs = Zero;
                    fieldelement(Lot_No; "Imported Purchase Lines"."Lot No.")
                    {
                        MinOccurs = Zero;

                        trigger OnAfterAssignField()
                        var
                            lrecLotNoInformation: Record "Lot No. Information";
                        begin
                            with "Imported Purchase Lines" do begin
                                if grecBejoSetup."Unique Lot No. per shipment" then begin
                                    lrecLotNoInformation.SetCurrentKey("Lot No.");
                                    lrecLotNoInformation.SetFilter("Lot No.", "Lot No." + '*');
                                    if lrecLotNoInformation.FindLast then begin
                                        if "Lot No." = lrecLotNoInformation."Lot No." then
                                            "Lot No." := "Lot No." + 'A'
                                        else
                                            "Lot No." := "Lot No." + Increment(CopyStr(lrecLotNoInformation."Lot No.", StrLen(lrecLotNoInformation."Lot No.")));
                                    end;
                                end;
                            end;
                        end;
                    }
                    fieldelement(Treatment_Code; "Imported Purchase Lines"."Treatment Code")
                    {
                        MinOccurs = Zero;
                    }
                    fieldelement(Tsw_in_gr; "Imported Purchase Lines"."Tsw. in gr.")
                    {
                        MinOccurs = Zero;
                    }
                    fieldelement(Germination; "Imported Purchase Lines".Germination)
                    {
                        MinOccurs = Zero;
                    }
                    fieldelement(Abnormals; "Imported Purchase Lines".Abnormals)
                    {
                        MinOccurs = Zero;
                    }
                    textelement(gpackingdate)
                    {
                        MinOccurs = Zero;
                        XmlName = 'Packing_Date';
                    }
                    textelement(gsource)
                    {
                        MinOccurs = Zero;
                        XmlName = 'Source';
                    }
                    fieldelement(Grade_Code; "Imported Purchase Lines"."Grade Code")
                    {
                        MinOccurs = Zero;
                    }
                    textelement(gbestusedby)
                    {
                        MinOccurs = Zero;
                        XmlName = 'Best_Used_By';

                        trigger OnAfterAssignVariable()
                        begin
                            "Imported Purchase Lines"."Best used by" := GetDate(gBestUsedBy);
                        end;
                    }
                    fieldelement(Determination_3; "Imported Purchase Lines"."Multi Germination")
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                    }
                    textelement(Phyto_Certificate_No)
                    {
                        MinOccurs = Zero;
                    }
                    textelement(COO)
                    {
                        MaxOccurs = Once;
                        MinOccurs = Zero;
                        textelement(Country)
                        {
                            MaxOccurs = Unbounded;
                            MinOccurs = Zero;
                            textelement(gcountryoforigin)
                            {
                                MaxOccurs = Once;
                                MinOccurs = Zero;
                                TextType = Text;
                                XmlName = 'Code';

                                trigger OnAfterAssignVariable()
                                var
                                    lrecShipmentNotification: Record "Shipment Notification";
                                begin

                                    lrecShipmentNotification."Lot No." := "Imported Purchase Lines"."Lot No.";
                                    lrecShipmentNotification."Country of Origin" := gCountryOfOrigin;
                                    lrecShipmentNotification."Phyto Certificate No." := Phyto_Certificate_No;
                                    lrecShipmentNotification."Document No." := "Imported Purchase Lines"."Document No.";
                                    lrecShipmentNotification."Date Imported" := Today;
                                    if lrecShipmentNotification.Insert then;

                                    grecTmpShipmentNotification.TransferFields(lrecShipmentNotification);
                                    grecTmpShipmentNotification."Phyto Certificate No." := Phyto_Certificate_No;
                                    if grecTmpShipmentNotification.Insert then;

                                end;
                            }
                        }
                    }
                }

                trigger OnBeforeInsertRecord()
                var
                    lrecImportedPurchline: Record "Imported Purchase Lines";
                begin
                    if "Imported Purchase Lines"."Document No." <> '' then begin
                        if not lrecImportedPurchline.Get(
                          "Imported Purchase Lines"."Document Type"::Order,
                          "Imported Purchase Lines"."Document No.",
                          "Imported Purchase Lines"."Line No.") then begin
                            lrecImportedPurchline.TransferFields("Imported Purchase Lines");
                            lrecImportedPurchline.Insert;
                        end;
                    end;
                end;
            }
            tableelement("<imported purchase lines>"; "Imported Purchase Lines")
            {
                MinOccurs = Zero;
                XmlName = 'SalesInvoiceLine';
                UseTemporary = true;
                fieldelement(Document_No; "<Imported Purchase Lines>"."Document No.")
                {

                    trigger OnAfterAssignField()
                    begin
                        "<Imported Purchase Lines>"."Document Type" := "<Imported Purchase Lines>"."Document Type"::Order;
                    end;
                }
                textelement(glineno2)
                {
                    XmlName = 'Line_No';

                    trigger OnAfterAssignVariable()
                    begin
                        Evaluate("<Imported Purchase Lines>"."Line No.", gLineno2);
                    end;
                }
                fieldelement(Sell_to_Customer_No; "<Imported Purchase Lines>"."Sell-to Customer No.")
                {

                    trigger OnAfterAssignField()
                    begin

                        with "<Imported Purchase Lines>" do begin
                            if "Sell-to Customer No." <> grecBejoSetup."Customer No. BejoNL" then
                                Error(text50000, FieldCaption("Sell-to Customer No."), "Sell-to Customer No.", grecBejoSetup."Customer No. BejoNL")
                            else
                                "Customer No. BejoNL" := "Sell-to Customer No.";
                        end;

                    end;
                }
                fieldelement(Item_No; "<Imported Purchase Lines>"."No.")
                {
                }
                textelement(gqty2)
                {
                    XmlName = 'Quantity';

                    trigger OnAfterAssignVariable()
                    begin
                        Evaluate("<Imported Purchase Lines>"."Qty. to Receive", ConvertValue(gQty2));
                    end;
                }
                textelement(gunitprice2)
                {
                    XmlName = 'Unit_Price';

                    trigger OnAfterAssignVariable()
                    begin
                        Evaluate("<Imported Purchase Lines>"."Direct Unit Cost", ConvertValue(gUnitPrice2));
                    end;
                }
                textelement(gamount)
                {
                    XmlName = 'Amount';

                    trigger OnAfterAssignVariable()
                    begin
                        Evaluate("<Imported Purchase Lines>".Amount, ConvertValue(gAmount));
                    end;
                }
                fieldelement(Type; "<Imported Purchase Lines>".Type)
                {

                    trigger OnAfterAssignField()
                    begin

                        with "<Imported Purchase Lines>" do

                            if Type = Type::"G/L Account" then begin

                                case "No." of
                                    grecBejoSetup."Bejo Zaden Freight Accounts":
                                        begin
                                            if grecBejoSetup."Freight Item Charge No." <> '' then begin
                                                Type := Type::"Charge (Item)";
                                                "No." := grecBejoSetup."Freight Item Charge No.";
                                            end else
                                                if grecBejoSetup."Freight G/L Account" <> '' then
                                                    "No." := grecBejoSetup."Freight G/L Account";
                                        end;
                                    grecBejoSetup."Bejo Zaden Custom Tax.Accounts":
                                        begin
                                            Type := Type::"Charge (Item)";
                                            "No." := grecBejoSetup."Custom Taxes Item Charge No.";
                                        end;
                                    grecBejoSetup."Bejo Zaden Handling Accounts":
                                        begin
                                            Type := Type::"Charge (Item)";
                                            "No." := grecBejoSetup."Handling Item Charge No.";
                                        end;

                                    else begin
                                            Type := Type::"Charge (Item)";
                                            "No." := grecBejoSetup."Default Item Charge No.";
                                        end;

                                end;

                            end;


                    end;
                }

                trigger OnBeforeInsertRecord()
                var
                    lrecImportedPurchline: Record "Imported Purchase Lines";
                begin
                    if ("<Imported Purchase Lines>"."Document No." <> '') then begin
                        if not lrecImportedPurchline.Get(
                          "<Imported Purchase Lines>"."Document Type"::Order,
                          "<Imported Purchase Lines>"."Document No.",
                          "<Imported Purchase Lines>"."Line No.") then begin
                            lrecImportedPurchline.TransferFields("<Imported Purchase Lines>");
                            lrecImportedPurchline.Insert;
                        end;
                    end;
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    trigger OnInitXmlPort()
    var
        lTextValue: Text[30];
        i: Integer;
    begin
        grecBejoSetup.Get;
        grecBejoSetup.TestField("Commercial Location");
        grecBejoSetup.TestField("Sample Location");

        lTextValue := Format(10 / 3);
        for i := 1 to StrLen(lTextValue) do
            if not (CopyStr(lTextValue, i, 1) in ['0' .. '9']) then
                gCurrDecimalSymbol := CopyStr(lTextValue, i, 1);

        lTextValue := Format(1234567890000.0);
        for i := 1 to StrLen(lTextValue) do
            if not (CopyStr(lTextValue, i, 1) in ['0' .. '9']) then
                gCurrDigitGroupingSymbol := CopyStr(lTextValue, i, 1);
    end;

    trigger OnPostXmlPort()
    var
        lrecShipmentNotification: Record "Shipment Notification";
    begin

        grecTmpShipmentNotification.Reset;
        if grecTmpShipmentNotification.FindSet then repeat
                                                        if lrecShipmentNotification.Get(grecTmpShipmentNotification."Lot No.", grecTmpShipmentNotification."Country of Origin") then begin
                                                            lrecShipmentNotification."Date Imported" := Today;
                                                            lrecShipmentNotification."Document No." := "Imported Purchase Lines"."Document No.";
                                                            lrecShipmentNotification."Phyto Certificate No." := grecTmpShipmentNotification."Phyto Certificate No.";
                                                            lrecShipmentNotification.Modify;
                                                        end;
            until grecTmpShipmentNotification.Next = 0;
        if grecTmpShipmentNotification.Insert then;

    end;

    var
        grecBejoSetup: Record "Bejo Setup";
        text50000: Label 'Incorrect file for this company: %1 %2 should be %3';
        grecItem: Record Item;
        grecUnitOfMeasure: Record "Unit of Measure";
        gCurrDigitGroupingSymbol: Code[1];
        gCurrDecimalSymbol: Code[1];
        grecTmpShipmentNotification: Record "Shipment Notification" temporary;

    procedure Increment(addendum: Text[1]) newaddendum: Text[1]
    begin
        newaddendum[1] := addendum[1] + 1;
    end;

    procedure CreateItemUnit(Itemno: Code[20]; UOM: Code[20])
    var
        cuBejoMgt: Codeunit "Bejo Management";
        lrecItemUnit: Record "Item/Unit";
    begin
        if cuBejoMgt.BejoItem(Itemno) then begin
            lrecItemUnit.Init;
            lrecItemUnit."Item No." := Itemno;
            lrecItemUnit."Unit of Measure" := UOM;
            lrecItemUnit.Validate("Item No.", Itemno);
            if lrecItemUnit.Insert then;
        end;
    end;

    procedure GetDate(lInDateText: Code[10]) NewDate: Date
    var
        lYearno: Integer;
        lMonthno: Integer;
        lDayno: Integer;
    begin
        // FORMAT = YYYY-MM-DD
        if StrLen(lInDateText) = 10 then begin
            Evaluate(lYearno, CopyStr(lInDateText, 1, 4));
            Evaluate(lMonthno, CopyStr(lInDateText, 6, 2));
            Evaluate(lDayno, CopyStr(lInDateText, 9, 2));
            NewDate := DMY2Date(lDayno, lMonthno, lYearno);
        end;
    end;

    procedure ConvertValue(lOldText: Text[30]) lNewText: Text[30]
    var
        i: Integer;
        lChar: Code[1];
    begin
        if (gDigitGroupingSymbol = gCurrDigitGroupingSymbol) and (gDecimalSymbol = gCurrDecimalSymbol) then
            exit(lOldText);

        for i := 1 to StrLen(lOldText) do begin
            lChar := CopyStr(lOldText, i, 1);
            if lChar = gDigitGroupingSymbol then
                lChar := ''
            else
                if lChar = gDecimalSymbol then
                    lChar := gCurrDecimalSymbol;
            lNewText := lNewText + lChar;
        end;
    end;
}

