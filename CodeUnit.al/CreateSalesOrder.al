codeunit 50113 CreateSalesOrder
{
    procedure CreateSalesOrder(_LogDocNumber: Integer)
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        logDocRec: Record LogDoc;
        logDetRec: Record LogDet;
        lineNo: Integer;
        contractRec: Record Contract;
        fixRate: Decimal;
        CompanyRec: Record "Company Register";
        RevAccount: code[50];
        customerAcc: code[50];
        tugBoatRec: Record "Tug Boat";
        LineDesc: Text[200];
    begin
        logDocRec.SetFilter(LogDocNumber, format(_LogDocNumber));
        if logDocRec.FindFirst() then begin

            fixRate := 2000;
            RevAccount := '40100';
            customerAcc := logDocRec.BusOwner;

            if logDocRec.ConNumber <> 0 then begin
                contractRec.SetFilter(ConNumber, format(logDocRec.ConNumber));
                if contractRec.FindFirst() then begin

                    if contractRec.AssistFixedRate then begin
                        fixRate := contractRec.Rate;
                    end;
                    if contractRec.BillingOptions = contractRec.BillingOptions::Agent then begin
                        customerAcc := logDocRec.BusLA;
                    end
                    else
                        customerAcc := logDocRec.BusOwner;
                end;
            end;

            SalesHeader."Document Type" := SalesHeader."Document Type"::Order;
            SalesHeader.Init();
            SalesHeader.Validate("Sell-to Customer No.", customerAcc);

            if SalesHeader.Insert(true) then begin
                Commit();
                Message('Sale Order : %1 has been created', SalesHeader."No.");

                SalesLine.SetFilter("Document Type", format(SalesLine."Document Type"::Order));
                SalesLine.SetFilter("Document No.", SalesHeader."No.");


                if logDocRec.CmpId <> '' then begin
                    CompanyRec.SetFilter(CmpId, logDocRec.CmpId);
                    if CompanyRec.FindFirst() then begin
                        RevAccount := CompanyRec.AcctRev;
                    end;
                end;

                if SalesLine.FindLast() then begin
                    lineNo := SalesLine."Line No."
                end
                else
                    lineNo := 1000;


                logDetRec.SetFilter(LogDocNumber, Format(_LogDocNumber));
                if logDetRec.FindSet() then Begin
                    repeat
                        tugBoatRec.SetFilter(TugId, logDetRec.TugId);
                        tugBoatRec.FindFirst();


                        if logDocRec.JobType = logDocRec.JobType::Docking
                       then begin
                            LineDesc := format(logDocRec.VesIdPk) + ' Docking From ' + logDetRec.DestinationStr + ' ' + format(logDetRec.Timefinish) + ' @ $' + format(fixRate);
                        end;

                        if logDocRec.JobType = logDocRec.JobType::Undocking
                       then begin
                            LineDesc := format(logDocRec.VesIdPk) + ' Undocking From ' + logDetRec.LocStr + ' ' + format(logDetRec.TimeStart) + ' @ $' + format(fixRate);
                        end;

                        SalesLine."Document No." := SalesHeader."No.";
                        SalesLine.Init();
                        SalesLine.Validate("Line No.", lineNo);
                        SalesLine.Validate("Document Type", SalesLine."Document Type"::Order);
                        SalesLine.Validate("Type", SalesLine.Type::"G/L Account");
                        SalesLine.Validate("No.", Format(RevAccount));
                        SalesLine.Validate(TBMSDescription, LineDesc);
                        SalesLine.Validate("Quantity", 1);
                        SalesLine.Validate("Unit Price", fixRate);
                        SalesLine.Validate("Line Amount", fixRate);
                        SalesLine.Insert(true);
                        lineNo := lineNo + 100;

                    until logDetRec.Next() = 0;

                end;



            end;


        end;


    end;
}