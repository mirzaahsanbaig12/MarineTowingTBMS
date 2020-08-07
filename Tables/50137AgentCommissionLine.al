table 50137 AgentCommissionLine
{
    DataClassification = ToBeClassified;
    Caption = 'Commission Lines';
    fields
    {
        field(50110; "No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(50111; AgentNo; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Agent';
            TableRelation = Customer where(TBMSAgent = const(true));
        }
        field(50112; ConNumber; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'Contract';
            TableRelation = Contract;
        }
        field(50113; CommissionPer; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Percentage';
            AutoFormatExpression = '<precision, 2:2><standard format,0>%';
            AutoFormatType = 10;
            trigger OnValidate()
            var
            begin
                CalculateCommissionAmount;
            end;
        }
        field(50114; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Sales Order';
            TableRelation = "Sales Header"."No." WHERE("Document Type" = FILTER(Order));
        }
        field(50115; TotalAmount; Decimal)
        {
            AutoFormatExpression = 'USD';
            AutoFormatType = 1;
            DataClassification = ToBeClassified;
            Caption = 'Sales Order Total';

            trigger OnValidate()
            var
            begin
                CalculateCommissionAmount;
            end;
        }
        field(50116; CommissionAmount; Decimal)
        {
            DataClassification = ToBeClassified;
            AutoFormatExpression = 'USD';
            AutoFormatType = 1;
            Caption = 'Commission Amount';
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

    local procedure CalculateCommissionAmount()
    var
    begin
        CommissionAmount := TotalAmount * CommissionPer;
    end;

    procedure GetNextNo(): Integer
    var
        No: Integer;
        agentComLine: Record AgentCommissionLine;
    begin
        if agentComLine.FindLast() then
            No := agentComLine."No." + 1
        else
            No := 1;

        exit(No);
    end;

}