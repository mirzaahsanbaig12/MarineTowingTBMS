table 50131 "Fuel Cost"
{
    DataClassification = ToBeClassified;
    Caption = 'Fuel Cost';
    LookupPageId = "Fuel Cost Card";

    fields
    {
        field(50110; FuelDate; DateTime)
        {
            DataClassification = ToBeClassified;
            Caption = 'Fuel Date';
        }

        field(50111; FuelCost; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Fuel Cost';
            DecimalPlaces = 0 : 5;
        }
    }

    keys
    {
        key(PK; FuelDate)
        {
            Clustered = true;
        }


    }
    fieldgroups
    {
        fieldgroup(DropDown; FuelDate, FuelCost)
        {

        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

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

    procedure LookupFuelCost(var FuelCostRec: Record "Fuel Cost"): Boolean
    var
        FuelCostList: Page "Fuel Cost List";
        Result: Boolean;
    begin
        FuelCostList.SetTableView(FuelCostRec);
        FuelCostList.SetRecord(FuelCostRec);
        FuelCostList.LookupMode := true;
        Result := FuelCostList.RunModal = ACTION::LookupOK;
        if Result then
            FuelCostList.GetRecord(FuelCostRec)
        else
            Clear(FuelCostRec);

        exit(Result);
    end;

}