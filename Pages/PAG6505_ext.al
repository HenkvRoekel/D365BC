pageextension 96505 LotNoInformationCardBTPageExt extends "Lot No. Information Card"
{

    layout
    {
        addafter(Description)
        {
            field("B Description 1"; "B Description 1")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("B Description 2"; "B Description 2")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("B ItemExtensionDescription"; "B ItemExtensionDescription")
            {
                Caption = 'Description 3';
                Editable = false;
                ApplicationArea = All;
            }
        }
        addafter(Blocked)
        {
            field("Unit of Measure"; "B ILEUnitOfMeasureCode")
            {
                Caption = 'Unit of Measure';
                Editable = false;
                ApplicationArea = All;
            }
            field("Qty. per Unit of Measure"; "B ILEUnitQtyPerOfMeasure")
            {
                Caption = 'Qty. per Unit of Measure';
                DecimalPlaces = 0 : 2;
                Editable = false;
                ApplicationArea = All;
            }
            field("B CountryOfOrigin"; "B CountryOfOrigin")
            {
                Caption = 'Country of Origin';
                Editable = false;
                ApplicationArea = All;
            }
            field("B PhytoCertificate"; "B PhytoCertificate")
            {
                Caption = 'Phyto Certificate';
                Editable = false;
                ApplicationArea = All;
            }
            field("B Best used by"; "B Best used by")
            {
                ApplicationArea = All;
            }
            field("B Tsw. in gr."; "B Tsw. in gr.")
            {
                DecimalPlaces = 2 : 5;
                ApplicationArea = All;
            }
            field("B Remark"; "B Remark")
            {
                ApplicationArea = All;
            }
            field("B Multi Germination"; "B Multi Germination")
            {
                ApplicationArea = All;
            }
            field("B Test Date"; "B Test Date")
            {
                ApplicationArea = All;
            }
            field("B Text for SalesOrders"; "B Text for SalesOrders")
            {
                ApplicationArea = All;
            }
            group(Control50040)
            {
                ShowCaption = false;
                grid(Control50041)
                {
                    GridLayout = Rows;
                    ShowCaption = false;
                    group(Control50042)
                    {
                        ShowCaption = false;
                        field("B Treatment Code"; "B Treatment Code")
                        {
                            Caption = 'Treatment';
                            ApplicationArea = All;
                        }
                        field("B TreatmentDescription"; "B TreatmentDescription")
                        {
                            Editable = false;
                            ApplicationArea = All;
                        }
                    }
                }
            }
            group(Control50045)
            {
                ShowCaption = false;
                grid(Control50046)
                {
                    GridLayout = Rows;
                    ShowCaption = false;
                    group(Control50047)
                    {
                        ShowCaption = false;
                        field("B Grade Code"; "B Grade Code")
                        {
                            ApplicationArea = All;
                        }
                        field("B GradeDescription"; "B GradeDescription")
                        {
                            Editable = false;
                            ApplicationArea = All;
                        }
                    }
                }
            }
            group(Control50050)
            {
                ShowCaption = false;
                grid(Control50051)
                {
                    GridLayout = Rows;
                    ShowCaption = false;
                    group(Control50052)
                    {
                        ShowCaption = false;
                        field("B Germination"; "B Germination")
                        {
                            ApplicationArea = All;
                        }
                        field("""B Germination""*100"; "B Germination" * 100)
                        {
                            ExtendedDatatype = Ratio;
                            ApplicationArea = All;
                        }
                    }
                }
            }
            group(Control50055)
            {
                ShowCaption = false;
                grid(Control50056)
                {
                    GridLayout = Rows;
                    ShowCaption = false;
                    group(Control50057)
                    {
                        ShowCaption = false;
                        field("B Abnormals"; "B Abnormals")
                        {
                            ApplicationArea = All;
                        }
                        field("""B Abnormals""*100"; "B Abnormals" * 100)
                        {
                            Caption = 'Abnormals';
                            ExtendedDatatype = Ratio;
                            ApplicationArea = All;
                        }
                    }
                }
            }
        }
        addafter(Inventory)
        {
            field("B Tracking Quantity"; "B Tracking Quantity")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter(Navigate)
        {
            group("&Bejo")
            {
                Caption = '&Bejo';
                action("Print Lot &History")
                {
                    Caption = 'Print Lot &History';
                    Image = LotInfo;
                    RunObject = Page "Lot No. Info. Actions Referrer";
                    RunPageLink = "B Page_Action ID" = CONST ('P6505_50057');
                    RunPageOnRec = true;
                    ApplicationArea = All;
                }
                action("Copy Lot Information")
                {
                    Caption = 'Copy Lot Information';
                    Image = ItemTrackingLedger;
                    RunObject = Page "Lot No. Info. Actions Referrer";
                    RunPageLink = "B Page_Action ID" = CONST ('P6505_50055');
                    RunPageOnRec = true;
                    ShortCutKey = 'Ctrl+F7';
                    ApplicationArea = All;
                }
            }
        }
    }
}

