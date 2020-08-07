table 50120 Pilot
{
    DataClassification = ToBeClassified;
    Caption = 'Pilot';


    fields
    {
        field(50110; PilId; Code[5])
        {
            DataClassification = ToBeClassified;
            Description = 'Pilot Id';
            Caption = 'Pilot Id';
        }
        field(50111; Name; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'Name';
        }

        field(50112; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Active","Inactive","Purge";
        }

        field(50113; Dbid; code[5])
        {
            DataClassification = ToBeClassified;
        }

        field(50114; PaId; Code[5])
        {
            DataClassification = ToBeClassified;
            Description = 'Pilot Assoc Id';
            Caption = 'Pilot Assoc Id';
            TableRelation = "Pilot Association".PaId;
        }

    }

    keys
    {
        key(PK; PilId)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin
        IF PilId = ''
                THEN
            ERROR('Please Add Pilot Id');

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