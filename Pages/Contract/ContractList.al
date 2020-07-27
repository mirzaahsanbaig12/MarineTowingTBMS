page 50137 "Contract List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Contract;
    Caption = 'Contract List';
    CardPageId = "Contract Card";


    layout
    {
        area(Content)
        {
            repeater("General")
            {

                field(ConNumber; ConNumber)
                {
                    ApplicationArea = All;
                }

                field(BusOc; BusOc)
                {
                    ApplicationArea = all;
                }

                field(CmpId; CmpId)
                {
                    ApplicationArea = All;
                }

                field(Status; Status)
                {
                    ApplicationArea = All;
                }

                field(Descr; Descr)
                {
                    ApplicationArea = all;
                }
                field(BillingOptions; BillingOptions)
                {
                    ApplicationArea = All;
                }
                field(TarCustomer; TarCustomer)
                {
                    ApplicationArea = All;
                }
                field(DeltaBilling; DeltaBilling)
                {
                    ApplicationArea = All;
                    Enabled = (AssistFixedRate = false) AND (TarCustomer <> '');
                }
                field(AssistFixedRate; AssistFixedRate)
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

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}
