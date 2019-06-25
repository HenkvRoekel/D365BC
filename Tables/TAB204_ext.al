tableextension 90204 UnitofMeasureBTExt extends "Unit of Measure" 
{
    

    fields
    {
        field(50000;"B Description for Reports";Text[20])
        {
            Caption = 'Description for Reports';
            
        }
        field(50002;"B Description for Prognoses";Text[15])
        {
            Caption = 'Description for Prognoses';
            
        }
        field(50003;"B Unit in Weight";Boolean)
        {
            Caption = 'Unit in Weight';
            
        }
        field(50004;"B Code BejoNL";Code[10])
        {
            Caption = 'Code BejoNL';
            
        }
    }
}

