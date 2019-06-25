table 50027 "EOSS Journal Line"
{

    Caption = 'EOSS Journal Line Bejo';
    DrillDownPageID = "Item Journal Lines";
    LookupPageID = "Item Journal Lines";

    fields
    {
        field(1; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            TableRelation = "Item Journal Template";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            Description = 'b';
            TableRelation = Item;

            trigger OnValidate()
            var
                ProdOrderLine: Record "Prod. Order Line";
                ProdOrderComp: Record "Prod. Order Component";
            begin
            end;
        }
        field(4; "Posting Date"; Date)
        {
            Caption = 'Posting Date';

            trigger OnValidate()
            var
                CheckDateConflict: Codeunit "Reservation-Check Date Confl.";
            begin
            end;
        }
        field(5; "Entry Type"; Option)
        {
            Caption = 'Entry Type';
            OptionCaption = 'Purchase,Sale,Positive Adjmt.,Negative Adjmt.,Transfer,Consumption,Output, ,Assembly Consumption,Assembly Output';
            OptionMembers = Purchase,Sale,"Positive Adjmt.","Negative Adjmt.",Transfer,Consumption,Output," ","Assembly Consumption","Assembly Output";
        }
        field(6; "Source No."; Code[20])
        {
            Caption = 'Source No.';
            Editable = false;
            TableRelation = IF ("Source Type" = CONST (Customer)) Customer
            ELSE
            IF ("Source Type" = CONST (Vendor)) Vendor
            ELSE
            IF ("Source Type" = CONST (Item)) Item;
        }
        field(7; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(8; Description; Text[50])
        {
            Caption = 'Description';
            Description = 'b';
        }
        field(9; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            Description = 'b';
            TableRelation = Location;
        }
        field(10; "Inventory Posting Group"; Code[10])
        {
            Caption = 'Inventory Posting Group';
            Editable = false;
            Enabled = false;
            TableRelation = "Inventory Posting Group";
        }
        field(11; "Source Posting Group"; Code[10])
        {
            Caption = 'Source Posting Group';
            Editable = false;
            Enabled = false;
            TableRelation = IF ("Source Type" = CONST (Customer)) "Customer Posting Group"
            ELSE
            IF ("Source Type" = CONST (Vendor)) "Vendor Posting Group"
            ELSE
            IF ("Source Type" = CONST (Item)) "Inventory Posting Group";
        }
        field(13; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
            Enabled = false;

            trigger OnValidate()
            var
                CallWhseCheck: Boolean;
            begin
            end;
        }
        field(15; "Invoiced Quantity"; Decimal)
        {
            Caption = 'Invoiced Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
            Enabled = false;
        }
        field(16; "Unit Amount"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Amount';
            Enabled = false;
        }
        field(17; "Unit Cost"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Cost';
            Enabled = false;
        }
        field(18; Amount; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount';
            Enabled = false;
        }
        field(22; "Discount Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Discount Amount';
            Editable = false;
            Enabled = false;
        }
        field(23; "Salespers./Purch. Code"; Code[10])
        {
            Caption = 'Salespers./Purch. Code';
            Enabled = false;
            TableRelation = "Salesperson/Purchaser";
        }
        field(26; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            Editable = false;
            Enabled = false;
            TableRelation = "Source Code";
        }
        field(29; "Applies-to Entry"; Integer)
        {
            Caption = 'Applies-to Entry';
            Enabled = false;

            trigger OnValidate()
            var
                ItemLedgEntry: Record "Item Ledger Entry";
                ItemTrackingLines: Page "Item Tracking Lines";
            begin
            end;
        }
        field(32; "Item Shpt. Entry No."; Integer)
        {
            Caption = 'Item Shpt. Entry No.';
            Editable = false;
            Enabled = false;
        }
        field(34; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            Enabled = false;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (1));
        }
        field(35; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            Enabled = false;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (2));
        }
        field(37; "Indirect Cost %"; Decimal)
        {
            Caption = 'Indirect Cost %';
            DecimalPlaces = 0 : 5;
            Enabled = false;
            MinValue = 0;
        }
        field(39; "Source Type"; Option)
        {
            Caption = 'Source Type';
            Editable = false;
            OptionCaption = ' ,Customer,Vendor,Item';
            OptionMembers = " ",Customer,Vendor,Item;
        }
        field(41; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            TableRelation = "Item Journal Batch".Name WHERE ("Journal Template Name" = FIELD ("Journal Template Name"));
        }
        field(42; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            Enabled = false;
            TableRelation = "Reason Code";
        }
        field(43; "Recurring Method"; Option)
        {
            BlankZero = true;
            Caption = 'Recurring Method';
            Enabled = false;
            OptionCaption = ',Fixed,Variable';
            OptionMembers = ,"Fixed",Variable;
        }
        field(44; "Expiration Date"; Date)
        {
            Caption = 'Expiration Date';
            Enabled = false;
        }
        field(45; "Recurring Frequency"; DateFormula)
        {
            Caption = 'Recurring Frequency';
            Enabled = false;
        }
        field(46; "Drop Shipment"; Boolean)
        {
            AccessByPermission = TableData "Drop Shpt. Post. Buffer" = R;
            Caption = 'Drop Shipment';
            Editable = false;
            Enabled = false;
        }
        field(47; "Transaction Type"; Code[10])
        {
            Caption = 'Transaction Type';
            Enabled = false;
            TableRelation = "Transaction Type";
        }
        field(48; "Transport Method"; Code[10])
        {
            Caption = 'Transport Method';
            Enabled = false;
            TableRelation = "Transport Method";
        }
        field(49; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            Enabled = false;
            TableRelation = "Country/Region";
        }
        field(50; "New Location Code"; Code[10])
        {
            Caption = 'New Location Code';
            Enabled = false;
            TableRelation = Location;
        }
        field(51; "New Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1,' + Text007;
            Caption = 'New Shortcut Dimension 1 Code';
            Enabled = false;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (1));
        }
        field(52; "New Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2,' + Text007;
            Caption = 'New Shortcut Dimension 2 Code';
            Enabled = false;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (2));
        }
        field(53; "Qty. (Calculated)"; Decimal)
        {
            Caption = 'Qty. (Calculated)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            Enabled = false;
        }
        field(54; "Qty. (Phys. Inventory)"; Decimal)
        {
            Caption = 'Qty. (Phys. Inventory)';
            DecimalPlaces = 0 : 5;
            Description = 'b';
        }
        field(55; "Last Item Ledger Entry No."; Integer)
        {
            Caption = 'Last Item Ledger Entry No.';
            Editable = false;
            Enabled = false;
            TableRelation = "Item Ledger Entry";

        }
        field(56; "Phys. Inventory"; Boolean)
        {
            Caption = 'Phys. Inventory';
            Editable = false;
            Enabled = false;
        }
        field(57; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            Enabled = false;
            TableRelation = "Gen. Business Posting Group";
        }
        field(58; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            Enabled = false;
            TableRelation = "Gen. Product Posting Group";
        }
        field(59; "Entry/Exit Point"; Code[10])
        {
            Caption = 'Entry/Exit Point';
            Enabled = false;
            TableRelation = "Entry/Exit Point";
        }
        field(60; "Document Date"; Date)
        {
            Caption = 'Document Date';
            Enabled = false;
        }
        field(62; "External Document No."; Code[35])
        {
            Caption = 'External Document No.';
            Enabled = false;
        }
        field(63; "Area"; Code[10])
        {
            Caption = 'Area';
            Enabled = false;
            TableRelation = Area;
        }
        field(64; "Transaction Specification"; Code[10])
        {
            Caption = 'Transaction Specification';
            Enabled = false;
            TableRelation = "Transaction Specification";
        }
        field(65; "Posting No. Series"; Code[10])
        {
            Caption = 'Posting No. Series';
            Enabled = false;
            TableRelation = "No. Series";
        }
        field(68; "Reserved Quantity"; Decimal)
        {
            AccessByPermission = TableData "Purch. Rcpt. Header" = R;
            CalcFormula = Sum ("Reservation Entry".Quantity WHERE ("Source ID" = FIELD ("Journal Template Name"),
                                                                  "Source Ref. No." = FIELD ("Line No."),
                                                                  "Source Type" = CONST (83),
                                                                  "Source Subtype" = FIELD ("Entry Type"),
                                                                  "Source Batch Name" = FIELD ("Journal Batch Name"),
                                                                  "Source Prod. Order Line" = CONST (0),
                                                                  "Reservation Status" = CONST (Reservation)));
            Caption = 'Reserved Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
            Enabled = false;
            FieldClass = FlowField;
        }
        field(72; "Unit Cost (ACY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Unit Cost (ACY)';
            Editable = false;
            Enabled = false;
        }
        field(73; "Source Currency Code"; Code[10])
        {
            AccessByPermission = TableData "Drop Shpt. Post. Buffer" = R;
            Caption = 'Source Currency Code';
            Editable = false;
            Enabled = false;
            TableRelation = Currency;
        }
        field(79; "Document Type"; Option)
        {
            Caption = 'Document Type';
            Enabled = false;
            OptionCaption = ' ,Sales Shipment,Sales Invoice,Sales Return Receipt,Sales Credit Memo,Purchase Receipt,Purchase Invoice,Purchase Return Shipment,Purchase Credit Memo,Transfer Shipment,Transfer Receipt,Service Shipment,Service Invoice,Service Credit Memo,Posted Assembly';
            OptionMembers = " ","Sales Shipment","Sales Invoice","Sales Return Receipt","Sales Credit Memo","Purchase Receipt","Purchase Invoice","Purchase Return Shipment","Purchase Credit Memo","Transfer Shipment","Transfer Receipt","Service Shipment","Service Invoice","Service Credit Memo","Posted Assembly";
        }
        field(80; "Document Line No."; Integer)
        {
            Caption = 'Document Line No.';
            Enabled = false;
        }
        field(90; "Order Type"; Option)
        {
            Caption = 'Order Type';
            Editable = false;
            Enabled = false;
            OptionCaption = ' ,Production,Transfer,Service,Assembly';
            OptionMembers = " ",Production,Transfer,Service,Assembly;
        }
        field(91; "Order No."; Code[20])
        {
            Caption = 'Order No.';
            Enabled = false;
            TableRelation = IF ("Order Type" = CONST (Production)) "Production Order"."No." WHERE (Status = CONST (Released));

            trigger OnValidate()
            var
                AssemblyHeader: Record "Assembly Header";
                ProdOrder: Record "Production Order";
                ProdOrderLine: Record "Prod. Order Line";
            begin
            end;
        }
        field(92; "Order Line No."; Integer)
        {
            Caption = 'Order Line No.';
            Enabled = false;
            TableRelation = IF ("Order Type" = CONST (Production)) "Prod. Order Line"."Line No." WHERE (Status = CONST (Released),
                                                                                                     "Prod. Order No." = FIELD ("Order No."));

            trigger OnValidate()
            var
                ProdOrderLine: Record "Prod. Order Line";
            begin
            end;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            Enabled = false;
            TableRelation = "Dimension Set Entry";
        }
        field(481; "New Dimension Set ID"; Integer)
        {
            Caption = 'New Dimension Set ID';
            Editable = false;
            Enabled = false;
            TableRelation = "Dimension Set Entry";
        }
        field(904; "Assemble to Order"; Boolean)
        {
            Caption = 'Assemble to Order';
            Editable = false;
            Enabled = false;
        }
        field(1000; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            Enabled = false;
        }
        field(1001; "Job Task No."; Code[20])
        {
            Caption = 'Job Task No.';
            Enabled = false;
        }
        field(1002; "Job Purchase"; Boolean)
        {
            Caption = 'Job Purchase';
            Enabled = false;
        }
        field(1030; "Job Contract Entry No."; Integer)
        {
            Caption = 'Job Contract Entry No.';
            Editable = false;
            Enabled = false;
        }
        field(5402; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            Enabled = false;
            TableRelation = "Item Variant".Code WHERE ("Item No." = FIELD ("Item No."));
        }
        field(5403; "Bin Code"; Code[20])
        {
            Caption = 'Bin Code';
            Description = 'b';
            TableRelation = IF ("Entry Type" = FILTER (Purchase | "Positive Adjmt." | Output),
                                Quantity = FILTER (>= 0)) Bin.Code WHERE ("Location Code" = FIELD ("Location Code"),
                                                                      "Item Filter" = FIELD ("Item No."),
                                                                      "Variant Filter" = FIELD ("Variant Code"))
            ELSE
            IF ("Entry Type" = FILTER (Purchase | "Positive Adjmt." | Output),
                                                                               Quantity = FILTER (< 0)) "Bin Content"."Bin Code" WHERE ("Location Code" = FIELD ("Location Code"),
                                                                                                                                    "Item No." = FIELD ("Item No."),
                                                                                                                                    "Variant Code" = FIELD ("Variant Code"))
            ELSE
            IF ("Entry Type" = FILTER (Sale | "Negative Adjmt." | Transfer | Consumption),
                                                                                                                                             Quantity = FILTER (> 0)) "Bin Content"."Bin Code" WHERE ("Location Code" = FIELD ("Location Code"),
                                                                                                                                                                                                  "Item No." = FIELD ("Item No."),
                                                                                                                                                                                                  "Variant Code" = FIELD ("Variant Code"))
            ELSE
            IF ("Entry Type" = FILTER (Sale | "Negative Adjmt." | Transfer | Consumption),
                                                                                                                                                                                                           Quantity = FILTER (<= 0)) Bin.Code WHERE ("Location Code" = FIELD ("Location Code"),
                                                                                                                                                                                                                                                 "Item Filter" = FIELD ("Item No."),
                                                                                                                                                                                                                                                 "Variant Filter" = FIELD ("Variant Code"));

            trigger OnValidate()
            var
                ProdOrderComp: Record "Prod. Order Component";
                WhseIntegrationMgt: Codeunit "Whse. Integration Management";
            begin
            end;
        }
        field(5404; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
            Editable = false;
            Enabled = false;
            InitValue = 1;
        }
        field(5406; "New Bin Code"; Code[20])
        {
            Caption = 'New Bin Code';
            Enabled = false;
            TableRelation = Bin.Code WHERE ("Location Code" = FIELD ("New Location Code"),
                                            "Item Filter" = FIELD ("Item No."),
                                            "Variant Filter" = FIELD ("Variant Code"));

            trigger OnValidate()
            var
                WhseIntegrationMgt: Codeunit "Whse. Integration Management";
            begin
            end;
        }
        field(5407; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            Description = 'b';
            TableRelation = "Item Unit of Measure".Code WHERE ("Item No." = FIELD ("Item No."));
        }
        field(5408; "Derived from Blanket Order"; Boolean)
        {
            Caption = 'Derived from Blanket Order';
            Editable = false;
            Enabled = false;
        }
        field(5413; "Quantity (Base)"; Decimal)
        {
            Caption = 'Quantity (Base)';
            DecimalPlaces = 0 : 5;
            Description = 'b';
        }
        field(5415; "Invoiced Qty. (Base)"; Decimal)
        {
            Caption = 'Invoiced Qty. (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            Enabled = false;
        }
        field(5468; "Reserved Qty. (Base)"; Decimal)
        {
            AccessByPermission = TableData "Purch. Rcpt. Header" = R;
            CalcFormula = Sum ("Reservation Entry"."Quantity (Base)" WHERE ("Source ID" = FIELD ("Journal Template Name"),
                                                                           "Source Ref. No." = FIELD ("Line No."),
                                                                           "Source Type" = CONST (83),
                                                                           "Source Subtype" = FIELD ("Entry Type"),
                                                                           "Source Batch Name" = FIELD ("Journal Batch Name"),
                                                                           "Source Prod. Order Line" = CONST (0),
                                                                           "Reservation Status" = CONST (Reservation)));
            Caption = 'Reserved Qty. (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            Enabled = false;
            FieldClass = FlowField;
        }
        field(5560; Level; Integer)
        {
            Caption = 'Level';
            Editable = false;
            Enabled = false;
        }
        field(5561; "Flushing Method"; Option)
        {
            Caption = 'Flushing Method';
            Editable = false;
            Enabled = false;
            OptionCaption = 'Manual,Forward,Backward,Pick + Forward,Pick + Backward';
            OptionMembers = Manual,Forward,Backward,"Pick + Forward","Pick + Backward";
        }
        field(5562; "Changed by User"; Boolean)
        {
            Caption = 'Changed by User';
            Editable = false;
            Enabled = false;
        }
        field(5700; "Cross-Reference No."; Code[20])
        {
            Caption = 'Cross-Reference No.';
            Enabled = false;
        }
        field(5701; "Originally Ordered No."; Code[20])
        {
            AccessByPermission = TableData "Item Substitution" = R;
            Caption = 'Originally Ordered No.';
            Enabled = false;
            TableRelation = Item;
        }
        field(5702; "Originally Ordered Var. Code"; Code[10])
        {
            AccessByPermission = TableData "Item Substitution" = R;
            Caption = 'Originally Ordered Var. Code';
            Enabled = false;
            TableRelation = "Item Variant".Code WHERE ("Item No." = FIELD ("Originally Ordered No."));
        }
        field(5703; "Out-of-Stock Substitution"; Boolean)
        {
            Caption = 'Out-of-Stock Substitution';
            Enabled = false;
        }
        field(5704; "Item Category Code"; Code[10])
        {
            Caption = 'Item Category Code';
            Enabled = false;
            TableRelation = "Item Category";
        }
        field(5705; Nonstock; Boolean)
        {
            Caption = 'Nonstock';
            Enabled = false;
        }
        field(5706; "Purchasing Code"; Code[10])
        {
            AccessByPermission = TableData "Drop Shpt. Post. Buffer" = R;
            Caption = 'Purchasing Code';
            Enabled = false;
            TableRelation = Purchasing;
        }
        field(5707; "Product Group Code"; Code[10])
        {
            Caption = 'Product Group Code';
            Enabled = false;
            TableRelation = "Product Group".Code WHERE ("Item Category Code" = FIELD ("Item Category Code"));
        }
        field(5791; "Planned Delivery Date"; Date)
        {
            Caption = 'Planned Delivery Date';
            Enabled = false;
        }
        field(5793; "Order Date"; Date)
        {
            Caption = 'Order Date';
            Enabled = false;
        }
        field(5800; "Value Entry Type"; Option)
        {
            Caption = 'Value Entry Type';
            Enabled = false;
            OptionCaption = 'Direct Cost,Revaluation,Rounding,Indirect Cost,Variance';
            OptionMembers = "Direct Cost",Revaluation,Rounding,"Indirect Cost",Variance;
        }
        field(5801; "Item Charge No."; Code[20])
        {
            Caption = 'Item Charge No.';
            Enabled = false;
            TableRelation = "Item Charge";
        }
        field(5802; "Inventory Value (Calculated)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Inventory Value (Calculated)';
            Editable = false;
            Enabled = false;
        }
        field(5803; "Inventory Value (Revalued)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Inventory Value (Revalued)';
            Enabled = false;
            MinValue = 0;
        }
        field(5804; "Variance Type"; Option)
        {
            Caption = 'Variance Type';
            Enabled = false;
            OptionCaption = ' ,Purchase,Material,Capacity,Capacity Overhead,Manufacturing Overhead';
            OptionMembers = " ",Purchase,Material,Capacity,"Capacity Overhead","Manufacturing Overhead";
        }
        field(5805; "Inventory Value Per"; Option)
        {
            Caption = 'Inventory Value Per';
            Editable = false;
            Enabled = false;
            OptionCaption = ' ,Item,Location,Variant,Location and Variant';
            OptionMembers = " ",Item,Location,Variant,"Location and Variant";
        }
        field(5806; "Partial Revaluation"; Boolean)
        {
            Caption = 'Partial Revaluation';
            Editable = false;
            Enabled = false;
        }
        field(5807; "Applies-from Entry"; Integer)
        {
            Caption = 'Applies-from Entry';
            Enabled = false;
            MinValue = 0;

            trigger OnValidate()
            var
                ItemLedgEntry: Record "Item Ledger Entry";
                ItemTrackingLines: Page "Item Tracking Lines";
            begin
            end;
        }
        field(5808; "Invoice No."; Code[20])
        {
            Caption = 'Invoice No.';
            Enabled = false;
        }
        field(5809; "Unit Cost (Calculated)"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Cost (Calculated)';
            Editable = false;
            Enabled = false;
        }
        field(5810; "Unit Cost (Revalued)"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Cost (Revalued)';
            Enabled = false;
            MinValue = 0;
        }
        field(5811; "Applied Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Applied Amount';
            Editable = false;
            Enabled = false;
        }
        field(5812; "Update Standard Cost"; Boolean)
        {
            Caption = 'Update Standard Cost';
            Enabled = false;
        }
        field(5813; "Amount (ACY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount (ACY)';
            Enabled = false;
        }
        field(5817; Correction; Boolean)
        {
            Caption = 'Correction';
            Enabled = false;
        }
        field(5818; Adjustment; Boolean)
        {
            Caption = 'Adjustment';
            Enabled = false;
        }
        field(5819; "Applies-to Value Entry"; Integer)
        {
            Caption = 'Applies-to Value Entry';
            Enabled = false;
        }
        field(5820; "Invoice-to Source No."; Code[20])
        {
            Caption = 'Invoice-to Source No.';
            Enabled = false;
            TableRelation = IF ("Source Type" = CONST (Customer)) Customer
            ELSE
            IF ("Source Type" = CONST (Vendor)) Vendor;
        }
        field(5830; Type; Option)
        {
            AccessByPermission = TableData "Machine Center" = R;
            Caption = 'Type';
            Enabled = false;
            OptionCaption = 'Work Center,Machine Center, ,Resource';
            OptionMembers = "Work Center","Machine Center"," ",Resource;
        }
        field(5831; "No."; Code[20])
        {
            Caption = 'No.';
            Enabled = false;
            TableRelation = IF (Type = CONST ("Machine Center")) "Machine Center"
            ELSE
            IF (Type = CONST ("Work Center")) "Work Center"
            ELSE
            IF (Type = CONST (Resource)) Resource;

            trigger OnValidate()
            var
                Resource: Record Resource;
            begin
            end;
        }
        field(5838; "Operation No."; Code[10])
        {
            Caption = 'Operation No.';
            Enabled = false;
            TableRelation = IF ("Order Type" = CONST (Production)) "Prod. Order Routing Line"."Operation No." WHERE (Status = CONST (Released),
                                                                                                                  "Prod. Order No." = FIELD ("Order No."),
                                                                                                                  "Routing No." = FIELD ("Routing No."),
                                                                                                                  "Routing Reference No." = FIELD ("Routing Reference No."));

            trigger OnValidate()
            var
                ProdOrderRtngLine: Record "Prod. Order Routing Line";
            begin
            end;
        }
        field(5839; "Work Center No."; Code[20])
        {
            Caption = 'Work Center No.';
            Editable = false;
            Enabled = false;
            TableRelation = "Work Center";
        }
        field(5841; "Setup Time"; Decimal)
        {
            AccessByPermission = TableData "Machine Center" = R;
            Caption = 'Setup Time';
            DecimalPlaces = 0 : 5;
            Enabled = false;
        }
        field(5842; "Run Time"; Decimal)
        {
            AccessByPermission = TableData "Machine Center" = R;
            Caption = 'Run Time';
            DecimalPlaces = 0 : 5;
            Enabled = false;
        }
        field(5843; "Stop Time"; Decimal)
        {
            AccessByPermission = TableData "Machine Center" = R;
            Caption = 'Stop Time';
            DecimalPlaces = 0 : 5;
            Enabled = false;
        }
        field(5846; "Output Quantity"; Decimal)
        {
            AccessByPermission = TableData "Machine Center" = R;
            Caption = 'Output Quantity';
            DecimalPlaces = 0 : 5;
            Enabled = false;
        }
        field(5847; "Scrap Quantity"; Decimal)
        {
            AccessByPermission = TableData "Machine Center" = R;
            Caption = 'Scrap Quantity';
            DecimalPlaces = 0 : 5;
            Enabled = false;
        }
        field(5849; "Concurrent Capacity"; Decimal)
        {
            AccessByPermission = TableData "Machine Center" = R;
            Caption = 'Concurrent Capacity';
            DecimalPlaces = 0 : 5;
            Enabled = false;

            trigger OnValidate()
            var
                TotalTime: Integer;
            begin
            end;
        }
        field(5851; "Setup Time (Base)"; Decimal)
        {
            Caption = 'Setup Time (Base)';
            DecimalPlaces = 0 : 5;
            Enabled = false;
        }
        field(5852; "Run Time (Base)"; Decimal)
        {
            Caption = 'Run Time (Base)';
            DecimalPlaces = 0 : 5;
            Enabled = false;
        }
        field(5853; "Stop Time (Base)"; Decimal)
        {
            Caption = 'Stop Time (Base)';
            DecimalPlaces = 0 : 5;
            Enabled = false;
        }
        field(5856; "Output Quantity (Base)"; Decimal)
        {
            Caption = 'Output Quantity (Base)';
            DecimalPlaces = 0 : 5;
            Enabled = false;
        }
        field(5857; "Scrap Quantity (Base)"; Decimal)
        {
            Caption = 'Scrap Quantity (Base)';
            DecimalPlaces = 0 : 5;
            Enabled = false;
        }
        field(5858; "Cap. Unit of Measure Code"; Code[10])
        {
            Caption = 'Cap. Unit of Measure Code';
            Enabled = false;
            TableRelation = IF (Type = CONST (Resource)) "Resource Unit of Measure".Code WHERE ("Resource No." = FIELD ("No."))
            ELSE "Capacity Unit of Measure";

            trigger OnValidate()
            var
                ProdOrderRtngLine: Record "Prod. Order Routing Line";
            begin
            end;
        }
        field(5859; "Qty. per Cap. Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Cap. Unit of Measure';
            DecimalPlaces = 0 : 5;
            Enabled = false;
        }
        field(5873; "Starting Time"; Time)
        {
            AccessByPermission = TableData "Machine Center" = R;
            Caption = 'Starting Time';
            Enabled = false;
        }
        field(5874; "Ending Time"; Time)
        {
            AccessByPermission = TableData "Machine Center" = R;
            Caption = 'Ending Time';
            Enabled = false;
        }
        field(5882; "Routing No."; Code[20])
        {
            Caption = 'Routing No.';
            Editable = false;
            Enabled = false;
            TableRelation = "Routing Header";
        }
        field(5883; "Routing Reference No."; Integer)
        {
            Caption = 'Routing Reference No.';
            Enabled = false;
        }
        field(5884; "Prod. Order Comp. Line No."; Integer)
        {
            Caption = 'Prod. Order Comp. Line No.';
            Enabled = false;
            TableRelation = IF ("Order Type" = CONST (Production)) "Prod. Order Component"."Line No." WHERE (Status = CONST (Released),
                                                                                                          "Prod. Order No." = FIELD ("Order No."),
                                                                                                          "Prod. Order Line No." = FIELD ("Order Line No."));
        }
        field(5885; Finished; Boolean)
        {
            AccessByPermission = TableData "Machine Center" = R;
            Caption = 'Finished';
            Enabled = false;
        }
        field(5887; "Unit Cost Calculation"; Option)
        {
            Caption = 'Unit Cost Calculation';
            Enabled = false;
            OptionCaption = 'Time,Units';
            OptionMembers = Time,Units;
        }
        field(5888; Subcontracting; Boolean)
        {
            Caption = 'Subcontracting';
            Enabled = false;
        }
        field(5895; "Stop Code"; Code[10])
        {
            Caption = 'Stop Code';
            Enabled = false;
            TableRelation = Stop;
        }
        field(5896; "Scrap Code"; Code[10])
        {
            Caption = 'Scrap Code';
            Enabled = false;
            TableRelation = Scrap;
        }
        field(5898; "Work Center Group Code"; Code[10])
        {
            Caption = 'Work Center Group Code';
            Editable = false;
            Enabled = false;
            TableRelation = "Work Center Group";
        }
        field(5899; "Work Shift Code"; Code[10])
        {
            Caption = 'Work Shift Code';
            Enabled = false;
            TableRelation = "Work Shift";
        }
        field(6500; "Serial No."; Code[20])
        {
            Caption = 'Serial No.';
            Editable = false;
            Enabled = false;
        }
        field(6501; "Lot No."; Code[20])
        {
            Caption = 'Lot No.';
            Editable = false;
            Enabled = false;
        }
        field(6502; "Warranty Date"; Date)
        {
            Caption = 'Warranty Date';
            Editable = false;
            Enabled = false;
        }
        field(6503; "New Serial No."; Code[20])
        {
            Caption = 'New Serial No.';
            Editable = false;
            Enabled = false;
        }
        field(6504; "New Lot No."; Code[20])
        {
            Caption = 'New Lot No.';
            Editable = false;
            Enabled = false;
        }
        field(6505; "New Item Expiration Date"; Date)
        {
            Caption = 'New Item Expiration Date';
            Enabled = false;
        }
        field(6506; "Item Expiration Date"; Date)
        {
            Caption = 'Item Expiration Date';
            Editable = false;
            Enabled = false;
        }
        field(6600; "Return Reason Code"; Code[10])
        {
            Caption = 'Return Reason Code';
            Enabled = false;
            TableRelation = "Return Reason";
        }
        field(7315; "Warehouse Adjustment"; Boolean)
        {
            Caption = 'Warehouse Adjustment';
            Enabled = false;
        }
        field(7380; "Phys Invt Counting Period Code"; Code[10])
        {
            Caption = 'Phys Invt Counting Period Code';
            Editable = false;
            Enabled = false;
            TableRelation = "Phys. Invt. Counting Period";
        }
        field(7381; "Phys Invt Counting Period Type"; Option)
        {
            Caption = 'Phys Invt Counting Period Type';
            Editable = false;
            Enabled = false;
            OptionCaption = ' ,Item,SKU';
            OptionMembers = " ",Item,SKU;
        }
        field(50003; "B Line type"; Option)
        {
            Caption = 'Line type';
            Description = 'BEJOWW5.0.007 Used in CU22 to fill table 32 and 50802';
            Enabled = false;
            OptionCaption = 'Normal,Market introduction,Compensation,Zero normal,Government,Price introduction,Other';
            OptionMembers = Normal,"Market introduction",Compensation,"Zero normal",Government,"Price introduction",Other;
        }
        field(50031; "B Comment"; Text[50])
        {
            Caption = 'Comment';
            Description = 'BEJOWW5.01.011';
            Enabled = false;
        }
        field(50089; "B Characteristic"; Option)
        {
            Caption = 'Characteristic';
            Description = 'BEJOWW5.0.007 Used in CU22 to fill table 32 and 50802';
            Enabled = false;
            OptionCaption = ' ,Price correction,Return-to stock,Return seed destruction,Customer seed destruction,Stock revaluation,Customs sample,Not to join';
            OptionMembers = " ","Price correction","Return-to stock","Return seed destruction","Customer seed destruction","Stock revaluation","Customs sample","Not to join";
        }
        field(50100; "B LookUpLotNoAvailQty"; Decimal)
        {
            Description = 'BEJOW19.00.021';
            Editable = false;
            Enabled = false;
        }
        field(50101; "B Page_Action ID"; Text[30])
        {
            Description = 'BEJOW19.00.021';
            Enabled = false;
        }
        field(50200; "Begin Date"; Date)
        {
            Description = 'b';
        }
        field(50201; "End Date"; Date)
        {
            Description = 'b';
        }
        field(50202; "Modified Date"; Date)
        {
            Description = 'b';
        }
        field(50203; "Quantity per Item"; Decimal)
        {
            CalcFormula = Sum ("EOSS Journal Line"."Quantity (Base)" WHERE ("Item No." = FIELD ("Item No.")));
            FieldClass = FlowField;
        }
        field(50204; "Quote Created"; Boolean)
        {
        }
        field(50205; "Quote Document No."; Code[20])
        {
        }
        field(50207; "Quote Date"; Date)
        {
        }
        field(99000755; "Overhead Rate"; Decimal)
        {
            Caption = 'Overhead Rate';
            DecimalPlaces = 0 : 5;
            Enabled = false;
        }
        field(99000756; "Single-Level Material Cost"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Single-Level Material Cost';
            Enabled = false;
        }
        field(99000757; "Single-Level Capacity Cost"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Single-Level Capacity Cost';
            Enabled = false;
        }
        field(99000758; "Single-Level Subcontrd. Cost"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Single-Level Subcontrd. Cost';
            Enabled = false;
        }
        field(99000759; "Single-Level Cap. Ovhd Cost"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Single-Level Cap. Ovhd Cost';
            Enabled = false;
        }
        field(99000760; "Single-Level Mfg. Ovhd Cost"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Single-Level Mfg. Ovhd Cost';
            Enabled = false;
        }
        field(99000761; "Rolled-up Material Cost"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Rolled-up Material Cost';
            Enabled = false;
        }
        field(99000762; "Rolled-up Capacity Cost"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Rolled-up Capacity Cost';
            Enabled = false;
        }
        field(99000763; "Rolled-up Subcontracted Cost"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Rolled-up Subcontracted Cost';
            Enabled = false;
        }
        field(99000764; "Rolled-up Mfg. Ovhd Cost"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Rolled-up Mfg. Ovhd Cost';
            Enabled = false;
        }
        field(99000765; "Rolled-up Cap. Overhead Cost"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Rolled-up Cap. Overhead Cost';
            Enabled = false;
        }
    }

    keys
    {
        key(Key1; "Journal Template Name", "Journal Batch Name", "Document No.", "Line No.")
        {
            MaintainSIFTIndex = false;
        }
        key(Key2; "Item No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        lrecBejoSetup: Record "Bejo Setup";
    begin
        lrecBejoSetup.Get;
        lrecBejoSetup.TestField("Begin Date");
        lrecBejoSetup.TestField("End Date");
        "Begin Date" := lrecBejoSetup."Begin Date";
        "End Date" := lrecBejoSetup."End Date";
        "Modified Date" := Today;
    end;

    var
        Text001: Label '%1 must be reduced.';
        Text002: Label 'You cannot change %1 when %2 is %3.';
        Text006: Label 'You must not enter %1 in a revaluation sum line.';
        Text007: Label 'New ';
        Text012: Label 'The update has been interrupted to respect the warning.';
        Text021: Label 'The entered bin code %1 is different from the bin code %2 in production order component %3.\\Are you sure that you want to post the consumption from bin code %1?';
        Text029: Label 'must be positive';
        Text030: Label 'must be negative';
        Text031: Label 'You can not insert item number %1 because it is not produced on released production order %2.';
        Text032: Label 'When posting, the entry %1 will be opened first.';
        Text033: Label 'If the item carries serial or lot numbers, then you must use the %1 field in the %2 window.';
        Text034: Label 'You cannot revalue individual item ledger entries for items that use the average costing method.';
}

