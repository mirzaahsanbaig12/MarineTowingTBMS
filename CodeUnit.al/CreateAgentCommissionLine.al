codeunit 50116 CreateAgentCommissionLine
{
    trigger OnRun()
    begin
        //CreateCommissionLines();
    end;

    procedure CreateCommissionLines(_Documentdate: Date)
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
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
        DocumentDate: Date;
    begin
        SalesInvoiceHeader.Reset();
        InvoiceCreated := 0;

        //SalesInvoiceHeader.SetRange("Document Type", SalesInvoiceHeader."Document Type"::Order);
        SalesInvoiceHeader.SetRange("Document Date", 0D, _Documentdate);
        if SalesInvoiceHeader.FindSet() then begin
            REPEAT
                NewPurchaseHeader.Reset();
                NewPurchaseLine.Reset();
                NewPurchaseHeader.Init();
                NewPurchaseLine.Init();

                SalesInvoiceHeader.CalcFields("Amount Including VAT");

                ConAgent.Reset();
                ConAgent.SetRange(ConNumber, SalesInvoiceHeader.ConNumber);
                ConAgent.SetRange(IsConfidential, false);
                if ConAgent.FindSet() then begin
                    repeat
                        if (ConAgent.BusId <> '') then begin
                            // //Message('agent no ' + Format(ConAgent.BusId));
                            PurchaseHeader.Reset();
                            PurchaseHeader.SetRange("Buy-from Vendor No.", ConAgent.BusId);
                            PurchaseHeader.SetRange(SalesOrderNo, SalesInvoiceHeader."No.");

                            PurchaseInvoice.Reset();
                            PurchaseInvoice.SetRange("Buy-from Vendor No.", ConAgent.BusId);
                            PurchaseInvoice.SetRange(SalesOrderNo, SalesInvoiceHeader."No.");


                            //check for purchase invoice and posted purchase invoice existng record
                            if (NOT PurchaseHeader.FindFirst()) and (NOT PurchaseInvoice.FindFirst()) then begin
                                PurchaseInvoiceNo := NoSeriesMgt.GetNextNo('P-INV', Today, true);

                                NewPurchaseHeader.Init();
                                NewPurchaseHeader.Validate("No.", PurchaseInvoiceNo);
                                NewPurchaseHeader.Validate("Document Type", NewPurchaseHeader."Document Type"::Invoice);
                                NewPurchaseHeader.Validate("Vendor Invoice No.", SalesInvoiceHeader."No.");
                                NewPurchaseHeader.Validate(SalesOrderNo, SalesInvoiceHeader."No.");
                                NewPurchaseHeader.Validate("Buy-from Vendor No.", ConAgent.BusId);

                                If NewPurchaseHeader.Insert(true) then begin
                                    NewPurchaseLine.Init();
                                    NewPurchaseLine.Validate("Line No.", 1000);
                                    NewPurchaseLine.Validate("Document Type", NewPurchaseLine."Document Type"::Invoice);
                                    NewPurchaseLine.Validate("Document No.", NewPurchaseHeader."No."); // Invoice number
                                    NewPurchaseLine.Validate(Type, NewPurchaseLine.Type::"G/L Account"); // Line type
                                    NewPurchaseLine.Validate("No.", format(61200)); // GL account number
                                    NewPurchaseLine.Validate(Quantity, 1);
                                    NewPurchaseLine.Validate("Direct Unit Cost", (SalesInvoiceHeader."Amount Including VAT" * ConAgent.CommonPer));
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
            UNTIL SalesInvoiceHeader.NEXT = 0;
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