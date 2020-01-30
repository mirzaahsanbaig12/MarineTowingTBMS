table 50125 "Revenue Tracking"
{
    DataClassification = ToBeClassified;
    caption = 'Revenue/Tracking Register';

    fields
    {
        field(50110; RevId; Code[5])
        {
            DataClassification = ToBeClassified;
            Caption = 'Revenue Id';

            trigger OnValidate()
            begin
                if RevId = ''
                then
                    Error('Please Enter Revenue Id');
            end;
        }
        field(50111; DbId; code[5])
        {
            DataClassification = ToBeClassified;
            Caption = 'Data Base Name';

        }

        field(50112; TrafficType; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Traffic Type';
            OptionMembers = "","Bulk","container","freight","Miscellaneous","Navy","Outside Harbor","Passenger","Tanker";
        }
        field(50113; Description; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Description';
        }

        field(50114; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Active","Inactive","Purge";
        }

        field(50115; AccountNumber; text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; RevId)
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