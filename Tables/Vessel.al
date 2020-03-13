table 50121 "Vessel"
{
    DataClassification = ToBeClassified;
    Caption = 'Vessel';
    LookupPageId = "Vessel Register Card";


    fields
    {

        field(50110; VesId; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Vessel Name';
        }
        field(50111; Name; text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Name/Description';

        }
        field(50112; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Active","Inactive","Purge";
            Caption = 'Status';
        }

        field(50113; DbId; Code[5])
        {
            DataClassification = ToBeClassified;
            Caption = 'Db Name';
        }

        field(50114; BusLa; text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Local Agent';
        }

        field(50115; BusOc; text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Owner/Character';
        }

        field(50116; VesType; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Barge","Dredge","Cat Tug","Drill Rig","Motor Tanker","Motor Vessel","Rig","Tug";
            Caption = 'Vessel Type';
        }
        field(50117; "DefaultFlag"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Yes","No";
            Caption = 'Default Flag';
        }

        field(50118; "LockFlag"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Yes","No";
            Caption = 'Lock Flag';
        }

        field(50119; Tonnage; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Gross Tonage';
            BlankZero = true;
        }


        field(50120; RevId; Code[5])
        {
            DataClassification = ToBeClassified;
            Caption = 'Revenue';
            TableRelation = "Revenue Tracking".RevId;

        }

    }


    keys
    {
        key(PK; VesId)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; VesId, Name)
        {

        }

    }


    var
        myInt: Integer;

    trigger OnInsert()
    begin
        IF VesId = ''
                THEN
            ERROR('Please Add Vessel Id');
        if Tonnage = 0 then
            FieldError(Tonnage, 'Can not be Zero');
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