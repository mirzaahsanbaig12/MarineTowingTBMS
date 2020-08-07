table 50127 OrdTug
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50110; LineItem; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }

        field(50111; DBId; code[5])
        {
            DataClassification = ToBeClassified;
            Caption = 'Database Id';
        }

        field(50112; TugId; code[5])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Tug Boat";
            Caption = 'Tug Id';
        }
        field(50113; confirmFlag; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Confirm Flag';
        }

        field(50114; TugDetNumber; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(50115; ORDocNumber; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Document Number';
        }

        field(50116; TugName; Text[50])
        {
            Caption = 'Name';
            Editable = False;
        }
    }

    keys
    {
        key(PK; LineItem)
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