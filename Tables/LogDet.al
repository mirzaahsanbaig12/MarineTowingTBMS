table 50130 LogDet
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50110; LineNumber; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }

        field(50111; LogDocNumber; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Number';
            TableRelation = LogDoc;
        }
        field(50112; CapId; Code[5])
        {
            DataClassification = ToBeClassified;
            Caption = 'Captain';
            TableRelation = Captain;
        }

        field(50120; DbId; code[5])
        {
            DataClassification = ToBeClassified;
            Caption = 'Data Base Id';
        }

        field(50121; LocStr; code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Start Loc';
            TableRelation = "Location Register";
        }

        field(50122; DestinationStr; code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Destination Loc';
            TableRelation = "Location Register";
        }

        field(50123; TugId; code[5])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Tug Boat";
            Caption = 'Tug';
        }

        field(50124; TarId; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Tariff;
            Caption = 'Tar';
        }


        field(50125; VesId; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Vessel Name';
            TableRelation = Vessel_PK;
        }
        field(50126; FSDiscFlag; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Yes","No";

        }

        field(50127; SBFlag; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Yes","No";
            Caption = 'Assistance Flag';
        }

        field(50128; TCFlag; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Yes","No";
            Caption = 'Turning Flag';
        }

        field(50129; LogDetNumber; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Log Det Number';
        }

        field(50130; NumberLines; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Lines';
        }

        field(50131; NumberCables; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Cables';
        }

        field(50132; DateLog; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Date Log';
        }

        field(50133; TimeStart; DateTime)
        {
            DataClassification = ToBeClassified;
        }

        field(50134; Timefinish; DateTime)
        {
            DataClassification = ToBeClassified;
        }

        field(50135; TimeAdd; DateTime)
        {
            DataClassification = ToBeClassified;
        }

        field(50136; Distance; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(50137; DistAmt; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(50138; LogCharge; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(50139; INVGross; Integer)
        {
            DataClassification = ToBeClassified;
        }


        field(50140; InvDisc; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(50141; InvNet; Integer)
        {
            DataClassification = ToBeClassified;
        }


    }

    keys
    {
        key(PK; LineNumber)
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