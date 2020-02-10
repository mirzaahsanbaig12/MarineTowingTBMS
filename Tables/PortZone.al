table 50114 "Port Zone"
{
    DataClassification = ToBeClassified;
    caption = 'Port Zone';
    LookupPageId = "Port Zone Register Card";

    fields
    {
        field(50110; PrtId; Code[5])
        {
            DataClassification = ToBeClassified;
            Caption = 'Port Id';

        }

        field(50111; DbId; Code[5])
        {
            DataClassification = ToBeClassified;
            Caption = 'DB Name';
        }

        field(50112; Name; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Name';
        }

        field(5013; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Active","Inactive","Purge";
            Caption = 'Status';

        }
    }

    keys
    {
        key(PK; PrtId)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin
        IF PrtId = ''
                THEN
            ERROR('Please Add Port Id');

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