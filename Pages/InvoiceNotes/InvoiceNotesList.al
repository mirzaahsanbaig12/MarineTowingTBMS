page 50154 "Invoice Notes List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Invoice Notes";
    Caption = 'Invoice Notes List';
    CardPageId = 50155;

    layout
    {
        area(Content)
        {
            repeater("General")
            {
                field(TerId; TerId)
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
