page 50127 "Revenue Tracking Register"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Revenue Tracking";
    Caption = 'Revenue/Tracking';
    CardPageId = 50128;

    layout
    {
        area(Content)
        {
            repeater("General")
            {
                field(RevId; RevId)
                {
                    ApplicationArea = All;

                }

                field(Status; Status)
                {
                    ApplicationArea = All;
                }
                field(TrafficType; TrafficType)
                {
                    ApplicationArea = All;

                }

                field(Description; Description)
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
        myInt: Record "Sales Line";
}
