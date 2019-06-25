tableextension 90018 CustomerBTExt extends Customer 
{
    
    fields
    {
        field(50000;"B Posting Date Filter";Date)
        {
            Caption = 'Posting Date Filter';
            FieldClass = FlowFilter;
        }
        field(50005;"B Country of Origin and PhytoC";Boolean)
        {
            Caption = 'Country of Origin and Phyto Certificate on Sales Order';
            
        }
        field(50024;"Region Filter";Code[100])
        {
            Caption = 'Region Filter';
            
        }
    }
}

