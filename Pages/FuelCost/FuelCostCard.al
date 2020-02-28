page 50151 "Fuel Cost Card"
{
    PageType = Document;
    RefreshOnActivate = true;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Fuel Cost";
    Caption = 'Fuel Cost Card';

    layout
    {
        area(Content)
        {
            group("General")
            {
                field(FuelDate; FuelDate)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
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

        }
    }


    var

}
