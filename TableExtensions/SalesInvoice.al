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

    }

    var
        myInt: Integer;
}