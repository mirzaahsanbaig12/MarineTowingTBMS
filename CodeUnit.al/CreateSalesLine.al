codeunit 50115 CreateSalesLines
{
    procedure CreateSalesLines(_LogDocNumber: Integer; SalesOrderNo: Code[50])
    var
        //SalesHeader: Record "Sales Header";
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
        tariffRec: Record Tariff;
        baseRateRec: Record TarBr;

    begin
        logDocRec.SetFilter(LogDocNumber, format(_LogDocNumber));
        if logDocRec.FindFirst() then begin

            fixRate := 2999;
            RevAccount := '40100';
            customerAcc := logDocRec.BusOwner;

            if logDocRec.CmpId <> '' then begin
                CompanyRec.SetFilter(CmpId, logDocRec.CmpId);
                if CompanyRec.FindFirst() then begin
                    RevAccount := CompanyRec.AcctRev;
                end;
            end;


            if logDocRec.ConNumber <> 0 then begin
                contractRec.SetFilter(ConNumber, format(logDocRec.ConNumber));
                if contractRec.FindFirst() then begin

                    if contractRec.AssistFixedRate then begin
                        fixRate := contractRec.Rate;
                    end;
                    if logDocRec.JobType = logDocRec.JobType::Shifting
                    then begin

                        tariffRec.SetFilter(TarId, CompanyRec.TarId);
                        if tariffRec.FindFirst() then begin

                            baseRateRec.SetFilter(TarId, tariffRec.TarId);
                            baseRateRec.SetFilter(TonnageEnd, format(logDocRec.Tonnage));
                            if baseRateRec.FindFirst()
                            then
                                if tariffRec.JobShiftType = tariffRec.JobShiftType::Amount
                                then begin
                                    fixRate := baseRateRec.Rate + tariffRec.JobShiftAmount;
                                end;

                            if tariffRec.JobShiftType = tariffRec.JobShiftType::Percentage
                            then begin
                                fixRate := baseRateRec.Rate + ((baseRateRec.Rate * tariffRec.JobShiftAmount) / 100);
                                fixRate := fixRate + baseRateRec.Rate;
                            end;
                        end;

                    end;

                    if contractRec.BillingOptions = contractRec.BillingOptions::Agent then begin
                        customerAcc := logDocRec.BusLA;
                    end
                    else
                        customerAcc := logDocRec.BusOwner;
                end;
            end;

            //contract find get tonnage rate

            if (contractRec.AssistFixedRate = false) and (contractRec.TarCustomer = '')
            then begin
                tariffRec.SetFilter(TarId, CompanyRec.TarId);
                if tariffRec.FindFirst()
                then begin
                    baseRateRec.SetFilter(TarId, tariffRec.TarId);
                    baseRateRec.SetFilter(TonnageEnd, format(logDocRec.Tonnage));
                    if (baseRateRec.FindFirst()) and (fixRate = 0)
                    then
                        fixRate := baseRateRec.Rate;
                end;
            end;

            logDocRec.Status := logDocRec.Status::SO;
            logDocRec.SalesOrderNo := SalesOrderNo;
            logDocRec.Modify();

            SalesLine.SetFilter("Document Type", format(SalesLine."Document Type"::Order));
            SalesLine.SetFilter("Document No.", SalesOrderNo);

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
                        LineDesc := format(logDocRec.VesId) + ' Docking From ' + logDetRec.DestinationStr + ' ' + format(DT2Time(logDetRec.TimeStart)) + ' - ' + format(DT2Time(logDetRec.Timefinish)) + ' @ $' + format(fixRate);
                    end;

                    if logDocRec.JobType = logDocRec.JobType::Undocking
                   then begin
                        LineDesc := format(logDocRec.VesId) + ' Undocking From ' + logDetRec.LocStr + ' ' + format(DT2Time(logDetRec.TimeStart)) + ' - ' + format(DT2Time(logDetRec.Timefinish)) + ' @ $' + format(fixRate);
                    end;

                    if logDocRec.JobType = logDocRec.JobType::Shifting
                   then begin
                        if DT2Date(logDetRec.TimeStart) = DT2Date(logDetRec.Timefinish) then begin
                            LineDesc := format(logDocRec.VesId) + 'Vessel Shifting From ' + logDetRec.LocStr + ' To ' + logDetRec.DestinationStr + ' ' + format(DT2Time(logDetRec.TimeStart)) + ' - ' + format(DT2Time(logDetRec.Timefinish)) + ' @ $' + format(fixRate);

                        end;
                        if DT2Date(logDetRec.TimeStart) <> DT2Date(logDetRec.Timefinish) then begin
                            LineDesc := format(logDocRec.VesId) + 'Vessel Shifting From ' + logDetRec.LocStr + ' To ' + logDetRec.DestinationStr + ' ' + format(logDetRec.TimeStart) + ' - ' + Format(logDetRec.Timefinish) + ' @ $' + format(fixRate);

                        end;
                    end;

                    SalesLine."Document No." := SalesOrderNo;
                    SalesLine.Init();
                    lineNo := lineNo + 100;
                    SalesLine.Validate("Line No.", lineNo);
                    SalesLine.Validate("Document Type", SalesLine."Document Type"::Order);
                    SalesLine.Validate("Type", SalesLine.Type::"G/L Account");
                    SalesLine.Validate("No.", Format(RevAccount));
                    SalesLine.Validate(TBMSDescription, LineDesc);
                    SalesLine.Validate("Quantity", 1);
                    SalesLine.Validate("Unit Price", fixRate);
                    SalesLine.Validate("Line Amount", fixRate);
                    SalesLine.Validate("Shortcut Dimension 1 Code", tugBoatRec.AccountCC);
                    SalesLine.Validate(Description, LineDesc);
                    SalesLine.Insert(true);
                until logDetRec.Next() = 0;
            end;
        end;
    end;
}