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
            TableRelation = Customer where(TBMSAgent = const(true));
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
            Editable = False;
        }

        field(50117; VesId; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vessel;
            Caption = 'Vessel Name';

        }
        field(50131; VesIdPk; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vessel;
            Caption = 'Vessel Name';
            ObsoleteState = Removed;
            ObsoleteReason = 'Field Changed';
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
            ObsoleteState = Removed;
            ObsoleteReason = 'Field Changed';
        }

        field(50134; JobTypeNew; Option)
        {

            DataClassification = ToBeClassified;
            OptionMembers = "SU","BR","NO","DC";
            Caption = 'Job Type';
            ObsoleteState = Removed;
            ObsoleteReason = 'Field Changed';

        }
        field(50135; SchedulerJobType; Code[20])
        {

            DataClassification = ToBeClassified;
            TableRelation = JobType;
            Caption = 'Job Type';
        }

        field(50121; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Open","Canceled","Logged","Active","Inactive","Purge";
            Caption = 'Status';
        }

        field(50122; LocDetNumber; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Location Det Number';
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

        field(50126; JobDate; DateTime)
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

        field(50132; "BusOwner"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Owner/Charcter';
            TableRelation = Customer where(TBMSOwner = const(true));
        }

        field(50133; "LocId"; code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Zone';
            TableRelation = "Location Register";
            Editable = false;
        }

        field(50136; LocStr; code[20])
        {
            Caption = 'Start Location';
            DataClassification = ToBeClassified;
            TableRelation = "Location Register";
        }

        field(50137; DestinationStr; code[20])
        {
            Caption = 'Destination Location';
            DataClassification = ToBeClassified;
            TableRelation = "Location Register";
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

    procedure CreateLog(): Integer
    var
        logDoc: Record LogDoc;
        logDetRec: Record LogDet;
        logDetRecl: Record LogDet;
        ordTugRec: Record OrdTug;
        ordLocRec: Record OrdLoc;
        ContractRec: Record Contract;
        JobTypeRec: Record JobType;

    begin

        if (Status <> Status::Canceled) OR (Status <> Status::Logged) then begin
            logDoc.Init();
            logDoc.Validate(Datelog, CurrentDateTime);
            logDoc.Validate(DocType, logDoc.DocType);
            logDoc.Validate(Status, logDoc.Status::Open);

            //MAPPING SCHEDULER JOB TYPE TO LOGS JOB TYPE
            if SchedulerJobType = '' then
                FieldError(SchedulerJobType, 'Job Type must be selected')
            else begin
                if JobTypeRec.Get(SchedulerJobType) then begin
                    if JobTypeRec.Description.ToLower().Contains('hourly') then
                        logDoc.Validate(JobType, logDoc.JobType::Hourly)
                    else
                        if JobTypeRec.Description.ToLower().Contains('undocking') then
                            logDoc.Validate(JobType, logDoc.JobType::Undocking)
                        else
                            if JobTypeRec.Description.ToLower().Contains('docking') then
                                logDoc.Validate(JobType, logDoc.JobType::Docking)
                            else
                                if JobTypeRec.Description.ToLower().Contains('shifting') then
                                    logDoc.Validate(JobType, logDoc.JobType::Shifting)
                                else
                                    FieldError(SchedulerJobType, 'Invalid Job Type');
                end;
            end;

            logDoc.Validate(PilId, PilId);
            logDoc.Validate(Tonnage, Tonnage);
            logDoc.Validate(ORDocNumber, ORDocNumber);
            logDoc.Validate(LogDocNumber, logDoc.GetLogDocNumber());
            logDoc.Validate(VesId, VesId);
            logDoc.Validate(BusOwner, BusOwner);

            if BusOwner = '' then begin
                FieldError(BusOwner, 'cannot be null');
            end;

            ContractRec.SetFilter(BusOc, BusOwner);
            if ContractRec.FindFirst() then begin



                logDoc.ConNumber := ContractRec.ConNumber;
                logDoc.CmpId := logDoc.getCompanyFromContract(logDoc.ConNumber);
                logDoc.BillingOptions := logDoc.getBillingOptionsFromContract(logDoc.ConNumber);


                if logDoc.Insert(true) then begin
                    //Rec.Validate(Status, Status::Logged);
                    //Rec.Modify(true);

                    //log details tab start
                    ordTugRec.SetFilter(ORDocNumber, format(ORDocNumber));
                    if ordTugRec.FindFirst() then begin
                        repeat

                            logDetRecl.SetAscending(LineNumber, true);

                            if logDetRecl.FindLast() then
                                logDetRec.LineNumber := logDetRecl.LineNumber + 1
                            else
                                logDetRec.LineNumber := 1;

                            logDetRec.Validate(TugId, ordTugRec.TugId);
                            logDetRec.Validate(LogDocNumber, logDoc.LogDocNumber);

                            ordLocRec.SetFilter(ORDocNumber, format(ORDocNumber));
                            ordLocRec.SetAscending(LineNumber, true);
                            ordLocRec.FindFirst();

                            logDetRec.Validate(LocStr, ordLocRec.LocId);

                            ordLocRec.SetFilter(ORDocNumber, format(ORDocNumber));
                            ordLocRec.SetAscending(LineNumber, true);
                            ordLocRec.FindLast();

                            logDetRec.Validate(DestinationStr, ordLocRec.LocId);
                            logDetRec.Insert(true);
                        until ordTugRec.Next() = 0
                    end;
                end;
                //log details tab end
                exit(logDoc.LogDocNumber);
            end;
        end
        else
            Message('Logs cannot be created beacuse no contract is defined for owner');
        exit(0);

    end;


    procedure CancelSchedule()
    begin
        if Status <> Status::Canceled then begin
            Rec.Validate(Status, Status::Canceled);
            Rec.Modify(true);
        end;
    end;




}