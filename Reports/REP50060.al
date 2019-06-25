report 50060 "Copy Lot Information"
{

    DefaultLayout = RDLC;
    RDLCLayout = './RDLC/Copy Lot Information.rdlc';

    Caption = 'Copy Lot Information';

    dataset
    {
        dataitem("Lot No. Information"; "Lot No. Information")
        {
            DataItemTableView = SORTING ("Lot No.");
            MaxIteration = 1;
            column(Lot_No__Information__Item_No__; "Item No.")
            {
            }
            column(Lot_No__Information__Lot_No__; "Lot No.")
            {
            }
            column(Lot_No__Information_Description; Description)
            {
            }
            column(Lot_No__Information__Treatment_Code_; "B Treatment Code")
            {
            }
            column(Lot_No__Information__Tsw__in_gr__; "B Tsw. in gr.")
            {
            }
            column(Lot_No__Information_Germination; "B Germination")
            {
            }
            column(Lot_No__Information_Abnormals; "B Abnormals")
            {
            }
            column(Lot_No__Information__Grade_Code_; "B Grade Code")
            {
            }
            column(Lot_No__Information__Best_used_by_; "B Best used by")
            {
            }
            column(Lot_No__Information__Test_Date_; "B Test Date")
            {
            }
            column(Lot_No__Information__Best_used_by_Caption; FieldCaption("B Best used by"))
            {
            }
            column(Lot_No__Information__Grade_Code_Caption; FieldCaption("B Grade Code"))
            {
            }
            column(Lot_No__Information_AbnormalsCaption; FieldCaption("B Abnormals"))
            {
            }
            column(Lot_No__Information_GerminationCaption; FieldCaption("B Germination"))
            {
            }
            column(Lot_No__Information__Tsw__in_gr__Caption; FieldCaption("B Tsw. in gr."))
            {
            }
            column(Lot_No__Information__Treatment_Code_Caption; FieldCaption("B Treatment Code"))
            {
            }
            column(Lot_No__Information_DescriptionCaption; FieldCaption(Description))
            {
            }
            column(Lot_No__Information__Lot_No__Caption; FieldCaption("Lot No."))
            {
            }
            column(Lot_No__Information__Item_No__Caption; FieldCaption("Item No."))
            {
            }
            column(Lot_No__Information__Test_Date_Caption; FieldCaption("B Test Date"))
            {
            }
            column(Lot_No__Information_Variant_Code; "Variant Code")
            {
            }

            trigger OnAfterGetRecord()
            begin
                NewLotnoInfo.SetCurrentKey("Lot No.");
                NewLotnoInfo.SetRange("Lot No.", NewLot);
                if NewLotnoInfo.Find('-') then begin
                    "B Treatment Code" := NewLotnoInfo."B Treatment Code";
                    "B Tsw. in gr." := NewLotnoInfo."B Tsw. in gr.";
                    "B Germination" := NewLotnoInfo."B Germination";
                    "B Abnormals" := NewLotnoInfo."B Abnormals";
                    "B Grade Code" := NewLotnoInfo."B Grade Code";
                    "B Remark" := NewLotnoInfo."B Remark";
                    "B Best used by" := NewLotnoInfo."B Best used by";
                    "B Variety" := NewLotnoInfo."B Variety";
                    "B Test Date" := NewLotnoInfo."B Test Date";
                    Modify;
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
                    field(NewLot; NewLot)
                    {
                        Caption = 'Copy from Lot';
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

    var
        NewLot: Code[20];
        NewLotnoInfo: Record "Lot No. Information";
        gcuBejoMgt: Codeunit "Bejo Management";
}

