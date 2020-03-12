pageextension 50111 CustomerListExt extends "Customer List"
{
    layout
    {
        addafter("Location Code")
        {
            field(TBMSAgent; TBMSAgent)
            {
                ApplicationArea = All;
            }

            field(TBMSCustomer; TBMSCustomer)
            {
                ApplicationArea = All;
            }

            field(TBMSOwner; TBMSOwner)
            {
                ApplicationArea = All;
            }
            field(TBMSBusinessType; TBMSBusinessType)
            {
                ApplicationArea = All;
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