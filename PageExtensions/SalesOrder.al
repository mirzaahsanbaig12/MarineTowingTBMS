pageextension 50117 SalesOrderExt extends "Sales Order"
{
    layout
    {
        // Add changes to page layout here

        addafter(Status)
        {

        }
    }

    actions
    {
        /*modify("Print Confirmation")
        {
            Visible = true;
        }

        addafter("Print Confirmation")
        {
            action("TBMS Print Confirmation")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Print Confirmation1123';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Category11;
                ToolTip = 'Print a sales order confirmation.';
                RunObject = report "TBMS Sales Confirmation";
            }
        }

        addlast("&Print")
        {
            action("TBMS Print Confirmation1")
            {
                ApplicationArea = All;
                Caption = 'Print Confirmation1';
                RunObject = report "TBMS Sales Confirmation";
            }
        }
        // Add changes to page actions here
        */
    }

    var
        myInt: Integer;
}