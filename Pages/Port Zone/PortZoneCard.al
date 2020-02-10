page 50119 "Port Zone Register Card"
{
    PageType = Card;
    DeleteAllowed = true;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Port Zone";
    Caption = 'Port Card';

    layout
    {
        area(Content)
        {
            group("General")
            {
                field(PrtId; PrtId)
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

            group(Location)
            {

                part("locations"; "Location SubForm")
                {
                    ApplicationArea = Basic, Suite;
                    SubPageLink = PrtId = FIELD(PrtId);
                    UpdatePropagation = Both;
                    //Editable = true;

                }
            }


        }
    }

    actions
    {
        area(Processing)
        {
            action("LocationFrom")
            {
                ApplicationArea = All;
                RunObject = page "Location Register List";
                Caption = 'Locations';
            }

        }
    }

    var
        myInt: Integer;
}
