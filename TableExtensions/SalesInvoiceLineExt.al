tableextension 50115 SalesInvoiceExt extends "Sales Invoice Line"
{
    fields
    {
        // Add changes to table fields here
        field(50110; TBMSDescription; Text[200])
        {
            DataClassification = ToBeClassified;
            Caption = 'Line Description 1';
        }

        field(50111; TBMSDescription2; Text[200])
        {
            DataClassification = ToBeClassified;
            Caption = 'Line Description 2';
        }
    }

    var
        myInt: Integer;
}