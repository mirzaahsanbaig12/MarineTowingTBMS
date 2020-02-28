page 50153 "Base Rate List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = TarBr;
    Caption = 'Base Rates';

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
                field(PrtId; PrtId)
                {
                    ApplicationArea = All;
                }

                field(TonnageEnd; TonnageEnd)
                {
                    ApplicationArea = All;
                }

                field(Rate; Rate)
                {
                    ApplicationArea = All;
                }
            }

        }
    }

    var




}
