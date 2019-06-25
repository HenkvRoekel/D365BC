pageextension 90052 PurchaseCreditMemoBTPageExt extends "Purchase Credit Memo"
{


    actions
    {
        addafter("P&osting")
        {
            group("&Bejo")
            {
                Caption = '&Bejo';
                action(Proforma)
                {
                    Caption = 'Proforma';
                    Image = PrepaymentCreditMemo;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = Page "Purchase Actions Referrer";
                    RunPageLink = "B Page_Action ID" = CONST ('P52_50023');
                    RunPageOnRec = true;
                    ApplicationArea = All;
                }
                action("Return Shipment")
                {
                    Caption = 'Return Shipment';
                    Image = PostedReturnReceipt;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = Page "Purchase Actions Referrer";
                    RunPageLink = "B Page_Action ID" = CONST ('P52_50025');
                    RunPageOnRec = true;
                    ApplicationArea = All;
                }
                action("Export Credit Memo")
                {
                    Caption = 'Export Credit Memo';
                    Image = ExportFile;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = Page "Purchase Actions Referrer";
                    RunPageLink = "B Page_Action ID" = CONST ('P52_50027');
                    RunPageOnRec = true;
                    ApplicationArea = All;
                }
            }
        }
    }
}

