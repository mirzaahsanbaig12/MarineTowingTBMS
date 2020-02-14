page 50141 "Outbound Ord Doc List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = OrdDoc;
    Caption = 'Outbound Order Document';
    CardPageId = 50142;
    SourceTableView = where(InboundOutbound = const(Outbound));

    layout
    {
        area(Content)
        {
            repeater("General")
            {
                field(ORDocNumber; ORDocNumber)
                {
                    ApplicationArea = All;
                }
                field(JobType; JobType)
                {
                    ApplicationArea = All;
                }

                field(TugOrderDescr; TugOrderDescr)
                {
                    ApplicationArea = All;
                }

                field(VesId; VesId)
                {
                    ApplicationArea = All;
                }

                field(BusLA; BusLA)
                {
                    ApplicationArea = All;
                }

                field(PilId; PilId)
                {
                    ApplicationArea = All;
                }

                field(LocDetNumber; LocDetNumber)
                {
                    ApplicationArea = All;
                }

                field(Tonnage; Tonnage)
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
}

