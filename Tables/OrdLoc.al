table 50128 OrdLoc
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50110; LineNumber; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }

        field(50111; DBId; code[5])
        {
            DataClassification = ToBeClassified;
            Caption = 'Database Id';
        }

        field(50112; LocId; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Location Register".LocId;
            Caption = 'Location';
        }
        field(50113; PositionType; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Position Type';
        }

        field(50114; LocDetNumber; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Location Det Number';
        }

        field(50115; ORDocNumber; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Document Number';
        }

        field(50116; LocationName; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Name';
            Editable = false;
        }

        field(50117; firstRec; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'First Line Check';
        }


    }

    keys
    {
        key(PK; LineNumber)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    var
        ordlocRec: Record OrdLoc;

    begin
        ordlocRec.SetFilter(ORDocNumber, format(ORDocNumber));

        if ordlocRec.FindFirst()
        then begin
            firstRec := false;
            updateLocationOnOrdoc(LocId, ORDocNumber, firstRec);

        end
        else begin
            firstRec := true;
            updateLocationOnOrdoc(LocId, ORDocNumber, firstRec);
        end;
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

    procedure updateLocationOnOrdoc(_locId: code[20]; _ORDocNumber: Integer; _firstRec: Boolean)
    var
        ordlocRec: Record OrdLoc;
        ordDocRec: Record OrdDoc;
        LocationRec: Record "Location Register";
    begin

        ordlocRec.SetFilter(ORDocNumber, format(_ORDocNumber));

        ordDocRec.SetFilter(ORDocNumber, format(_ORDocNumber));

        if ordDocRec.FindFirst()
            then begin

            //Message('schedular no %1', ordDocRec.ORDocNumber);
            if (ordlocRec.FindFirst()) and (_firstRec = false)
            then begin
                ordDocRec.LocId := ordlocRec.LocId;
                LocationRec.SetFilter(LocId, ordlocRec.LocId);
                LocationRec.FindFirst();
                ordDocRec.PrtId := LocationRec.PrtId;
                ordDocRec.Modify();
            end
            else begin
                ordDocRec.LocId := _LocId;
                LocationRec.SetFilter(LocId, _LocId);
                LocationRec.FindFirst();
                ordDocRec.PrtId := LocationRec.PrtId;
                ordDocRec.Modify();

            end;

            ;
        end;


        /*if ordlocRec.FindFirst()
        then begin
            ordlocRec.SetFilter(ORDocNumber, format(_ORDocNumber));

            if ordlocRec.FindFirst()
            then begin
                ordlocRec.LocId := LocId;
                ordlocRec.Modify();
            end;
        end;
        */

    end;




}