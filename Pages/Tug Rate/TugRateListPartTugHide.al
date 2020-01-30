page 50117 "Tug Rate List Tug Hide"
{
    AutoSplitKey = false;
    Caption = 'Tug Rates';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = false;
    PageType = ListPart;
    SourceTable = "Tug Rate";


    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {

                field(CmpId; CmpId)
                {
                    ApplicationArea = All;

                }
                field(TugId; TugId)
                {
                    ApplicationArea = All;
                    Visible = false;
                    Caption = 'Tug';

                }
                field(TarId; TarId)
                {
                    ApplicationArea = All;
                    Caption = 'Tariff';

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

                trigger OnAction();
                begin

                end;
            }
        }

    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        TugId := TugIdCode;
    end;

    var
        TugIdCode: code[5];

    procedure SetTugId(_TugId: Code[5])
    begin
        TugIdCode := _TugId;
    end;
}