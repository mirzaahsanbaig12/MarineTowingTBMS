tableextension 50110 CustomerExt extends Customer
{
    fields
    {
        // Add changes to table fields here
        field(50110; TBMSAgent; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Agent';

        }

        field(50111; TBMSCustomer; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Customer';

        }

        field(50112; TBMSOwner; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Owner/Charter';

        }

        field(50113; TBMSBusinessType; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'Business Type';
            Caption = 'Business Type';
            OptionMembers = "","Internal","External";
        }

        field(50114; AgentCommission; Decimal)
        {
            FieldClass = FlowField;
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum (AgentCommissionLine.CommissionAmount WHERE(AgentNo = FIELD("No.")));
            Caption = 'Total Commission';
            Editable = false;
        }

    }

    var
        myInt: Integer;
}