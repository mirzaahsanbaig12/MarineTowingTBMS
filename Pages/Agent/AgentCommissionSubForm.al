page 50168 AgentCommissionSubForm
{
    PageType = ListPart;
    SourceTable = AgentCommissionLine;
    Editable = false;
    Caption = 'Commission Lines';
    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
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
                field(CommissionPer; CommissionPer)
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
            // action(ActionName)
            // {
            //     ApplicationArea = All;

            //     trigger OnAction();
            //     begin

            //     end;
            // }
        }
    }
}