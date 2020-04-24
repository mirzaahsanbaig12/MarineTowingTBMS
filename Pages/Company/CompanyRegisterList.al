page 50110 "Company Register List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Company Register";
    Caption = 'Company List';
    CardPageId = 50111;

    layout
    {
        area(Content)
        {
            repeater("General")
            {
                field(CmpId; CmpId)
                {
                    ApplicationArea = All;
                }


                field(Description; Name)
                {
                    ApplicationArea = All;
                }

                field(TarId; TarId)
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
        sales: page "Sales Order";
        sales1: page "Sales Order Subform";
}
