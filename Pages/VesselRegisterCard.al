page 50135 "Vessel Register Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Vessel;
    Caption = 'Vessel Register Card';

    layout
    {
        area(Content)
        {
            group("General")
            {
                field(VesId; VesId)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field(VesType; VesType)
                {
                    ApplicationArea = All;
                }
                field(RevId; RevId)
                {
                    ApplicationArea = All;
                }
                field(Tonnage; Tonnage)
                {
                    ApplicationArea = All;
                }

                field(BusLa; BusLa)
                {
                    ApplicationArea = All;
                }

                field(BusOc; BusOc)
                {
                    ApplicationArea = All;
                }

                field(DefaultFlag; DefaultFlag)
                {
                    ApplicationArea = All;
                }

                field(LockFlag; LockFlag)
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
