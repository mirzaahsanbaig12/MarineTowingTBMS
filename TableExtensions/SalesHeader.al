tableextension 50113 SalesHeaderExtTBMS extends "Sales Header"
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

        field(50112; "TBMS Discount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum ("Sales Line"."Line Discount Amount" WHERE("Document Type" = FIELD("Document Type"),
                                                                         "Document No." = FIELD("No.")));
            Caption = 'Discount';
            Editable = false;
            FieldClass = FlowField;

        }
        field(50113; "TBMS Discount Description"; Text[300])
        {
            DataClassification = ToBeClassified;
            Caption = 'Discount Description';
            Editable = false;
        }
        field(50114; ConNumber; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = Contract;
        }
    }

    var
        myInt: Integer;
}