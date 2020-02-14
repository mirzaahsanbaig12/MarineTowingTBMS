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
}
