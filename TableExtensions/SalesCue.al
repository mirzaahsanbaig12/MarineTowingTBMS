tableextension 50116 SalesCueExt extends "Sales Cue"
{
    fields
    {

        // Add changes to table fields here
        field(50110; "AXP unposted sales invoice"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count ("Sales Header" where("Document Type" = Filter(Invoice), "Axp Tug Imported" = FILTER(true)));
            Caption = 'Tug boat unposted sales invoice';

        }

        field(50111; "AXP posted sales invoice"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count ("Sales Invoice Header" where("Axp Tug Imported" = FILTER(true)));
            Caption = 'Tug boat posted sales invoice';

        }

        field(50112; "AXP unposted purchase invoice"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count ("Purchase Header" where("Document Type" = Filter(Invoice), "Axp Tug Imported" = FILTER(true)));
            Caption = 'Tug boat unposted purchase invoice';

        }

        field(50113; "AXP posted purchase invoice"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count ("Purch. Inv. Header" where("Axp Tug Imported" = FILTER(true)));
            Caption = 'Tug boat posted purchase invoice';

        }


        field(50114; "AXP unposted sales Invoice Tot"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum ("Sales Line"."Amount Including VAT" where("Axp Tug Imported" = FILTER(true)));
            Caption = 'Tug boat unposted Sales invoice Total';
            AutoFormatExpression = '1,USD';
            AutoFormatType = 10;
        }

        field(50115; "AXP posted sales Invoice Tot"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum ("Sales Invoice Line"."Amount Including VAT" where("Axp Tug Imported" = FILTER(true)));
            Caption = 'Tug boat posted Sales invoice Total';
            AutoFormatExpression = '1,USD';
            AutoFormatType = 10;
        }

        field(50116; "AXP unposted purch Invoice Tot"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum ("Purchase Line"."Amount Including VAT" where("Axp Tug Imported" = FILTER(true)));
            Caption = 'Tug boat unposted purchase invoice Total';
            AutoFormatExpression = '1,USD';
            AutoFormatType = 10;
        }

        field(50117; "AXP posted purch Invoice Tot"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum ("Purch. Inv. Line"."Amount Including VAT" where("Axp Tug Imported" = FILTER(true)));
            Caption = 'Tug boat posted purchase invoice Total';
            AutoFormatExpression = '1,USD';
            AutoFormatType = 10;
        }

        field(50118; FuelCost; Decimal)
        {
            FieldClass = Normal;
            Caption = 'Current Fuel Cost';
            AutoFormatExpression = '1,USD';
            AutoFormatType = 10;
        }
    }

    var
        myInt: Integer;
}