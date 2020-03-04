page 50144 "Inbound Ord Doc Card"
{
    PageType = Document;
    RefreshOnActivate = true;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = OrdDoc;
    Caption = 'Inbound Order Document Details';

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
                    CreateLogAction();
                end;
            }
            action("Cancel")
            {
                ApplicationArea = All;
                Caption = 'Cancel';
                Visible = ShowCancelAction;
                Enabled = ShowCancelAction;
                trigger OnAction()
                begin
                    CancelScheduleAction();
                end;
            }
        }
    }


    var
        customerList: Page "Customer List";
        ordDocRec: Record OrdDoc;
        getVesselTonnage: Codeunit GetData;
        ShowCreateLogAction: Boolean;
        ShowCancelAction: Boolean;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        InboundOutbound := ordDocRec.InboundOutbound::Inbound;
        CurrPage."ord Tug SubForm".Page.SetORDocNumber(ordDocRec.GetORDocNumber());
        CurrPage."ord loc SubForm".Page.SetORDocNumber(ordDocRec.GetORDocNumber());
    end;

    trigger OnOpenPage()
    begin
        CurrPage."ord Tug SubForm".Page.SetORDocNumber(ORDocNumber);
        CurrPage."ord loc SubForm".Page.SetORDocNumber(ORDocNumber);
        ShowHideActions();
    end;

    procedure ShowHideActions()
    begin
        case Status of
            Status::Canceled:
                begin
                    CurrPage.Editable := false;
                    ShowCreateLogAction := false;
                    ShowCancelAction := false;
                end;
            Status::Logged:
                begin
                    ShowCreateLogAction := false;
                end;
            else begin
                    ShowCreateLogAction := true;
                    ShowCancelAction := true;
                end;
        end;
    end;

    procedure CreateLogAction()
    var
        logId: Integer;
    begin
        logId := Rec.CreateLog();
        ShowHideActions();
        CurrPage.Update();
        Message('Log created. Log Number: %1', logId);

    end;


    procedure CancelScheduleAction()
    begin
        if Dialog.Confirm('Please confirm to cancel this schedule?') then begin
            Rec.CancelSchedule();
            ShowHideActions();
            CurrPage.Update();
        end;
    end;

    /*actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }
    */



}
