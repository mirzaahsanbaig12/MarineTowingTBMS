page 50173 "Agent Blanket Comm SubForm"
{
    MultipleNewLines = false;
    PageType = ListPart;
    SourceTable = AgentBlanketCommission;

    layout
    {
        area(Content)
        {
            repeater(groupname)
            {
                field(LineNo; LineNo)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(AgentId; AgentId)
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field(Company; CompanyId)
                {
                    ApplicationArea = All;
                }
                field(CommissionType; CommissionType)
                {
                    ApplicationArea = All;
                    Caption = 'Commission Type';
                }
                field(Percentage; Percentage)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
}