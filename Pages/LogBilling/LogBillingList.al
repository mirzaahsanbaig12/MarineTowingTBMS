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
                field(VesId; VesId)
                {
                    ApplicationArea = All;
                }

                field(BusOwner; BusOwner)
                {
                    ApplicationArea = All;
                }
                field(BusLA; BusLA)
                {
                    ApplicationArea = All;
                }
                field(BillingOptions; BillingOptions)
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
                    multipleLogs: Boolean;
                    i: Integer;
                Begin
                    info := 'Selected records may have different vessel, agent , owner or contract';
                    CurrPage.SetSelectionFilter(logDocRec);
                    if logDocRec.FindFirst() then begin
                        SameRecs := true;
                        StatusSO := false;
                        multipleLogs := false;
                        i := 0;
                        logDocRecFirst.TransferFields(logDocRec);
                        repeat

                            if //(logDocRecFirst.JobType <> logDocRec.JobType) or
                               (logDocRecFirst.VesId <> logDocRec.VesId) or
                               (logDocRecFirst.BusLA <> logDocRec.BusLA) or
                               (logDocRecFirst.BusOwner <> logDocRec.BusOwner) or
                               (logDocRecFirst.ConNumber <> logDocRec.ConNumber)
                               then begin
                                SameRecs := false;
                                i := 0;
                            end
                            else
                                i := i + 1;

                            if (logDocRec.Status = logDocRec.Status::SO) or (logDocRec.Status = logDocRec.Status::Invoiced)
                                   then begin
                                StatusSO := true;
                            end



                        until logDocRec.Next() = 0;
                    end;

                    if StatusSO
                    then begin

                        Message('Sales order cannot be created beacuse log status is SO or Invoiced \ Please Change log status to create sales order');
                        exit;
                    end;

                    if (SameRecs) and (logDocRec.FindFirst())
                    then begin

                        if (i > 1) then
                            multipleLogs := true;


                        salesOrder := CreateSalesHeader.CreateSalesHeader(logDocRecFirst.LogDocNumber, multipleLogs);

                        if salesOrder <> '1111'
                        then begin

                            CurrPage.SetSelectionFilter(logDocRec);
                            if logDocRec.FindFirst() then begin
                                repeat
                                    CreateSalesLines.CreateSalesLines(logDocRec.LogDocNumber, salesOrder);
                                until logDocRec.Next() = 0;
                            end;

                            setConfidentalDiscount(salesOrder);

                            if Dialog.CONFIRM('Sales Order %1 has been created \ Do you want to open sales order?', TRUE, salesOrder)
                            then begin
                                salesHeaderRec.SetFilter("No.", salesOrder);
                                if salesHeaderRec.FindFirst() then begin

                                    salesHeaderPage.SetRecord(salesHeaderRec);
                                    salesHeaderPage.Run();
                                end;


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
        StatusSO: Boolean;
        CreateSalesHeader: Codeunit CreateSalesHeader;
        salesOrder: code[50];
        CreateSalesLines: Codeunit CreateSalesLines;
        salesHeaderPage: page "Sales Order";
        salesHeaderRec: Record "Sales Header";


    procedure setConfidentalDiscount(_salesHeaderNo: code[50])

    var
        salesHeaderLocalRec: Record "Sales Header";
        salesHeaderAmount: Decimal;
        ConAgent: Record ConAgent;
        salesline: Record "Sales Line";
        lineNo: Integer;
        contractRec: Record Contract;
        desc: Text[200];
        PriceFormatStr: Text[200];
    begin

        PriceFormatStr := '<Integer Thousand><Decimals,3>';
        SalesLine.SetFilter("Document Type", format(SalesLine."Document Type"::Order));
        SalesLine.SetFilter("Document No.", _salesHeaderNo);

        if SalesLine.FindLast() then begin
            lineNo := SalesLine."Line No."
        end
        else
            lineNo := 100;

        //get salesline no end

        // set Confidental Discount start

        if salesHeaderLocalRec.Get(salesHeaderLocalRec."Document Type"::Order, _salesHeaderNo) then begin

            salesHeaderLocalRec.CalcFields(Amount);
            SalesHeaderAmount := salesHeaderLocalRec.Amount;
            //Message('Sales Header NO : %1 and amount %2', SalesOrderNo, SalesHeaderAmount);
            ConAgent.SetFilter(IsConfidential, format(True));
            Conagent.SetFilter(ConNumber, format(salesHeaderLocalRec.ConNumber));

            contractRec.SetFilter(ConNumber, format(salesHeaderLocalRec.ConNumber));
            contractRec.FindFirst();

            if ConAgent.FindFirst() then begin
                repeat


                    SalesLine."Document No." := _salesHeaderNo;
                    SalesLine.Init();
                    lineNo := lineNo + 1000;
                    SalesLine.Validate("Line No.", lineNo);
                    SalesLine.Validate("Document Type", SalesLine."Document Type"::Order);
                    SalesLine.Validate("Type", SalesLine.Type::"G/L Account");
                    SalesLine.Validate("No.", Format('40250'));
                    SalesLine.Validate("Quantity", 1);
                    SalesLine.Validate(TBMSIsFieldConfidentalLine, true);
                    SalesLine.Validate("Unit Price", 0 - (ConAgent.DiscPer * SalesHeaderAmount));
                    SalesLine.Validate("Line Amount", 0 - (ConAgent.DiscPer * SalesHeaderAmount));
                    SalesLine.Validate(LogDate, DT2Date(logDocRec.Datelog));
                    salesline.Validate(ChargeType, 'Discount');
                    if not salesHeaderLocalRec.mulipleLogs then
                        SalesLine.Validate(LogDocNumber, salesHeaderLocalRec.LogDocNumber);

                    desc := 'DISCOUNT (' + Format(ConAgent.DiscPer, 0, PriceFormatStr) + '% ) On $' + Format(SalesHeaderAmount, 0, PriceFormatStr);
                    SalesLine.Validate(TBMSlongDesc, 'Confidential Discount');
                    SalesLine.Validate(TBMSDescription, 'Confidential Discount');
                    SalesLine.Validate(TBMSDescription2);
                    SalesLine.Validate(TBMSDescription3, desc);
                    //SalesLine.Validate(LogDocNumber, logDocRec.LogDocNumber);
                    if contractRec.DiscPer > 0 then begin
                        if (contractRec.DiscType = contractRec.DiscType::"Gross On All Charges") OR (contractRec.DiscType = contractRec.DiscType::"Gross On Base Charges") then begin
                            SalesLine.Validate("Line Discount %", contractRec.DiscPer * 100);
                        end
                    end;

                    SalesLine.Insert(true);


                until ConAgent.Next() = 0
            end;
        end;
        //set Confidental Discount end
    end;



}

