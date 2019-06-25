report 50035 "Import Item Remarks"
{

    DefaultLayout = RDLC;
    RDLCLayout = './RDLC/Import Item Remarks.rdlc';

    Caption = 'Import Item Remarks';

    dataset
    {
        dataitem("Comment Line"; "Comment Line")
        {
            DataItemTableView = SORTING ("Table Name", "B Comment Type", "No.", "B Variety") ORDER(Ascending) WHERE ("Table Name" = CONST (Item), "B Entry No." = FILTER (> 0));
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(USERID; UserId)
            {
            }

            column(grecVarieties__No__; grecVarieties."No.")
            {
            }
            column(Comment_Line_Date; Date)
            {
            }
            column(Comment_Line_Comment; Comment)
            {
            }
            column(Comment_Line__End_Date_; "B End Date")
            {
            }
            column(grecVarieties_Description; grecVarieties.Description)
            {
            }
            column(gTxtBlockingCode; gTxtBlockingCode)
            {
            }
            column(gTxtPromostatus; gTxtPromostatus)
            {
            }
            column(Comment_Line__Comment_Line___Last_Date_Modified_; "Comment Line"."B Last Date Modified")
            {
            }
            column(New_and_changed_remarks_for_todayCaption; New_and_changed_remarks_for_todayCaptionLbl)
            {
            }
            column(PageCaption; PageCaptionLbl)
            {
            }
            column(grecVarieties__No__Caption; grecVarieties__No__CaptionLbl)
            {
            }
            column(Comment_Line_DateCaption; Comment_Line_DateCaptionLbl)
            {
            }
            column(Comment_Line_CommentCaption; Comment_Line_CommentCaptionLbl)
            {
            }
            column(Comment_Line__End_Date_Caption; Comment_Line__End_Date_CaptionLbl)
            {
            }
            column(grecVarieties_DescriptionCaption; grecVarieties_DescriptionCaptionLbl)
            {
            }
            column(BCCaption; BCCaptionLbl)
            {
            }
            column(PromostatusCaption; PromostatusCaptionLbl)
            {
            }
            column(Last_Date_Modified_by_BejoNLCaption; Last_Date_Modified_by_BejoNLCaptionLbl)
            {
            }
            column(Comment_Line_Table_Name; "Table Name")
            {
            }
            column(Comment_Line_No_; "No.")
            {
            }
            column(Comment_Line_Line_No_; "Line No.")
            {
            }

            trigger OnAfterGetRecord()
            begin

                if not grecVarieties.Get("B Variety") then
                    Clear(grecVarieties);
                grecVarieties.CalcFields("Item Exist");
                if not grecVarieties."Item Exist" then
                    CurrReport.Skip;



                gTxtPromostatus := grecVarieties."Promo Status" + '.';
                gTxtBlockingCode := lcuBlockingMgt.VarietyBlockCode(grecVarieties) + '.';

            end;

            trigger OnPreDataItem()
            begin
                "Comment Line".SetRange("B Import Modification Date", Today);
                "Comment Line".SetRange("B Show", "Comment Line"."B Show"::External);
            end;
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

    labels
    {
    }

    trigger OnPreReport()
    var
    //lcuWebservices: Codeunit Webservices;
    begin
        gdlgWindow.Open('@1@@@@@@@@@@@@@@@@@@@@');
        gdlgWindow.Update(1, 5000);

        //lcuWebservices.GetItemRemarks;
        gdlgWindow.Update(1, 10000);

        gdlgWindow.Close;
        Commit;
    end;

    var
        gdlgWindow: Dialog;
        gcuBejoMgt: Codeunit "Bejo Management";
        gTxtPromostatus: Text[50];
        gTxtBlockingCode: Text[50];
        lcuBlockingMgt: Codeunit "Blocking Management";
        grecVarieties: Record Varieties;
        New_and_changed_remarks_for_todayCaptionLbl: Label 'New and changed remarks for today';
        PageCaptionLbl: Label 'Page';
        grecVarieties__No__CaptionLbl: Label 'Variety';
        Comment_Line_DateCaptionLbl: Label 'Begin Date';
        Comment_Line_CommentCaptionLbl: Label 'Comment';
        Comment_Line__End_Date_CaptionLbl: Label 'End Date';
        grecVarieties_DescriptionCaptionLbl: Label 'Description';
        BCCaptionLbl: Label 'BC';
        PromostatusCaptionLbl: Label 'Promostatus';
        Last_Date_Modified_by_BejoNLCaptionLbl: Label 'Last Date Modified by BejoNL';
}

