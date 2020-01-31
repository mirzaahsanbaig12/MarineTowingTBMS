page 50131 "Pilot Association List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Pilot Association";
    Caption = 'Pilot Association Register List';
    CardPageId = 50132;

    layout
    {
        area(Content)
        {
            repeater("General")
            {
                field(PaId; PaId)
                {
                    ApplicationArea = All;
                }
                field(Description; Name)
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
        sales: page "Sales Order";
        sales1: page "Sales Order Subform";
}
