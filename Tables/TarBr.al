table 50122 TarBr
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50110; LineNo; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }

        field(50111; TarId; code[5])
        {
            DataClassification = ToBeClassified;
            TableRelation = Tariff.TarId;
        }

        field(50112; PrtId; code[5])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Port Zone".PrtId;
        }

        field(50113; class; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(50114; TonnageBeg; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50115; TonnageEnd; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50116; Rate; Integer)
        {
            DataClassification = ToBeClassified;
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