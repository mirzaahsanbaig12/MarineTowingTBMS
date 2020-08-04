page 50141 "Outbound Ord Doc List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = OrdDoc;
    Caption = 'Outbound Order Document';
    CardPageId = 50142;
    SourceTableView = where(InboundOutbound = const(Outbound));

    layout
    {
        area(Content)
        {
            repeater("General")
            {
                field(ORDocNumber; ORDocNumber)
                {
                    ApplicationArea = All;
                }
                field(JobType; SchedulerJobType)
                {
                    ApplicationArea = All;
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
                }

                field(BusLA; BusLA)
                {
                    ApplicationArea = All;
                }
                field(Status; Status)
                {
                    ApplicationArea = All;
                }
                field(PilId; PilId)
                {
                    ApplicationArea = All;
                }

                field(LocDetNumber; LocDetNumber)
                {
                    Visible = false;
                    ApplicationArea = All;
                }

                field(Tonnage; Tonnage)
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
            // action("Customer List")
            // {
            //     ApplicationArea = All;
            //     Caption = 'Customer';

            //     trigger OnAction()
            //     begin
            //         customerList.Run();
            //     end;
            // }
            action("Cancel Records")
            {
                ApplicationArea = All;
                Caption = 'Logs Cancel';

                trigger OnAction()
                begin
                    CancelScheduleAction();
                end;
            }
            action("Log Records")
            {
                ApplicationArea = All;
                Caption = 'Create Log';

                trigger OnAction()
                begin
                    CreateLogAction();
                end;
            }
        }
    }

    procedure CreateLogAction()
    begin
        CurrPage.SetSelectionFilter(SelectedRecords);
        if SelectedRecords.FindSet() then begin
            repeat
                SelectedRecords.CreateLog();
            until SelectedRecords.Next() = 0;
        end;
        CurrPage.Update();
        Message(Format(SelectedRecords.Count) + ' Records Updated');
    end;

    procedure CancelScheduleAction()
    begin
        if Dialog.Confirm('Please confirm to cancel the selected schedules?') then begin
            CurrPage.SetSelectionFilter(SelectedRecords);
            if SelectedRecords.FindSet() then begin
                repeat
                    SelectedRecords.CancelSchedule();
                until SelectedRecords.Next() = 0;
            end;
            CurrPage.Update();
            Message(Format(SelectedRecords.Count) + ' Records Updated');
        end;
    end;

    var
        customerList: Page "Customer List";
        SelectedRecords: Record OrdDoc;
}

