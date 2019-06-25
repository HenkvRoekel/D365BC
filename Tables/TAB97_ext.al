tableextension 90097 CommentLineBTExt extends "Comment Line"
{

    fields
    {
        field(50000; "B Comment Type"; Option)
        {
            Caption = 'Comment Type';

            OptionCaption = ',Sales,Warehouse,Expedition,Export,Variety,Item,Manager,Available,Salesperson';
            OptionMembers = ,Sales,Warehouse,Expedition,Export,"Var 5 pos","Var 8 Pos",Manager,Available,Salesperson;

            trigger OnValidate()
            var
                lrecItemUnitOfMeasure: Record "Item Unit of Measure";
                Txt50000: Label 'Please select a valid ''Unit Of Measure code'' for this item.';
            begin

                if "B Comment Type" = "B Comment Type"::Salesperson then begin

                    lrecItemUnitOfMeasure.SetFilter("Item No.", "No.");
                    lrecItemUnitOfMeasure.SetFilter(Code, Code);
                    if not lrecItemUnitOfMeasure.FindFirst then
                        Message(Txt50000);
                end

            end;
        }
        field(50001; "B End Date"; Date)
        {
            Caption = 'End Date';

        }
        field(50002; "B Variety"; Code[5])
        {
            Caption = 'Variety';


            trigger OnValidate()
            begin

                if "B Comment Type" = "B Comment Type"::"Var 5 pos" then
                    "B Variety" := CopyStr("No.", 1, 5)
                else
                    "B Variety" := '';

            end;
        }
        field(50003; "B Show"; Option)
        {
            Caption = 'Show';

            OptionCaption = 'Internal,External';
            OptionMembers = Internal,External;
        }
        field(50004; "B Entry No."; Integer)
        {
            Caption = 'Entry No.';

        }
        field(50005; "B Creation Date"; Date)
        {
            Caption = 'Creation Date';

        }
        field(50006; "B Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';

        }
        field(50007; "B User-ID"; Code[20])
        {
            Caption = 'User ID';

        }
        field(50008; "B Import Modification Date"; Date)
        {
            Caption = 'Import Modification Date';

        }
    }
}

