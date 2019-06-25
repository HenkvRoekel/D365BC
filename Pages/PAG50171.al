page 50171 "Scan Page"
{

    Caption = 'Scanning';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    LinksAllowed = false;
    ModifyAllowed = false;
    PageType = Card;

    layout
    {
        area(content)
        {
            field(CompanyInf; CompanyInf.Picture)
            {
                Editable = false;
                Image = "None";
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Transit From")
            {
                Caption = 'Transit From';
                Image = TransferReceipt;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Scan Transit From";
                ApplicationArea = All;
            }
            action("Transit To")
            {
                Caption = 'Transit To';
                Image = TransferReceipt;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Scan Transit To";
                ApplicationArea = All;
            }
            action("Lot Information")
            {
                Image = LotInfo;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Scan Lot Info";
                ApplicationArea = All;
            }
        }
    }

    trigger OnOpenPage()
    begin
        CompanyInf.Get();
        CompanyInf.CalcFields(Picture);
    end;

    var
        CompanyInf: Record "Company Information";

    procedure UpdateSalesLines(LotNo: Code[20]; BinCode: Code[20])
    var
        SalesLine: Record "Sales Line";
    begin

        SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
        SalesLine.SetRange("B Lot No.", LotNo);
        if SalesLine.FindSet then repeat

                                      SalesLine.Validate("Bin Code", BinCode);
                                      SalesLine.Modify;

            until SalesLine.Next = 0;
    end;
}

