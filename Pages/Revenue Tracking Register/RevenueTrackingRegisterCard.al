page 50128 "Revenue Tracking Register Card"
{
    PageType = Card;
    DeleteAllowed = true;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Revenue Tracking";
    Caption = 'Revenue Tracking Register Card';

    layout
    {
        area(Content)
        {
            group("General")
            {
                field(RevId; RevId)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }

                field(AccountNumber; AccountNumber)
                {
                    ApplicationArea = All;
                }

                field(TrafficType; TrafficType)
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
