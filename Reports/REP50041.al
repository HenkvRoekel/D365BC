report 50041 "Allocation Import List"
{

    DefaultLayout = RDLC;
    RDLCLayout = './RDLC/Allocation Import List.rdlc';


    dataset
    {
        dataitem("Prognosis/Allocation Entry"; "Prognosis/Allocation Entry")
        {
            DataItemTableView = SORTING ("Item No.", "Entry No.") ORDER(Ascending);
            RequestFilterFields = "Internal Entry No.", "Export/Import Date";
            column(UserId; UserId)
            {
            }
            column(CompanyName; CompanyName)
            {
            }
            column(ItemNo_PrognosisAllocationEntry; "Prognosis/Allocation Entry"."Item No.")
            {
            }
            column(PrognosisLastDateModified_PrognosisAllocationEntry; "Prognosis/Allocation Entry"."Date Modified")
            {
            }
            column(Allocated_PrognosisAllocationEntry; "Prognosis/Allocation Entry".Allocated)
            {
            }
            column(Descrption1; grecItem.Description)
            {
            }
            column(Description2; grecItem."Description 2")
            {
            }
            column(ExtensionCode_Item; grecItemExtension."Extension Code")
            {
            }

            trigger OnAfterGetRecord()
            begin

                if not grecItem.Get("Item No.") then
                    grecItem.Init;

                if not grecItemExtension.Get(grecItem."B Extension", '') then
                    grecItemExtension.Init;
            end;

            trigger OnPreDataItem()
            begin
                gLastFieldNo := FieldNo("Internal Entry No.");
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
        lblItemNo = 'Item No.';
        lblDescription = 'Description';
        lblDescription2 = 'Description 2';
        lblDescription3 = 'Description 3';
        lblLastDateModified = 'Last Date Modified';
        lblAlocated = 'Allocated';
        lblAlocatedListImport = 'Allocation Import List';
    }

    var
        gLastFieldNo: Integer;
        gFooterPrinted: Boolean;
        grecItem: Record Item;
        grecItemExtension: Record "Item Extension";
        gcuBejoMgt: Codeunit "Bejo Management";
}

