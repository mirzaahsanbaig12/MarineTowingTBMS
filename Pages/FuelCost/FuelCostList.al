page 50150 "Fuel Cost List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Fuel Cost";
    Caption = 'Fuel CostList';
    CardPageId = 50151;
    SourceTableView = sorting(FuelDate) order(descending);

    layout
    {
        area(Content)
        {
            repeater("General")
            {
                field(FuelDate; FuelDate)
                {
                    ApplicationArea = All;
                }

                field(FuelCost; FuelCost)
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
            /* action(ActionName)
             {
                 ApplicationArea = All;

                 trigger OnAction()
                 begin

                 end;
             }
             */
        }
    }

    var
        myInt: Integer;

}
