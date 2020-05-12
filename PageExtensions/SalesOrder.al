pageextension 50117 SalesOrderExt extends "Sales Order"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        //modify("Print Confirmation")
        //{
        // Visible = false;
        //}

        addafter("Print Confirmation")
        {
            action("TBMS Print Confirmation")
            {
                ApplicationArea = All;
                Caption = 'Print Confirmation1';
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
    }

    var
        myInt: Integer;
}