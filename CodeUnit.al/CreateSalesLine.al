codeunit 50115 CreateSalesLines
{
    procedure CreateSalesLines(_LogDocNumber: Integer; SalesOrderNo: Code[50])
    var
        baseRateAmount: Decimal;
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        RepositionChargeSL: Record "Sales Line";
        OvertimeChargeSL: Record "Sales Line";
        FuelSurchargesSL: Record "Sales Line";
        AdditionalTimeChargeSL: Record "Sales Line";
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
        locStart: Record "Location Register";
        LocEnd: Record "Location Register";
        PortZoneRec: Record "Port Zone";
        StandardJobMins: Integer;
        Duration1: Duration;
        minsDiff: Decimal;
        JobDurationMins: Decimal;
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
        VesselRec: Record Vessel;
        FuelSurchargeAmount: Decimal;
        FuelSurchargePercent: Decimal;
        LogFuelRate: Decimal;
        FuelSurchargeDesc: Text;
        IsFixedRate: Boolean;
        PortZoneId: Code[5];
        SalesLineCharges: Decimal;
    begin
        TotalOverTimeCharges := 0;
        TotalBaseCharges := 0;
        TotalDiscountAmount := 0;


        logDocRec.SetFilter(LogDocNumber, format(_LogDocNumber));

        if logDocRec.FindFirst() then begin

            fixRate := 0;
            IsFixedRate := false;
            RevAccount := '40100';
            customerAcc := logDocRec.BusOwner;


            //find company and set rev account
            if logDocRec.CmpId <> '' then begin
                CompanyRec.SetFilter(CmpId, logDocRec.CmpId);
                if CompanyRec.FindFirst() then begin
                    RevAccount := CompanyRec.AcctRev;
                end;
            end;

            if logDocRec.ConNumber = 0 then begin
                Message('Contract is not defined on log # %1', logDocRec.LogDocNumber);
                exit;
            end;

            // if contract is define on log 
            if logDocRec.ConNumber <> 0 then begin

                contractRec.SetFilter(ConNumber, format(logDocRec.ConNumber));

                if contractRec.FindFirst() then begin

                    //check contract have fixed rate set then assign fix rate    
                    if contractRec.AssistFixedRate then begin
                        if (logDocRec.JobType = logDocRec.JobType::Docking) OR (logDocRec.JobType = logDocRec.JobType::Undocking) then
                            fixRate := contractRec.Rate;

                        if logDocRec.JobType = logDocRec.JobType::Shifting then
                            fixRate := contractRec.AssistRate;

                        if fixRate = 0 then begin
                            Message('Fix rate on contract# %1 is zero', contractRec.ConNumber);
                            exit;
                        end;
                        IsFixedRate := true;
                    end;

                    //if customer tarif is not defined on contract then use company tarif
                    if contractRec.TarCustomer = ''
                            then begin
                        tariffRec.SetFilter(TarId, CompanyRec.TarId);
                    end
                    else begin
                        tariffRec.SetFilter(TarId, contractRec.TarCustomer);
                    end;

                    //add customer account base on contract billing option value
                    if contractRec.BillingOptions = contractRec.BillingOptions::Agent then begin
                        customerAcc := logDocRec.BusLA;
                    end
                    else
                        customerAcc := logDocRec.BusOwner;

                    //get salesline no start
                    SalesLine.SetFilter("Document Type", format(SalesLine."Document Type"::Order));
                    SalesLine.SetFilter("Document No.", SalesOrderNo);

                    if SalesLine.FindLast() then begin
                        lineNo := SalesLine."Line No."
                    end
                    else
                        lineNo := 1000;

                    //get salesline no end


                    logDetRec.SetFilter(LogDocNumber, Format(_LogDocNumber));

                    if logDetRec.FindSet() then Begin
                        repeat

                            tugBoatRec.SetFilter(TugId, logDetRec.TugId);
                            tugBoatRec.FindFirst();

                            LocEnd.Get(logDetRec.DestinationStr);
                            locStart.Get(logDetRec.LocStr);

                            //ahsan changes start

                            if tariffRec.FindFirst()
                            then begin

                                baseRateRec.Reset();
                                baseRateRec.SetFilter(TarId, tariffRec.TarId);

                                if logDocRec.Tonnage > 30000 then
                                    baseRateRec.SetFilter(TonnageEnd, format(30000))
                                else
                                    baseRateRec.SetFilter(TonnageEnd, '<=%1', logDocRec.Tonnage);

                                if logDocRec.JobType = logDocRec.JobType::Docking then
                                    baseRateRec.SetFilter(PrtId, LocEnd.PrtId);

                                if logDocRec.JobType = logDocRec.JobType::Undocking then
                                    baseRateRec.SetFilter(PrtId, locStart.PrtId);

                                //calculation for shifting start

                                if IsFixedRate = false then begin
                                    if (logDocRec.JobType = logDocRec.JobType::Shifting) then begin

                                        baseRateRec.SetFilter(PrtId, locStart.PrtId);

                                        if baseRateRec.FindLast() then begin
                                            if tariffRec.JobShiftType = tariffRec.JobShiftType::Amount then begin
                                                if logDocRec.Tonnage > 30000 then begin

                                                    TonnageDiff := logDocRec.Tonnage - 30000;
                                                    TonnageDiff := Round(TonnageDiff / tariffRec.BRInc, 1, '=');
                                                    fixRate := baseRateRec.Rate + tariffRec.JobShiftAmount + (TonnageDiff * tariffRec.BRAmt);
                                                end
                                                else
                                                    fixRate := baseRateRec.Rate + tariffRec.JobShiftAmount;
                                            end;


                                            if tariffRec.JobShiftType = tariffRec.JobShiftType::Percentage then begin
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
                                    end

                                    //calculation for shifting end
                                    //calculation for job type docking and undocking
                                    else begin
                                        if (baseRateRec.FindLast())
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
                                    if baseRateRec.FindLast() then begin
                                        //fuel surcharge calcautions  
                                        FuelSurchargePercent := (logDocRec.FuelCost - tariffRec.FSPrcBase) DIV tariffRec.FSPrcInc;
                                        FuelSurchargeAmount := (FuelSurchargePercent / 100) * baseRateRec.Rate;
                                        FuelSurchargeAmount := ROUND(FuelSurchargeAmount, 0.01, '>');
                                        LogFuelRate := logDocRec.FuelCost;
                                    end;
                                end;
                            end;


                            //

                            //ahsan changed end
                            if logDocRec.JobType = logDocRec.JobType::Docking
                            then begin
                                LineDesc := /*format(logDocRec.VesId) + */' Vessel Docking AT ' + LocEnd.Description + ' ' + format(DT2Time(logDetRec.TimeStart)) + ' - ' + format(DT2Time(logDetRec.Timefinish)) + ' ' + tugBoatRec.Name + ' @ $' + format(fixRate);
                                lineDesc1 :=/* format(logDocRec.VesId) + */' Vessel Docking AT ' + LocEnd.Description;
                                lineDesc2 := format(DT2Time(logDetRec.TimeStart)) + ' - ' + format(DT2Time(logDetRec.Timefinish)) + ' ' + tugBoatRec.Name + ' @ $' + format(fixRate);
                            end;

                            if logDocRec.JobType = logDocRec.JobType::Undocking
                               then begin
                                LineDesc := /*format(logDocRec.VesId) + */' Vessel Undocking AT ' + locStart.Description + ' ' + format(DT2Time(logDetRec.TimeStart)) + ' - ' + format(DT2Time(logDetRec.Timefinish)) + ' ' + tugBoatRec.Name + ' @ $' + format(fixRate);
                                lineDesc1 := /*format(logDocRec.VesId) + */' Vessel Undocking AT ' + locStart.Description;
                                lineDesc2 := format(DT2Time(logDetRec.TimeStart)) + ' - ' + format(DT2Time(logDetRec.Timefinish)) + ' ' + tugBoatRec.Name + ' @ $' + format(fixRate);
                            end;

                            if logDocRec.JobType = logDocRec.JobType::Shifting
                            then begin
                                if DT2Date(logDetRec.TimeStart) = DT2Date(logDetRec.Timefinish) then begin
                                    LineDesc := /*format(logDocRec.VesId) +*/ 'Shifted Vessel  From ' + locStart.Description + ' To ' + LocEnd.Description + ' ' + format(DT2Time(logDetRec.TimeStart)) + ' - ' + format(DT2Time(logDetRec.Timefinish)) + ' ' + tugBoatRec.Name + ' @ $' + format(fixRate);
                                    lineDesc1 := /*format(logDocRec.VesId) +*/ 'Shifted Vessel  From ' + locStart.Description + ' To ' + LocEnd.Description;
                                    lineDesc2 := format(DT2Time(logDetRec.TimeStart)) + ' - ' + format(DT2Time(logDetRec.Timefinish)) + ' ' + tugBoatRec.Name + ' @ $' + format(fixRate);
                                end;
                                if DT2Date(logDetRec.TimeStart) <> DT2Date(logDetRec.Timefinish) then begin
                                    LineDesc := /*format(logDocRec.VesId) + */' Shifted Vessel  From ' + locStart.Description + ' To ' + LocEnd.Description + ' ' + format(logDetRec.TimeStart) + ' - ' + Format(logDetRec.Timefinish) + ' ' + tugBoatRec.Name + ' @ $' + format(fixRate);
                                    lineDesc1 := /*format(logDocRec.VesId) + */' Shifted Vessel  From ' + locStart.Description + ' To ' + LocEnd.Description;
                                    lineDesc2 := format(logDetRec.TimeStart) + ' - ' + Format(logDetRec.Timefinish) + ' @ $' + format(fixRate);
                                end;
                            end;

                            if logDocRec.JobType = logDocRec.JobType::Hourly
                            then begin
                                hours := logDetRec.Timefinish - logDetRec.TimeStart;
                                fixRate := hours / 3600000;
                                fixRate := Round(fixRate, 1, '=') * tugBoatRec.HourlyRate;
                                LineDesc := tugBoatRec.Name;//+ ' \ vessel ' + logDocRec.VesId + ' \';
                                LineDesc := LineDesc + ' Leave doc at' + format(DT2Time(logDetRec.TimeStart)) + ' ' + locStart.Description;
                                LineDesc := LineDesc + ' Arrive doc at ' + format(DT2Time(logDetRec.Timefinish)) + ' ' + LocEnd.Description;
                                LineDesc := LineDesc + ' 5 @ ' + Format(tugBoatRec.HourlyRate);

                                LineDesc1 := tugBoatRec.Name;//+ ' \ vessel ' + logDocRec.VesId + ' \';
                                LineDesc1 := LineDesc1 + ' Leave doc at' + format(DT2Time(logDetRec.TimeStart)) + ' ' + locStart.Description;

                                LineDesc2 := ' Arrive doc at ' + format(DT2Time(logDetRec.Timefinish)) + ' ' + LocEnd.Description;
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
                            SalesLineCharges := fixRate;
                            SalesLine.Validate("Unit Price", fixRate);
                            SalesLine.Validate("Line Amount", fixRate);
                            SalesLine.Validate("Shortcut Dimension 1 Code", tugBoatRec.AccountCC);
                            //SalesLine.Validate(Description, LineDesc);
                            SalesLine.Validate(TBMSlongDesc, LineDesc);
                            SalesLine.Validate(TBMSDescription, lineDesc1);
                            SalesLine.Validate(TBMSDescription2, lineDesc2);
                            SalesLine.Validate(LogDocNumber, logDocRec.LogDocNumber);
                            SalesLine.Validate(LogDate, DT2Date(logDocRec.Datelog));
                            SalesLine.Validate(LogDateString, format(DT2Date(logDocRec.Datelog)));
                            //Message('date %1', DT2Date(logDocRec.Datelog));

                            if contractRec.DiscPer > 0 then begin
                                if (contractRec.DiscType = contractRec.DiscType::"Gross On All Charges") OR (contractRec.DiscType = contractRec.DiscType::"Gross On Base Charges") then begin
                                    SalesLine.Validate("Line Discount %", contractRec.DiscPer * 100);
                                end
                            end;

                            TotalBaseCharges += fixRate;

                            if SalesLine.Insert(true) then begin
                                if IsFixedRate = false then begin
                                    //REOSITION START
                                    if tariffRec.FindFirst() then begin
                                        if logDocRec.JobType = logDocRec.JobType::Docking then
                                            PortZoneId := LocEnd.PrtId;
                                        if logDocRec.JobType = logDocRec.JobType::Undocking then
                                            PortZoneId := locStart.PrtId;
                                        if logDocRec.JobType = logDocRec.JobType::Shifting then
                                            PortZoneId := locStart.PrtId;

                                        if PortZoneRec.Get(PortZoneId) then begin
                                            if PortZoneRec.FlatRate <> 0 then begin
                                                RepositionChargeSL."Document No." := SalesOrderNo;
                                                RepositionChargeSL.Init();
                                                lineNo := lineNo + 100;
                                                RepositionChargeSL.Validate("Line No.", lineNo);
                                                RepositionChargeSL.Validate("Document Type", SalesLine."Document Type"::Order);
                                                RepositionChargeSL.Validate("Type", SalesLine.Type::"G/L Account");
                                                RepositionChargeSL.Validate("No.", Format(RevAccount));
                                                RepositionChargeSL.Validate("Quantity", 1);

                                                RepositionChargeSL.Validate("Unit Price", PortZoneRec.FlatRate);
                                                RepositionChargeSL.Validate("Line Amount", PortZoneRec.FlatRate);
                                                RepositionChargeSL.Validate("Shortcut Dimension 1 Code", tugBoatRec.AccountCC);
                                                LineDesc := 'Repositioning Charge for ' + logDetRec.TugId;
                                                RepositionChargeSL.Validate(TBMSlongDesc, LineDesc);
                                                RepositionChargeSL.Validate(TBMSDescription, LineDesc);
                                                RepositionChargeSL.Validate(LogDocNumber, logDocRec.LogDocNumber);
                                                RepositionChargeSL.Validate(LogDate, DT2Date(logDocRec.Datelog));
                                                if contractRec.DiscPer > 0 then begin
                                                    if contractRec.DiscType = contractRec.DiscType::"Gross On All Charges" then begin
                                                        RepositionChargeSL.Validate("Line Discount %", contractRec.DiscPer);
                                                    end
                                                end;
                                                if RepositionChargeSL.Insert(true)
                                                then
                                                    ;
                                            end;
                                        end;
                                    end;
                                    //REPOSITION END
                                    //ADDITIONAL TIME CHARGE START
                                    if tariffRec.FindFirst() then begin
                                        if logDocRec.JobType = logDocRec.JobType::Shifting then
                                            StandardJobMins := tariffRec.JobShiftTime
                                        else
                                            StandardJobMins := tariffRec.JobStandardTime;

                                        JobDurationMins := logDetRec.Timefinish - logDetRec.TimeStart;
                                        JobDurationMins := Round(JobDurationMins / 60000, 1, '=');
                                        minsDiff := JobDurationMins - StandardJobMins;

                                        if (JobDurationMins > StandardJobMins) and ((minsDiff) >= 15)
                                        then begin

                                            fixRate := (minsDiff / 60) * tugBoatRec.HourlyRate;
                                            AdditionalTimeChargeSL."Document No." := SalesOrderNo;
                                            AdditionalTimeChargeSL.Init();
                                            lineNo := lineNo + 100;
                                            AdditionalTimeChargeSL.Validate("Line No.", lineNo);
                                            AdditionalTimeChargeSL.Validate("Document Type", SalesLine."Document Type"::Order);
                                            AdditionalTimeChargeSL.Validate("Type", SalesLine.Type::"G/L Account");
                                            AdditionalTimeChargeSL.Validate("No.", Format(RevAccount));
                                            AdditionalTimeChargeSL.Validate("Quantity", 1);

                                            AdditionalTimeChargeSL.Validate("Unit Price", fixRate);
                                            AdditionalTimeChargeSL.Validate("Line Amount", fixRate);
                                            AdditionalTimeChargeSL.Validate("Shortcut Dimension 1 Code", tugBoatRec.AccountCC);
                                            LineDesc := 'Additional Time Charge for ' + logDetRec.TugId;
                                            AdditionalTimeChargeSL.Validate(TBMSlongDesc, LineDesc);
                                            AdditionalTimeChargeSL.Validate(TBMSDescription, LineDesc);
                                            AdditionalTimeChargeSL.Validate(LogDocNumber, logDocRec.LogDocNumber);
                                            AdditionalTimeChargeSL.Validate(LogDate, DT2Date(logDocRec.Datelog));
                                            if contractRec.DiscPer > 0 then begin
                                                if contractRec.DiscType = contractRec.DiscType::"Gross On All Charges" then begin
                                                    AdditionalTimeChargeSL.Validate("Line Discount %", contractRec.DiscPer);
                                                end
                                            end;

                                            TotalOverTimeCharges += fixRate;

                                            if AdditionalTimeChargeSL.Insert(true)
                                             then
                                                ;

                                        end;
                                    end;
                                    //ADDITIONAL TIME CHARGE END
                                    //OVERTIME START
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

                                        if logDocRec.JobType = logDocRec.JobType::Shifting then
                                            StandardJobMins := tariffRec.JobShiftTime
                                        else
                                            StandardJobMins := tariffRec.JobStandardTime;

                                        //Duration1 := logDetRec.Timefinish - logDetRec.TimeStart;
                                        minsDiff := Round(Duration1 / 60000, 1, '=');

                                        if (minsDiff > StandardJobMins) and ((minsDiff - StandardJobMins) >= 15)
                                        then begin

                                            //fixRate := (minsDiff / 60) * tugBoatRec.HourlyRate;
                                            fixRate := SalesLineCharges * (tariffRec.OTRateAmount / 100);

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
                                            //OvertimeChargeSL.Validate(Description, LineDesc);
                                            OvertimeChargeSL.Validate(TBMSlongDesc, LineDesc);
                                            OvertimeChargeSL.Validate(TBMSDescription, LineDesc);
                                            OvertimeChargeSL.Validate(LogDocNumber, logDocRec.LogDocNumber);
                                            OvertimeChargeSL.Validate(LogDate, DT2Date(logDocRec.Datelog));
                                            if contractRec.DiscPer > 0 then begin
                                                if contractRec.DiscType = contractRec.DiscType::"Gross On All Charges" then begin
                                                    OvertimeChargeSL.Validate("Line Discount %", contractRec.DiscPer);
                                                end
                                            end;

                                            TotalOverTimeCharges += fixRate;

                                            if OvertimeChargeSL.Insert(true)
                                             then
                                                ;

                                        end;
                                    end;
                                    //OVERTIME END
                                    //FUEL SURCHARGE START
                                    if IsFixedRate = false then begin
                                        FuelSurchargesSL."Document No." := SalesOrderNo;
                                        FuelSurchargesSL.Init();
                                        lineNo := lineNo + 100;
                                        FuelSurchargesSL.Validate("Line No.", lineNo);
                                        FuelSurchargesSL.Validate("Document Type", SalesLine."Document Type"::Order);
                                        FuelSurchargesSL.Validate("Type", SalesLine.Type::"G/L Account");
                                        FuelSurchargesSL.Validate("No.", Format(RevAccount));
                                        FuelSurchargesSL.Validate("Quantity", 1);
                                        FuelSurchargesSL.Validate("Unit Price", FuelSurchargeAmount);
                                        FuelSurchargesSL.Validate("Line Amount", FuelSurchargeAmount);
                                        FuelSurchargeDesc := 'Fuel Surcharge of ' + Format(FuelSurchargePercent) + '% on log rate of ' + Format(LogFuelRate);
                                        FuelSurchargesSL.Validate(TBMSlongDesc, FuelSurchargeDesc);
                                        FuelSurchargesSL.Validate(TBMSDescription, FuelSurchargeDesc);
                                        FuelSurchargesSL.Validate(LogDocNumber, logDocRec.LogDocNumber);
                                        FuelSurchargesSL.Validate(LogDate, DT2Date(logDocRec.Datelog));
                                        FuelSurchargesSL.Insert(true);
                                        //Log document contract <> 0
                                    end;
                                    //FUEL SURCHARGE END
                                end;
                            end;
                        until logDetRec.Next() = 0;
                        //log details lines end
                    end;
                    //contract find end
                end;
                //log doc find end
                logDocRec.Status := logDocRec.Status::SO;
                logDocRec.SalesOrderNo := SalesOrderNo;
                logDocRec.Modify();

                // SET DISCOUNT ON HEADER Start
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
                // SET DISCOUNT ON HEADER end

                // set Confidental Discount start

                /*if SalesHeader.Get(SalesHeader."Document Type"::Order, SalesOrderNo) then begin

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
                            SalesLine.Validate(TBMSlongDesc, 'Confidential Discount');
                            SalesLine.Validate(TBMSDescription, 'Confidential Discount');
                            SalesLine.Validate(TBMSDescription2);
                            SalesLine.Validate(LogDocNumber, logDocRec.LogDocNumber);
                            if contractRec.DiscPer > 0 then begin
                                if (contractRec.DiscType = contractRec.DiscType::"Gross On All Charges") OR (contractRec.DiscType = contractRec.DiscType::"Gross On Base Charges") then begin
                                    SalesLine.Validate("Line Discount %", contractRec.DiscPer * 100);
                                end
                            end;

                            TotalBaseCharges += fixRate;

                            SalesLine.Insert(true);

                        until ConAgent.Next() = 0
                    end;
                end;
                */
                //set Confidental Discount end
            end;
        end;
    end;


}