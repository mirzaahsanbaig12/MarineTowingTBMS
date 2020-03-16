page 50135 "Vessel Register Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Vessel_pk;
    Caption = 'Vessel Card';
    DelayedInsert = true;

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
                    Visible = false;
                }
                field(Tonnage; Tonnage)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }

                field(BusLa; BusLa)
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field(BusOc; BusOc)
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field(DefaultFlag; DefaultFlag)
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field(LockFlag; LockFlag)
                {
                    ApplicationArea = All;
                    Visible = false;
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
