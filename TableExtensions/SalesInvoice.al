tableextension 50114 SalesInvoiceHeaderExtTBMS extends "Sales Invoice Header"
{
    fields
    {
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
            CalcFormula = Sum ("Sales Invoice Line"."Line Discount Amount" WHERE("Document No." = FIELD("No.")));
            Caption = 'Discount';
            Editable = false;
            FieldClass = FlowField;

        }

        field(50115; "TBMS Confidental Discount"; Decimal)
        {
            Caption = 'Confidental Discount';
            Editable = false;
            FieldClass = FlowField;

            CalcFormula = Sum ("Sales Invoice Line"."Line Discount Amount" where("Document No." = FIELD("No."), "Document No." = FIELD("No."),
                                                                         "TBMSIsFieldConfidentalLine" = const(true)));
        }

        field(50113; "TBMS Discount Description"; Text[300])
        {
            DataClassification = ToBeClassified;
            Caption = 'Discount Description';
            Editable = false;
        }
        field(50117; "Invoice Notes"; Text[2048])
        {
            DataClassification = ToBeClassified;
            Description = 'Invoice Notes';
            Caption = 'Invoice Notes';
        }

        field(50118; LogDate; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Log Date';
        }

        field(50119; mulipleLogs; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Multiple Logs';
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