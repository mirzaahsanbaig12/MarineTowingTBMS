page 50148 "Log Billing"
{
    PageType = Document;
    RefreshOnActivate = true;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = LogDoc;
    Caption = 'Log Billing';
    DelayedInsert = true;

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

                field(VesId; VesId)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        Tonnage := getTonnage.GetVesselTonnage(VesId);
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

                field(PilId; PilId)
                {
                    ApplicationArea = All;
                }



                field(BusOwner; BusOwner)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        ConNumber := getTonnage.GetSingleContractId(BusOwner);
                        CmpId := LogDocRec.getCompanyFromContract(ConNumber);
                        BillingOptions := getBillingOptionsFromContract(ConNumber);
                    end;

                }

                field(BusLA; BusLA)
                {
                    ApplicationArea = All;
                }

                field(ConNumber; ConNumber)
                {
                    ApplicationArea = All;
                }

                field(BillingOptions; BillingOptions)
                {
                    ApplicationArea = All;
                }

                field(CmpId; CmpId)
                {
                    ApplicationArea = All;
                    Editable = false;
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
                    Visible = false;
                    ApplicationArea = All;
                }

                field(ShipFlag; ShipFlag)
                {
                    Visible = false;
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

            action("Sales Order")
            {
                ApplicationArea = All;
                Caption = 'Sales Order';
                Visible = SalesOrderMenu;

                trigger OnAction()
                begin

                    salesHeader.SetFilter("No.", SalesOrderNo);
                    if salesHeader.FindFirst() then begin

                        SalesOrder.SetRecord(salesHeader);
                        //SalesOrder.Editable(False);
                        SalesOrder.Run();

                    end;
                end;
            }

            action("date time")
            {
                ApplicationArea = All;
                Visible = false;
                trigger OnAction()
                begin
                    dateTimeTest.Run();

                end;
            }
        }
    }



    var
        LogDocRec: Record LogDoc;
        customerList: Page "Customer List";
        getTonnage: Codeunit GetData;
        SalesOrder: Page "Sales Order";
        salesHeader: Record "Sales Header";
        SalesOrderMenu: Boolean;

        dateTimeTest: Codeunit DateTimeTest;


    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        CurrPage.LogDetailsSubFrom.Page.SetLogDocNumber(LogDocRec.GetLogDocNumber());
    end;

    trigger OnOpenPage()
    begin
        CurrPage.LogDetailsSubFrom.Page.SetLogDocNumber(LogDocNumber);
        ShowHideMenu();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        if not SalesOrderMenu then
            SalesOrderNo := '';

    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Datelog := System.CurrentDateTime;
        FuelCost := getTonnage.GetFuelCost()

    end;

    procedure ShowHideMenu()
    var
        SalesHeaderLocal: Record "Sales Header";
    begin
        SalesHeaderLocal.SetFilter("No.", SalesOrderNo);
        if SalesHeaderLocal.FindFirst() then begin
            SalesOrderMenu := true;

        end
        else
            SalesOrderMenu := false;



    end;



}
