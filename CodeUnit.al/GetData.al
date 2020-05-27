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
    begin
        if SalesHeader.LogDocNumber <> 0
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

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Correct Posted Sales Invoice", 'OnAfterCreateCorrSalesInvoice', '', true, true)]

    local procedure two(var SalesHeader: Record "Sales Header")
    var
        logdocRec: Record LogDoc;
    begin
        if SalesHeader.LogDocNumber <> 0
        then begin
            logdocRec.SetFilter(LogDocNumber, Format(SalesHeader.LogDocNumber));
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




}





