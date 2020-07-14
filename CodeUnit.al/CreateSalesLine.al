codeunit 50115 CreateSalesLines
{
    procedure CreateSalesLines(_LogDocNumber: Integer; SalesOrderNo: Code[50])
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        RepositionChargeSL: Record "Sales Line";
        OvertimeChargeSL: Record "Sales Line";
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
        hours: Duration;
        TonnageDiff: Integer;
        StartPort: Code[20];
        EndPort: code[20];
        locationRec: Record "Location Register";
        overtimeMins: Integer;
        Duration1: Duration;
        hoursDiff: Decimal;
        tempStartDate: DateTime;
        CompInfo: Record "Company Information";
        CustomizedCalendarChange: Record "Customized Calendar Change";
        CalendarMgmt: Codeunit "Calendar Management";
        baseCalendar: Record "Base Calendar";
        lineDesc1: text[200];
        lineDesc2: text[200];
        TotalOverTimeCharges: Decimal;
        TotalBaseCharges: Decimal;
        TotalDiscountAmount: Decimal;
        DiscountSL: Record "Sales Line";
        ConAgent: Record ConAgent;
        SalesHeaderAmount: Decimal;

    begin
        TotalOverTimeCharges := 0;
        TotalBaseCharges := 0;
        TotalDiscountAmount := 0;
        logDocRec.SetFilter(LogDocNumber, format(_LogDocNumber));
        if logDocRec.FindFirst() then begin

            fixRate := 0;
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

                        if contractRec.TarCustomer = ''
                        then begin
                            tariffRec.SetFilter(TarId, CompanyRec.TarId);
                        end
                        else begin
                            tariffRec.SetFilter(TarId, contractRec.TarCustomer);

                        end;

                        if tariffRec.FindFirst() then begin

                            baseRateRec.SetFilter(TarId, tariffRec.TarId);
                            if logDocRec.Tonnage > 30000
                            then
                                baseRateRec.SetFilter(TonnageEnd, format(30000))
                            else
                                baseRateRec.SetFilter(TonnageEnd, format(logDocRec.Tonnage));
                            if baseRateRec.FindLast()
                            then
                                if tariffRec.JobShiftType = tariffRec.JobShiftType::Amount
                                then begin
                                    if logDocRec.Tonnage > 30000 then begin

                                        TonnageDiff := logDocRec.Tonnage - 30000;
                                        TonnageDiff := Round(TonnageDiff / tariffRec.BRInc, 1, '=');
                                        fixRate := baseRateRec.Rate + tariffRec.JobShiftAmount + (TonnageDiff * tariffRec.BRAmt);



                                    end
                                    else
                                        fixRate := baseRateRec.Rate + tariffRec.JobShiftAmount;


                                end;

                            if tariffRec.JobShiftType = tariffRec.JobShiftType::Percentage
                            then begin
                                if logDocRec.Tonnage > 30000 then begin

                                    TonnageDiff := logDocRec.Tonnage - 30000;
                                    TonnageDiff := Round(TonnageDiff / tariffRec.BRInc, 1, '=');
                                    fixRate := baseRateRec.Rate + ((baseRateRec.Rate * tariffRec.JobShiftAmount) / 100);
                                    fixRate := fixRate + baseRateRec.Rate + (TonnageDiff * tariffRec.BRAmt);

                                end
                                else begin
                                    fixRate := baseRateRec.Rate + ((baseRateRec.Rate * tariffRec.JobShiftAmount) / 100);
                                    fixRate := fixRate + baseRateRec.Rate;
                                end;
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
                if contractRec.TarCustomer = ''
                then begin
                    tariffRec.SetFilter(TarId, CompanyRec.TarId);
                end
                else begin
                    tariffRec.SetFilter(TarId, contractRec.TarCustomer);

                end;
                if tariffRec.FindFirst()
                then begin
                    baseRateRec.SetFilter(TarId, tariffRec.TarId);
                    if logDocRec.Tonnage > 30000 then
                        baseRateRec.SetFilter(TonnageEnd, format(30000))
                    else
                        baseRateRec.SetFilter(TonnageEnd, format(logDocRec.Tonnage));

                    if (baseRateRec.FindLast()) and (fixRate = 0)
                    then begin

                        if logDocRec.Tonnage > 30000 then begin

                            TonnageDiff := logDocRec.Tonnage - 30000;
                            TonnageDiff := Round(TonnageDiff / tariffRec.BRInc, 1, '=');
                            fixRate := baseRateRec.Rate + (TonnageDiff * tariffRec.BRAmt);
                        end
                        else
                            fixRate := baseRateRec.Rate;
                    end;
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
                        lineDesc1 := format(logDocRec.VesId) + ' Docking From ' + logDetRec.DestinationStr;
                        lineDesc2 := format(DT2Time(logDetRec.TimeStart)) + ' - ' + format(DT2Time(logDetRec.Timefinish)) + ' @ $' + format(fixRate);
                    end;

                    if logDocRec.JobType = logDocRec.JobType::Undocking
                   then begin
                        LineDesc := format(logDocRec.VesId) + ' Undocking From ' + logDetRec.LocStr + ' ' + format(DT2Time(logDetRec.TimeStart)) + ' - ' + format(DT2Time(logDetRec.Timefinish)) + ' @ $' + format(fixRate);
                        lineDesc1 := format(logDocRec.VesId) + ' Undocking From ' + logDetRec.LocStr;
                        lineDesc2 := format(DT2Time(logDetRec.TimeStart)) + ' - ' + format(DT2Time(logDetRec.Timefinish)) + ' @ $' + format(fixRate);
                    end;

                    if logDocRec.JobType = logDocRec.JobType::Shifting
                   then begin
                        if DT2Date(logDetRec.TimeStart) = DT2Date(logDetRec.Timefinish) then begin
                            LineDesc := format(logDocRec.VesId) + 'Vessel Shifting From ' + logDetRec.LocStr + ' To ' + logDetRec.DestinationStr + ' ' + format(DT2Time(logDetRec.TimeStart)) + ' - ' + format(DT2Time(logDetRec.Timefinish)) + ' @ $' + format(fixRate);
                            lineDesc1 := format(logDocRec.VesId) + 'Vessel Shifting From ' + logDetRec.LocStr + ' To ' + logDetRec.DestinationStr;
                            lineDesc2 := format(DT2Time(logDetRec.TimeStart)) + ' - ' + format(DT2Time(logDetRec.Timefinish)) + ' @ $' + format(fixRate);
                        end;
                        if DT2Date(logDetRec.TimeStart) <> DT2Date(logDetRec.Timefinish) then begin
                            LineDesc := format(logDocRec.VesId) + 'Vessel Shifting From ' + logDetRec.LocStr + ' To ' + logDetRec.DestinationStr + ' ' + format(logDetRec.TimeStart) + ' - ' + Format(logDetRec.Timefinish) + ' @ $' + format(fixRate);
                            lineDesc1 := format(logDocRec.VesId) + 'Vessel Shifting From ' + logDetRec.LocStr + ' To ' + logDetRec.DestinationStr;
                            lineDesc2 := format(logDetRec.TimeStart) + ' - ' + Format(logDetRec.Timefinish) + ' @ $' + format(fixRate);
                        end;
                    end;

                    if logDocRec.JobType = logDocRec.JobType::Hourly
                    then begin
                        hours := logDetRec.Timefinish - logDetRec.TimeStart;
                        fixRate := hours / 3600000;
                        fixRate := Round(fixRate, 1, '=') * tugBoatRec.HourlyRate;
                        LineDesc := tugBoatRec.Name;//+ ' \ vessel ' + logDocRec.VesId + ' \';
                        LineDesc := LineDesc + ' Leave doc at' + format(DT2Time(logDetRec.TimeStart)) + ' ' + logDetRec.LocStr;
                        LineDesc := LineDesc + ' Arrive doc at ' + format(DT2Time(logDetRec.Timefinish)) + ' ' + logDetRec.DestinationStr;
                        LineDesc := LineDesc + ' 5 @ ' + Format(tugBoatRec.HourlyRate);

                        LineDesc1 := tugBoatRec.Name;//+ ' \ vessel ' + logDocRec.VesId + ' \';
                        LineDesc1 := LineDesc1 + ' Leave doc at' + format(DT2Time(logDetRec.TimeStart)) + ' ' + logDetRec.LocStr;

                        LineDesc2 := ' Arrive doc at ' + format(DT2Time(logDetRec.Timefinish)) + ' ' + logDetRec.DestinationStr;
                        LineDesc2 := LineDesc2 + ' 5 @ ' + Format(tugBoatRec.HourlyRate);

                    end;

                    SalesLine."Document No." := SalesOrderNo;
                    SalesLine.Init();
                    lineNo := lineNo + 100;
                    SalesLine.Validate("Line No.", lineNo);
                    SalesLine.Validate("Document Type", SalesLine."Document Type"::Order);
                    SalesLine.Validate("Type", SalesLine.Type::"G/L Account");
                    SalesLine.Validate("No.", Format(RevAccount));
                    SalesLine.Validate("Quantity", 1);
                    SalesLine.Validate("Unit Price", fixRate);
                    SalesLine.Validate("Line Amount", fixRate);
                    SalesLine.Validate("Shortcut Dimension 1 Code", tugBoatRec.AccountCC);
                    SalesLine.Validate(Description, LineDesc);
                    SalesLine.Validate(TBMSDescription, lineDesc1);
                    SalesLine.Validate(TBMSDescription2, lineDesc2);
                    if contractRec.DiscPer > 0 then begin
                        if (contractRec.DiscType = contractRec.DiscType::"Gross On All Charges") OR (contractRec.DiscType = contractRec.DiscType::"Gross On Base Charges") then begin
                            SalesLine.Validate("Line Discount %", contractRec.DiscPer * 100);
                        end
                    end;

                    TotalBaseCharges += fixRate;

                    if SalesLine.Insert(true) then begin
                        locationRec.SetFilter(LocId, logDetRec.LocStr);
                        if locationRec.FindFirst() then
                            StartPort := locationRec.PrtId;

                        locationRec.Reset();
                        locationRec.SetFilter(LocId, logDetRec.DestinationStr);
                        if locationRec.FindFirst() then
                            EndPort := locationRec.PrtId;

                        if (StartPort = 'C') and (EndPort = 'D') then begin
                            if contractRec.TarCustomer = ''
                            then begin
                                tariffRec.SetFilter(TarId, CompanyRec.TarId);
                            end
                            else begin
                                tariffRec.SetFilter(TarId, contractRec.TarCustomer);

                            end;

                            if tariffRec.FindFirst() then begin


                                RepositionChargeSL."Document No." := SalesOrderNo;
                                RepositionChargeSL.Init();
                                lineNo := lineNo + 100;
                                RepositionChargeSL.Validate("Line No.", lineNo);
                                RepositionChargeSL.Validate("Document Type", SalesLine."Document Type"::Order);
                                RepositionChargeSL.Validate("Type", SalesLine.Type::"G/L Account");
                                RepositionChargeSL.Validate("No.", Format(RevAccount));
                                RepositionChargeSL.Validate("Quantity", 1);

                                RepositionChargeSL.Validate("Unit Price", tariffRec.FlatRate);
                                RepositionChargeSL.Validate("Line Amount", tariffRec.FlatRate);
                                RepositionChargeSL.Validate("Shortcut Dimension 1 Code", tugBoatRec.AccountCC);
                                LineDesc := 'Repositioning Charge for ' + logDetRec.TugId;
                                RepositionChargeSL.Validate(Description, LineDesc);
                                RepositionChargeSL.Validate(TBMSDescription, LineDesc);

                                if contractRec.DiscPer > 0 then begin
                                    if contractRec.DiscType = contractRec.DiscType::"Gross On All Charges" then begin
                                        RepositionChargeSL.Validate("Line Discount %", contractRec.DiscPer);
                                    end
                                end;

                                if tariffRec.FSType = tariffRec.FSType::"All Charges" then begin
                                    if RepositionChargeSL.Insert(true)
                                    then
                                        ;
                                end;

                            end;

                        end;

                        //<overtimeRate>
                        if contractRec.TarCustomer = ''
                           then begin
                            tariffRec.SetFilter(TarId, CompanyRec.TarId);
                        end
                        else begin
                            tariffRec.SetFilter(TarId, contractRec.TarCustomer);
                        end;

                        baseCalendar.Reset();
                        CustomizedCalendarChange.Reset();
                        CompInfo.Get();
                        baseCalendar.SetRange(Code, CompInfo."Base Calendar Code");
                        if baseCalendar.FindFirst() then begin
                            CalendarMgmt.SetSource(baseCalendar, CustomizedCalendarChange);
                        end;
                        if tariffRec.FindFirst() then begin

                            //calculation working dates
                            tempStartDate := logDetRec.TimeStart;
                            REPEAT
                                IF NOT CalendarMgmt.IsNonworkingDay(DT2DATE(tempStartDate), CustomizedCalendarChange) then begin
                                    Duration1 := Duration1 + (CreateDateTime(CalcDate('+1D', DT2Date(tempStartDate)), 000000T) - tempStartDate);
                                end;
                                tempStartDate := CreateDateTime(CALCDATE('+1D', DT2DATE(tempStartDate)), 000000T);

                            UNTIL logDetRec.Timefinish < tempStartDate;

                            overtimeMins := tariffRec.JobStandardTime;
                            //Duration1 := logDetRec.Timefinish - logDetRec.TimeStart;
                            hoursDiff := Round(Duration1 / 3600000, 1, '=');

                            if (hoursDiff > overtimeMins) and ((hoursDiff - overtimeMins) >= 15)
                            then begin

                                fixRate := hoursDiff * tugBoatRec.HourlyRate;

                                OvertimeChargeSL."Document No." := SalesOrderNo;
                                OvertimeChargeSL.Init();
                                lineNo := lineNo + 100;
                                OvertimeChargeSL.Validate("Line No.", lineNo);
                                OvertimeChargeSL.Validate("Document Type", SalesLine."Document Type"::Order);
                                OvertimeChargeSL.Validate("Type", SalesLine.Type::"G/L Account");
                                OvertimeChargeSL.Validate("No.", Format(RevAccount));
                                OvertimeChargeSL.Validate("Quantity", 1);

                                OvertimeChargeSL.Validate("Unit Price", fixRate);
                                OvertimeChargeSL.Validate("Line Amount", fixRate);
                                OvertimeChargeSL.Validate("Shortcut Dimension 1 Code", tugBoatRec.AccountCC);
                                LineDesc := 'Over Time Charge for ' + logDetRec.TugId;
                                OvertimeChargeSL.Validate(Description, LineDesc);
                                OvertimeChargeSL.Validate(TBMSDescription, LineDesc);

                                if contractRec.DiscPer > 0 then begin
                                    if contractRec.DiscType = contractRec.DiscType::"Gross On All Charges" then begin
                                        OvertimeChargeSL.Validate("Line Discount %", contractRec.DiscPer);
                                    end
                                end;

                                TotalOverTimeCharges += fixRate;
                                if tariffRec.FSType = tariffRec.FSType::"All Charges" then begin
                                    if OvertimeChargeSL.Insert(true)
                                     then
                                        ;
                                end;
                            end;

                        end;

                    end;
                //</overtimeRate>
                until logDetRec.Next() = 0;
            end;

            // SET DISCOUNT ON HEADER
            if contractRec.DiscPer > 0 then begin
                if contractRec.DiscType = contractRec.DiscType::"Gross On All Charges" then begin
                    TotalDiscountAmount := 0 - (contractRec.DiscPer * (TotalOverTimeCharges + TotalBaseCharges));
                    LineDesc := 'Discount of ' + Format(contractRec.DiscPer * 100) + '% on total of $' + Format(TotalOverTimeCharges + TotalBaseCharges) + '';
                end
                else
                    if contractRec.DiscType = contractRec.DiscType::"Gross On Base Charges" then begin
                        TotalDiscountAmount := 0 - (contractRec.DiscPer * TotalBaseCharges);
                        LineDesc := 'Discount of ' + Format(contractRec.DiscPer * 100) + '% on total of $' + Format(TotalBaseCharges) + '';
                    end;

                SalesHeader.Reset();
                if SalesHeader.Get(SalesHeader."Document Type"::Order, SalesOrderNo) then begin
                    SalesHeader.Validate("TBMS Discount Description", LineDesc);

                    SalesHeader.Modify(true);
                end;
            end;


            // set Confidental Discount

            if SalesHeader.Get(SalesHeader."Document Type"::Order, SalesOrderNo) then begin

                SalesHeader.CalcFields(Amount);
                SalesHeaderAmount := SalesHeader.Amount;
                //Message('Sales Header NO : %1 and amount %2', SalesOrderNo, SalesHeaderAmount);
                ConAgent.SetFilter(IsConfidential, format(True));
                Conagent.SetFilter(ConNumber, format(contractRec.ConNumber));
                if ConAgent.FindFirst() then begin
                    repeat

                        SalesLine."Document No." := SalesOrderNo;
                        SalesLine.Init();
                        lineNo := lineNo + 100;
                        SalesLine.Validate("Line No.", lineNo);
                        SalesLine.Validate("Document Type", SalesLine."Document Type"::Order);
                        SalesLine.Validate("Type", SalesLine.Type::"G/L Account");
                        SalesLine.Validate("No.", Format(RevAccount));
                        SalesLine.Validate("Quantity", 1);
                        SalesLine.Validate(TBMSIsFieldConfidentalLine, true);
                        SalesLine.Validate("Unit Price", 0 - (ConAgent.DiscPer * SalesHeaderAmount));
                        SalesLine.Validate("Line Amount", 0 - (ConAgent.DiscPer * SalesHeaderAmount));

                        SalesLine.Validate(Description, 'Confidental Discount');
                        SalesLine.Validate(TBMSDescription, 'Confidental Discount');
                        SalesLine.Validate(TBMSDescription2);
                        if contractRec.DiscPer > 0 then begin
                            if (contractRec.DiscType = contractRec.DiscType::"Gross On All Charges") OR (contractRec.DiscType = contractRec.DiscType::"Gross On Base Charges") then begin
                                SalesLine.Validate("Line Discount %", contractRec.DiscPer * 100);
                            end
                        end;

                        TotalBaseCharges += fixRate;

                        SalesLine.Insert(true);

                    until ConAgent.Next() = 0
                end;

            End;




        end;
    end;

}