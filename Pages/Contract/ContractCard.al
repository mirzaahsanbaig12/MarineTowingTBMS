page 50138 "Contract Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Contract;
    Caption = 'Contract Card';

    layout
    {
        area(Content)
        {
            group("General")
            {
                field(BusOc; BusOc)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field(CmpId; CmpId)
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
                }

                field(TarChange; TarChange)
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
        myInt: Integer;
}
