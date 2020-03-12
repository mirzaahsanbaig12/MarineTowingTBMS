tableextension 50111 ActivitiesCueExt extends "Activities Cue"
{
    fields
    {
        field(50110; FuelCost; Decimal)
        {
            FieldClass = Normal;
            Caption = 'Current Fuel Cost';
            AutoFormatExpression = '1,USD';
            AutoFormatType = 10;
        }
    }

    var
        myInt: Integer;
        getFuelCost: Codeunit GetData;

}