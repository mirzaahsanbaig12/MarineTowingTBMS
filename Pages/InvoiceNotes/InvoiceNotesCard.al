page 50155 "Invoice Note Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Invoice Notes";
    Caption = 'Invoice Note Card';

    layout
    {
        area(Content)
        {
            group("General")
            {
                field(TerId; TerId)
                {
                    ApplicationArea = All;
                }
                field(Descr; Descr)
                {
                    ApplicationArea = All;
                }

                field(Status; Status)
                {
                    ApplicationArea = All;
                }

                field(InoMemos; InoMemos)
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
