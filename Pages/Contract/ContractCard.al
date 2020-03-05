page 50138 "Contract Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Contract;
    Caption = 'Contract Card';
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            group("General")
            {

                field(CmpId; CmpId)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }

                field(ConNumber; ConNumber)
                {
                    ApplicationArea = All;
                    Visible = false;

                }
                field(BusOc; BusOc)
                {
                    ApplicationArea = All;
                }

                field(TerID; TerID)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(StartDate; StartDate)
                {
                    ApplicationArea = All;
                }

                field(EndDate; EndDate)
                {
                    ApplicationArea = All;
                }

                field(Class; Class)
                {
                    ApplicationArea = All;
                }

                field(Status; Status)
                {
                    ApplicationArea = All;
                }

                field(Descr; Descr)
                {
                    ApplicationArea = All;
                }

                field(DiscPer; DiscPer)
                {
                    ApplicationArea = All;
                }

                field(DiscType; DiscType)
                {
                    ApplicationArea = All;
                }

                field(TarBase; TarBase)
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field(TarChange; TarChange)
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field(TarCustomer; TarCustomer)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(TarCustomerName; TarCustomerName)
                {
                    ApplicationArea = All;
                }

                field(AssistFixedRate; AssistFixedRate)
                {
                    ApplicationArea = All;
                }

                field(Rate; Rate)
                {
                    ApplicationArea = All;
                }
            }
            group("Contract Agent")
            {
                part(contractAgent; "Contract Agent SubForm")
                {
                    ApplicationArea = Basic, Suite;
                    SubPageLink = ConNumber = FIELD(ConNumber);
                    UpdatePropagation = Both;
                    //Editable = true;

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
        contractRec: Record Contract;

    trigger OnAfterGetRecord()
    begin
        CurrPage.contractAgent.Page.SetConNumber(ConNumber);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        CurrPage.contractAgent.Page.SetConNumber(contractRec.GetLastLineNo());
    end;

    trigger OnOpenPage()
    begin
        CurrPage.contractAgent.Page.SetConNumber(ConNumber);

    end;


}
