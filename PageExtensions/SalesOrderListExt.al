pageextension 50126 SalesOrderlistExt extends "Sales Order List"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter("Print Confirmation")
        {
            action("TBMS Print Confirmation")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'TBMS Print Discount';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Category11;
                ToolTip = 'Print a sales order discount confirmation.';
                //RunObject = report "TBMS Sales Confirmation";

                trigger OnAction()
                begin
                    PrintReport.TBMSSalesConfDiscountReport(Rec."No.");
                end;


            }
        }

        // Add changes to page actions here
    }

    var
        myInt: Integer;
        PrintReport: Codeunit GetData;
}