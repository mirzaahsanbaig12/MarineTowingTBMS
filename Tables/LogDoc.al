table 50129 LogDoc
{
    DataClassification = ToBeClassified;
    Caption = 'Log Billing';

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

            trigger OnLookup()
            var
                ContractRec: Record Contract;
            begin
                if ConNumber <> 0 then
                    ContractRec.Get(ConNumber);
                ContractRec.SetFilter(BusOc, BusOwner);
                ContractRec.FindFirst();

                if ContractRec.LookupContract(ContractRec) then begin
                    ConNumber := ContractRec.ConNumber;
                    CmpId := getCompanyFromContract(ConNumber);
                    BillingOptions := getBillingOptionsFromContract(ConNumber);

                end;

            end;



            trigger OnValidate()
            begin
                CmpId := getCompanyFromContract(ConNumber);
                BillingOptions := getBillingOptionsFromContract(ConNumber);
            end;
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

            // ValidateTableRelation = false;
            // trigger OnLookup()
            // var
            //     dispatcherRec: Record Dispatcher;
            // begin
            //     if DisId <> '' then
            //         dispatcherRec.Get(DisId);

            //     if dispatcherRec.LookupDispatcher(dispatcherRec) then begin
            //         DisId := dispatcherRec.DisId;

            //     end;

            // end;

        }

        field(50121; PilId; code[5])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Pilot Association";
            Caption = 'Pilot';
            ValidateTableRelation = false;
            /* trigger OnLookup()
             var
                 pilotAssocRec: Record "Pilot Association";
             begin
                 if PilId <> '' then
                     pilotAssocRec.Get(PilId);

                 if pilotAssocRec.LookupPilotAssoc(pilotAssocRec) then begin
                     PilId := pilotAssocRec.PaId;

                 end;

             end;
             */
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

        field(50124; VesId; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Vessel Name';
            TableRelation = Vessel;
            //ObsoleteState = Removed;
            // ObsoleteReason = 'Field Changed';
        }

        field(50156; VesIdPk; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Vessel Name';
            TableRelation = Vessel;
            ObsoleteState = Removed;
            ObsoleteReason = 'Field Changed';
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
            OptionMembers = "","Docking","Shifting","Undocking","Hourly";
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
            OptionMembers = "Open","Close","SO","Invoiced","Reopen";
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

            Caption = 'Fuel Cost';

            TableRelation = "Fuel Cost".FuelCost;
            ValidateTableRelation = false;
            trigger OnLookup()
            var
                FuelCostRec: Record "Fuel Cost";
            begin
                if FuelCost <> 0 then
                    FuelCostRec.SetFilter(FuelCost, format(FuelCost));

                if FuelCostRec.LookupFuelCost(FuelCostRec) then begin
                    FuelCost := FuelCostRec.FuelCost;

                end;

            end;
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

        field(50157; SalesOrderNo; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Sales Order';
            TableRelation = "Sales Header";
            Editable = false;
        }

        field(50158; BillingOptions; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Billing Options';
            TableRelation = Contract.BillingOptions where(ConNumber = field(ConNumber));
            Editable = false;
        }


        field(50159; SalesInvoiceNo; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Posted Sales Invoice';
            TableRelation = "Sales Invoice Header";
            Editable = false;
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

        LogDocfieldError();

    end;

    trigger OnModify()
    begin
        LogDocfieldError();
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

    procedure getCompanyFromContract(contractNo: Integer): code[20]
    var
        ContractRec: Record Contract;
    begin

        ContractRec.SetFilter(ConNumber, format(contractNo));
        if ContractRec.FindFirst() then begin
            exit(ContractRec.CmpId);
        end;
        exit('');
    end;

    procedure getBillingOptionsFromContract(contractNo: Integer): Text[50]
    var
        ContractRec: Record Contract;
    begin

        ContractRec.SetFilter(ConNumber, format(contractNo));
        if ContractRec.FindFirst() then begin
            exit(format(ContractRec.BillingOptions));
        end;
        exit('');
    end;

    procedure LogDocfieldError()
    begin

        if ConNumber = 0 then
            FieldError(ConNumber, 'cannot be null');

        if format(JobType) = '' then
            FieldError(JobType, 'cannot be null');

        if VesId = '' then
            FieldError(VesId, 'cannot be null');

        //if Datelog = 0DT then
        //    FieldError(Datelog, 'cannot be null');

        if BusOwner = '' then
            FieldError(BusOwner, 'cannot be null');
    end;

}
