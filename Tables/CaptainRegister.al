table 50117 Captain
{
    DataClassification = ToBeClassified;
    Caption = 'Captain';

    fields
    {
        field(50110; CapId; Code[5])
        {
            DataClassification = ToBeClassified;
            Description = 'Captain Id';
            Caption = 'Captain Id';
        }
        field(50111; Name; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'Name';
        }

        field(50112; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Active","Inactive","Retired","Terminated","Purge";
        }
    }

    keys
    {
        key(PK; CapId)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin
        IF CapId = ''
                THEN
            ERROR('Please Add Captain Id');

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