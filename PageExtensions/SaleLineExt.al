pageextension 50113 SalesLineExt extends "Sales Order Subform"
{
    layout
    {
        //Add changes to page layout here
        addafter("No.")
        {
            field(TBMSDescription; TBMSDescription)
            {
                ApplicationArea = All;
                Visible = false;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}