page 50115 "Tug Register Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Tug Boat";
    Caption = 'Tug Boat Card';

    layout
    {
        area(Content)
        {
            group("General")
            {
                field(TugId; TugId)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    trigger OnValidate()
                    begin
                        CurrPage."Tug Rate".Page.SetTugId(TugId);
                    end;
                }

                field(Name; Name)
                {
                    ApplicationArea = All;
                }
                field(CmpId; CmpId)
                {
                    Visible = false;
                    ApplicationArea = All;
                }

                field(AccountCC; AccountCC)
                {
                    ApplicationArea = All;
                }
                field(AcctRev; AcctRev)
                {
                    ApplicationArea = All;
                }

                field(Power; Power)
                {
                    ApplicationArea = All;
                }
                field(Class; Class)
                {
                    Visible = false;
                    ApplicationArea = All;
                }

                field("Type"; "Type")
                {
                    ApplicationArea = All;
                }
                field(Status; Status)
                {
                    ApplicationArea = All;
                }

                field(ExternaTug; ExternaTug)
                {
                    ApplicationArea = All;
                }

                field(HourlyRate; HourlyRate)
                {
                    ApplicationArea = All;
                }

                field(Memo; Memo)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
            }



            group("Tug Rates")
            {
                Visible = false;
                part("Tug Rate"; "Tug Rate List Tug Hide")
                {
                    ApplicationArea = Basic, Suite;
                    SubPageLink = TugId = FIELD(TugId);
                    UpdatePropagation = Both;
                    Editable = true;

                }
            }

        }

    }

    trigger OnAfterGetRecord()
    begin
        CurrPage."Tug Rate".Page.SetTugId(TugId);
    end;
}
