page 50116 "Tug Rate List Company Hide"
{
    AutoSplitKey = false;
    Caption = 'Tug Rates';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = false;
    PageType = ListPart;
    SourceTable = "Tug Rate";


    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {

                field(CmpId; CmpId)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(TugId; TugId)
                {
                    ApplicationArea = All;
                    Caption = 'Tug';

                }
                field(TarId; TarId)
                {
                    ApplicationArea = All;
                    Caption = 'Tariff';

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

                trigger OnAction();
                begin

                end;
            }
        }
    }

}