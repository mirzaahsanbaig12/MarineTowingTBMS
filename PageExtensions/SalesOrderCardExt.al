pageextension 50117 SalesOrderExt extends "Sales Order"
{
    layout
    {
        // Add changes to page layout here

        addafter("Sell-to Customer Name")
        {
            field(LogJobType; LogJobType)
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }

    actions
    {
        /*modify("Print Confirmation")
        {
            Visible = true;
        }
        */

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

        /*addlast("&Print")
        {
            action("TBMS Print Discount")
            {
                ApplicationArea = All;
                Caption = 'TBMS Print Discount';
                RunObject = report "TBMS Sales Conf Dsicount";
            }
        }
        */
        // Add changes to page actions here

    }

    var
        myInt: Integer;
        PrintReport: Codeunit GetData;


}