table 50119 "Pilot Association"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Pilot Assoc Register Card";

    fields
    {
        field(50110; PaId; Code[5])
        {
            DataClassification = ToBeClassified;
            Description = 'Ident';
            Caption = 'Pilot Association';

        }
        field(50111; DbId; Code[5])
        {
            DataClassification = ToBeClassified;
            Description = 'DB';
            Caption = 'DB';
        }

        field(50112; Name; Text[50])
        {
            Caption = 'Name';

        }

        field(50113; Phone; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'Name';
            Caption = 'Name';
        }

        field(50114; Fax; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'Fax';
            Caption = 'Fax';
        }


    }

    keys
    {
        key(PK; PaId)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;



    trigger OnInsert()
    begin
        IF PaId = ''
                THEN
            ERROR('Please Add Pilot Association Id');

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

    procedure LookupPilotAssoc(var PilotAssoc: Record "Pilot Association"): Boolean
    var
        LookupPilotAssoc: Page "Pilot Association List";
        Result: Boolean;
    begin
        LookupPilotAssoc.SetTableView(PilotAssoc);
        LookupPilotAssoc.SetRecord(PilotAssoc);
        LookupPilotAssoc.LookupMode := true;
        Result := LookupPilotAssoc.RunModal = ACTION::LookupOK;
        if Result then
            LookupPilotAssoc.GetRecord(PilotAssoc)
        else
            Clear(PilotAssoc);

        exit(Result);
    end;

}