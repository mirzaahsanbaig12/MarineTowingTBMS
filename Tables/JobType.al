table 50138 JobType
{
    DataClassification = ToBeClassified;
    LookupPageId = JobTypeListPage;
    DrillDownPageId = JobTypeListPage;
    fields
    {
        field(50110; JobType; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50111; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; JobType)
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