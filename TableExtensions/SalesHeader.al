tableextension 50113 SalesHeaderExt extends "Sales Header"
{
    fields
    {
        // Add changes to table fields here
        field(50110; LogDocNumber; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Number';
            Editable = false;
        }

        field(50111; Vessel; code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Vessel';
            Editable = false;
        }
    }

    var
        myInt: Integer;
}