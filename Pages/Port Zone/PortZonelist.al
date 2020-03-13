page 50118 "Port Zone Register List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Port Zone";
    Caption = 'Zone List';
    CardPageId = 50119;

    layout
    {
        area(Content)
        {
            repeater("AreaPort Zone Register")
            {
                field(PrtId; PrtId)
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
    //ahsan:  "Locations Subform";
}
