table 50113 "Tug Rate"
{
    DataClassification = ToBeClassified;
    Caption = 'Tug Boat';

    fields
    {
        field(50110; lineNo; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(50111; TugId; Code[5])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tug Id';
            TableRelation = "Tug Boat".TugId;
        }
        field(50112; TarId; code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tar Id';
            TableRelation = Tariff.TarId;

        }
        field(50113; CmpId; Code[5])
        {
            DataClassification = ToBeClassified;
            Caption = 'Company Id';
            TableRelation = "Company Register".CmpId;
        }

        field(50114; BusId; Code[5])
        {
            DataClassification = ToBeClassified;
            Caption = 'Bus ID';

        }

    }


    keys
    {
        key(PK; lineNo, CmpId)
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