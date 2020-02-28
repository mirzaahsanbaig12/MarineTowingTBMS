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
                field(JobDate; JobDate)
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
                    trigger OnValidate()
                    begin
                        Tonnage := getVesselTonnage.GetVesselTonnage(VesId);
                    end;
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
                    Editable = false;
                }

            }

            group("Ord Tug")
            {
                part("ord Tug SubForm"; "Ord Tug SubForm")
                {
                    ApplicationArea = Basic, Suite;
                    SubPageLink = ORDocNumber = field(ORDocNumber);
                    UpdatePropagation = Both;
                    //Editable = true;
                }

            }

            group("Ord Loc")
            {
                part("ord loc SubForm"; "Ord Loc SubForm")
                {
                    ApplicationArea = Basic, Suite;
                    SubPageLink = ORDocNumber = field(ORDocNumber);
                    UpdatePropagation = Both;
                    //Editable = true;
                }
            }

            group(Memos)
            {
                field(ManagerMemo; ManagerMemo)
                {
                    ApplicationArea = All;
                }

                field(DispatcherMemo; DispatcherMemo)
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
            action("Customer List")
            {
                ApplicationArea = All;
                Caption = 'Customer';

                trigger OnAction()
                begin
                    customerList.Run();
                end;
            }
        }
    }

    var
        ordDocRec: Record OrdDoc;
        getVesselTonnage: Codeunit GetData;
        customerList: Page "Customer List";

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        InboundOutbound := ordDocRec.InboundOutbound::Outbound;
        CurrPage."ord Tug SubForm".Page.SetORDocNumber(ordDocRec.GetORDocNumber());
        CurrPage."ord loc SubForm".Page.SetORDocNumber(ordDocRec.GetORDocNumber());
    end;

    trigger OnOpenPage()
    begin
        CurrPage."ord Tug SubForm".Page.SetORDocNumber(ORDocNumber);
        CurrPage."ord loc SubForm".Page.SetORDocNumber(ORDocNumber);
    end;



}
