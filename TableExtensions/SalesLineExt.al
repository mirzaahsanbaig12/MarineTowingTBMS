tableextension 50112 SalesLineExtTBMS extends "Sales Line"
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
        field(50113; LogDocNumber; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Log #';
            TableRelation = LogDoc;
        }

        field(50114; LogDate; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Log Date';
        }

        field(50115; LogDateString; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Log Date';
        }


    }

    var
        myInt: Integer;
}