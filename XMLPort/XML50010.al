xmlport 50010 "Export Purch. Order"
{


    Caption = 'Export Purch. Order';
    FormatEvaluate = Xml;

    schema
    {
        textelement(PurchaseLines)
        {
            tableelement("Purchase Line"; "Purchase Line")
            {
                XmlName = 'PurchaseLine';
                textelement(gdocumenttype)
                {
                    XmlName = 'Document_Type';

                    trigger OnBeforePassVariable()
                    begin
                        gDocumentType := StrSubstNo(Text10000, 0 + "Purchase Line"."Document Type", Format("Purchase Line"."Document Type"))
                    end;
                }
                fieldelement(Document_No; "Purchase Line"."Document No.")
                {
                }
                fieldelement(Line_No; "Purchase Line"."Line No.")
                {
                }
                textelement(gtype)
                {
                    XmlName = 'Type';

                    trigger OnBeforePassVariable()
                    begin
                        gType := StrSubstNo(Text10000, 0 + "Purchase Line".Type, Format("Purchase Line".Type))
                    end;
                }
                fieldelement(No; "Purchase Line"."No.")
                {
                }
                fieldelement(Quantity; "Purchase Line".Quantity)
                {
                }
                fieldelement(Unit_of_Measure_Code; "Purchase Line"."Unit of Measure Code")
                {
                }
                fieldelement(Qty_per_Unit_of_Measure; "Purchase Line"."Qty. per Unit of Measure")
                {
                }
                fieldelement(Requested_Receipt_Date; "Purchase Line"."Requested Receipt Date")
                {
                }
                fieldelement(Quantity_Base; "Purchase Line"."Quantity (Base)")
                {
                }
                textelement(gcustno)
                {
                    XmlName = 'Customer_No_BejoNL';
                }
                fieldelement(Description; "Purchase Line".Description)
                {
                }
                fieldelement(Description_2; "Purchase Line"."Description 2")
                {
                }
                textelement(guomnl)
                {
                    XmlName = 'Eenheid_NL';
                }
                textelement(glinetype)
                {
                    XmlName = 'Line_type';

                    trigger OnBeforePassVariable()
                    begin
                        gLineType := StrSubstNo(Text10000, 0 + "Purchase Line"."B Line type", Format("Purchase Line"."B Line type"))
                    end;
                }
                textelement(glotno)
                {
                    XmlName = 'Lot_No';
                }
                fieldelement(Box_No; "Purchase Line"."B Box No.")
                {
                }
                textelement(gorderadress)
                {
                    XmlName = 'Order_Adress';
                }

                trigger OnAfterGetRecord()
                var
                    lrecUOM: Record "Unit of Measure";
                    lrecReservEntry: Record "Reservation Entry";
                    UOMNL: Code[10];
                begin
                    Clear(gLotNo);
                    Clear(gUOMNL);
                    Clear(gOrderAdress);

                    if GetPurchOrder("Purchase Line"."Document Type", "Purchase Line"."Document No.") then begin

                        gOrderAdress := grecPurchHdr."Order Address Code";
                    end;

                    if lrecUOM.Get("Purchase Line"."Unit of Measure Code") then
                        gUOMNL := lrecUOM."B Code BejoNL";

                    lrecReservEntry.SetRange("Source Type", DATABASE::"Purchase Line");
                    lrecReservEntry.SetRange("Source ID", "Purchase Line"."Document No.");
                    lrecReservEntry.SetRange("Source Ref. No.", "Purchase Line"."Line No.");
                    if lrecReservEntry.FindFirst then
                        gLotNo := lrecReservEntry."Lot No."
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

    trigger OnPreXmlPort()
    var
        lrecBejoSetup: Record "Bejo Setup";
    begin
        lrecBejoSetup.Get;
        lrecBejoSetup.TestField("Customer No. BejoNL");
        gCustNo := lrecBejoSetup."Customer No. BejoNL";
    end;

    var
        Text50001: Label 'You must enter the Requested Receipt Date in Purchase Header.';
        grecPurchHdr: Record "Purchase Header";
        Text10000: Label '%1,%2';

    procedure GetPurchOrder(DocType: Option; Orderno: Code[20]): Boolean
    begin
        if (grecPurchHdr."Document Type" <> DocType) or (grecPurchHdr."No." <> Orderno) then begin
            if not grecPurchHdr.Get(DocType, Orderno) then
                Clear(grecPurchHdr)
            else
                if (DocType = grecPurchHdr."Document Type"::Order) and (grecPurchHdr."Requested Receipt Date" = 0D) then
                    Error(Text50001);
        end;

        exit((grecPurchHdr."Document Type" = DocType) and (grecPurchHdr."No." = Orderno));
    end;
}

