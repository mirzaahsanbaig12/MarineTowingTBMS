table 50139 AgentBlanketCommission
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50110; LineNo; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'LineNo';
            Caption = 'LineNo';
            AutoIncrement = true;
        }
        field(50111; AgentId; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Agent';
            TableRelation = Customer."No.";
        }
        field(50112; CompanyId; Code[5])
        {
            DataClassification = ToBeClassified;
            Description = 'Company';
            TableRelation = "Company Register";
        }
        field(50113; CommissionType; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Commission Type';
            OptionMembers = "","DISCOUNTABLE","GROSS","NET","NET/NET";
        }
        field(50114; Percentage; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Percentage';
            AutoFormatExpression = '<precision, 2:2><standard format,0>%';
            AutoFormatType = 10;
        }
    }

    keys
    {
        key(PK; LineNo)
        {
            Clustered = true;
        }
        key(MyKey; AgentId, CompanyId)
        {
            Clustered = false;
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

}