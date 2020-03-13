table 50114 "Port Zone"
{
    DataClassification = ToBeClassified;
    caption = 'Zone';
    LookupPageId = "Port Zone Register Card";

    fields
    {
        field(50110; PrtId; Code[5])
        {
            DataClassification = ToBeClassified;
            Caption = 'Zone Id';
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

        field(50113; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Active","Inactive","Purge";
            Caption = 'Status';

        }
        field(50114; Company; Code[5])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Company Register";
            Caption = 'Company';
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
            ERROR('Please Add Zone Id');
        if Company = '' then
            FieldError(Company, 'Can not be null');

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