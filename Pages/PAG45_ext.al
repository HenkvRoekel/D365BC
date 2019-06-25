pageextension 90045 SalesListBTPageExt extends "Sales List"
{

    layout
    {
        addafter("Assigned User ID")
        {
            field("<Reason Code Bejo>"; "Reason Code")
            {
                ApplicationArea = All;
            }
        }
    }
}

