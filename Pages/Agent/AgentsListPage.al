page 50166 AgentsListPage
{
    Caption = 'Agents';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Customer;
    SourceTableView = WHERE(TBMSAgent = const(true));
    Editable = false;
    CardPageId = 50167;

    layout
    {
        area(Content)
        {
            repeater("Agents List")
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

                field("Phone No."; "Phone No.")
                {
                    ApplicationArea = All;
                }
                field(Contact; Contact)
                {
                    ApplicationArea = All;
                }
                field("Agent Commission"; AgentCommission)
                {
                    ApplicationArea = All;
                }
            }
        }

    }

    actions
    {
        area(Processing)
        {
            //     action(ActionName)
            //     {
            //         ApplicationArea = All;

            //         trigger OnAction()
            //         begin

            //         end;
            //     }
        }
    }

    var
        myInt: Integer;
}