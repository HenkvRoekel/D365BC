report 50023 "Daily Email Sales Shipments"
{

    Caption = 'Daily Email Sales Shipments';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Salesperson/Purchaser"; "Salesperson/Purchaser")
        {
            DataItemTableView = SORTING (Code) ORDER(Ascending) WHERE ("E-Mail" = FILTER (<> ''));
            PrintOnlyIfDetail = true;
            dataitem("Sales Shipment Header"; "Sales Shipment Header")
            {
                DataItemLink = "Salesperson Code" = FIELD (Code);
                DataItemTableView = SORTING ("Salesperson Code", "Shipment Date", "Order No.") ORDER(Ascending);

                trigger OnAfterGetRecord()
                begin
                    grecSalesShipmentLine.Reset;
                    grecSalesShipmentLine.SetRange("Document No.", "No.");
                    grecSalesShipmentLine.SetRange(Type, grecSalesShipmentLine.Type::Item);
                    grecSalesShipmentLine.SetFilter(Quantity, '<>0');
                    if grecSalesShipmentLine.FindSet then begin
                        if gMailCreated then begin
                            if gLastOrderNo <> "Order No." then begin
                                if grecBejoSetup."Use SMTP Mail" then begin
                                    gcuSMTPMail.AppendBody(gCrLf);
                                    gcuSMTPMail.AppendBody(gCrLf);
                                end else begin
                                    //gcuMail.AddBodyline(gCrLf);
                                    //gcuMail.AddBodyline(gCrLf);
                                end;
                            end;
                        end else begin
                            if grecBejoSetup."Use SMTP Mail" then begin
                                gcuSMTPMail.CreateMessage(
                                  grecCompanyInformation.Name,
                                  grecBejoSetup."SMTP E-Mail",
                                  "Salesperson/Purchaser"."E-Mail",
                                  gSubject, StrSubstNo(TextDear, "Salesperson/Purchaser".Name), false);
                                gcuSMTPMail.AppendBody(gCrLf);
                                gcuSMTPMail.AppendBody(gCrLf);
                            end else begin
                                Clear(gcuMail);
                                //gcuMail.AddBodyline(StrSubstNo(TextDear,"Salesperson/Purchaser".Name));
                                //gcuMail.AddBodyline(gCrLf);
                                //gcuMail.AddBodyline(gCrLf);
                            end;
                            gMailCreated := true;
                        end;

                        if gLastOrderNo <> "Order No." then begin
                            if grecBejoSetup."Use SMTP Mail" then begin
                                gcuSMTPMail.AppendBody(StrSubstNo(TextShipment, "Order No.", "Sell-to Customer Name", "Sell-to Customer No.", "Shipment Date"));
                                gcuSMTPMail.AppendBody(gCrLf);
                            end else begin
                                //gcuMail.AddBodyline(StrSubstNo(TextShipment,"Order No.","Sell-to Customer Name","Sell-to Customer No.","Shipment Date"));
                                //gcuMail.AddBodyline(gCrLf);
                            end;
                        end;

                        gLastOrderNo := "Order No.";

                        repeat
                            if grecBejoSetup."Use SMTP Mail" then begin
                                gcuSMTPMail.AppendBody(
                                  StrSubstNo(
                                    TextShipmentLine,
                                    grecSalesShipmentLine."No.",
                                    grecSalesShipmentLine.Description,
                                    grecSalesShipmentLine."Description 2",
                                    grecSalesShipmentLine.Quantity,
                                    grecSalesShipmentLine."Unit of Measure"));
                                gcuSMTPMail.AppendBody(gCrLf);
                            end else begin
                                //gcuMail.AddBodyline(
                                //  StrSubstNo(
                                //    TextShipmentLine,
                                //    grecSalesShipmentLine."No.",
                                //    grecSalesShipmentLine.Description,
                                //    grecSalesShipmentLine."Description 2",
                                //    grecSalesShipmentLine.Quantity,
                                //   grecSalesShipmentLine."Unit of Measure"));
                                //gcuMail.AddBodyline(gCrLf);
                            end;
                        until grecSalesShipmentLine.Next = 0;
                    end;
                end;

                trigger OnPostDataItem()
                begin
                    if gMailCreated then begin
                        if grecBejoSetup."Use SMTP Mail" then begin
                            gcuSMTPMail.Send;
                            Clear(gcuSMTPMail);
                        end else begin
                            //gcuMail.NewMessage("Salesperson/Purchaser"."E-Mail", '', '', gSubject, '', '', false);
                            Clear(gcuMail);
                        end;
                    end;
                end;

                trigger OnPreDataItem()
                begin
                    if gShipmentDate <> 0D then
                        SetRange("Shipment Date", gShipmentDate, gShipmentDateUpto)
                    else
                        SetRange("Shipment Date", Today);
                    gMailCreated := false;
                    gLastOrderNo := '';
                end;
            }
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
                    field(gShipmentDate; gShipmentDate)
                    {
                        Caption = 'From Date';
                    }
                    field(gShipmentDateUpto; gShipmentDateUpto)
                    {
                        Caption = 'Upto Date (incl.)';
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
    }

    trigger OnInitReport()
    begin
        gCrLf[1] := 13;
        gCrLf[2] := 10;

        gShipmentDate := WorkDate;
        gShipmentDateUpto := gShipmentDate;
    end;

    trigger OnPreReport()
    begin
        grecBejoSetup.Get;
        grecCompanyInformation.Get;

        if gShipmentDate = gShipmentDateUpto then
            gSubject := CopyStr(StrSubstNo(TextSubject, gShipmentDate), 1, MaxStrLen(gSubject))
        else
            gSubject := CopyStr(StrSubstNo(TextSubject2, gShipmentDate, gShipmentDateUpto), 1, MaxStrLen(gSubject));
    end;

    var
        TextSubject: Label 'Sales Orders Shipped %1';
        TextDear: Label 'Dear %1,';
        TextShipment: Label 'Sales Order %1 for Customer %2 (%3) with Shipment Date %4 has been shipped!';
        TextShipmentLine: Label '%1 %2 %3,  %4x %5';
        gMailCreated: Boolean;
        grecSalesShipmentLine: Record "Sales Shipment Line";
        grecBejoSetup: Record "Bejo Setup";
        grecCompanyInformation: Record "Company Information";
        gcuMail: Codeunit Mail;
        gcuSMTPMail: Codeunit "SMTP Mail";
        gCrLf: Text[2];
        gSubject: Text[200];
        gLastOrderNo: Code[20];
        gShipmentDate: Date;
        gShipmentDateUpto: Date;
        TextSubject2: Label 'Sales Orders Shipped in period %1..%2';

    procedure SetShipmentDate(SetToDate: Date)
    begin
        gShipmentDate := SetToDate;
        gShipmentDateUpto := gShipmentDate;
    end;
}

