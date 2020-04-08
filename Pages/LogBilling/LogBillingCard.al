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

                field(VesId; VesIdPk)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        Tonnage := getTonnage.GetVesselTonnage(VesIdPk);
                    End;
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
                    trigger OnValidate()
                    begin
                        if Status = LogDocRec.Status::Reopen
                        then
                            SalesOrderNo := '';
                    end;
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


                field(BusLA; BusLA)
                {
                    ApplicationArea = All;
                }
                field(BusOwner; BusOwner)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        ConNumber := getTonnage.GetSingleContractId(BusOwner);
                    end;

                }

                field(ConNumber; ConNumber)
                {
                    ApplicationArea = All;
                }

                field(RevId; RevId)
                {
                    Visible = false;
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
                    Visible = false;
                    ApplicationArea = All;
                }

                field(DestinationStr; DestinationStr)
                {
                    Visible = false;
                    ApplicationArea = All;
                }


                field(AsstFlag; AsstFlag)
                {
                    Visible = false;
                    ApplicationArea = All;
                }

                field(HWFlag; HWFlag)
                {
                    Visible = false;
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
                    Visible = false;
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

                field(SalesOrderNo; SalesOrderNo)
                {
                    ApplicationArea = All;
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
