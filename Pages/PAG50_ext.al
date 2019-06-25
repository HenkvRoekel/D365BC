pageextension 90050 PurchaseOrderBTPageExt extends "Purchase Order"
{

    layout
    {
        addafter("No. of Archived Versions")
        {
            field("<Reason Code Bejo>"; "Reason Code")
            {
                ApplicationArea = All;
            }
        }
        addafter("Order Date")
        {
            field("<Requested Receipt Date BEJO>"; "Requested Receipt Date")
            {
                AccessByPermission = TableData "Order Promising Line" =;
                ShowMandatory = true;
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter(Print)
        {
            group("&Bejo")
            {
                Caption = '&Bejo';
                action("Prognoses to Order")
                {
                    Caption = 'Prognoses to Order';
                    Image = CreateLinesFromJob;
                    RunObject = Report "Preview Purchase";
                    ApplicationArea = All;
                }
                action("Export Order Bejo NL")
                {
                    Caption = 'Export Order Bejo NL';
                    Ellipsis = true;
                    Image = TransmitElectronicDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Purchase Actions Referrer";
                    RunPageLink = "B Page_Action ID" = CONST ('P50_50035');
                    RunPageOnRec = true;
                    ApplicationArea = All;
                }
                action("Delete Original Purchase Line")
                {
                    Caption = 'Delete Original Purchase Line';
                    Image = DeleteQtyToHandle;
                    RunObject = Page "Purchase Actions Referrer";
                    RunPageLink = "B Page_Action ID" = CONST ('P50_50037');
                    RunPageOnRec = true;
                    ApplicationArea = All;
                }
                action("Purchase order preview")
                {
                    Image = Purchase;
                    RunObject = Page "Purchase Orders Preview";
                    ApplicationArea = All;
                }
            }
        }
    }
}

