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


    procedure GetVesselTonnage(_VesId: code[20]): Integer
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


}
