page 50147 "Log Billing List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = LogDoc;
    Caption = 'log Billing';
    CardPageId = 50148;
    //SourceTableView = where(InboundOutbound = const(Inbound)),;

    layout
    {
        area(Content)
        {
            repeater("General")
            {
                field(LogDocNumber; LogDocNumber)
                {
                    ApplicationArea = All;
                }
                field(JobType; JobType)
                {
                    ApplicationArea = All;
                }

                field(Datelog; Datelog)
                {
                    ApplicationArea = All;
                }

                field(OTType; OTType)
                {
                    ApplicationArea = All;
                }

                field(Status; Status)
                {
                    ApplicationArea = All;
                }

                field(DisId; DisId)
                {
                    ApplicationArea = All;
                }

                field(CmpId; CmpId)
                {
                    ApplicationArea = All;
                }

                field(PilId; PilId)
                {
                    ApplicationArea = All;
                }
                field(VesId; VesIdPk)
                {
                    ApplicationArea = All;
                }
                field(BusLA; BusLA)
                {
                    ApplicationArea = All;
                }
                field(BusOwner; BusOwner)
                {
                    ApplicationArea = All;
                }

                field(RevId; RevId)
                {
                    ApplicationArea = All;
                }

                field(Tonnage; Tonnage)
                {
                    ApplicationArea = All;
                }

                field(FuelCost; FuelCost)
                {
                    ApplicationArea = All;
                }

                field(LocStr; LocStr)
                {
                    ApplicationArea = All;
                }

                field(DestinationStr; DestinationStr)
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

            action("Create Sales Order")
            {
                ApplicationArea = All;
                Caption = 'Create Sales Order';

                trigger OnAction()
                Begin
                    CreateSalesOrder.CreateSalesOrder(LogDocNumber);
                End;
            }

            /*action("Working date")
            {
                ApplicationArea = All;
                Caption = 'Working Dates';

                trigger OnAction()
                Begin
                    dates.CalcworkingDate();

                End;
            }*/

        }
    }



    var
        customerList: Page "Customer List";
        CreateSalesOrder: Codeunit CreateSalesOrder;
        dates: Codeunit GetData;


}

