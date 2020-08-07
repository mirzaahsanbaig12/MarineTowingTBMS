table 50132 LocationPort
{
    DataClassification = ToBeClassified;
    Caption = 'Port Register';

    fields
    {
        field(50110; LocId; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Location ID';
        }

        field(50111; PrtId; Code[5])
        {
            DataClassification = ToBeClassified;
            Caption = 'Port/Zone';
            TableRelation = "Port Zone".PrtId;
        }
    }

    keys
    {
        key(PK; LocId, PrtId)
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