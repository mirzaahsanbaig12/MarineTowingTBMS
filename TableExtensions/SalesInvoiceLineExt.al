tableextension 50115 SalesInvoiceExtTBMS extends "Sales Invoice Line"
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
        field(50112; TBMSIsFieldConfidentalLine; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Is Confidental Line';
        }
    }

    var
        myInt: Integer;
}