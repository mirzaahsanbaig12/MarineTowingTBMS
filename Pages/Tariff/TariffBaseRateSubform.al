page 50136 "Tariff Base Rate Subfrom"
{
    AutoSplitKey = false;
    Caption = 'Base Rate';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = false;
    PageType = ListPart;
    SourceTable = TarBr;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(TonnageEnd; TonnageEnd)
                {
                    ApplicationArea = All;
                    Caption = 'Tonnage';
                }
                field(Rate; Rate)
                {
                    ApplicationArea = All;
                    Caption = 'Rate';
                }
                field(TarId; TarId)
                {
                    ApplicationArea = All;
                    Caption = 'Tariff';
                    Visible = false;
                }

                field(PrtId; PrtId)
                {
                    ApplicationArea = All;
                    Caption = 'Port Id';
                    Visible = false;
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
    var
        prtIdCode: Code[5];
        tarIdCode: Code[5];

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        PrtId := prtIdCode;
        TarId := tarIdCode;
    end;


    procedure SetPrtId(_prtId: Code[5])
    begin
        prtIdCode := _prtId;
    end;

    procedure SetTarId(_TarId: Code[5])
    begin
        tarIdCode := _TarId;
    end;



}