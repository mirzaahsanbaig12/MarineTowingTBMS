codeunit 50111 GetData
{
    procedure GetTugName(_TugId: code[5]): Text[50]
    var
        Name: Text[50];
        TugBoat: Record "Tug Boat";
    begin
        TugBoat.SetFilter(TugId, _TugId);
        if (TugBoat.FindFirst()) then
            exit(TugBoat.Name);
        exit('');
    end;

    procedure GetLocationName(_LocId: code[20]): Text[50]
    var
        Name: Text[50];
        Location: Record "Location Register";
    begin
        Location.SetFilter(LocId, _LocId);
        if (Location.FindFirst()) then
            exit(Location.Description);
        exit('');
    end;


    procedure GetVesselTonnage(_VesId: code[50]): Integer
    var
        VesselRec: Record Vessel;
        Tonnage: Integer;
    begin
        VesselRec.Reset();
        VesselRec.SetFilter(VesId, _VesId);

        if VesselRec.FindFirst() then begin

            Tonnage := VesselRec.Tonnage;
        end
        else begin
            Tonnage := 0;
        end;

        exit(Tonnage);
    end;

    procedure GetFuelCost(): Decimal
    var
        Cost: Decimal;
        FuelCosetRec: Record "Fuel Cost";
        TodayDate: DateTime;
    begin
        TodayDate := CurrentDateTime;
        FuelCosetRec.Reset();
        FuelCosetRec.SetFilter(FuelDate, format(TodayDate));

        FuelCosetRec.SetFilter(FuelDate, '..%1', TodayDate);
        FuelCosetRec.SetAscending(FuelDate, false);
        if FuelCosetRec.FindFirst()
        then
            exit(FuelCosetRec.FuelCost);
        exit(0);
    end;


    procedure GetSingleContractId(Customer: Code[20]): Integer
    var
        contractRec: Record Contract;
    Begin
        contractRec.SetFilter(BusOc, Customer);
        if contractRec.FindSet()
        then
            if contractRec.Count = 1
           then
                exit(contractRec.ConNumber);
        exit(0);
    End;

    procedure CalcworkingDate()
    var
        c1: Codeunit "Calendar Management";
    Begin
        //Message('here');
        //message(format(c1.CalcDateBOC('DD/MM/YYYY', WorkDate(), false, false));


    End;

    [EventSubscriber(ObjectType::Table, Database::"Sales Invoice Line", 'OnAfterInsertEvent', '', true, true)]

    local procedure hello()

    begin
        //Message('hi');
    end;


    [EventSubscriber(ObjectType::Page, Page::"Log Billing", 'OnOpenPageEvent', '', true, true)]

    local procedure MyProcedure(var Rec: Record LogDoc)

    begin
        //Message('page open EventSubscriber %1', rec.LogDocNumber);

    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Sales-Post", 'OnAfterPostInvPostBuffer', '', true, true)]
    local procedure one(var SalesHeader: Record "Sales Header")
    var
        logdocRec: Record LogDoc;
        salesLine: Record "Sales Line";

    begin

        salesLine.SetFilter("Document No.", SalesHeader."No.");
        if salesLine.FindFirst() then begin
            repeat
                if salesLine.LogDocNumber <> 0
                then begin
                    logdocRec.SetFilter(LogDocNumber, Format(salesLine.LogDocNumber));
                    if logdocRec.FindFirst()
                    then begin
                        repeat

                            if logdocRec.Status = logdocRec.Status::Invoiced
                            then begin
                                //logdocRec.Status := logdocRec.Status::Reopen;
                            end;

                            if logdocRec.Status = logdocRec.Status::SO
                            then begin
                                logdocRec.Status := logdocRec.Status::Invoiced;
                                logdocRec.SalesOrderNo := '';
                            end;
                            logdocRec.Modify();
                        until logdocRec.Next() = 0;
                    end;
                end;




            until salesLine.Next() = 0;


        end;


        /*if SalesHeader.LogDocNumber <> 0
        then begin
            logdocRec.SetFilter(LogDocNumber, Format(SalesHeader.LogDocNumber));
            if logdocRec.FindFirst()
            then begin
                repeat

                    if logdocRec.Status = logdocRec.Status::Invoiced
                    then begin
                        //logdocRec.Status := logdocRec.Status::Reopen;
                    end;

                    if logdocRec.Status = logdocRec.Status::SO
                    then begin
                        logdocRec.Status := logdocRec.Status::Invoiced;
                    end;
                    logdocRec.Modify();
                until logdocRec.Next() = 0;
            end;

            

         end;
*/


    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Correct Posted Sales Invoice", 'OnAfterCreateCorrSalesInvoice', '', true, true)]

    local procedure two(var SalesHeader: Record "Sales Header")
    var
        logdocRec: Record LogDoc;
        salesLineRec: Record "Sales Line";

    begin

        salesLineRec.SetFilter("Document No.", SalesHeader."No.");
        if salesLineRec.FindFirst() then begin
            repeat

                if saleslineRec.LogDocNumber <> 0
                then begin
                    logdocRec.SetFilter(LogDocNumber, Format(salesLineRec.LogDocNumber));
                    if logdocRec.FindFirst()
                    then begin
                        repeat
                            if logdocRec.Status = logdocRec.Status::Invoiced
                            then begin
                                logdocRec.Status := logdocRec.Status::Reopen;
                                logdocRec.SalesOrderNo := '';
                            end;
                            logdocRec.Modify();
                        until logdocRec.Next() = 0;
                    end;

                end;
            until salesLineRec.Next() = 0;
        end;


    end;

    [EventSubscriber(ObjectType::Page, Page::"Ord Loc SubForm", 'OnModifyRecordEvent', '', true, true)]

    local procedure MyProcedure123(var Rec: Record OrdLoc)

    begin
        //rec.updateLocationOnOrdoc(rec.LocId, rec.ORDocNumber);
    end;



    [EventSubscriber(ObjectType::Page, Page::"Ord Loc SubForm", 'OnAfterGetRecordEvent', '', true, true)]

    local procedure MyProcedure124(var Rec: Record OrdLoc)
    begin
        //rec.updateLocationOnOrdoc(rec.LocId, rec.ORDocNumber);

    end;

    local procedure GetOverTimeHours(startDT: DateTime; endDT: DateTime): Duration
    var
        CompInfo: Record "Company Information";
        CustomizedCalendarChange: Record "Customized Calendar Change";
        CalendarMgmt: Codeunit "Calendar Management";
        baseCalendar: Record "Base Calendar";
        tempStartDateTime: DateTime;
        OvertimeDuration: Duration;
        tempTime: Time;
        isOverTimeHour: Boolean;
        isHoliday: Boolean;
        isWeekend: Boolean;
    begin
        baseCalendar.Reset();
        CustomizedCalendarChange.Reset();
        CompInfo.Get();
        baseCalendar.SetRange(Code, CompInfo."Base Calendar Code");
        if baseCalendar.FindFirst() then begin
            CalendarMgmt.SetSource(baseCalendar, CustomizedCalendarChange);
        end;

        tempStartDateTime := startDT;
        REPEAT
            //CHECK IF HOLIDAY
            tempTime := DT2Time(tempStartDateTime);
            IF CalendarMgmt.IsNonworkingDay(DT2DATE(tempStartDateTime), CustomizedCalendarChange) then begin
                //CHECK IF DAY IS SATURDAY OR SUNDAY (6 OR 7)
                if (DATE2DWY(DT2Date(tempStartDateTime), 1) = 6) OR (DATE2DWY(DT2Date(tempStartDateTime), 1) = 7) then begin
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
            if tempTime = 230000T then
                tempStartDateTime := CreateDateTime(CalcDate('+1D', DT2Date(tempStartDateTime)), 000000T)
            else
                tempStartDateTime := CreateDateTime(DT2DATE(tempStartDateTime), tempTime + 3600000);
        UNTIL endDT < tempStartDateTime;
        exit(OvertimeDuration);
    end;


    procedure TBMSSalesConfDiscountReport(_SalesOrderNo: code[20])
    var
        SalesHeader: Record "Sales Header";
    begin
        SalesHeader.SetRange("No.", _SalesOrderNo);
        Report.RunModal(Report::"TBMS Sales Conf Dsicount", true, true, SalesHeader);

    end;

    procedure TBMSSalesInvoiceDiscountReport(_salesInvoiceNo: code[20])
    var
        SalesInvoice: Record "Sales Invoice Header";
    begin
        SalesInvoice.SetRange("No.", _salesInvoiceNo);
        Report.RunModal(Report::"TBMS Sales Discount Invoice", true, true, SalesInvoice);

    end;
}





