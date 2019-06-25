page 50042 "Item Tracking Summary Subform"
{

    Caption = 'Item Tracking Summary';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = ListPart;
    SourceTable = "Entry Summary";
    SourceTableTemporary = true;
    SourceTableView = SORTING ("Lot No.", "Serial No.");

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("B Item No."; "B Item No.")
                {
                    ApplicationArea = All;
                }
                field("Lot No."; "Lot No.")
                {
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin
                        grecLotNoInformation.SetRange("Lot No.", "Lot No.");
                        PAGE.RunModal(50003, grecLotNoInformation);
                    end;
                }
                field("B Treatment Code"; "B Treatment Code")
                {
                    ApplicationArea = All;
                }
                field("B Unit of Measure Code"; "B Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Total Available Quantity"; "Total Available Quantity")
                {
                    Caption = 'Total Available Quantity (Base)';
                    ApplicationArea = All;
                }
                field("B Tot Available Quantity(UofM)"; "B Tot Available Quantity(UofM)")
                {
                    ApplicationArea = All;
                }
                field("B Tot Requested Quantity(UofM)"; "B Tot Requested Quantity(UofM)")
                {
                    ApplicationArea = All;
                }
                field("B Best used by"; "B Best used by")
                {
                    ApplicationArea = All;
                }
                field("B Tsw. in gr."; "B Tsw. in gr.")
                {
                    ApplicationArea = All;
                }
                field("B Germination"; "B Germination")
                {
                    ApplicationArea = All;
                }
                field("B Grade Code"; "B Grade Code")
                {
                    ApplicationArea = All;
                }
                field("B Blocked"; "B Blocked")
                {
                    ApplicationArea = All;
                }
                field("B Location Code"; "B Location Code")
                {
                    ApplicationArea = All;
                }
                field("B Bin Code"; "B Bin Code")
                {
                    ApplicationArea = All;
                }
                field("B Comment"; "B Comment")
                {
                    DrillDownPageID = "Item Tracking Comments";
                    LookupPageID = "Item Tracking Comments";
                    ApplicationArea = All;
                }
                field("B Qty. per Unit of Measure"; "B Qty. per Unit of Measure")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("B Total Quantity (UofM)"; "B Total Quantity (UofM)")
                {
                    ApplicationArea = All;
                }
                field("B Tot Reserved Quantity (UofM)"; "B Tot Reserved Quantity (UofM)")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Total Quantity"; "Total Quantity")
                {
                    Caption = 'Total Quantity (Base)';
                    DrillDown = true;
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin
                        grecReservationEntryTemp.Reset;
                        grecReservationEntryTemp.SetCurrentKey("Reservation Status");
                        grecReservationEntryTemp.Ascending(false);
                        grecReservationEntryTemp.SetRange(Positive, true);
                        grecReservationEntryTemp.SetRange("Reservation Status", grecReservationEntryTemp."Reservation Status"::Surplus);
                        grecReservationEntryTemp.SetRange("Lot No.", "Lot No.");
                        if "Serial No." <> '' then
                            grecReservationEntryTemp.SetRange("Serial No.", "Serial No.");
                        PAGE.RunModal(PAGE::"Avail. - Item Tracking Lines", grecReservationEntryTemp);
                    end;
                }
                field("Total Requested Quantity"; "Total Requested Quantity")
                {
                    Caption = 'Total Requested Quantity (Base)';
                    DrillDown = true;
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin
                        grecReservationEntryTemp.Reset;
                        grecReservationEntryTemp.SetCurrentKey("Reservation Status");
                        grecReservationEntryTemp.Ascending(false);
                        grecReservationEntryTemp.SetRange(Positive, false);
                        grecReservationEntryTemp.SetRange("Reservation Status",
                          grecReservationEntryTemp."Reservation Status"::Reservation, grecReservationEntryTemp."Reservation Status"::Surplus);
                        grecReservationEntryTemp.SetRange("Lot No.", "Lot No.");
                        if "Serial No." <> '' then
                            grecReservationEntryTemp.SetRange("Serial No.", "Serial No.");
                        PAGE.RunModal(PAGE::"Avail. - Item Tracking Lines", grecReservationEntryTemp);
                    end;
                }
                field("Current Reserved Quantity"; "Current Reserved Quantity")
                {
                    Caption = 'Current Reserved Quantity (Base)';
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Total Reserved Quantity"; "Total Reserved Quantity")
                {
                    Caption = 'Total Reserved Quantity (Base)';
                    Visible = false;
                    ApplicationArea = All;
                }
                field("B Line type"; "B Line type")
                {
                    ApplicationArea = All;
                }
                field("B Abnormals"; "B Abnormals")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(GetFilter)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Message('%1   %2', Count, "B Item No.");
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        LotNoOnPageat;
        BestusedbyOnPageat;
    end;

    var
        grecReservationEntryTemp: Record "Reservation Entry" temporary;
        grecEntrySummaryTemp: Record "Entry Summary" temporary;
        grecLotNoInformation: Record "Lot No. Information";
        gCalculatedBestUsedBy: Date;

    procedure SetSources(var parReservEntry: Record "Reservation Entry"; var parEntrySummary: Record "Entry Summary")
    begin

        Reset;
        grecReservationEntryTemp.Reset;
        grecReservationEntryTemp.DeleteAll;
        if parReservEntry.Find('-') then repeat
                                             grecReservationEntryTemp := parReservEntry;
                                             grecReservationEntryTemp.Insert;
            until parReservEntry.Next = 0;

        grecEntrySummaryTemp.Reset;
        grecEntrySummaryTemp.DeleteAll;
        Reset;
        DeleteAll;
        if parEntrySummary.Find('-') then repeat
                                              grecEntrySummaryTemp := parEntrySummary;
                                              Rec := grecEntrySummaryTemp;
                                              Insert;
                                              grecEntrySummaryTemp.Insert;
            until parEntrySummary.Next = 0;

    end;

    procedure Update()
    begin
        CurrPage.Update(false);
    end;

    local procedure LotNoOnPageat()
    begin
        if "B Blocked" then;
    end;

    local procedure BestusedbyOnPageat()
    begin
        if ("B Best used by" <> 0D) and ("B Best used by" < gCalculatedBestUsedBy) then;
    end;
}

