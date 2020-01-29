table 50111 Address
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50110; LineNo; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }


        field(50111; AddId; Code[5])
        {
            DataClassification = ToBeClassified;
            //TableRelation = "Company Register".CmpId;
            Caption = 'Address ID';
        }

        field(50112; DbId; Code[5])
        {
            DataClassification = ToBeClassified;
            Description = 'DB';
            Caption = 'DB';
        }

        field(50113; "Type"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Type';
        }

        field(50114; "Line 1"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Line 1';
        }

        field(50115; "Line 2"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Line 2';
        }

        field(50116; "Line 3"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Line 3';
        }
        field(50117; "Country"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Country';
        }

        field(50118; "City"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'City';
        }

        field(50119; "Zip"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Zip';
        }

        field(50120; "State"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'State';
        }


    }

    keys
    {
        key(PK; AddId)
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