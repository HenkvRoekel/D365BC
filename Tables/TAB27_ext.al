tableextension 90027 ItemBTExt extends Item 
{
    
    fields
    {
        modify("Sales (Qty.)")
        {

            //Unsupported feature: Property Modification (CalcFormula) on ""Sales (Qty.)"(Field 72)".

            Description = 'Attention';
        }
        modify("Sales (LCY)")
        {

            //Unsupported feature: Property Modification (CalcFormula) on ""Sales (LCY)"(Field 78)".

            Description = 'Attention';
        }
        modify("COGS (LCY)")
        {

            //Unsupported feature: Property Modification (CalcFormula) on ""COGS (LCY)"(Field 83)".

            Description = 'Attention';
        }
        modify("Qty. on Sales Order")
        {

            //Unsupported feature: Property Modification (CalcFormula) on ""Qty. on Sales Order"(Field 85)".

            Description = 'Attention';
        }
        field(50000;"B Created from Template";Code[10])
        {
            Caption = 'Created from Template';
            
            TableRelation = "Config. Template Header".Code WHERE ("Table ID"=CONST(27));
            ValidateTableRelation = false;
        }
        field(50005;"B Gen.Prod.Posting Grp Filter";Code[10])
        {
            Caption = 'B Gen.Prod.Posting Grp Filter';
            
            FieldClass = FlowFilter;
            TableRelation = "Gen. Product Posting Group";
        }
        field(50006;"B Gen.Bus.Posting Grp Filter";Code[10])
        {
            Caption = 'B Gen.Bus.Posting Grp Filter';
            
            FieldClass = FlowFilter;
            TableRelation = "Gen. Business Posting Group";
        }
        field(50014;"B Salespersonfilter";Code[10])
        {
            Caption = 'B Salespersonfilter';
            
            FieldClass = FlowFilter;
            TableRelation = "Salesperson/Purchaser";
        }
        field(50015;"B Customerfilter";Code[20])
        {
            Caption = 'B Customerfilter';
            
            FieldClass = FlowFilter;
            TableRelation = Customer;
        }
        field(50016;"B Packingfilter";Code[10])
        {
            Caption = 'Packingfilter';
            
            FieldClass = FlowFilter;
            TableRelation = "Item Unit of Measure" WHERE ("Item No."=FIELD("No."));
        }
        field(50033;"B Purchase BZ Lead Time Calc";DateFormula)
        {
            Caption = 'Purchase BZ Lead Time Calc';
            
        }
        field(50037;"B Prognoses";Decimal)
        {
            CalcFormula = Sum("Prognosis/Allocation Entry".Prognoses WHERE ("Item No."=FIELD("No."),
                                                                            "Sales Date"=FIELD("Date Filter"),
                                                                            Salesperson=FIELD("B Salespersonfilter"),
                                                                            Customer=FIELD("B Customerfilter")));
            Caption = 'Prognoses';
            
            FieldClass = FlowField;
        }
        field(50042;"B Product Type";Code[2])
        {
            Caption = 'Product Type';
            
        }
        field(50043;"B Variety";Code[10])
        {
            Caption = 'Variety';
            
        }
        field(50044;"B Allocated";Decimal)
        {
            CalcFormula = Sum("Prognosis/Allocation Entry"."Allocated Cust. Sales person" WHERE ("Item No."=FIELD("No."),
                                                                                                 "Sales Date"=FIELD("Date Filter"),
                                                                                                 Salesperson=FIELD("B Salespersonfilter"),
                                                                                                 Customer=FIELD("B Customerfilter")));
            Caption = 'Allocated';
            
            FieldClass = FlowField;
        }
        field(50045;"B To be allocated";Decimal)
        {
            CalcFormula = Sum("Prognosis/Allocation Entry"."Allocated Cust. Sales person" WHERE ("Item No."=FIELD("No."),
                                                                                                 "Sales Date"=FIELD("Date Filter")));
            Caption = 'To be allocated';
            
            FieldClass = FlowField;
        }
        field(50048;"B Country allocated";Decimal)
        {
            CalcFormula = Sum("Prognosis/Allocation Entry".Allocated WHERE ("Item No."=FIELD("No."),
                                                                            "Sales Date"=FIELD("Date Filter")));
            Caption = 'Country allocated';
            
            FieldClass = FlowField;
        }
        field(50049;"B Salesperson/cust. allocated";Decimal)
        {
            CalcFormula = Sum("Prognosis/Allocation Entry"."Allocated Cust. Sales person" WHERE ("Item No."=FIELD("No."),
                                                                                                 "Sales Date"=FIELD("Date Filter"),
                                                                                                 Customer=FIELD("B Customerfilter"),
                                                                                                 Salesperson=FIELD("B Salespersonfilter")));
            Caption = 'Salesperson/customer allocated';
            
            FieldClass = FlowField;
        }
        field(50050;"B Current Season filter";Date)
        {
            Caption = 'B Current Season filter';
           
            FieldClass = FlowFilter;
        }
        field(50051;"B Last Season filter";Date)
        {
            Caption = 'B Last Season filter';
            
            FieldClass = FlowFilter;
        }
        field(50052;"B Sales (Qty.) Current season";Decimal)
        {
            CalcFormula = -Sum("Value Entry"."Invoiced Quantity" WHERE ("Item Ledger Entry Type"=CONST(Sale),
                                                                        "Item No."=FIELD("No."),
                                                                        "Global Dimension 1 Code"=FIELD("Global Dimension 1 Filter"),
                                                                        "Global Dimension 2 Code"=FIELD("Global Dimension 2 Filter"),
                                                                        "Location Code"=FIELD("Location Filter"),
                                                                        "Drop Shipment"=FIELD("Drop Shipment Filter"),
                                                                        "Variant Code"=FIELD("Variant Filter"),
                                                                        "Posting Date"=FIELD("B Current Season filter"),
                                                                        "Source No."=FIELD("B Customerfilter"),
                                                                        "Salespers./Purch. Code"=FIELD("B Salespersonfilter")));
            Caption = 'Sales (Qty.) Season';
            DecimalPlaces = 0:5;
            
            Editable = false;
            FieldClass = FlowField;
        }
        field(50053;"B Sales (Qty.) Last season";Decimal)
        {
            CalcFormula = -Sum("Value Entry"."Invoiced Quantity" WHERE ("Item Ledger Entry Type"=CONST(Sale),
                                                                        "Item No."=FIELD("No."),
                                                                        "Global Dimension 1 Code"=FIELD("Global Dimension 1 Filter"),
                                                                        "Global Dimension 2 Code"=FIELD("Global Dimension 2 Filter"),
                                                                        "Location Code"=FIELD("Location Filter"),
                                                                        "Drop Shipment"=FIELD("Drop Shipment Filter"),
                                                                        "Variant Code"=FIELD("Variant Filter"),
                                                                        "Posting Date"=FIELD("B Last Season filter"),
                                                                        "Source No."=FIELD("B Customerfilter"),
                                                                        "Salespers./Purch. Code"=FIELD("B Salespersonfilter")));
            Caption = 'Sales (Qty.) Season -1';
            DecimalPlaces = 0:5;
            
            Editable = false;
            FieldClass = FlowField;
        }
        field(50055;"B Value Filter";Decimal)
        {
            Caption = 'Value Filter';
            
            FieldClass = FlowFilter;
        }
        field(50056;"B Unit in Weight Filter";Boolean)
        {
            Caption = 'B Unit in Weight Filter';
            
            FieldClass = FlowFilter;
        }
        field(50057;"B Treatment Code Filter";Code[10])
        {
            Caption = 'B Treatment Code Filter';
            
            FieldClass = FlowFilter;
            TableRelation = "Treatment Code";
        }
        field(50068;"B Remaining Quantity";Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Remaining Quantity" WHERE ("Item No."=FIELD("No."),
                                                                              Open=CONST(true),
                                                                              "Location Code"=FIELD("Location Filter")));
            Caption = 'Remaining Quantity';
            DecimalPlaces = 0:5;
            
            Editable = false;
            FieldClass = FlowField;
        }
        field(50084;"B Qty. on Purch. Quote";Decimal)
        {
            CalcFormula = Sum("Purchase Line"."Outstanding Qty. (Base)" WHERE ("Document Type"=CONST(Quote),
                                                                               Type=CONST(Item),
                                                                               "No."=FIELD("No."),
                                                                               "Shortcut Dimension 1 Code"=FIELD("Global Dimension 1 Filter"),
                                                                               "Shortcut Dimension 2 Code"=FIELD("Global Dimension 2 Filter"),
                                                                               "Location Code"=FIELD("Location Filter"),
                                                                               "Drop Shipment"=FIELD("Drop Shipment Filter"),
                                                                               "Variant Code"=FIELD("Variant Filter"),
                                                                               "Bin Code"=FIELD("Bin Filter"),
                                                                               "Requested Receipt Date"=FIELD("Date Filter")));
            Caption = 'Qty. on Purch. Quote';
            DecimalPlaces = 0:5;
            
            Editable = false;
            FieldClass = FlowField;
        }
        field(50085;"B Qty. to Invoice";Decimal)
        {
            CalcFormula = Sum("Sales Line"."Qty. to Invoice (Base)" WHERE ("Document Type"=CONST(Order),
                                                                           Type=CONST(Item),
                                                                           "No."=FIELD("No."),
                                                                           "Shortcut Dimension 1 Code"=FIELD("Global Dimension 1 Filter"),
                                                                           "Shortcut Dimension 2 Code"=FIELD("Global Dimension 2 Filter"),
                                                                           "Location Code"=FIELD("Location Filter"),
                                                                           "Drop Shipment"=FIELD("Drop Shipment Filter"),
                                                                           "Variant Code"=FIELD("Variant Filter"),
                                                                           "Bin Code"=FIELD("Bin Filter"),
                                                                           "Shipment Date"=FIELD("Date Filter"),
                                                                           "B Salesperson"=FIELD("B Salespersonfilter"),
                                                                           "Sell-to Customer No."=FIELD("B Customerfilter")));
            Caption = 'Qty. to Invoice';
            DecimalPlaces = 0:5;
            
            Editable = false;
            FieldClass = FlowField;
        }
        field(50099;"B In prognoses";Boolean)
        {
            Caption = 'In prognoses';
            Description = 'BEJOWW5.01.000';
        }
        field(50103;"B Tracking Qty on Sales Orders";Decimal)
        {
            CalcFormula = -Sum("Reservation Entry"."Quantity (Base)" WHERE ("Reservation Status"=CONST(Surplus),
                                                                            "Item No."=FIELD("No."),
                                                                            "Location Code"=FIELD("Variant Filter"),
                                                                            "Variant Code"=FIELD("Bin Filter"),
                                                                            "Source Type"=CONST(37),
                                                                            "Source Subtype"=CONST("1"),
                                                                            "Shipment Date"=FIELD("Date Filter")));
            Caption = 'Tracking Qty. on Sales Orders';
            DecimalPlaces = 0:5;
            
            Editable = false;
            FieldClass = FlowField;
        }
        field(50113;"B Tracking Units on Sales Ords";Decimal)
        {
            CalcFormula = -Sum("Reservation Entry".Quantity WHERE ("Reservation Status"=CONST(Surplus),
                                                                   "Item No."=FIELD("No."),
                                                                   "Location Code"=FIELD("Variant Filter"),
                                                                   "Variant Code"=FIELD("Bin Filter"),
                                                                   "Source Type"=CONST(37),
                                                                   "Source Subtype"=CONST("1"),
                                                                   "Shipment Date"=FIELD("Date Filter")));
            Caption = 'Tracking Units on Sales Orders';
            DecimalPlaces = 0:5;
            
            Editable = false;
            FieldClass = FlowField;
        }
        field(50154;"B Organic";Boolean)
        {
            Caption = 'Organic';
            
        }
        field(50171;"B Extension";Code[1])
        {
            Caption = 'Extension';
           
            TableRelation = "Item Extension";
        }
        field(50173;"B Crop";Code[3])
        {
            Caption = 'Crop';
            
            TableRelation = Crops;
        }
        field(50181;"B Promo Status";Code[20])
        {
            CalcFormula = Lookup(Varieties."Promo Status" WHERE ("No."=FIELD("B Variety")));
            Caption = 'Promo Status';
            
            Editable = false;
            FieldClass = FlowField;
        }
        field(50182;"B Promo Status Description";Text[50])
        {
            CalcFormula = Lookup("Promo Status".Description WHERE (Code=FIELD("B Promo Status")));
            Caption = 'Promo Status Description';
           
            Editable = false;
            FieldClass = FlowField;
        }
        field(50185;"B Qty. on Blanket Sales Order";Decimal)
        {
            CalcFormula = Sum("Sales Line"."Outstanding Qty. (Base)" WHERE ("Document Type"=CONST("Blanket Order"),
                                                                            Type=CONST(Item),
                                                                            "No."=FIELD("No."),
                                                                            "Shortcut Dimension 1 Code"=FIELD("Global Dimension 1 Filter"),
                                                                            "Shortcut Dimension 2 Code"=FIELD("Global Dimension 2 Filter"),
                                                                            "Location Code"=FIELD("Location Filter"),
                                                                            "Drop Shipment"=FIELD("Drop Shipment Filter"),
                                                                            "Variant Code"=FIELD("Variant Filter"),
                                                                            "Shipment Date"=FIELD("Date Filter"),
                                                                            "B Salesperson"=FIELD("B Salespersonfilter")));
            Caption = 'Qty. on Blanket Sales Order';
            DecimalPlaces = 0:5;
            
            Editable = false;
            FieldClass = FlowField;
        }
        field(50190;"B Description 3";Text[10])
        {
            CalcFormula = Lookup("Item Extension"."Extension Code" WHERE (Extension=FIELD("B Extension"),
                                                                          Language=FILTER('')));
            Caption = 'Description 3';
            
            FieldClass = FlowField;
        }
        field(50200;"B Location Code";Code[10])
        {
            Caption = 'Location Code';
            
            TableRelation = Location WHERE ("Use As In-Transit"=CONST(false));
        }
        field(50210;"B Crop Extension";Code[5])
        {
            Caption = 'Crop Extension';
            
            TableRelation = "Crop Extension Description".Extension WHERE ("Crop Code"=FIELD("B Crop"));
        }
        field(50211;"B Purch. (Qty.) Current season";Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Invoiced Quantity" WHERE ("Entry Type"=CONST(Purchase),
                                                                             "Item No."=FIELD("No."),
                                                                             "Global Dimension 1 Code"=FIELD("Global Dimension 1 Filter"),
                                                                             "Global Dimension 2 Code"=FIELD("Global Dimension 2 Filter"),
                                                                             "Location Code"=FIELD("Location Filter"),
                                                                             "Drop Shipment"=FIELD("Drop Shipment Filter"),
                                                                             "Variant Code"=FIELD("Variant Filter"),
                                                                             "Posting Date"=FIELD("B Current Season filter"),
                                                                             "Lot No."=FIELD("Lot No. Filter"),
                                                                             "Serial No."=FIELD("Serial No. Filter")));
            Caption = 'Purch. (Qty.) Season';
            DecimalPlaces = 0:5;
            
            Editable = false;
            FieldClass = FlowField;
        }
        field(50212;"B Purch. (Qty.) Last season";Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Invoiced Quantity" WHERE ("Entry Type"=CONST(Purchase),
                                                                             "Item No."=FIELD("No."),
                                                                             "Global Dimension 1 Code"=FIELD("Global Dimension 1 Filter"),
                                                                             "Global Dimension 2 Code"=FIELD("Global Dimension 2 Filter"),
                                                                             "Location Code"=FIELD("Location Filter"),
                                                                             "Drop Shipment"=FIELD("Drop Shipment Filter"),
                                                                             "Variant Code"=FIELD("Variant Filter"),
                                                                             "Posting Date"=FIELD("B Last Season filter"),
                                                                             "Lot No."=FIELD("Lot No. Filter"),
                                                                             "Serial No."=FIELD("Serial No. Filter")));
            Caption = 'Purch. (Qty.) Season -1';
            DecimalPlaces = 0:5;
           
            Editable = false;
            FieldClass = FlowField;
        }
        field(50213;MOBSRow1;Text[150])
        {
            Description = 'MOBS';
        }
        field(50214;MOBSRow2;Text[150])
        {
            Description = 'MOBS';
        }
        field(50215;MOBSRow3;Text[150])
        {
            Description = 'MOBS';
        }
        field(50300;"B DisplayPromoStatus";Text[72])
        {
            
            Editable = false;
        }
        field(50301;"B VarietySalesComment";Text[50])
        {
           
            Editable = false;
        }
        field(50302;"B VarietyDateToBeDiscontinued";Date)
        {
           
            Editable = false;
        }
        field(50303;"B ItemExtensionDescription";Text[60])
        {
            
            Editable = false;
        }
        field(50304;"B ItemBlockDescription";Text[50])
        {
            
            Editable = false;
        }
    }
}

