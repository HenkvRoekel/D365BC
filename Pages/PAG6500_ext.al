pageextension 96500 ItemTrackingSummaryBTPageExt extends "Item Tracking Summary"
{


    layout
    {
        addafter("Serial No.")
        {
            field("B Location Code"; "B Location Code")
            {
                ApplicationArea = All;
            }
            field("B Bin Code"; "B Bin Code")
            {
                ApplicationArea = All;
            }
            field("B Tot Available Quantity(UofM)"; "B Tot Available Quantity(UofM)")
            {
                ApplicationArea = All;
            }
        }
        addafter("Total Requested Quantity")
        {
            field("B Unit of Measure Code"; "B Unit of Measure Code")
            {
                ApplicationArea = All;
            }
            field("B Treatment Code"; "B Treatment Code")
            {
                ApplicationArea = All;
            }
            field("B Tsw. in gr."; "B Tsw. in gr.")
            {
                ApplicationArea = All;
            }
            field("B Germination"; "B Germination")
            {
                ApplicationArea = All;
            }
            field("B Abnormals"; "B Abnormals")
            {
                ApplicationArea = All;
            }
            field("B Grade Code"; "B Grade Code")
            {
                ApplicationArea = All;
            }
            field("B Qty. per Unit of Measure"; "B Qty. per Unit of Measure")
            {
                ApplicationArea = All;
            }
            field("B Best used by"; "B Best used by")
            {
                StyleExpr = "B Best used by Style";
                ApplicationArea = All;
            }
            field("B Remark"; "B Remark")
            {
                ApplicationArea = All;
            }
            field("B Line type"; "B Line type")
            {
                ApplicationArea = All;
            }
        }
    }
}

