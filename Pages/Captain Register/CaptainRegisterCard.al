page 50126 "Captain Register Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Captain;
    Caption = 'Captain Card';

    layout
    {
        area(Content)
        {
            group("General")
            {
                field(CapId; CapId)
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
