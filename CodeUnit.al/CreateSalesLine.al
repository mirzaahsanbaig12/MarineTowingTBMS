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
        HourlyJobDuration: Duration;
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
        tempStartDateTime: DateTime;
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
        PriceFormatStr: Text;
        RateFormatStr: Text;
        TempDate: date;
        isWeekend: Boolean;
        isHoliday: Boolean;
        tempTime: Time;
        OvertimeDuration: Duration;
        isOverTimeHour: Boolean;
        overtimeCharges: Decimal;
    begin
        TotalOverTimeCharges := 0;
        TotalBaseCharges := 0;
        TotalDiscountAmount := 0;
        PriceFormatStr := '<Integer Thousand><Decimals,3>';
        RateFormatStr := '<Integer Thousand><Decimals>';
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
                Error('Contract is not defined on log # %1', logDocRec.LogDocNumber);
                exit;
            end;

            // if contract is define on log 
            if logDocRec.ConNumber <> 0 then begin

                contractRec.SetFilter(ConNumber, format(logDocRec.ConNumber));

                if contractRec.FindFirst() then begin

                    //check contract have fixed rate set then assign fix rate    
                    //IGNORE FIX RATE FOR HOURLY TYPE
                    if (logDocRec.JobType <> logDocRec.JobType::Hourly) AND (contractRec.AssistFixedRate) then begin
                        if (logDocRec.JobType = logDocRec.JobType::Docking) OR (logDocRec.JobType = logDocRec.JobType::Undocking) then
                            fixRate := contractRec.Rate;

                        if logDocRec.JobType = logDocRec.JobType::Shifting then
                            fixRate := contractRec.AssistRate;

                        if fixRate = 0 then begin
                            Error('Fix rate on contract# %1 is zero', contractRec.ConNumber);
                        end;
                        IsFixedRate := true;
                    end;

                    SetTariff(tariffRec, contractRec, CompanyRec);

                    /*Message('tariffRec.BRInc %1 ,tariffRec.JobShiftAmount %2, tariffRec.BRAmt %3, tariffRec.JobShiftTime %4, tariffRec.JobStandardTime %5 , tariffRec.OTRateAmount %6 ,tariffRec.FSPrcBase %7 ,tariffRec.FSPrcInc %8', tariffRec.BRInc,
                    tariffRec.JobShiftAmount,
                    tariffRec.BRAmt,
                    tariffRec.JobShiftTime,
                    tariffRec.JobStandardTime,
                    tariffRec.OTRateAmount,
                    tariffRec.FSPrcBase,
                    tariffRec.FSPrcInc);
                    */




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

                            //GET LOCATIONS BASED ON JOB TYPE
                            case logDocRec.JobType of
                                logDocRec.JobType::Shifting:
                                    begin
                                        LocEnd.Get(logDetRec.DestinationStr);
                                        locStart.Get(logDetRec.LocStr);
                                    end;
                                logDocRec.JobType::Docking:
                                    LocEnd.Get(logDetRec.DestinationStr);
                                logDocRec.JobType::Undocking:
                                    locStart.Get(logDetRec.LocStr);
                            end;

                            // LocEnd.Get(logDetRec.DestinationStr);
                            // locStart.Get(logDetRec.LocStr);

                            //ahsan changes start

                            if tariffRec.TarId <> ''
                            then begin

                                baseRateRec.Reset();
                                baseRateRec.SetFilter(TarId, tariffRec.TarId);
                                baseRateRec.SetCurrentKey(TonnageEnd);
                                baseRateRec.SetAscending(TonnageEnd, true);
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

                                            //COMMENTING FOR AMOUNT TYPE ONLY PERCENT WILL BE USED
                                            // if tariffRec.JobShiftType = tariffRec.JobShiftType::Amount then begin
                                            //     if logDocRec.Tonnage > 30000 then begin

                                            //         TonnageDiff := logDocRec.Tonnage - 30000;
                                            //         TonnageDiff := Round(TonnageDiff / tariffRec.BRInc, 1, '=');
                                            //         fixRate := baseRateRec.Rate + tariffRec.JobShiftAmount + (TonnageDiff * tariffRec.BRAmt);
                                            //     end
                                            //     else
                                            //         fixRate := baseRateRec.Rate + tariffRec.JobShiftAmount;
                                            // end;

                                            if logDocRec.Tonnage > 30000 then begin
                                                TonnageDiff := logDocRec.Tonnage - 30000;
                                                TonnageDiff := Round(TonnageDiff / tariffRec.BRInc, 1, '=');
                                                fixRate := baseRateRec.Rate + (baseRateRec.Rate * (tariffRec.JobShiftAmount / 100));
                                                fixRate := fixRate + (TonnageDiff * tariffRec.BRAmt);
                                            end
                                            else begin
                                                fixRate := baseRateRec.Rate + (baseRateRec.Rate * (tariffRec.JobShiftAmount / 100));
                                                //fixRate := fixRate + baseRateRec.Rate;
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
                                end;
                            end;


                            //

                            //ahsan changed end
                            if logDocRec.JobType = logDocRec.JobType::Docking
                            then begin
                                LineDesc := /*format(logDocRec.VesId) + */' Vessel Docking AT ' + LocEnd.Description + ' ' + format(DT2Time(logDetRec.TimeStart)) + ' - ' + format(DT2Time(logDetRec.Timefinish)) + ' ' + tugBoatRec.Name + ' @ $' + format(fixRate, 0, PriceFormatStr);
                                lineDesc1 :=/* format(logDocRec.VesId) + */' Vessel Docking AT ' + LocEnd.Description;
                                lineDesc2 := format(DT2Time(logDetRec.TimeStart)) + ' - ' + format(DT2Time(logDetRec.Timefinish)) + ' ' + tugBoatRec.Name + ' @ $' + format(fixRate, 0, PriceFormatStr);
                            end;

                            if logDocRec.JobType = logDocRec.JobType::Undocking
                               then begin
                                LineDesc := /*format(logDocRec.VesId) + */' Vessel Undocking AT ' + locStart.Description + ' ' + format(DT2Time(logDetRec.TimeStart)) + ' - ' + format(DT2Time(logDetRec.Timefinish)) + ' ' + tugBoatRec.Name + ' @ $' + format(fixRate, 0, PriceFormatStr);
                                lineDesc1 := /*format(logDocRec.VesId) + */' Vessel Undocking AT ' + locStart.Description;
                                lineDesc2 := format(DT2Time(logDetRec.TimeStart)) + ' - ' + format(DT2Time(logDetRec.Timefinish)) + ' ' + tugBoatRec.Name + ' @ $' + format(fixRate, 0, PriceFormatStr);
                            end;

                            if logDocRec.JobType = logDocRec.JobType::Shifting
                            then begin
                                if DT2Date(logDetRec.TimeStart) = DT2Date(logDetRec.Timefinish) then begin
                                    LineDesc := /*format(logDocRec.VesId) +*/ 'Shifted Vessel  From ' + locStart.Description + ' To ' + LocEnd.Description + ' ' + format(DT2Time(logDetRec.TimeStart)) + ' - ' + format(DT2Time(logDetRec.Timefinish)) + ' ' + tugBoatRec.Name + ' @ $' + format(fixRate, 0, PriceFormatStr);
                                    lineDesc1 := /*format(logDocRec.VesId) +*/ 'Shifted Vessel  From ' + locStart.Description + ' To ' + LocEnd.Description;
                                    lineDesc2 := format(DT2Time(logDetRec.TimeStart)) + ' - ' + format(DT2Time(logDetRec.Timefinish)) + ' ' + tugBoatRec.Name + ' @ $' + format(fixRate, 0, PriceFormatStr);
                                end;
                                if DT2Date(logDetRec.TimeStart) <> DT2Date(logDetRec.Timefinish) then begin
                                    LineDesc := /*format(logDocRec.VesId) + */' Shifted Vessel  From ' + locStart.Description + ' To ' + LocEnd.Description + ' ' + format(logDetRec.TimeStart) + ' - ' + Format(logDetRec.Timefinish) + ' ' + tugBoatRec.Name + ' @ $' + format(fixRate, 0, PriceFormatStr);
                                    lineDesc1 := /*format(logDocRec.VesId) + */' Shifted Vessel  From ' + locStart.Description + ' To ' + LocEnd.Description;
                                    lineDesc2 := format(logDetRec.TimeStart) + ' - ' + Format(logDetRec.Timefinish) + ' @ $' + format(fixRate, 0, PriceFormatStr);
                                end;
                            end;

                            if logDocRec.JobType = logDocRec.JobType::Hourly
                            then begin
                                //in minutes calculation
                                HourlyJobDuration := logDetRec.Timefinish - logDetRec.TimeStart;
                                HourlyJobDuration := HourlyJobDuration / 60000;
                                hours := logDetRec.Timefinish - logDetRec.TimeStart;
                                //hours := Round(hours / 60000, 1.00, '>');

                                if HourlyJobDuration <= 60 then
                                    //If less then 1 hour, bill for 1 hour
                                    fixRate := tugBoatRec.HourlyRate
                                else begin
                                    //Bill in 5 mins increments
                                    fixRate := Round((HourlyJobDuration / 5), 1, '>') * (Round(tugBoatRec.HourlyRate / 12, 0.01, '>'));
                                end;

                                //fixRate := Round(fixRate, 1, '=') * tugBoatRec.HourlyRate;

                                // LineDesc := tugBoatRec.Name;//+ ' \ vessel ' + logDocRec.VesId + ' \';
                                // LineDesc := LineDesc + ' Leave doc at' + format(DT2Time(logDetRec.TimeStart)) + ' ' + locStart.Description;
                                // LineDesc := LineDesc + ' Arrive doc at ' + format(DT2Time(logDetRec.Timefinish)) + ' ' + LocEnd.Description;
                                // LineDesc := LineDesc + ' 5 @ ' + Format(tugBoatRec.HourlyRate, 0, RateFormatStr);

                                // LineDesc1 := tugBoatRec.Name;//+ ' \ vessel ' + logDocRec.VesId + ' \';
                                // LineDesc1 := LineDesc1 + ' Leave doc at' + format(DT2Time(logDetRec.TimeStart)) + ' ' + locStart.Description;

                                // LineDesc2 := ' Arrive doc at ' + format(DT2Time(logDetRec.Timefinish)) + ' ' + LocEnd.Description;
                                // LineDesc2 := LineDesc2 + ' 5 @ ' + Format(tugBoatRec.HourlyRate, 0, RateFormatStr);

                                LineDesc := tugBoatRec.Name + ' ' + Format(hours) + ' @ $' + format(tugBoatRec.HourlyRate, 0, PriceFormatStr);
                                lineDesc1 := LineDesc;
                            end;

                            SalesLine."Document No." := SalesOrderNo;
                            SalesLine.Init();
                            lineNo := lineNo + 100;
                            SalesLine.Validate("Line No.", lineNo);
                            SalesLine.Validate("Document Type", SalesLine."Document Type"::Order);
                            SalesLine.Validate("Type", SalesLine.Type::"G/L Account");
                            if tugBoatRec.AcctRev <> '' then
                                SalesLine.Validate("No.", Format(tugBoatRec.AcctRev))
                            else
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
                            SalesLine.Validate(ChargeType, Format(logDocRec.JobType));
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
                                    if tariffRec.TarId <> '' then begin
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
                                                RepositionChargeSL.Validate(ChargeType, 'Reposition');
                                                RepositionChargeSL.Validate("Unit Price", PortZoneRec.FlatRate);
                                                RepositionChargeSL.Validate("Line Amount", PortZoneRec.FlatRate);
                                                RepositionChargeSL.Validate("Shortcut Dimension 1 Code", tugBoatRec.AccountCC);
                                                LineDesc := 'Repositioning Charge for ' + tugBoatRec.Name;
                                                RepositionChargeSL.Validate(TBMSlongDesc, LineDesc);
                                                RepositionChargeSL.Validate(TBMSDescription, LineDesc);
                                                RepositionChargeSL.Validate(LogDocNumber, logDocRec.LogDocNumber);
                                                RepositionChargeSL.Validate(LogDate, DT2Date(logDocRec.Datelog));
                                                if contractRec.DiscPer > 0 then begin
                                                    if contractRec.DiscType = contractRec.DiscType::"Gross On All Charges" then begin
                                                        RepositionChargeSL.Validate("Line Discount %", contractRec.DiscPer * 100);
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
                                    //No additional charge for hourly type
                                    if logDocRec.JobType <> logDocRec.JobType::Hourly then begin

                                        if tariffRec.TarId <> '' then begin
                                            if logDocRec.JobType = logDocRec.JobType::Shifting then
                                                StandardJobMins := tariffRec.JobShiftTime
                                            else
                                                StandardJobMins := tariffRec.JobStandardTime;

                                            JobDurationMins := logDetRec.Timefinish - logDetRec.TimeStart;
                                            JobDurationMins := Round(JobDurationMins / 60000, 1, '=');
                                            minsDiff := JobDurationMins - StandardJobMins;

                                            //Additional charge after 10mins of grace period
                                            if (JobDurationMins > StandardJobMins) and ((minsDiff) > 10)
                                            then begin

                                                // Additional charges need to be billed for each 30 mins   
                                                // for each min above 30 mins mark, charges for next 30 mins will be added 
                                                fixRate := Round((minsDiff / 30), 1, '>') * (tugBoatRec.HourlyRate / 2);
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
                                                LineDesc := 'Additional Time Charge for ' + tugBoatRec.name;
                                                AdditionalTimeChargeSL.Validate(ChargeType, 'Additional Time');
                                                AdditionalTimeChargeSL.Validate(TBMSlongDesc, LineDesc);
                                                AdditionalTimeChargeSL.Validate(TBMSDescription, LineDesc);
                                                AdditionalTimeChargeSL.Validate(LogDocNumber, logDocRec.LogDocNumber);
                                                AdditionalTimeChargeSL.Validate(LogDate, DT2Date(logDocRec.Datelog));
                                                if contractRec.DiscPer > 0 then begin
                                                    if contractRec.DiscType = contractRec.DiscType::"Gross On All Charges" then begin
                                                        AdditionalTimeChargeSL.Validate("Line Discount %", contractRec.DiscPer * 100);
                                                    end
                                                end;

                                                TotalOverTimeCharges += fixRate;

                                                if AdditionalTimeChargeSL.Insert(true)
                                                 then
                                                    ;
                                            end;
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
                                    if tariffRec.TarId <> '' then begin

                                        //calculation working dates
                                        //OLD CODE START
                                        // tempStartDate := logDetRec.TimeStart;
                                        // REPEAT
                                        //     IF NOT CalendarMgmt.IsNonworkingDay(DT2DATE(tempStartDate), CustomizedCalendarChange) then begin
                                        //         Duration1 := Duration1 + (CreateDateTime(CalcDate('+1D', DT2Date(tempStartDate)), 000000T) - tempStartDate);
                                        //     end;
                                        //     tempStartDate := CreateDateTime(CALCDATE('+1D', DT2DATE(tempStartDate)), 000000T);

                                        // UNTIL logDetRec.Timefinish < tempStartDate;

                                        // if logDocRec.JobType = logDocRec.JobType::Shifting then
                                        //     StandardJobMins := tariffRec.JobShiftTime
                                        // else
                                        //     StandardJobMins := tariffRec.JobStandardTime;

                                        // //Duration1 := logDetRec.Timefinish - logDetRec.TimeStart;
                                        // minsDiff := Round(Duration1 / 60000, 1, '=');
                                        //OLD CODE END

                                        baseCalendar.Reset();
                                        CustomizedCalendarChange.Reset();
                                        CompInfo.Get();
                                        baseCalendar.SetRange(Code, CompInfo."Base Calendar Code");
                                        if baseCalendar.FindFirst() then begin
                                            CalendarMgmt.SetSource(baseCalendar, CustomizedCalendarChange);
                                        end;

                                        tempStartDateTime := logDetRec.TimeStart;

                                        REPEAT
                                            //CHECK IF HOLIDAY
                                            tempTime := DT2Time(tempStartDateTime);
                                            IF CalendarMgmt.IsNonworkingDay(DT2DATE(tempStartDateTime), CustomizedCalendarChange) then begin
                                                //CHECK IF DAY IS SATURDAY OR SUNDAY (6 OR 7)
                                                if (DATE2DWY(DT2Date(tempStartDateTime), 1) = 6) OR (DATE2DWY(DT2Date(tempStartDateTime), 1) = 7) then begin
                                                    //CHECK IF IT IS A HOLIDAY ON SATURDAY OR SUNDAY
                                                    if CustomizedCalendarChange.Description.ToLower().Contains('holiday') then
                                                        isHoliday := true
                                                    else
                                                        isWeekend := true;
                                                end
                                                else begin
                                                    isHoliday := true;
                                                end;
                                                //ADD 1 hour in overtime duration
                                                OvertimeDuration += 3600000;
                                            end
                                            else begin
                                                //CHECK FOR NON WORKING HOURS ON WORKING DAY
                                                if NOT ((tempTime >= 080000T) AND (tempTime <= 170000T)) then begin //IF NOT WORKING HOURS
                                                    isOverTimeHour := true;
                                                    //ADD 1 hour in overtime duration
                                                    OvertimeDuration += 3600000;
                                                end;
                                            end;
                                            //ADD 1 Hour and continue loop till end datetime
                                            //ADD 1 day if time is 2300 hours (11 PM)
                                            if tempTime = 230000T then
                                                tempStartDateTime := CreateDateTime(CalcDate('+1D', DT2Date(tempStartDateTime)), 000000T)
                                            else
                                                tempStartDateTime := CreateDateTime(DT2DATE(tempStartDateTime), tempTime + 3600000);
                                        UNTIL logDetRec.Timefinish <= tempStartDateTime;


                                        if OvertimeDuration > 0
                                        then begin
                                            if isHoliday then
                                                LineDesc := 'Holiday Overtime Charge'
                                            else
                                                if isWeekend then
                                                    LineDesc := 'Weekend Overtime Charge'
                                                else
                                                    if isOverTimeHour then
                                                        LineDesc := 'Overtime Charge';

                                            //fixRate := (minsDiff / 60) * tugBoatRec.HourlyRate;
                                            //fixRate := SalesLineCharges * (tariffRec.OTRateAmount / 100);

                                            if logDocRec.JobType = logDocRec.JobType::Hourly then begin
                                                overtimeCharges := ((OvertimeDuration / 3600000) * tugBoatRec.HourlyRate) * (tariffRec.OTRateAmount / 100)
                                            end
                                            else
                                                overtimeCharges := baseRateRec.Rate * (tariffRec.OTRateAmount / 100);

                                            OvertimeChargeSL."Document No." := SalesOrderNo;
                                            OvertimeChargeSL.Init();
                                            lineNo := lineNo + 100;
                                            OvertimeChargeSL.Validate("Line No.", lineNo);
                                            OvertimeChargeSL.Validate("Document Type", SalesLine."Document Type"::Order);
                                            OvertimeChargeSL.Validate("Type", SalesLine.Type::"G/L Account");
                                            OvertimeChargeSL.Validate("No.", Format(RevAccount));
                                            OvertimeChargeSL.Validate("Quantity", 1);

                                            OvertimeChargeSL.Validate("Unit Price", overtimeCharges);
                                            OvertimeChargeSL.Validate("Line Amount", overtimeCharges);
                                            OvertimeChargeSL.Validate("Shortcut Dimension 1 Code", tugBoatRec.AccountCC);
                                            //LineDesc := 'Over Time Charge for ' + tugBoatRec.Name;
                                            //OvertimeChargeSL.Validate(Description, LineDesc);
                                            OvertimeChargeSL.Validate(ChargeType, 'Overtime');
                                            OvertimeChargeSL.Validate(TBMSlongDesc, LineDesc);
                                            OvertimeChargeSL.Validate(TBMSDescription, LineDesc);
                                            OvertimeChargeSL.Validate(LogDocNumber, logDocRec.LogDocNumber);
                                            OvertimeChargeSL.Validate(LogDate, DT2Date(logDocRec.Datelog));
                                            if contractRec.DiscPer > 0 then begin
                                                if contractRec.DiscType = contractRec.DiscType::"Gross On All Charges" then begin
                                                    OvertimeChargeSL.Validate("Line Discount %", contractRec.DiscPer * 100);
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

                                        //fuel surcharge calcautions  
                                        FuelSurchargePercent := (logDocRec.FuelCost - tariffRec.FSPrcBase) DIV tariffRec.FSPrcInc;
                                        FuelSurchargeAmount := (FuelSurchargePercent / 100) * SalesLineCharges;
                                        FuelSurchargeAmount := ROUND(FuelSurchargeAmount, 0.01, '>');

                                        LogFuelRate := logDocRec.FuelCost;

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
                                        FuelSurchargesSL.Validate(ChargeType, 'Fuel Surcharge');
                                        FuelSurchargeDesc := 'Fuel Surcharge ' + tugBoatRec.name + ' ' + Format(FuelSurchargePercent, 0, PriceFormatStr) + '% on $';
                                        if (logDocRec.JobType = logDocRec.JobType::Hourly) then
                                            FuelSurchargeDesc += Format(SalesLineCharges, 0, PriceFormatStr)
                                        else
                                            FuelSurchargeDesc += Format(baseRateRec.Rate, 0, PriceFormatStr);

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
                        LineDesc := 'Discount of ' + Format(contractRec.DiscPer * 100, 0, '<Integer><Decimals,3>') + '% on total of $' + Format(TotalOverTimeCharges + TotalBaseCharges, 0, '<Integer><Decimals>') + '';
                    end
                    else
                        if contractRec.DiscType = contractRec.DiscType::"Gross On Base Charges" then begin
                            TotalDiscountAmount := 0 - (contractRec.DiscPer * TotalBaseCharges);
                            LineDesc := 'Discount of ' + Format(contractRec.DiscPer * 100, 0, '<Integer><Decimals,3>') + '% on total of $' + Format(TotalBaseCharges, 0, '<Integer><Decimals>') + '';
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

    local procedure SetTariff(VAR tariffRec: Record Tariff; ContractRec: Record Contract; CompanyRec: Record "Company Register")
    var
        NullNumberValue: Decimal;
        CompanyTariff: Record Tariff;
        CustomerTariff: Record Tariff;
    begin
        NullNumberValue := -1;
        //GET COMPANY TARIFF
        CompanyTariff.Get(CompanyRec.TarId);

        // GET CUSTOMER TARIFF
        if ContractRec.TarCustomer <> '' then
            CustomerTariff.Get(contractRec.TarCustomer);

        //IF CUSTOMER TARIFF IS NULL, SET COMPANY TARIFF
        if ContractRec.TarCustomer = '' then
            tariffRec := CompanyTariff
        else
            //IF CUSTOMER TARIFF IS DEFINED 
            if ContractRec.TarCustomer <> '' then begin
                //IS DELTA BILLING IS FALSE, USE CUSTOMER TARIFF
                if ContractRec.DeltaBilling = false then begin
                    tariffRec := CustomerTariff
                end
                else begin
                    //ELSE SET VALUES USING DELTA BILLING
                    tariffRec := CompanyTariff;
                    if CustomerTariff.BRInc <> NullNumberValue then
                        tariffRec.BRInc := CustomerTariff.BRInc;

                    if CustomerTariff.BRAmt <> NullNumberValue then
                        tariffRec.BRAmt := CustomerTariff.BRAmt;

                    if CustomerTariff.JobShiftAmount <> NullNumberValue then
                        tariffRec.JobShiftAmount := CustomerTariff.JobShiftAmount;

                    if CustomerTariff.JobShiftTime <> NullNumberValue then
                        tariffRec.JobShiftTime := CustomerTariff.JobShiftTime;

                    if CustomerTariff.JobStandardTime <> NullNumberValue then
                        tariffRec.JobStandardTime := CustomerTariff.JobStandardTime;

                    if CustomerTariff.OTRateAmount <> NullNumberValue then
                        tariffRec.OTRateAmount := CustomerTariff.OTRateAmount;

                    if CustomerTariff.FSPrcBase <> NullNumberValue then
                        tariffRec.FSPrcBase := CustomerTariff.FSPrcBase;

                    if CustomerTariff.FSPrcInc <> NullNumberValue then
                        tariffRec.FSPrcInc := CustomerTariff.FSPrcInc;
                end;
            end;
    end;
}