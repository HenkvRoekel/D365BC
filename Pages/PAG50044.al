page 50044 "Allocate Non Bejo Items"
{

    Caption = 'Allocate Non Bejo Items';
    LinksAllowed = false;

    layout
    {
        area(content)
        {
            field(ItemNo; ItemNo)
            {
                AssistEdit = false;
                Caption = 'Item';
                DrillDown = false;
                Editable = false;
                Lookup = false;
                ApplicationArea = All;
            }
            field(Quantity; Quantity)
            {
                Caption = 'Quantity to Allocate';
                ApplicationArea = All;

                trigger OnValidate()
                var
                    ctxtError: Label 'The Allocation (Purchase) Quantity %1 is less than Allocated (Sales) Quantity %2';
                begin

                    Item.CalcFields("B Allocated");
                    if Quantity < Item."B Allocated" then
                        Error(ctxtError, Quantity, Item."B Allocated");
                end;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Generate Allocation")
            {
                Caption = 'Generate Allocation';
                Image = Allocate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    ctxtAllocation: Label 'Allocation is created.';
                begin
                    CreateAllocation();

                    Message(ctxtAllocation);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        Item.Get(ItemNo);
        Item.CalcFields(Inventory);
        Quantity := Item.Inventory;
    end;

    var
        Quantity: Decimal;
        ItemNo: Code[20];
        Item: Record Item;

    procedure SetItem(TheItemNo: Code[20])
    begin
        ItemNo := TheItemNo;
    end;

    local procedure CreateAllocation()
    var
        AllocationEntry: Record "Prognosis/Allocation Entry";
        Item: Record Item;
        Varieties: Record Varieties;
        BEJOSetup: Record "Bejo Setup";
        ctxtNonBEJO: Label 'Allocation non Bejo Item';
        AllocationEntrySum: Record "Prognosis/Allocation Entry";
        TotalQty: Decimal;
    begin
        BEJOSetup.Get();

        AllocationEntry.Init;
        AllocationEntry.Validate("Item No.", ItemNo);
        if Item.Get(ItemNo) then begin
            AllocationEntry.Variety := Item."B Variety";
        end;
        AllocationEntry."Date Modified" := Today;
        AllocationEntry."Entry Type" := AllocationEntry."Entry Type"::Allocation;
        AllocationEntry."Begin Date" := BEJOSetup."Begin Date";
        AllocationEntry."Sales Date" := BEJOSetup."End Date";
        AllocationEntry."User-ID" := UserId;
        AllocationEntry."Is Import from Bejo" := false;
        AllocationEntry.Description := ctxtNonBEJO;

        TotalQty := 0;
        AllocationEntrySum.SetRange("Item No.", ItemNo);
        AllocationEntrySum.SetRange("Entry Type", AllocationEntrySum."Entry Type"::Allocation);
        AllocationEntrySum.SetRange("Begin Date", BEJOSetup."Begin Date");
        AllocationEntrySum.SetRange("Sales Date", BEJOSetup."End Date");
        if AllocationEntrySum.FindSet then repeat
                                               TotalQty += AllocationEntrySum.Allocated;
            until AllocationEntrySum.Next = 0;

        AllocationEntry.Allocated := Quantity - TotalQty;

        AllocationEntry.Insert(true);
    end;
}

