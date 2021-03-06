table 50135 "Invoice Notes"
{
    DataClassification = ToBeClassified;
    Caption = 'Invoive Notes';
    LookupPageId = "Invoice Notes List";

    fields
    {
        field(50110; TerId; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Invoice Note Id';
            Caption = 'Invoice Note Id';
        }
        field(50111; DbId; code[5])
        {
            DataClassification = ToBeClassified;
            Description = 'Name';
        }

        field(50112; Descr; Blob)
        {
            DataClassification = ToBeClassified;
            Description = 'Description';
            Caption = 'Description';
        }

        field(50113; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Active","Inactive","Purge";
            Caption = 'Status';
        }

        field(50114; DueDate; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Due Date';
        }

        field(50115; InoMemos; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Memo';
        }

    }

    keys
    {
        key(PK; TerId)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin
        IF TerId = ''
                THEN
            ERROR('Please Add Invoice Note Id');

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

    procedure SetNotesDescription(NewNotesDescription: Text)
    var
        OutStream: OutStream;
    begin
        Clear(Descr);
        Descr.CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(NewNotesDescription);
        Modify;
    end;

    procedure GetNotesDescription(): Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        CalcFields(Descr);
        Descr.CreateInStream(InStream, TEXTENCODING::UTF8);
        exit(TypeHelper.ReadAsTextWithSeparator(InStream, TypeHelper.LFSeparator));
    end;

}