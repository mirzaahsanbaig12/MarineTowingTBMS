table 50124 ConAgent
{
    DataClassification = ToBeClassified;
    Caption = 'Contract Agent';
    LookupPageId = "Contract Agent SubForm";

    fields
    {
        field(50110; LineNo; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'LineNo';
            Caption = 'LineNo';
            AutoIncrement = true;
        }
        field(50111; ConNumber; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'ConNumber';
            TableRelation = Contract;
        }

        field(50112; BusId; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Agent Name';
            TableRelation = Customer where(TBMSAgent = const(true));
        }

        field(50113; DbId; Code[5])
        {
            DataClassification = ToBeClassified;

        }

        field(50114; CommonType; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Commission Type';
            OptionMembers = "DISCOUNTABLE","GROSS","NET","NET/NET";
        }

        field(50115; CommonPer; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Percentage';
            AutoFormatExpression = '<precision, 2:2><standard format,0>%';
            AutoFormatType = 10;
        }
        field(50116; DiscType; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Confidential Discount';
        }

        field(50117; DiscPer; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Discount Percentage';
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