pageextension 50110 CustomerExt extends "Customer Card"
{
    layout
    {
        // Add changes to page layout here
        addafter("Address & Contact")
        {

            group("Contract")
            {
                part(ContractForm; "Contract SubForm")
                {
                    ApplicationArea = Basic, Suite;
                    SubPageLink = BusOc = FIELD("No.");
                    UpdatePropagation = Both;
                    SubPageView = sorting(ConNumber) order(ascending);

                }
            }
            group("Blanket Commissions")
            {

                Visible = TBMSAgent = true;
                part(BlanketCommissions; "Agent Blanket Comm SubForm")
                {
                    Caption = 'Blanket Commissions';
                    ApplicationArea = Basic, Suite;
                    SubPageLink = AgentId = FIELD("No.");
                    UpdatePropagation = Both;

                }
            }

            group("Business Types")
            {

                field(TBMSAgent; TBMSAgent)
                {
                    ApplicationArea = all;
                }

                field(TBMSCustomer; TBMSCustomer)
                {
                    ApplicationArea = all;
                }

                field(TBMSOwner; TBMSOwner)
                {
                    ApplicationArea = all;
                }

                field(TBMSBusinessType; TBMSBusinessType)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        CurrPage.ContractForm.Page.SetBusOc("No.");
        CurrPage.BlanketCommissions.Page.SetAgentId("No.");
    end;

    trigger OnAfterGetRecord()
    begin
        CurrPage.ContractForm.Page.SetBusOc("No.");
        CurrPage.BlanketCommissions.Page.SetAgentId("No.");
    end;


}