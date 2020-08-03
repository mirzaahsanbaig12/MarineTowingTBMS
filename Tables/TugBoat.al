table 50112 "Tug Boat"
{
    DataClassification = ToBeClassified;
    Caption = 'Tug Boat';
    //
    DrillDownPageId = "Company Register List";
    LookupPageId = "Tug Register Card";

    fields
    {
        field(50110; TugId; Code[5])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tug Id';

        }
        field(50111; Name; text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Name';

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

        field(50114; AccountCC; code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Department Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          Blocked = CONST(false));
        }

        field(50115; Power; text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Power';
        }

        field(50116; Class; text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Class';
        }

        field(50117; "Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Tug","SDM";
            Caption = 'Type';
        }

        field(50118; Memo; text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Memo';
        }

        field(50119; CmpId; Code[5])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Company Register".CmpId;
            Caption = 'Owner Company';
        }
        field(50120; HourlyRate; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Hourly Rate';
        }

        field(50121; ExternaTug; Boolean)
        {
            Caption = 'External Tug';
            DataClassification = ToBeClassified;
        }

        field(50122; AcctRev; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Revenue Account';
            Caption = 'Revenue Account';
            TableRelation = "G/L Account";
        }
    }


    keys
    {
        key(PK; TugId)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; TugId, Name, Status)
        {

        }

    }





    var
        myInt: Integer;

    trigger OnInsert()
    begin
        IF TugId = ''
                THEN
            ERROR('Please Add Tug Id');
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


    procedure LookupTariff(var tugBoatRec: Record "Tug Boat"): Boolean
    var
        TugBoatList: Page "Tug Boat Register List";
        Result: Boolean;
    begin
        TugBoatList.SetTableView(tugBoatRec);
        TugBoatList.SetRecord(tugBoatRec);
        TugBoatList.LookupMode := true;
        Result := TugBoatList.RunModal = ACTION::LookupOK;
        if Result then
            TugBoatList.GetRecord(tugBoatRec)
        else
            Clear(tugBoatRec);

        exit(Result);
    end;


}