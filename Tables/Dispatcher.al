table 50116 Dispatcher
{
    DataClassification = ToBeClassified;
    Caption = 'Dispatcher';

    fields
    {
        field(50110; DisId; Code[5])
        {
            DataClassification = ToBeClassified;
            Description = 'Dispatcher Id';
            Caption = 'Dispatcher Id';
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
        key(PK; DisId)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin
        IF DisId = ''
                THEN
            ERROR('Please Add Dispatcher Id');

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