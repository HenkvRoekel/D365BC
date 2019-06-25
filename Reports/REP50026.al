report 50026 CommentsLine
{

    DefaultLayout = RDLC;
    RDLCLayout = './RDLC/CommentsLine.rdlc';


    dataset
    {
        dataitem("Comment Line"; "Comment Line")
        {
            RequestFilterFields = "Table Name", "No.";
            column(TableName; "Comment Line"."Table Name")
            {
                IncludeCaption = true;
            }
            column(Item_No; "Comment Line"."No.")
            {
                IncludeCaption = true;
            }
            column(Date; "Comment Line".Date)
            {
                IncludeCaption = true;
            }
            column(Comment; "Comment Line".Comment)
            {
                IncludeCaption = true;
            }
            column(CommentType; "Comment Line"."B Comment Type")
            {
                IncludeCaption = true;
            }
            column(Variety_No; "Comment Line"."B Variety")
            {
                IncludeCaption = true;
            }
            column(EndDate; "Comment Line"."B End Date")
            {
                IncludeCaption = true;
            }
            column(CreationDate; "Comment Line"."B Creation Date")
            {
                IncludeCaption = true;
            }
            column(Show; "Comment Line"."B Show")
            {
                IncludeCaption = true;
            }
            column(Item_Description; gTextItemDescription)
            {
            }
            column(Variety_Description; gTextVarietyDescription)
            {
            }
            column(Crop_Description; gTextCropDescription)
            {
            }
            column(Crop_No; gRecCrop."Crop Code")
            {
            }

            trigger OnAfterGetRecord()
            begin
                gTextItemDescription := '';
                gTextVarietyDescription := '';
                gTextCropDescription := '';
                gRecItem.Reset;
                gRecVariety.Reset;
                gRecCrop.Reset;

                if "Comment Line"."Table Name" = "Comment Line"."Table Name"::Item then begin
                    if gRecItem.Get("Comment Line"."No.") then begin
                        gTextItemDescription := gRecItem.Description;
                        if gRecVariety.Get(gRecItem."B Variety") then
                            gTextVarietyDescription := gRecVariety.Description;
                        if gRecCrop.Get(gRecItem."B Crop") then
                            gTextCropDescription := gRecCrop.Description;
                    end;
                end;
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

    var
        gRecItem: Record Item;
        gRecVariety: Record Varieties;
        gRecCrop: Record Crops;
        gTextItemDescription: Text[50];
        gTextVarietyDescription: Text[50];
        gTextCropDescription: Text[50];
        gcuBejoMgt: Codeunit "Bejo Management";
}

