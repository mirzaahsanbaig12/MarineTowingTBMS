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

    procedure GetLocationName(_LocId: code[5]): Text[50]
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
        VesselRec: Record Vessel_PK;
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
        exit(0)
    End;

}
