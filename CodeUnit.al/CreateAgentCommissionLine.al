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
        PurchaseInvoice: Record "Purch. Inv. Header";
        NewPurchaseHeader: Record "Purchase Header";
        NewPurchaseLine: Record "Purchase Line";
        ConAgent: Record ConAgent;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        InvoiceCreated: Integer;
        PurchaseInvoiceNo: Code[20];
    begin
        SalesHeader.Reset();
        InvoiceCreated := 0;

        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
        if SalesHeader.FindSet() then begin
            REPEAT
                NewPurchaseHeader.Reset();
                NewPurchaseLine.Reset();
                NewPurchaseHeader.Init();
                NewPurchaseLine.Init();

                SalesHeader.CalcFields("Amount Including VAT");

                ConAgent.Reset();
                ConAgent.SetRange(ConNumber, SalesHeader.ConNumber);
                ConAgent.SetRange(IsConfidential, false);
                if ConAgent.FindSet() then begin
                    repeat
                        if (ConAgent.BusId <> '') then begin
                            // //Message('agent no ' + Format(ConAgent.BusId));
                            PurchaseHeader.Reset();
                            PurchaseHeader.SetRange("Buy-from Vendor No.", ConAgent.BusId);
                            PurchaseHeader.SetRange(SalesOrderNo, SalesHeader."No.");

                            PurchaseInvoice.Reset();
                            PurchaseInvoice.SetRange("Buy-from Vendor No.", ConAgent.BusId);
                            PurchaseInvoice.SetRange(SalesOrderNo, SalesHeader."No.");


                            //check for purchase invoice and posted purchase invoice existng record
                            if (NOT PurchaseHeader.FindFirst()) and (NOT PurchaseInvoice.FindFirst()) then begin
                                PurchaseInvoiceNo := NoSeriesMgt.GetNextNo('P-INV', Today, true);
                                
                                NewPurchaseHeader.Init();
                                NewPurchaseHeader.Validate("No.", PurchaseInvoiceNo);
                                NewPurchaseHeader.Validate("Document Type", NewPurchaseHeader."Document Type"::Invoice);
                                NewPurchaseHeader.Validate("Vendor Invoice No.", SalesHeader."No.");
                                NewPurchaseHeader.Validate(SalesOrderNo, SalesHeader."No.");
                                NewPurchaseHeader.Validate("Buy-from Vendor No.", ConAgent.BusId);

                                If NewPurchaseHeader.Insert(true) then begin

                                    NewPurchaseLine.Init();
                                    NewPurchaseLine.Validate("Line No.", 1000);
                                    NewPurchaseLine.Validate("Document Type", NewPurchaseLine."Document Type"::Invoice);
                                    NewPurchaseLine.Validate("Document No.", NewPurchaseHeader."No."); // Invoice number
                                    NewPurchaseLine.Validate(Type, NewPurchaseLine.Type::"G/L Account"); // Line type
                                    NewPurchaseLine.Validate("No.", format(61200)); // GL account number
                                    NewPurchaseLine.Validate(Quantity, 1);
                                    NewPurchaseLine.Validate("Direct Unit Cost", (SalesHeader."Amount Including VAT" * ConAgent.CommonPer));
                                    //purchLine.Validate("Line Amount", purchInvLineStg."Line Amount");
                                    NewPurchaseLine.Validate("Shortcut Dimension 1 Code", Format(100300));
                                    if NewPurchaseLine.Insert(true) then begin
                                        //Message('Purchase Invoice created No. : %1', NewPurchaseHeader."No.");
                                        InvoiceCreated := InvoiceCreated + 1;
                                        Commit();
                                    end;

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
                            end;
                        end;

                    until ConAgent.Next() = 0;
                end;
            UNTIL SalesHeader.NEXT = 0;
        end;

        Message('Total invoices created %1', InvoiceCreated);

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