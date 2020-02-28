page 50170 "Contract List2"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Contract2;
    Caption = 'Contract List';
    CardPageId = 50171;


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
