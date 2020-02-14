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
            TableRelation = Customer;
            Caption = 'Agent Name';
        }

        field(50113; DbId; Code[5])
        {
            DataClassification = ToBeClassified;

        }

        field(50114; CommonType; Code[5])
        {
            DataClassification = ToBeClassified;
            Caption = 'Commission';
        }

        field(50115; CommonPer; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Percentage';
        }
        field(50116; DiscType; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Discount';
        }

        field(50117; DiscPer; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Discount Percentage';
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