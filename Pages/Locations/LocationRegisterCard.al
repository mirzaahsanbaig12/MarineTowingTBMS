page 50121 "location Register Card"
{
    PageType = Document;
    RefreshOnActivate = true;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Location Register";
    Caption = 'Location Register Card';

    layout
    {
        area(Content)
        {
            group("General")
            {
                field(LocId; LocId)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field(PrtId; PrtId)
                {
                    ApplicationArea = All;
                }

                field(araId; araId)
                {
                    ApplicationArea = All;
                }

                field("type"; "type")
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


    var
        myInt: Integer;
        InsertAddress: Codeunit "Insert Address";
}
