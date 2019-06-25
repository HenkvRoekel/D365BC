tableextension 90349 DimensionValueBTExt extends "Dimension Value"
{

    fields
    {
        field(50000; "B Consolidation Cost Center"; Option)
        {
            Caption = 'Consolidation Cost Center';

            OptionCaption = ',Sales, Onion Sets,Research,Production';
            OptionMembers = ,Sales," Onion Sets",Research,Production;
        }
    }
}

