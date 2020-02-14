table 50126 OrdDoc
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50110; ORDocNumber; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Document Number';
        }
        field(50111; DbId; Code[5])
        {
            DataClassification = ToBeClassified;
            Caption = 'Data Base Id';
        }
        field(50112; LogDocNumber; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Log Document Number';
        }
        field(50113; BusLA; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer;
            Caption = 'Agent';
        }

        field(50114; BusOC; text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Charter';
        }

        field(50115; PilId; Code[5])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Pilot Association";
            Caption = 'Pilot Id';
        }
        field(50116; PrtId; code[5])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Port Zone";
            Caption = 'Port Id';
        }

        field(50117; VesId; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vessel;
            Caption = 'Vesel Id';
        }
        field(50118; TugOrderDescr; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tug Order Description';
        }

        field(50119; DocType; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Document Type';

        }


        field(50120; JobType; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Job Type';
        }

        field(50121; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Active","Inactive","Purge";
            Caption = 'Status';
        }

        field(50122; LocDetNumber; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Locaiton Det Number';
        }
        field(50123; TugDetNumber; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Tug Det Number';
        }

        field(50124; Tonnage; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = ' Tonnage';
        }
        field(50125; DocDate; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Document Date';
        }

        field(50126; JobDate; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Job Date';
        }

        field(50127; ManagerMemo; text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Manager Memo';
        }

        field(50128; DispatcherMemo; text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Dispatcher Memo';
        }

        field(50129; LineItem; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
            Caption = 'Line Item';
        }

        field(50130; InboundOutbound; option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Inbound","Outbound";
            Caption = 'Inbound\Outbound';
        }





    }

    keys
    {
        key(PK; ORDocNumber)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin
        ORDocNumber := GetORDocNumber();
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

    procedure GetORDocNumber(): Integer
    var
        DocNumber: Integer;
        OrdDocRec: Record OrdDoc;
    begin
        if (OrdDocRec.FindLast())
        then begin
            DocNumber := OrdDocRec.ORDocNumber;
        end
        else begin
            DocNumber := 1000;
        end;

        exit(DocNumber + 10);

    end;


}