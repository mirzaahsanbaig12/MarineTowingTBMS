page 50142 "Outbound Ord Doc Card"
{
    PageType = Document;
    RefreshOnActivate = true;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = OrdDoc;
    Caption = 'Outbound Order Document Details';

    layout
    {
        area(Content)
        {
            group("General")
            {
                field(ORDocNumber; ORDocNumber)
                {
                    ApplicationArea = All;
                    Visible = false;
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


    var
        ordDocRec: Record OrdDoc;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        InboundOutbound := ordDocRec.InboundOutbound::Outbound;
    end;
    /*actions
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
    */



}
