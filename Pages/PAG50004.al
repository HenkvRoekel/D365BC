page 50004 "Crops List"
{

    Caption = 'Crops List';
    PageType = List;
    SourceTable = Crops;

    layout
    {
        area(content)
        {
            repeater(List)
            {
                field("Crop Code"; "Crop Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Description English"; "Description English")
                {
                    ApplicationArea = All;
                }
                field("Price per Qty."; "Price per Qty.")
                {
                    ApplicationArea = All;
                }
                field("Purity % NAL"; "Purity % NAL")
                {
                    ApplicationArea = All;
                }
                field("Amount countingdays Nal"; "Amount countingdays Nal")
                {
                    ApplicationArea = All;
                }
                field("Min. amount. Seeds Nal"; "Min. amount. Seeds Nal")
                {
                    ApplicationArea = All;
                }
                field(Weeds; Weeds)
                {
                    ApplicationArea = All;
                }
                field("Latin Name"; "Latin Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

