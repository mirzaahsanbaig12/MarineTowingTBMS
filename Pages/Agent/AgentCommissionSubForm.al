page 50168 AgentCommissionSubForm
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = AgentCommissionLine;
    Editable = false;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Agent No"; AgentNo)
                {
                    ApplicationArea = All;
                }
                field("Contract"; ConNumber)
                {
                    ApplicationArea = All;
                }
                field("Document No."; "Document No.")
                {
                    ApplicationArea = All;
                }
                field("Total Amount"; TotalAmount)
                {
                    ApplicationArea = All;
                }
                field("Commission Amount"; CommissionAmount)
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
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}