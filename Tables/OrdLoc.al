table 50128 OrdLoc
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50110; LineNumber; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }

        field(50111; DBId; code[5])
        {
            DataClassification = ToBeClassified;
            Caption = 'Database Id';
        }

        field(50112; LocId; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Location Register".LocId;
            Caption = 'Location';
        }
        field(50113; PositionType; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Position Type';
        }

        field(50114; LocDetNumber; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Location Det Number';
        }

        field(50115; ORDocNumber; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Document Number';
        }

        field(50116; LocationName; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Name';
            Editable = false;
        }


    }

    keys
    {
        key(PK; LineNumber)
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