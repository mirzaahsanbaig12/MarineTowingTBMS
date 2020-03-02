table 50115 "Location Register"
{
    DataClassification = ToBeClassified;
    Caption = 'Location';
    LookupPageId = "location Register Card";

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

        field(50112; DbId; Code[5])
        {
            DataClassification = ToBeClassified;
            Caption = 'DataBaseId';

        }
        field(50113; Description; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Name/Description';
        }

        field(50114; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Active","Inactive","Purge";
            Caption = 'status';
        }

        field(50115; "type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Berth","Buoy";
            Caption = 'Type';
        }

        field(50116; araId; code[5])
        {
            DataClassification = ToBeClassified;
            Caption = 'Area/State';
        }
    }

    keys
    {
        key(PK; LocId)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin
        IF LocId = ''
                THEN
            ERROR('Please Add Location Id');

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