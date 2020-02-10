page 50129 "Tariff Register List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Tariff;
    Caption = 'Tariff List';
    CardPageId = 50130;

    layout
    {
        area(Content)
        {
            repeater("General")
            {
                field(TarId; TarId)
                {
                    ApplicationArea = All;
                }
                field(Descr; Descr)
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
            /*action(ActionName)
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


}
