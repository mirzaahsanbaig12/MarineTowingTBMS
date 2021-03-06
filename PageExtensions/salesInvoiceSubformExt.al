pageextension 50125 SalesInvoiceLineExt extends "Sales Invoice Subform"
{
    layout
    {
        // Add changes to page layout here
        addafter("No.")
        {
            field(LogDocNumber; LogDocNumber)
            {
                ApplicationArea = All;
                Caption = 'Log #';
                Editable = false;
                DrillDown = true;
                DrillDownPageId = "Log Billing";
            }
            field(ChargeType; ChargeType)
            {
                ApplicationArea = ALL;
                Editable = false;
                Caption = 'Charge Type';
            }
            field(TBMSlongDesc; TBMSlongDesc)
            {
                ApplicationArea = ALL;
            }
        }
        modify(Description)
        {
            Visible = false;
        }
        addafter("TotalSalesLine.""Line Amount""")
        {
            field("TBMS Discount"; tbmsDiscount)
            {
                ApplicationArea = Suite;
                AutoFormatExpression = "Currency Code";
                AutoFormatType = 1;
                Caption = 'Discount';
                Editable = false;
            }
        }
        modify("Invoice Discount Amount")
        {
            Visible = false;

        }
        modify("Invoice Disc. Pct.")
        {
            Visible = false;
        }
    }

    actions
    {


        // Add changes to page actions here
    }

    trigger OnOpenPage()
    begin
        SalesHeader.Init();
        tbmsDiscount := 0;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        if SalesHeader.Get("Document Type", "Document No.") then begin
            SalesHeader.CalcFields("TBMS Discount");
            tbmsDiscount := SalesHeader."TBMS Discount";
        end;
    end;

    var
        tbmsDiscount: Decimal;
        SalesHeader: Record "Sales Header";
}