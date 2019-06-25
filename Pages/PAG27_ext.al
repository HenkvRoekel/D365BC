pageextension 90027 VendorListBTPageExt extends "Vendor List"
{


    layout
    {
        addafter("Purchaser Code")
        {
            field("<B VAT Registration No.>"; "VAT Registration No.")
            {
                Caption = '<B VAT Registration No.>';
                Visible = false;
                ApplicationArea = All;
            }
        }
    }
}

