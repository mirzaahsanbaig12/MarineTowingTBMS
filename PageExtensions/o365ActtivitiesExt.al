pageextension 50112 o365ActtivitiesExt extends "O365 Activities"
{
    layout
    {
        addafter("Sales This Month")
        {
            field(FuelCost; FuelCost)
            {
                ApplicationArea = all;
                DrillDownPageId = "Fuel Cost List";
            }
        }
    }

    actions
    {

        // Add changes to page actions here
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