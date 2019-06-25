table 50008 "Bejo Setup"
{
    Caption = 'Bejo Setup';

    fields
    {
        field(50000; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';

        }
        field(50002; "Customer No. BejoNL"; Code[20])
        {
            Caption = 'Customer No. BejoNL';

        }
        field(50010; "G/L Shipping Charges"; Code[20])
        {
            Caption = 'G/L Shipping Charges';

            TableRelation = "G/L Account";
        }
        field(50011; "G/L Shipping Charges 2"; Code[20])
        {
            Caption = 'G/L Shipping Charges 2';

            TableRelation = "G/L Account";
        }
        field(50025; "Block Sales on Int.PromoStatus"; Boolean)
        {
            Caption = 'Block Sales on Int.PromoStatus';

        }
        field(50035; "Variety Blocking"; Boolean)
        {
            Caption = 'Variety Blocking';

        }
        field(50036; "Vendor No. BejoNL"; Code[20])
        {
            Caption = 'Vendor No. BejoNL';

            TableRelation = Vendor."No." WHERE ("No." = FIELD ("Vendor No. BejoNL"));
        }
        field(50050; "ADP Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';

            TableRelation = "Gen. Journal Template";
        }
        field(50051; "ADP Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';

            TableRelation = "Gen. Journal Batch".Name WHERE ("Journal Template Name" = FIELD ("ADP Journal Template Name"));
        }
        field(50052; "ADP Shortcut Dimension 1 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 1 Code';

            Editable = false;
            TableRelation = Dimension;
        }
        field(50053; "ADP Shortcut Dimension 2 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 2 Code';

            Editable = false;
            TableRelation = Dimension;
        }
        field(50054; "ADP Shortcut Dimension 3 Code"; Code[20])
        {
            AccessByPermission = TableData "Dimension Combination" = R;
            Caption = 'Shortcut Dimension 3 Code';

            TableRelation = Dimension;
        }
        field(50055; "ADP Shortcut Dimension 4 Code"; Code[20])
        {
            AccessByPermission = TableData "Dimension Combination" = R;
            Caption = 'Shortcut Dimension 3 Code';

            TableRelation = Dimension;
        }
        field(50056; "ADP First line to import"; Integer)
        {

        }
        field(50057; "ADP Excel Format"; Option)
        {

            OptionCaption = 'Standard,Standard Detailed,Custom';
            OptionMembers = Standard,"Standard Detailed",Custom;
        }
        field(50060; "Commercial Location"; Code[10])
        {
            Caption = 'Commercial Location';

            TableRelation = Location.Code;
        }
        field(50063; "Commercial Bin"; Code[20])
        {
            Caption = 'Commercial Bin';

            TableRelation = Bin.Code WHERE ("Location Code" = FIELD ("Commercial Location"));
        }
        field(50065; "Sample Location"; Code[10])
        {
            Caption = 'Sample Location';

            TableRelation = Location.Code;
        }
        field(50067; "Sample Bin"; Code[20])
        {
            Caption = 'Sample Bin';

            TableRelation = Bin.Code WHERE ("Location Code" = FIELD ("Sample Location"));
        }
        field(50070; "Purchase Allocation Check"; Boolean)
        {
            Caption = 'Purchase Allocation Check';

        }
        field(50075; "Sales Allocation Check"; Boolean)
        {
            Caption = 'Sales Allocation Check';

        }
        field(50080; "Country Code"; Code[10])
        {
            Caption = 'Country Code';

            TableRelation = "Country/Region";
        }
        field(50081; "Continent Code"; Code[10])
        {
            Caption = 'Continent Code';

        }
        field(50090; "Prognoses per Customer"; Boolean)
        {
            Caption = 'Prognoses per Customer mandatory';

        }
        field(50100; "Prognoses per Salesperson"; Boolean)
        {
            Caption = 'Prognoses per Salesperson mandatory';

        }
        field(50110; "Begin Date"; Date)
        {
            Caption = 'Season Begin Date';

        }
        field(50111; "End Date"; Date)
        {
            Caption = 'Season End Date';

        }
        field(50120; "G/L Account No. Sales"; Text[200])
        {
            Caption = 'G/L Account No. Sales';

            //This property is currently not supported
            //TestTableRelation = false;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(50130; "Export Path"; Text[200])
        {
            Caption = 'Export Path';

        }
        field(50131; "Import Path"; Text[200])
        {
            Caption = 'Import Path';

        }
        field(50140; "Unique Lot No. per shipment"; Boolean)
        {
            Caption = 'Unique Lot No. per purchase shipment';

        }
        field(50150; "Bejo Zaden Freight Accounts"; Code[100])
        {
            Caption = 'Bejo Zaden Freight Accounts';

        }
        field(50151; "Freight Item Charge No."; Code[10])
        {
            Caption = 'Freight Item Charge No.';

            TableRelation = "Item Charge"."No.";

            trigger OnValidate()
            begin

                if "Freight Item Charge No." <> '' then
                    TestField("Freight G/L Account", '');

            end;
        }
        field(50152; "Bejo Zaden Custom Tax.Accounts"; Code[100])
        {
            Caption = 'Bejo Zaden Custom Tax.Accounts';

        }
        field(50153; "Custom Taxes Item Charge No."; Code[10])
        {
            Caption = 'Custom Taxes Item Charge No.';

            TableRelation = "Item Charge"."No.";
        }
        field(50154; "Bejo Zaden Handling Accounts"; Code[100])
        {
            Caption = 'Bejo Zaden Handling Accounts';

        }
        field(50155; "Handling Item Charge No."; Code[10])
        {
            Caption = 'Handling Item Charge No.';

            TableRelation = "Item Charge"."No.";
        }
        field(50156; "Default Item Charge No."; Code[10])
        {
            Caption = 'Default Item Charge No.';

            TableRelation = "Item Charge"."No.";
        }
        field(50157; "Default LocationFilter on Item"; Text[250])
        {
            Caption = 'Default LocationFilter on Item';

        }
        field(50158; "Post Warehouse Orders"; Boolean)
        {
            Caption = 'Post Warehouse Orders';

        }
        field(50160; "Dimension Group 1"; Code[250])
        {
            Caption = 'Dimension Group 1';

            TableRelation = "Dimension Value".Code WHERE ("Dimension Code" = FIELD ("Global Dimension to group on"));

            ValidateTableRelation = false;
        }
        field(50161; "Dimension Group 2"; Code[250])
        {
            Caption = 'Dimension Group 2';

            TableRelation = "Dimension Value".Code WHERE ("Dimension Code" = FIELD ("Global Dimension to group on"));

            ValidateTableRelation = false;
        }
        field(50162; "Dimension Group 3"; Code[250])
        {
            Caption = 'Dimension Group 3';

            TableRelation = "Dimension Value".Code WHERE ("Dimension Code" = FIELD ("Global Dimension to group on"));

            ValidateTableRelation = false;
        }
        field(50163; "Dimension Group 4"; Code[250])
        {
            Caption = 'Dimension Group 4';

            TableRelation = "Dimension Value".Code WHERE ("Dimension Code" = FIELD ("Global Dimension to group on"));

            ValidateTableRelation = false;
        }
        field(50170; "Dimension Group 1 Name"; Text[20])
        {
            Caption = 'Dimension Group 1 Name';

        }
        field(50171; "Dimension Group 2 Name"; Text[20])
        {
            Caption = 'Dimension Group 2 Name';

        }
        field(50172; "Dimension Group 3 Name"; Text[20])
        {
            Caption = 'Dimension Group 3 Name';

        }
        field(50173; "Dimension Group 4 Name"; Text[20])
        {
            Caption = 'Dimension Group 4 Name';

        }
        field(50180; "Global Dimension to group on"; Code[20])
        {
            Caption = 'Global Dimension to group on';

            TableRelation = Dimension.Code;

            trigger OnValidate()
            var
                lrecGenLedgerSetup: Record "General Ledger Setup";
            begin
                if lrecGenLedgerSetup.Get then
                    if ("Global Dimension to group on" <> lrecGenLedgerSetup."Global Dimension 1 Code") and
                       ("Global Dimension to group on" <> lrecGenLedgerSetup."Global Dimension 2 Code") then
                        Error(Text50000);
            end;
        }
        field(50190; "Mail Shipping"; Boolean)
        {
            Caption = 'Mail Shipping';

        }
        field(50191; "Mail Allocation Change"; Boolean)
        {
            Caption = 'Mail Allocation Change';

        }
        field(50194; "Use SMTP Mail"; Boolean)
        {
            Caption = 'Use SMTP Mail';

        }

        field(50196; "SMTP E-Mail"; Text[80])
        {
            Caption = 'SMTP E-Mail';

        }
        field(50210; "Direct Expense Start Task No."; Code[20])
        {

        }
        field(50211; "Direct Expense End Task No."; Code[20])
        {

        }
        field(50212; "Overhead Expense Start TaskNo."; Code[20])
        {

        }
        field(50213; "Overhead Expense End Task No."; Code[20])
        {

        }
        field(50240; "Mobile Sales Profile"; Code[30])
        {

            TableRelation = Profile."Profile ID";
        }
        field(50251; "Freight G/L Account"; Code[20])
        {
            Caption = 'Freight G/L Account';

            TableRelation = "G/L Account";

            trigger OnValidate()
            begin

                if "Freight G/L Account" <> '' then
                    TestField("Freight Item Charge No.", '');

            end;
        }
        field(50255; "Item Category Code Not Used"; Boolean)
        {
            Caption = 'Item Category Code Not Used';

        }
        field(50256; "SO Post Alloc Rec Auto-Create"; Option)
        {
            Caption = 'SO Post Alloc Rec Auto-Create';

            OptionCaption = ' ,Salesperson,Customer';
            OptionMembers = " ",Salesperson,Customer;
        }
        field(50257; "Enforce NAV SO Status"; Boolean)
        {
            Caption = 'Enforce NAV SO Status';

        }
        field(50258; "Enforce SO Reason Code"; Option)
        {
            Caption = 'Enforce SO Reason Code';

            OptionCaption = 'None,Item,G/L Acct,Item and G/L Acct';
            OptionMembers = "None",Item,"G/L Acct","Item and G/L Acct";
        }
        field(50259; "BlockPostSales if AllocExceed"; Boolean)
        {
            Caption = 'BlockPostSales if AllocExceeded';

        }
        field(50260; "BlockPrintProforma if AllocExc"; Boolean)
        {
            Caption = 'BlockPrintSalesProforma if AllocExceeded';

        }
        field(50261; "Validate Lot when OrderStaus=2"; Boolean)
        {
            Caption = 'Validate Lot when OrderStatus is 2';

        }
        field(50262; "PrognNotAllowed Filter"; Text[250])
        {
            Caption = 'Prognosis Not Allowed Filter';

        }
        field(50680; "Years for Market Potential"; Integer)
        {
            Caption = 'Years for Market Potential';

            MinValue = 1;
        }
        field(50681; "Auto-update Next Years"; Boolean)
        {
            Caption = 'Auto-update Next Years';

        }
        field(50710; "Transit Bin"; Code[20])
        {

            TableRelation = Bin.Code;
        }
        field(50720; "Best Used By in Red"; Code[10])
        {
            Caption = 'Best Used By in Red';
        }
        field(50721; "Best Used By in Blue"; Code[10])
        {
            Caption = 'Best Used By in Blue';
        }
        field(50730; "Sales Line Check Price"; Option)
        {
            OptionCaption = ' ,Warning,Block';
            OptionMembers = " ",Warning,Block;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Text50000: Label 'The selected dimension is not a Global Dimension.';
        Text50001: Label 'You are not allowed to modify this value.';

    procedure ExportPath() PathText: Text[200]
    var
        lBejoSetup: Record "Bejo Setup";
    begin

        lBejoSetup.Get;
        lBejoSetup.TestField("Export Path");

        if (CopyStr(lBejoSetup."Export Path", StrLen(lBejoSetup."Export Path"), 1) = '\') then
            PathText := lBejoSetup."Export Path" else
            PathText := lBejoSetup."Export Path" + '\';

    end;

    procedure ImportPath() PathText: Text[200]
    var
        lBejoSetup: Record "Bejo Setup";
    begin

        lBejoSetup.Get;
        lBejoSetup.TestField("Import Path");

        if (CopyStr(lBejoSetup."Import Path", StrLen(lBejoSetup."Import Path"), 1) = '\') then
            PathText := lBejoSetup."Import Path" else
            PathText := lBejoSetup."Import Path" + '\';

    end;

    [BusinessEvent(false)]
    local procedure BejoMgt_GetDomainUserSID(var parUserSID: Text[119])
    begin
    end;
}

