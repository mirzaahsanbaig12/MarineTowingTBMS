page 50142 "Outbound Ord Doc Card"
{
    PageType = Document;
    RefreshOnActivate = true;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = OrdDoc;
    Caption = 'Outbound Order Document Details';

    layout
    {
        area(Content)
        {
            group("General")
            {
                field(ORDocNumber; ORDocNumber)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(JobDate; JobDate)
                {
                    ApplicationArea = All;
                }

                field(TugOrderDescr; TugOrderDescr)
                {
                    ApplicationArea = All;
                }

                field(VesId; VesId)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        Tonnage := getVesselTonnage.GetVesselTonnage(VesId);
                    end;
                }

                field(BusLA; BusLA)
                {
                    ApplicationArea = All;
                }

                field(PilId; PilId)
                {
                    ApplicationArea = All;
                }

                field(LocDetNumber; LocDetNumber)
                {
                    ApplicationArea = All;
                }

                field(Tonnage; Tonnage)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Status; Status)
                {
                    ApplicationArea = All;
                    Caption = 'Status';
                    Editable = false;
                }

            }

            group("Ord Tug")
            {
                part("ord Tug SubForm"; "Ord Tug SubForm")
                {
                    ApplicationArea = Basic, Suite;
                    SubPageLink = ORDocNumber = field(ORDocNumber);
                    UpdatePropagation = Both;
                    //Editable = true;
                }

            }

            group("Ord Loc")
            {
                part("ord loc SubForm"; "Ord Loc SubForm")
                {
                    ApplicationArea = Basic, Suite;
                    SubPageLink = ORDocNumber = field(ORDocNumber);
                    UpdatePropagation = Both;
                    //Editable = true;
                }
            }

            group(Memos)
            {
                field(ManagerMemo; ManagerMemo)
                {
                    ApplicationArea = All;
                }

                field(DispatcherMemo; DispatcherMemo)
                {
                    ApplicationArea = All;
                }

            }

        }
    }
    actions
    {
        area(Processing)
        {
            action("Customer List")
            {
                ApplicationArea = All;
                Caption = 'Customer';

                trigger OnAction()
                begin
                    customerList.Run();
                end;
            }
            action("Create Log")
            {
                ApplicationArea = All;
                Caption = 'Create Log';
                Visible = ShowCreateLogAction;
                Enabled = ShowCreateLogAction;
                trigger OnAction()
                begin
                    CreateLog();
                end;
            }
            action("Cancel")
            {
                ApplicationArea = All;
                Caption = 'Cancel';

                trigger OnAction()
                begin
                    CancelSchedule();
                end;
            }
        }
    }

    var
        ordDocRec: Record OrdDoc;
        getVesselTonnage: Codeunit GetData;
        customerList: Page "Customer List";
        ShowCreateLogAction: Boolean;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        InboundOutbound := ordDocRec.InboundOutbound::Outbound;
        CurrPage."ord Tug SubForm".Page.SetORDocNumber(ordDocRec.GetORDocNumber());
        CurrPage."ord loc SubForm".Page.SetORDocNumber(ordDocRec.GetORDocNumber());
    end;

    trigger OnOpenPage()
    begin
        CurrPage."ord Tug SubForm".Page.SetORDocNumber(ORDocNumber);
        CurrPage."ord loc SubForm".Page.SetORDocNumber(ORDocNumber);

        if Status = Status::Canceled then begin
            CurrPage.Editable := false;
            ShowCreateLogAction := false;
        end
        else begin
            ShowCreateLogAction := true;
        end;
    end;

    procedure CreateLog()
    var
        logDoc: Record LogDoc;
    begin
        logDoc.Init();
        logDoc.Validate(Datelog, CurrentDateTime);
        logDoc.Validate(DocType, logDoc.DocType);
        logDoc.Validate(Status, logDoc.Status::Open);

        logDoc.Validate(JobType, logDoc.JobType::Assiting); //confirm this
        logDoc.Validate(PilId, PilId);
        logDoc.Validate(Tonnage, Tonnage);
        logDoc.Validate(ORDocNumber, ORDocNumber);
        logDoc.Insert(true);

        Rec.Validate(Status, Status::Logged);
        ShowCreateLogAction := false;
        Rec.Modify(true);
        CurrPage.Update();

    end;

    procedure CancelSchedule()
    begin
        Rec.Validate(Status, Status::Canceled);
        ShowCreateLogAction := false;
        Rec.Modify(true);
        CurrPage.Update();
    end;



}
