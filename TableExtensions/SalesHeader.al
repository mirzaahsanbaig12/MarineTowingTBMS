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
    }

    var
        myInt: Integer;
}