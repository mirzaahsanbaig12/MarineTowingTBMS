page 50167 AgentCommissionCardPage
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Customer;
    Editable = false;
    Permissions = tabledata Customer = r;
    layout
    {
        area(Content)
        {
            group(GroupName)
            {

                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Name)
                {
                    ApplicationArea = All;
                }
                field("Location Code"; "Location Code")
                {
                    ApplicationArea = All;
                }
                field("Agent Commission"; AgentCommission)
                {
                    ApplicationArea = All;
                }
            }

            part(CommissionLines; AgentCommissionSubForm)
            {
                ApplicationArea = Basic, Suite;
                Editable = false;
                SubPageLink = AgentNo = FIELD("No.");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}