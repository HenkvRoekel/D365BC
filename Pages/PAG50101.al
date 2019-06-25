page 50101 PCustomer
{

    PageType = List;
    SourceTable = Customer;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Customer_No; "No.")
                {
                    Caption = 'Customer No.';
                    ApplicationArea = All;
                }
                field(Customer_Name; Name)
                {
                    Caption = 'Customer Name';
                    ApplicationArea = All;
                }
                field(Customer_City; City)
                {
                    Caption = 'Customer City';
                    ApplicationArea = All;
                }
                field(Customer_Address; Address)
                {
                    Caption = 'Customer Address';
                    ApplicationArea = All;
                }
                field(Dimension_1; gTextDimension[1])
                {
                    ApplicationArea = All;
                }
                field(Dimension_2; gTextDimension[2])
                {
                    ApplicationArea = All;
                }
                field(Dimension_3; gTextDimension[3])
                {
                    ApplicationArea = All;
                }
                field(Dimension_4; gTextDimension[4])
                {
                    ApplicationArea = All;
                }
                field(Dimension_5; gTextDimension[5])
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        X := 0;
        Clear(gTextDimension);

        gRecDefaultDimension.Reset;
        gRecDefaultDimension.SetRange("Table ID", 18);
        gRecDefaultDimension.SetRange("No.", "No.");
        if gRecDefaultDimension.Find('-') then
            repeat
                X += 1;
                gTextDimension[X] := gRecDefaultDimension."Dimension Code" + ':' + gRecDefaultDimension."Dimension Value Code";
            until (gRecDefaultDimension.Next = 0) or (X = 5);
    end;

    var
        gRecDefaultDimension: Record "Default Dimension";
        gTextDimension: array[5] of Text[100];
        X: Integer;
}

