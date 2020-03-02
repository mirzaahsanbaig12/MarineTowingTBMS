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

                field(TariffType; TariffType)
                {
                    ApplicationArea = All;
                }

                field(DateBegining; DateBegining)
                {
                    ApplicationArea = All;
                }

                field(DateEnding; DateEnding)
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
            action("Copy Tariff")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    CopyTariff.CopyTariff(TarId);
                end;
            }

            action("Base Rate List")
            {
                ApplicationArea = All;
                trigger OnAction()
                begin
                    PageBaseRate.Run();
                end;
            }

        }


    }

    var

        CopyTariff: Codeunit InsertData;
        PageBaseRate: Page "Base Rate List";


}
