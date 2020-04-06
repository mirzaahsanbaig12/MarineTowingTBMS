tableextension 50112 SalesLineExt extends "Sales Line"
{
    fields
    {
        // Add changes to table fields here
        field(50110; TBMSDescription; Text[200])
        {
            DataClassification = ToBeClassified;
            Caption = 'Line Description';
        }
    }

    var
        myInt: Integer;
}