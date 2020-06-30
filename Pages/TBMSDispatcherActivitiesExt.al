page 50169 "TBMS Dispatcher Activities"
{
    Caption = 'Activities';
    PageType = CardPart;
    RefreshOnActivate = true;
    ShowFilter = false;
    SourceTable = "Activities Cue";

    layout
    {
        area(content)
        {
            cuegroup("My Cues")
            {
                CueGroupLayout = Wide;
                ShowCaption = false;
                field(FuelCost; FuelCost)
                {
                    ApplicationArea = all;
                    DrillDownPageId = "Fuel Cost List";
                }
                field(OpenOutbound; OpenOutbound)
                {
                    ApplicationArea = all;
                    DrillDownPageId = "Outbound Ord Doc List";
                }
                field(OpenInbound; OpenInbound)
                {
                    ApplicationArea = all;
                    DrillDownPageId = "InBound Ord Doc List";
                }
                field(OpenLogs; OpenLogs)
                {
                    ApplicationArea = all;
                    DrillDownPageId = "Log Billing List";
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        FuelCost := GetFuelCost.GetFuelCost();
        CurrPage.Update();
    End;

    trigger OnOpenPage()
    begin
        RESET;
        IF NOT GET THEN BEGIN
            INIT;
            INSERT;
        END;
    end;


    var
        FuelCost: Decimal;
        GetFuelCost: Codeunit GetData;
}
