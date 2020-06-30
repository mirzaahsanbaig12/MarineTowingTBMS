codeunit 50116 CreateAgentCommissionLine
{
    trigger OnRun()
    begin
        CreateCommissionLines();
    end;

    local procedure CreateCommissionLines()
    var
        SalesHeader: Record "Sales Header";
        AgentConLine: Record AgentCommissionLine;
        NewAgentComLine: Record AgentCommissionLine;
        PurchaseHeader: Record "Purchase Header";
        NewPurchaseHeader: Record "Purchase Header";
        NewPurchaseLine: Record "Purchase Line";
        ConAgent: Record ConAgent;
        NoSeriesMgmt: Codeunit NoSeriesManagement;
    begin
        SalesHeader.Reset();
        NewPurchaseHeader.Reset();
        NewPurchaseLine.Reset();

        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
        if SalesHeader.FindSet() then begin
            REPEAT
                SalesHeader.CalcFields("Amount Including VAT");

                ConAgent.Reset();
                ConAgent.SetRange(ConNumber, SalesHeader.ConNumber);
                if ConAgent.FindSet() then begin
                    repeat
                        // //Message('agent no ' + Format(ConAgent.BusId));
                        PurchaseHeader.Reset();
                        PurchaseHeader.SetRange("Buy-from Vendor No.", ConAgent.BusId);
                        PurchaseHeader.SetRange(SalesOrderNo, SalesHeader."No.");

                        if PurchaseHeader.FindFirst() then begin

                        end
                        else begin
                            NewPurchaseHeader.Init();
                            NewPurchaseHeader.Validate("No.", NoSeriesMgmt.GetNextNo('P-INV', Today, false));
                            NewPurchaseHeader.Validate(SalesOrderNo, SalesHeader."No.");
                            NewPurchaseHeader.Validate("Buy-from Vendor No.", ConAgent.BusId);

                        end;
                    // AgentConLine.Reset();
                    // AgentConLine.SetRange("Document No.", SalesHeader."No.");
                    // AgentConLine.SetRange(ConNumber, SalesHeader.ConNumber);
                    // AgentConLine.SetRange(AgentNo, ConAgent.BusId);

                    // if AgentConLine.FindFirst() then begin
                    // end
                    // else begin
                    //     NewAgentComLine.Init();
                    //     NewAgentComLine.Validate("No.", NewAgentComLine.GetNextNo());//ignore
                    //     NewAgentComLine.Validate(AgentNo, ConAgent.BusId); //ignore
                    //     NewAgentComLine.Validate(ConNumber, SalesHeader.ConNumber); //ignore
                    //     NewAgentComLine."Document No." := SalesHeader."No."; //ignore
                    //     NewAgentComLine.Validate(TotalAmount, SalesHeader."Amount Including VAT"); //ignore
                    //     NewAgentComLine.Validate(CommissionPer, ConAgent.CommonPer); //         CommissionAmount := TotalAmount * CommissionPer;
                    //     NewAgentComLine.Insert();
                    //     Commit();
                    // end;
                    until ConAgent.Next() = 0;
                end;
            UNTIL SalesHeader.NEXT = 0;
        end;

        Message('Calculation done');
    end;

    local procedure DeleteAllAgentCommissionLines()
    var
        acl: Record AgentCommissionLine;
    begin

        acl.DeleteAll(true);
    end;

    local procedure InsertConNumberInSalesHeader()
    var
        log: Record LogDoc;
        salesHeader: Record "Sales Header";
    begin

        log.Reset();

        if log.FindSet() then begin
            repeat
                salesHeader.Reset();
                if salesHeader.Get(salesHeader."Document Type"::Order, log.SalesOrderNo) then begin
                    salesHeader.Validate(ConNumber, log.ConNumber);
                    salesHeader.Modify(true);
                end;
            until log.Next() = 0
        end;
    end;

    var
        myInt: Integer;
}