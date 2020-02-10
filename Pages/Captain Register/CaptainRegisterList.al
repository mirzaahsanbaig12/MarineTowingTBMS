page 50125 "Captain Register List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Captain;
    Caption = 'Captain List';
    CardPageId = 50126;

    layout
    {
        area(Content)
        {
            repeater("General")
            {
                field(CapId; CapId)
                {
                    ApplicationArea = All;
                }
                field(Description; Name)
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
