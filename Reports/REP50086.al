report 50086 "Quality Certificate"
{

    DefaultLayout = RDLC;
    RDLCLayout = './RDLC/Quality Certificate.rdlc';

    Caption = 'Quality Certificate';

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING ("No.");
            RequestFilterFields = "No.";
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(Text50000______CompanyInformation_Name; Text50000 + ': ' + CompanyInformation.Name)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(USERID; UserId)
            {
            }
            column(CompanyInformation_Address; CompanyInformation.Address)
            {
            }
            column(CompanyInformation__VAT_Registration_No__; CompanyInformation."VAT Registration No.")
            {
            }
            column(country_Name; country.Name)
            {
            }
            column(Sales_Invoice_Header__Bill_to_Name_2_; "Bill-to Name 2")
            {
            }
            column(gCertNo; gCertNo)
            {
            }
            column(gCertDate; Format(gCertDate))
            {
            }
            column(Text50000______CompanyInformation_Name_Control1000000054; Text50000 + ': ' + CompanyInformation.Name)
            {
            }
            column(Sales_Invoice_Header__Sales_Invoice_Header___Bill_to_Name_; "Sales Invoice Header"."Bill-to Name")
            {
            }
            column(CompanyInformation_Address_Control1000000052; CompanyInformation.Address)
            {
            }
            column(QUALITY_CERTIFICATECaption; QUALITY_CERTIFICATECaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(No_Caption; No_CaptionLbl)
            {
            }
            column(fromCaption; fromCaptionLbl)
            {
            }
            column(Lot_No__Information__Best_used_by_Caption; "Lot No. Information".FieldCaption("B Best used by"))
            {
            }
            column(TreatmentCaption; TreatmentCaptionLbl)
            {
            }
            column(County_of_producingCaption; County_of_producingCaptionLbl)
            {
            }
            column(ProducerCaption; ProducerCaptionLbl)
            {
            }
            column(Lot_No__Information__Tsw__in_gr__Caption; "Lot No. Information".FieldCaption("B Tsw. in gr."))
            {
            }
            column(Total_GerminationCaption; Total_GerminationCaptionLbl)
            {
            }
            column(PurityCaption; PurityCaptionLbl)
            {
            }
            column(Lot_No__Information__Test_Date_Caption; "Lot No. Information".FieldCaption("B Test Date"))
            {
            }
            column(Certificate_NoCaption; Certificate_NoCaptionLbl)
            {
            }
            column(Sales_Invoice_Line___Unit_of_Measure_Caption; Sales_Invoice_Line___Unit_of_Measure_CaptionLbl)
            {
            }
            column(PacksCaption; PacksCaptionLbl)
            {
            }
            column(QuantityCaption; QuantityCaptionLbl)
            {
            }
            column(Lot_No__Information__Lot_No__Caption; "Lot No. Information".FieldCaption("Lot No."))
            {
            }
            column(DescriptionCaption; DescriptionCaptionLbl)
            {
            }
            column(Description_2Caption; Description_2CaptionLbl)
            {
            }
            column(OrganicCaption; OrganicCaptionLbl)
            {
            }
            column(Form_type_II_8_1_Order_MAAP_no__350_2002Caption; Form_type_II_8_1_Order_MAAP_no__350_2002CaptionLbl)
            {
            }
            column(L_S_Caption; L_S_CaptionLbl)
            {
            }
            column(L_S_Caption_Control1000000042; L_S_Caption_Control1000000042Lbl)
            {
            }
            column(Customer_Caption; Customer_CaptionLbl)
            {
            }
            column(Depozit_delivery_place_Caption; Depozit_delivery_place_CaptionLbl)
            {
            }
            column(The_seed_agrees_for_sawing_according_to_Technical_Rules_of_Order_MAAP_no_Caption; The_seed_agrees_for_sawing_according_to_Technical_Rules_of_Order_MAAP_no_CaptionLbl)
            {
            }
            column(The_seed_is_delivered_according_to_art__13_from_Law_no__266_2002_Caption; The_seed_is_delivered_according_to_art__13_from_Law_no__266_2002_CaptionLbl)
            {
            }
            column(Mentions_Caption; Mentions_CaptionLbl)
            {
            }
            column(Sales_Invoice_Header_No_; "No.")
            {
            }
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = FIELD ("No.");
                DataItemTableView = SORTING ("Document No.", "Line No.");
                RequestFilterFields = Type, "No.";
                column(Sales_Invoice_Line_Document_No_; "Document No.")
                {
                }
                column(Sales_Invoice_Line_Line_No_; "Line No.")
                {
                }
                column(Sales_Invoice_Line_No_; "No.")
                {
                }
                dataitem("Value Entry"; "Value Entry")
                {
                    DataItemLink = "Document No." = FIELD ("Document No."), "Item No." = FIELD ("No.");
                    DataItemTableView = SORTING ("Document No.", "Posting Date");
                    column(Value_Entry_Entry_No_; "Entry No.")
                    {
                    }
                    column(Value_Entry_Document_No_; "Document No.")
                    {
                    }
                    column(Value_Entry_Item_No_; "Item No.")
                    {
                    }
                    column(Value_Entry_Item_Ledger_Entry_No_; "Item Ledger Entry No.")
                    {
                    }
                    dataitem("Item Ledger Entry"; "Item Ledger Entry")
                    {
                        DataItemLink = "Entry No." = FIELD ("Item Ledger Entry No.");
                        DataItemTableView = SORTING ("Entry No.");
                        column(Item_Ledger_Entry_Entry_No_; "Entry No.")
                        {
                        }
                        column(Item_Ledger_Entry_Item_No_; "Item No.")
                        {
                        }
                        column(Item_Ledger_Entry_Lot_No_; "Lot No.")
                        {
                        }
                        dataitem("Lot No. Information"; "Lot No. Information")
                        {
                            DataItemLink = "Item No." = FIELD ("Item No."), "Lot No." = FIELD ("Lot No.");
                            DataItemTableView = SORTING ("Lot No.");
                            column(Lot_No__Information__Lot_No__; "Lot No.")
                            {
                            }
                            column(gShortTreatmentDescription; gShortTreatmentDescription)
                            {
                            }
                            column(Lot_No__Information__Tsw__in_gr__; "B Tsw. in gr.")
                            {
                            }
                            column(Total_Germination; Format("B Abnormals" + "B Germination") + '%')
                            {
                            }
                            column(gCrop_Description; gCrop.Description)
                            {
                            }
                            column(FORMAT_gCrop__Purity___NAL______; Format(gCrop."Purity % NAL") + '%')
                            {
                            }
                            column(Lot_No__Information__Best_used_by_; Format("B Best used by"))
                            {
                            }
                            column(Sales_Invoice_Line__Description; "Sales Invoice Line".Description)
                            {
                            }
                            column(Sales_Invoice_Line___Description_2_; "Sales Invoice Line"."Description 2")
                            {
                            }
                            column(Sales_Invoice_Line___Quantity__Base__; "Sales Invoice Line"."Quantity (Base)")
                            {
                            }
                            column(Sales_Invoice_Line__Quantity; "Sales Invoice Line".Quantity)
                            {
                            }
                            column(Sales_Invoice_Line___Unit_of_Measure_; "Sales Invoice Line"."Unit of Measure")
                            {
                            }
                            column(Lot_No__Information__Test_Date_; Format("B Test Date"))
                            {
                            }
                            column(gProducer; gProducer)
                            {
                            }
                            column(gCountryOfProducing; gCountryOfProducing)
                            {
                            }
                            column(gOrganicOption; gOrganicOption)
                            {
                            }
                            column(gFullTreatmentDescription; gFullTreatmentDescription)
                            {
                            }
                            column(Lot_No__Information__Lot_No___Control1000000018; "Lot No.")
                            {
                            }
                            column(xCaption; xCaptionLbl)
                            {
                            }
                            column(Lot_No__Information_Item_No_; "Item No.")
                            {
                            }
                            column(Lot_No__Information_Variant_Code; "Variant Code")
                            {
                            }

                            trigger OnAfterGetRecord()
                            var
                                CUBlockingmanagement: Codeunit "Bejo Management";
                            begin

                                gCrop.Get(CopyStr("Item No.", 1, 2));
                                gItem.Get("Item No.");
                                if gItem."B Organic" then
                                    gOrganicOption := gOrganicOption::Organic else
                                    gOrganicOption := gOrganicOption::Standard;

                                gTreatment.Get("B Treatment Code");

                                gShortTreatmentDescription := '';
                                gFullTreatmentDescription := '';
                                if StrLen(gTreatment.Description) < 20 then
                                    gShortTreatmentDescription := gTreatment.Description else
                                    gFullTreatmentDescription := gTreatment.Description;

                                if CUBlockingmanagement.BejoItem("Item No.") then begin
                                    gProducer := Text50002;
                                    gCountryOfProducing := Text50003;
                                end else begin

                                    gProducer := 'BROER BV';
                                    gCountryOfProducing := 'OLANDA';

                                end;
                            end;
                        }

                        trigger OnPreDataItem()
                        begin
                            "Item Ledger Entry".SetRange("Qty. per Unit of Measure", "Sales Invoice Line"."Qty. per Unit of Measure");
                            "Item Ledger Entry".SetRange(Quantity, -"Sales Invoice Line"."Quantity (Base)");
                        end;
                    }

                    trigger OnPreDataItem()
                    begin
                        if "Value Entry Relation"."Value Entry No." <> 0 then
                            "Value Entry".SetRange("Value Entry"."Entry No.", "Value Entry Relation"."Value Entry No.");
                    end;
                }

                trigger OnAfterGetRecord()
                var
                    ItemTrackingMgt: Codeunit "Item Tracking Management";
                begin

                    InvRowID := ItemTrackingMgt.ComposeRowID(113, 0, "Sales Invoice Line"."Document No.", '', 0, "Sales Invoice Line"."Line No.");
                    "Value Entry Relation".SetCurrentKey("Source RowId");
                    "Value Entry Relation".SetRange("Source RowId", InvRowID);
                    if not "Value Entry Relation".Find('-') then
                        "Value Entry Relation".Init;

                end;
            }

            trigger OnAfterGetRecord()
            var
                lLanguage: Record Language;
            begin
                CurrReport.Language := lLanguage.GetLanguageID("Language Code");
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FieldNo("No.");
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Option)
                {
                    field(gCertDate; gCertDate)
                    {
                        Caption = 'Certificate Date';
                        ApplicationArea = All;
                    }
                    field(gCertNo; gCertNo)
                    {
                        Caption = 'Certiicate No.';
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
    }

    trigger OnPreReport()
    begin
        CompanyInformation.Get();
        country.Get(CompanyInformation."Country/Region Code");
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        "Value Entry Relation": Record "Value Entry Relation";
        InvRowID: Text[100];
        gCrop: Record Crops;
        CompanyInformation: Record "Company Information";
        country: Record "Country/Region";
        Text50000: Label 'Vendor';
        Text50002: Label 'Bejo Zaden';
        gProducer: Text[30];
        gCountryOfProducing: Text[30];
        Text50003: Label 'Holland';
        gItem: Record Item;
        gTreatment: Record "Treatment Code";
        gShortTreatmentDescription: Text[60];
        gFullTreatmentDescription: Text[60];
        gOrganicOption: Option Standard,Organic;
        gCertDate: Date;
        gCertNo: Text[30];
        QUALITY_CERTIFICATECaptionLbl: Label 'Quality Certificate';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        No_CaptionLbl: Label 'No.';
        fromCaptionLbl: Label 'from';
        TreatmentCaptionLbl: Label 'Treatment';
        County_of_producingCaptionLbl: Label 'County of producing';
        ProducerCaptionLbl: Label 'Producer';
        Total_GerminationCaptionLbl: Label 'Total Germination';
        PurityCaptionLbl: Label 'Purity';
        Certificate_NoCaptionLbl: Label 'Certificate No.';
        Sales_Invoice_Line___Unit_of_Measure_CaptionLbl: Label 'Unit of Measure';
        PacksCaptionLbl: Label 'Packs';
        QuantityCaptionLbl: Label 'Quantity';
        DescriptionCaptionLbl: Label 'Description';
        Description_2CaptionLbl: Label 'Description 2';
        OrganicCaptionLbl: Label 'Organic';
        Form_type_II_8_1_Order_MAAP_no__350_2002CaptionLbl: Label 'Form type II.8/1 Order MAAP no. 350/2002';
        L_S_CaptionLbl: Label 'L.S.';
        L_S_Caption_Control1000000042Lbl: Label 'L.S.';
        Customer_CaptionLbl: Label 'Customer,';
        Depozit_delivery_place_CaptionLbl: Label 'Depozit-delivery place:';
        The_seed_agrees_for_sawing_according_to_Technical_Rules_of_Order_MAAP_no_CaptionLbl: Label 'The seed agrees for sawing according to Technical Rules of Order MAAP no.';
        The_seed_is_delivered_according_to_art__13_from_Law_no__266_2002_CaptionLbl: Label 'The seed is delivered according to art. 13 from Law no. 266/2002.';
        Mentions_CaptionLbl: Label 'Mentions:';
        xCaptionLbl: Label 'x';
}

