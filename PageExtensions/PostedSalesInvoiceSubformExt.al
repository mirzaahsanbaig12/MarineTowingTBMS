pageextension 50118 PostedSalesInvoiceSubformExt extends "Posted Sales Invoice Subform"
{
    layout
    {
        // Add changes to page layout here
        addafter("Invoice Discount Amount")
        {
            field("TBMS Discount"; tbmsDiscount)
            {
                ApplicationArea = Suite;
                AutoFormatType = 1;
                Caption = 'Discount';
                Editable = false;
            }
        }
        modify("Invoice Discount Amount")
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
        SalesInvoice.Init();
        tbmsDiscount := 0;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        if SalesInvoice.Get("Document No.") then begin
            SalesInvoice.CalcFields("TBMS Discount");
            tbmsDiscount := SalesInvoice."TBMS Discount";
        end;
    end;

    var
        tbmsDiscount: Decimal;
        SalesInvoice: Record "Sales Invoice Header";
}