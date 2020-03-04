page 50148 "Log Billing"
{
    PageType = Document;
    RefreshOnActivate = true;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = LogDoc;
    Caption = 'Log Billing';

    layout
    {
        area(Content)
        {
            group("General")
            {
                field(LogDocNumber; LogDocNumber)
                {
                    ApplicationArea = All;
                    Visible = false;
                }


                field(JobType; JobType)
                {
                    ApplicationArea = All;
                }
                field(Datelog; Datelog)
                {
                    ApplicationArea = All;
                }

                field(Status; Status)
                {
                    ApplicationArea = All;
                }

                //field(dis)

                field(DisId; DisId)
                {
                    ApplicationArea = All;
                }

                field(CmpId; CmpId)
                {
                    ApplicationArea = All;
                }

                field(PilId; PilId)
                {
                    ApplicationArea = All;
                }


                field(VesId; VesId)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        Tonnage := getTonnage.GetVesselTonnage(VesId);
                    End;
                }
                field(BusLA; BusLA)
                {
                    ApplicationArea = All;
                }
                field(BusOwner; BusOwner)
                {
                    ApplicationArea = All;
                }

                field(RevId; RevId)
                {
                    ApplicationArea = All;
                }
                field(Tonnage; Tonnage)
                {
                    ApplicationArea = All;
                }
                field(FuelCost; FuelCost)
                {
                    ApplicationArea = All;
                }

                field(LocStr; LocStr)
                {
                    ApplicationArea = All;
                }

                field(DestinationStr; DestinationStr)
                {
                    ApplicationArea = All;
                }


                field(AsstFlag; AsstFlag)
                {
                    ApplicationArea = All;
                }

                field(HWFlag; HWFlag)
                {
                    ApplicationArea = All;
                }
                field(OTType; OTType)
                {
                    ApplicationArea = All;
                }

                field(ShipFlag; ShipFlag)
                {
                    ApplicationArea = All;
                }

                field(TimeOrd; TimeOrd)
                {
                    ApplicationArea = All;
                }

                field(TimeCan; TimeCan)
                {
                    ApplicationArea = All;
                }

                field(DUFlag; DUFlag)
                {
                    ApplicationArea = All;
                }

                field(Position; Position)
                {
                    ApplicationArea = All;
                }
                field(ORDocNumber; ORDocNumber)
                {
                    Editable = false;
                    ApplicationArea = All;
                    Caption = 'Scheduler ID';
                }

            }

            group("Log Details")
            {
                part("LogDetailsSubFrom"; "Log Details")
                {
                    ApplicationArea = Basic, Suite;
                    SubPageLink = LogDocNumber = field(LogDocNumber);
                    UpdatePropagation = Both;
                    //Editable = true;

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
        LogDocRec: Record LogDoc;
        customerList: Page "Customer List";
        getTonnage: Codeunit GetData;


    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        CurrPage.LogDetailsSubFrom.Page.SetLogDocNumber(LogDocRec.GetLogDocNumber());
    end;

    trigger OnOpenPage()
    begin
        CurrPage.LogDetailsSubFrom.Page.SetLogDocNumber(LogDocNumber);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Datelog := System.CurrentDateTime;

        FuelCost := getTonnage.GetFuelCost()

    end;




}
