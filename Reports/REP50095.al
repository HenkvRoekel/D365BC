report 50095 "Preview Purchase"
{

    DefaultLayout = RDLC;
    RDLCLayout = './RDLC/Preview Purchase.rdlc';


    dataset
    {
        dataitem("Prognosis/Allocation Entry"; "Prognosis/Allocation Entry")
        {
            DataItemTableView = SORTING ("Entry Type", "Item No.", "Sales Date", "Unit of Measure", Salesperson) WHERE ("Entry Type" = CONST (Prognoses));
            RequestFilterFields = "Item No.", "Purchase Date";
            column(gPreview; gPreview)
            {
            }

            column(UserId; UserId)
            {
            }
            column(CompanyName; CompanyName)
            {
            }
            column(gAllfilters; gAllfilters)
            {
            }
            column(Vendor; grecToImportedPurchLines."Customer No. BejoNL")
            {
            }
            column(Vendor_Name; grecVendor.Name)
            {
            }
            column(DocNo_PurchaseLine; grecToImportedPurchLines."Document No.")
            {
            }
            column(RequestReceiptDate_PurchaseLine; Format(grecToImportedPurchLines."Requested Receipt Date"))
            {
            }
            column(StartDate1; Format(gPeriodeStartDate[1]))
            {
            }
            column(EndDate1; Format(gPeriodeStartDate[2] - 1))
            {
            }
            column(StartDate2; Format(gPeriodeStartDate[2]))
            {
            }
            column(EndDate2; Format(gPeriodeStartDate[3] - 1))
            {
            }
            column(StartDate3; Format(gPeriodeStartDate[3]))
            {
            }
            column(EndDate3; Format(gPeriodeStartDate[4] - 1))
            {
            }
            column(LineNo_PurchLine; grecToImportedPurchLines."Line No.")
            {
            }
            column(No_PurchLine; grecToImportedPurchLines."No.")
            {
            }
            column(Description_PurchLine; grecToImportedPurchLines.Description)
            {
            }
            column(Description2_PurchLine; grecToImportedPurchLines."Description 2")
            {
            }
            column(QtyToReceive_PurchLine; Format(grecToImportedPurchLines."Qty. to Receive", 0, '<Precision,2:2><Standard format,0>'))
            {
            }
            column(UoM_OurchLine; grecUnitOfMeasure."B Description for Prognoses")
            {
            }
            column(Prognosis1; gPeriodePrognosis[1])
            {
            }
            column(Prognosis2; gPeriodePrognosis[2])
            {
            }
            column(Prognosis3; gPeriodePrognosis[3])
            {
            }

            trigger OnAfterGetRecord()
            begin


                if gMarkPrognosisHandled then begin

                    Validate(Handled, true);

                    Modify;
                end;


                if (gAuxVariety = "Prognosis/Allocation Entry"."Item No.") and // (HulpLand="Prognosis/Allocation Entry".Country) AND BEJOWW5.0.006
                   (gAuxPack = "Prognosis/Allocation Entry"."Unit of Measure") then
                    CurrReport.Skip;

                gAuxVariety := "Prognosis/Allocation Entry"."Item No.";

                gAuxPack := "Prognosis/Allocation Entry"."Unit of Measure";

                grecToImportedPurchLines.Init;
                grecToImportedPurchLines."Document Type" := grecToImportedPurchLines."Document Type"::Order;
                grecToImportedPurchLines."Document No." := gPreviewOrderNo;
                grecToImportedPurchLines."Line No." := gPreviewOrderLineNo;
                grecToImportedPurchLines."Customer No. BejoNL" := gRelationNo;
                grecToImportedPurchLines."Order Address Code" := grecShiptoAddress.Code;
                grecToImportedPurchLines.Type := grecToImportedPurchLines.Type::Item;
                grecToImportedPurchLines."No." := "Prognosis/Allocation Entry"."Item No.";
                grecToImportedPurchLines.User := UserId;
                grecToImportedPurchLines.Variety := CopyStr("Prognosis/Allocation Entry"."Item No.", 1, 5);
                if grecLanguage.Code = '' then begin
                    if grecItem.Get("Item No.") then begin
                        grecToImportedPurchLines.Description := grecItem.Description;
                        grecToImportedPurchLines."Description 2" := grecItem."Description 2";
                    end;
                end else begin
                    if grecItemDescription.Get("Item No.", '', grecLanguage.Code) then;
                    grecToImportedPurchLines.Description := grecItemDescription.Description;
                    grecToImportedPurchLines."Description 2" := grecItemDescription."Description 2";
                end;

                grecToImportedPurchLines."Unit of Measure Code" := "Prognosis/Allocation Entry"."Unit of Measure";
                grecToImportedPurchLines."Requested Receipt Date" := gDeliverDate;
                if grecItemUnitOfMeasure.Get(grecToImportedPurchLines."No.", grecToImportedPurchLines."Unit of Measure Code") then begin
                    grecToImportedPurchLines."Qty. per Unit of Measure" := grecItemUnitOfMeasure."Qty. per Unit of Measure";
                end;

                if not grecUnitOfMeasure.Get(grecToImportedPurchLines."Unit of Measure Code") then
                    grecUnitOfMeasure.Init;

                if not grecItem.Get(grecToImportedPurchLines."No.") then
                    grecToImportedPurchLines.Description := text50000;


                if grecItemUnit.Get("Prognosis/Allocation Entry"."Item No.", "Prognosis/Allocation Entry"."Unit of Measure") then begin

                    for gi := 1 to 3 do begin
                        grecItemUnit.SetRange("Date Filter", gPeriodeStartDate[gi], gPeriodeStartDate[gi + 1] - 1);

                        grecItemUnit.CalcFields(grecItemUnit."Prognoses to Order");
                        gPeriodePrognosis[gi] := grecItemUnit."Prognoses to Order";

                    end;


                    "Prognosis/Allocation Entry".CopyFilter("Purchase Date", grecItemUnit."Date Filter");
                    grecItemUnit.CalcFields(grecItemUnit."Prognoses to Order");
                    if grecUnitOfMeasure."B Unit in Weight" = true then begin
                        grecToImportedPurchLines."Qty. to Receive" := grecItemUnit."Prognoses to Order" / grecItemUnitOfMeasure."Qty. per Unit of Measure";
                        grecToImportedPurchLines."Qty. to Receive (Base)" := grecItemUnit."Prognoses to Order";
                    end else begin
                        grecToImportedPurchLines."Qty. to Receive" :=
                          grecItemUnit."Prognoses to Order" * 1000000 / grecItemUnitOfMeasure."Qty. per Unit of Measure";
                        grecToImportedPurchLines."Qty. to Receive (Base)" := grecItemUnit."Prognoses to Order" * 1000000;

                    end;
                end else begin
                    CurrReport.Skip;
                end;

                if grecToImportedPurchLines."Qty. to Receive" = 0 then
                    CurrReport.Skip;


                grecToImportedPurchLines1.SetRange("Document No.", grecToImportedPurchLines."Document No.");
                grecToImportedPurchLines1.SetRange("No.", grecToImportedPurchLines."No.");
                grecToImportedPurchLines1.SetRange("Unit of Measure Code", grecToImportedPurchLines."Unit of Measure Code");
                grecToImportedPurchLines1.SetRange("Customer No. BejoNL", grecToImportedPurchLines."Customer No. BejoNL");
                if grecToImportedPurchLines1.FindFirst then
                    CurrReport.Skip;

                if not grecVendor.Get(gRelationNo) then
                    grecVendor.Init;

                if gMakePreview = gMakePreview::"Preview order" then
                    grecToImportedPurchLines.Insert(true);

                gPreviewOrderLineNo += 10000;
                if not grecCustomer.Get() then
                    grecCustomer.Init;

                gTooLittle := '';

                gDate1 := '<+1Y>';


                gFromDate := GetRangeMin("Purchase Date");

                if gMakePreview = gMakePreview::Preview then
                    gPreview := 'Preview';
            end;

            trigger OnPreDataItem()
            var
                lrecImportedPurchLines: Record "Imported Purchase Lines";
            begin
                if gRelationNo = '' then
                    Error(text50001);


                if gDeliverDate = 0D then
                    Error(text50002);


                grecShiptoAddress.SetRange("Customer No.", gRelationNo);
                grecShiptoAddress.SetRange("B Default", true);
                if not grecShiptoAddress.FindFirst then
                    grecShiptoAddress.Init;

                grecImportedPurchLines.SetRange(grecImportedPurchLines."Document No.", 'PR000000', 'PR999999');

                gPreviewOrderNo := 'PR' + Format("Prognosis/Allocation Entry".GetRangeMin("Purchase Date"), 0, '<day,2><month,2><year,2>');


                gPreviewOrderLineNo := 10000;


                lrecImportedPurchLines.SetCurrentKey("Document Type", "Document No.", "Line No.");
                lrecImportedPurchLines.SetRange("Document Type", lrecImportedPurchLines."Document Type"::Order);
                lrecImportedPurchLines.SetRange("Document No.", gPreviewOrderNo);
                if lrecImportedPurchLines.FindLast then begin
                    gPreviewOrderLineNo := lrecImportedPurchLines."Line No." + 10000;
                end;

                SetRange(Handled, false);

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
                    field(gRelationNo; gRelationNo)
                    {
                        Caption = 'Vendor No.';
                        ApplicationArea = All;
                    }
                    field(gDeliverDate; gDeliverDate)
                    {
                        Caption = 'Requested Receipt Date';
                        ApplicationArea = All;
                    }
                    field(gMarkPrognosisHandled; gMarkPrognosisHandled)
                    {
                        Caption = 'Mark Prognosis as Handled';
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
        lblPurchaseOrder = 'Purchase Order';
        lblDocumentNo = 'Document No.';
        lblDeliveryDate = 'Delivery Date';
        lblVendor = 'Vendor';
        lblLineNo = 'Line No.';
        lblDescription = 'Description';
        lblItemNo = 'Item No.';
        lblQty = 'Qty.';
        lblUnit = 'Unit';
        lblDescription2 = 'Description 2';
    }

    trigger OnInitReport()
    begin
        grecCompanyInformation.Get;


        grecBejoSetup.Get;
        grecBejoSetup.TestField("Vendor No. BejoNL");
        gRelationNo := grecBejoSetup."Vendor No. BejoNL";


        if CopyStr(grecCompanyInformation."VAT Registration No.", 1, 2) = 'NL' then
            gPurchOrSale := gPurchOrSale::Sale
        else
            gPurchOrSale := gPurchOrSale::Purchase;

        gMakePreview := gMakePreview::"Preview order";

        gMarkPrognosisHandled := true;
    end;

    trigger OnPreReport()
    begin


        gPeriodeStartDate[1] := "Prognosis/Allocation Entry".GetRangeMin("Purchase Date");

        for gi := 1 to 3 do begin

            gPeriodeStartDate[gi + 1] := CalcDate('<1M>', gPeriodeStartDate[gi]);
        end;
        gAllfilters := "Prognosis/Allocation Entry".GetFilters;
    end;

    var
        grecItem: Record Item;
        grecLanguage: Record Language;
        grecItemDescription: Record "Item Translation";
        grecCustomer: Record Customer;
        grecVendor: Record Vendor;
        grecImportedPurchLines: Record "Imported Purchase Lines";
        grecToImportedPurchLines: Record "Imported Purchase Lines";
        grecToImportedPurchLines1: Record "Imported Purchase Lines";
        grecItemUnitOfMeasure: Record "Item Unit of Measure";
        grecShiptoAddress: Record "Ship-to Address";
        grecItemUnit: Record "Item/Unit";
        grecUnitOfMeasure: Record "Unit of Measure";
        grecCompanyInformation: Record "Company Information";
        grecBejoSetup: Record "Bejo Setup";
        gcuBejoMgt: Codeunit "Bejo Management";
        gMarkPrognosisHandled: Boolean;
        gPreviewOrderNo: Code[20];
        gRelationNo: Code[20];
        gAuxVariety: Code[10];
        gAuxPack: Code[10];
        gDeliverDate: Date;
        gPeriodeStartDate: array[5] of Date;
        gPeriodePrognosis: array[5] of Decimal;
        gFromDate: Date;
        gPreviewOrderLineNo: Integer;
        gi: Integer;
        gPurchOrSale: Option Purchase,Sale;
        gMakePreview: Option Preview,"Preview order";
        gTooLittle: Text[30];
        gAllfilters: Text[250];
        gPreview: Text[30];
        gDate1: Text[30];
        text50000: Label 'Incorrect item or not existing!';
        text50001: Label 'You must enter a Vendor No.';
        text50002: Label 'The Requested Receipt Date must be entered!';
}

