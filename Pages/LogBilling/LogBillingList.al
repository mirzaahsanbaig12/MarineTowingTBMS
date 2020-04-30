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
                Visible = false;

                trigger OnAction()
                Begin
                    CreateSalesOrder.CreateSalesOrder(LogDocNumber);
                End;
            }

            action("Create Sales Order2")
            {
                ApplicationArea = All;
                Caption = 'Create Sales Order';

                trigger OnAction()
                var
                    info: Text;
                Begin
                    info := 'Selected records may have different vessel, job type , agent , owner or contract';
                    CurrPage.SetSelectionFilter(logDocRec);
                    if logDocRec.FindFirst() then begin
                        SameRecs := true;
                        logDocRecFirst.TransferFields(logDocRec);
                        repeat

                            if (logDocRecFirst.JobType <> logDocRec.JobType) or
                               (logDocRecFirst.VesIdPk <> logDocRec.VesIdPk) or
                               (logDocRecFirst.BusLA <> logDocRec.BusLA) or
                               (logDocRecFirst.BusOwner <> logDocRec.BusOwner) or
                               (logDocRecFirst.ConNumber <> logDocRec.ConNumber)
                               then begin
                                SameRecs := false;

                            end;



                        until logDocRec.Next() = 0;
                    end;

                    if (SameRecs) and (logDocRec.FindFirst())
                    then begin

                        salesOrder := CreateSalesHeader.CreateSalesHeader(logDocRecFirst.LogDocNumber);

                        if salesOrder <> '1111'
                        then begin
                            Message('Sales Order : %1 has been created', salesOrder);

                            CurrPage.SetSelectionFilter(logDocRec);
                            if logDocRec.FindFirst() then begin
                                repeat
                                    CreateSalesLines.CreateSalesLines(logDocRec.LogDocNumber, salesOrder);
                                until logDocRec.Next() = 0;
                            end;

                        end;


                    end
                    else begin
                        Message('Cannot create sales order \%1', info);
                    end;
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
        logDocRec: Record LogDoc;
        logDocRecFirst: Record LogDoc;
        logDocRecNext: Record LogDoc;
        SameRecs: Boolean;
        CreateSalesHeader: Codeunit CreateSalesHeader;
        salesOrder: code[50];
        CreateSalesLines: Codeunit CreateSalesLines;



}

