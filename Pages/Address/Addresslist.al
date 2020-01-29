page 50112 "Address Register List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Address;
    Caption = 'Address Register List';
    CardPageId = 50113;

    layout
    {
        area(Content)
        {
            repeater("General")
            {
                field(AddId; AddId)
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
