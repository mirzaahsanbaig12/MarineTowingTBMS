page 50134 "Vessel Register List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Vessel;
    Caption = 'Vessel List';
    CardPageId = "Vessel Register Card";
    Editable = false;


    layout
    {
        area(Content)
        {
            repeater("General")
            {
                field(VesId; VesId)
                {
                    ApplicationArea = All;
                }

                field(Name; Name)
                {
                    ApplicationArea = All;
                    Visible = true;
                }

                field(VesType; VesType)
                {
                    ApplicationArea = All;
                }


                field(Status; Status)
                {
                    ApplicationArea = All;
                }

                field(Tonnage; Tonnage)
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
