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
                    Visible = false;

                }
                field(Company; CompanyId)
                {
                    Caption = 'Company';
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

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        AgentId := AgentIdCode;
    end;

    var
        AgentIdCode: Code[20];

    procedure SetAgentId(_agentId: Code[20])
    begin
        AgentIdCode := _agentId;
    end;
}