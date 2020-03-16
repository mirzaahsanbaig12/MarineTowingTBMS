table 50129 LogDoc
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50110; LogDocNumber; Integer)
        {
            DataClassification = ToBeClassified;
            //AutoIncrement = true;
            Caption = 'Number';
            Editable = false;
        }

        field(50111; ORDocNumber; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Document Number';
            TableRelation = OrdDoc;
        }
        field(50112; InoDocNumber; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Ino Document Number';
        }

        field(50113; BatNumber; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Bat Number';
        }
        field(50114; ConNumber; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract';
            TableRelation = Contract where(BusOc = field(BusOwner));
        }

        field(50115; BusCus; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Bus Cus';
            TableRelation = Customer where(TBMSCustomer = const(true));
        }
        field(50116; BusLA; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Local Agent';
            TableRelation = Customer where(TBMSAgent = const(true));
        }
        field(50117; "BusOwner"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Owner/Charcter';
            TableRelation = Customer where(TBMSOwner = const(true));
        }

        field(50118; CmpId; code[5])
        {
            DataClassification = ToBeClassified;
            Caption = 'Company';
            TableRelation = "Company Register";
        }

        field(50119; DbId; code[5])
        {
            DataClassification = ToBeClassified;
            Caption = 'Data Base Id';
        }

        field(50120; DisId; code[5])
        {
            DataClassification = ToBeClassified;
            TableRelation = Dispatcher;
            Caption = 'Dispatcher';
        }

        field(50121; PilId; code[5])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Pilot Association";
            Caption = 'Pilot';
        }

        field(50122; LocStr; code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Start Loc';
            TableRelation = "Location Register";
        }

        field(50123; DestinationStr; code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Destination Loc';
            TableRelation = "Location Register" where(type = const(0));
        }

        field(50124; VesId; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Vessel Name';
            TableRelation = Vessel_PK;
        }

        field(50125; RevId; Code[5])
        {
            DataClassification = ToBeClassified;
            Caption = 'Revenue Id';
            TableRelation = "Revenue Tracking";
        }

        field(50126; Position; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Position';
        }

        field(50127; AsstFlag; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Yes","No";
            Caption = 'Assistance Flag';
        }

        field(50128; DUFlag; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Dead / Unattended Flag';
            OptionMembers = "Yes","No";
        }

        field(50129; HWFlag; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Yes","No";
            Caption = 'Hawser';
        }

        field(50130; ShipFlag; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Yes","No";
            Caption = 'Ship Flag';
        }

        field(50131; DiscType; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(50132; DocType; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(50133; JobType; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Assiting","Docking","Shifting","Undocking","Hourly";
            Caption = 'Job Type';
        }

        field(50134; OTType; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "No","Overtime","Holiday","Night Time","Weekend";
            Caption = 'Overtime';
        }

        field(50135; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Open","Close";
            Caption = 'Status';
        }

        field(50136; LogDetNumber; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50137; NumberLines; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(50138; dateIno; Text[50])
        {
            DataClassification = ToBeClassified;
        }


        field(50139; Datelog; DateTime)
        {
            DataClassification = ToBeClassified;
            Caption = 'Log Date';

        }

        field(50140; TimeOrd; DateTime)
        {
            DataClassification = ToBeClassified;
            Caption = 'Time Ordered';
        }

        field(50141; TimeCan; DateTime)
        {
            DataClassification = ToBeClassified;
            Caption = 'Time Canceled';
        }

        field(50142; TimeStart; DateTime)
        {
            DataClassification = ToBeClassified;
        }

        field(50143; Timefinish; DateTime)
        {
            DataClassification = ToBeClassified;
        }

        field(50144; TimeTotal; DateTime)
        {
            DataClassification = ToBeClassified;
        }

        field(50145; Tonnage; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(50146; DistTug; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(50147; DistVest; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(50148; FuelCost; Decimal)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Fuel Cost".FuelCost;
            ValidateTableRelation = false;
            Caption = 'Fuel Cost';
        }
        field(50149; DiscountPer; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Discount Percentage';
            AutoFormatExpression = '<precision, 2:2><standard format,0>%';
            AutoFormatType = 10;
        }

        field(50150; DiscountAmount; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Discount Percentage';
            AutoFormatExpression = '<precision, 2:2><standard format,0>%';
            AutoFormatType = 10;
        }

        field(50151; LogCharge; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(50152; InGross; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'InGross';
        }


        field(50153; InvDisc; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(50154; InvNet; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(50155; Memo; Text[50])
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(PK; LogDocNumber)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;


    trigger OnInsert()
    begin
        LogDocNumber := GetLogDocNumber();
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

    procedure GetLogDocNumber(): Integer
    var
        DocNumber: Integer;
        LogDocRec: Record LogDoc;
    begin
        LogDocRec.Reset();
        if (LogDocRec.FindLast())
        then begin

            DocNumber := LogDocRec.LogDocNumber;
        end
        else begin
            DocNumber := 1000;
        end;

        exit(DocNumber + 10);

    end;

}