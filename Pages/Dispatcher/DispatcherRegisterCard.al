page 50124 "Dispatcher Register Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Dispatcher;
    Caption = 'Dispatcher Card';

    layout
    {
        area(Content)
        {
            group("General")
            {
                field(DisId; DisId)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field(Name; Name)
                {
                    ApplicationArea = All;
                }
                field(Status; Status)
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
