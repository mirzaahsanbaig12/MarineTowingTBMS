tableextension 50111 ActivitiesCueExtTBMS extends "Activities Cue"
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
        field(50111; OpenOutbound; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count (OrdDoc where(InboundOutbound = const(Outbound), Status = FILTER(Open)));
            Caption = 'Open Outbound vessels';
        }
        field(50112; OpenInbound; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count (OrdDoc where(InboundOutbound = const(Inbound), Status = FILTER(Open)));
            Caption = 'Open Inbound vessels';
        }
        field(50113; OpenLogs; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count (LogDoc where(Status = const(Open)));
            Caption = 'Open Logs';
        }
    }

    var
        myInt: Integer;
        getFuelCost: Codeunit GetData;

}