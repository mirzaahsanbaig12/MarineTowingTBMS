pageextension 50128 SalesInvoiceListHeader extends "Posted Sales Invoices"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {

        addafter(Print)
        {
            action("TBMS Print Confirmation")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'TBMS Print Discount';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Category7;
                ToolTip = 'Print a sales invoice discount';
                //RunObject = report "TBMS Sales Confirmation";

                trigger OnAction()
                begin
                    PrintReport.TBMSSalesInvoiceDiscountReport(Rec."No.");
                end;


            }

        }
        // Add changes to page actions here
    }


    var
        myInt: Integer;
        PrintReport: Codeunit GetData;
}