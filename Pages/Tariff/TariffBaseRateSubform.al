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
                    DecimalPlaces = 2;
                    AutoFormatType = 0;
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
                    Caption = 'Zone Id';
                    Visible = false;
                }
            }
        }
    }



    actions
    {
        area(Processing)
        {
            action("Add Tonnage")
            {
                ApplicationArea = All;

                trigger OnAction();
                begin
                    if prtIdCode = '' then
                        Error('Zone Cannot be null')
                    else
                        InsertBaseRate.InsertTariffBaseRate(prtIdCode, tarIdCode);
                end;
            }
        }
    }
    var
        prtIdCode: Code[5];
        tarIdCode: Code[20];
        InsertBaseRate: Codeunit InsertData;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        PrtId := prtIdCode;
        TarId := tarIdCode;
    end;


    procedure SetPrtId(_prtId: Code[5])
    begin
        prtIdCode := _prtId;
    end;

    procedure SetTarId(_TarId: Code[20])
    begin
        tarIdCode := _TarId;
    end;



}