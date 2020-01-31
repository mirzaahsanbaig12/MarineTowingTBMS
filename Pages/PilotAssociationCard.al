page 50132 "Pilot Assoc Register Card"
{
    PageType = Document;
    RefreshOnActivate = true;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Pilot Association";
    Caption = 'Pilot Association Register Card';

    layout
    {
        area(Content)
        {
            group("General")
            {
                field(PaId; PaId)
                {

                    ApplicationArea = All;
                    ShowMandatory = true;
                    trigger OnValidate()
                    begin
                        InsertAddress.InsertAddress(PaId);
                        CurrPage.Pilot.Page.SetPaId(PaId);
                    end;

                }
                field(Name; Name)
                {
                    ApplicationArea = All;
                }


            }

            group("Address Information")
            {


                field(Phone; Phone)
                {
                    ApplicationArea = All;
                }

                field(Fax; Fax)
                {
                    ApplicationArea = All;
                }



                part(Address; Address)
                {
                    ApplicationArea = Basic, Suite;
                    UpdatePropagation = Both;
                    SubPageLink = AddId = field(PaId);
                    Editable = true;
                }


            }

            group("Pilots")
            {

                part(Pilot; "Pilot Subform")
                {
                    ApplicationArea = Basic, Suite;
                    SubPageLink = PaId = FIELD(PaId);
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
        myInt: Integer;
        InsertAddress: Codeunit "Insert Address";

    trigger OnAfterGetRecord()
    begin
        CurrPage.Pilot.Page.SetPaId(PaId);
    end;
}
