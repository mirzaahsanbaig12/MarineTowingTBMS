page 50111 "Company Register Card"
{
    PageType = Document;
    RefreshOnActivate = true;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Company Register";
    Caption = 'Company Card';

    layout
    {
        area(Content)
        {
            group("General")
            {
                field(CmpId; CmpId)
                {

                    ApplicationArea = All;
                    ShowMandatory = true;
                    trigger OnValidate()
                    begin
                        InsertAddress.InsertAddress(CmpId);
                        //CurrPage.Update();

                    end;

                }
                field(Name; Name)
                {
                    ApplicationArea = All;
                }
                field(Status; Status)
                {
                    ApplicationArea = All;
                }

                field(CmpType; CmpType)
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field(CmpTar; CmpTar)
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field(TarId; TarId)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        if CmpId = ''
                        then begin
                            FieldError(CmpId, 'Please add Company Id');
                        end;
                        CmpTar := InsertCompanyTariff.InsertTariffForCompany(tarId, CmpId);
                        deleteTariffForCompany(CmpTar, PrevCmpTar);
                        PrevCmpTar := CmpTar;
                    end;
                }

                field(AcctRev; AcctRev)
                {
                    ApplicationArea = All;
                }

                field(RemitToMessage; RemitToMessage)
                {
                    ApplicationArea = All;
                }

            }

            group("Address Information")
            {
                field(Title; Title)
                {
                    ApplicationArea = All;
                }

                field(Phone; Phone)
                {
                    ApplicationArea = All;
                }

                field(Fax; Fax)
                {
                    ApplicationArea = All;
                }

                field(Email; Email)
                {
                    ApplicationArea = All;
                }

                part(Address; Address)
                {
                    ApplicationArea = Basic, Suite;
                    UpdatePropagation = Both;
                    SubPageLink = AddId = field(CmpId);
                    Editable = true;
                }


            }

            group("Accounting")
            {
                Visible = false;
                field(DbName; DbName)
                {
                    ApplicationArea = All;
                }




            }

            group("Invoicing")
            {
                Visible = false;

                field(InoInvNumber; InoInvNumber)
                {
                    ApplicationArea = All;
                }
                field(InoSegType; InoSegType)
                {
                    ApplicationArea = All;
                }


            }

            group("Tug Rates")
            {
                Visible = false;

                part("Tug Rate"; "Tug Rate List Company Hide")
                {
                    ApplicationArea = Basic, Suite;
                    SubPageLink = CmpId = FIELD(CmpId);
                    UpdatePropagation = Both;
                    //Editable = true;

                }
            }

        }
    }
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



    var
        PrevCmpTar: Integer;
        InsertAddress: Codeunit "Insert Address";
        InsertCompanyTariff: Codeunit InsertData;

    trigger OnAfterGetRecord()
    begin
        PrevCmpTar := CmpTar;
    end;
}
