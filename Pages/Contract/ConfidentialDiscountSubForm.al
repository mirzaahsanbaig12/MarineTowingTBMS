page 50170 "Confidential Discount SubForm"
{
    AutoSplitKey = false;
    Caption = 'Confidential Discount';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = false;
    PageType = ListPart;
    SourceTable = ConAgent;
    SourceTableView = WHERE(IsConfidential = const(true));

    layout
    {
        area(Content)
        {
            repeater(groupname)
            {
                field(LineNo; LineNo)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(ConNumber; ConNumber)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;

                }
                field(BusId; BusId)
                {
                    ApplicationArea = All;
                }

                field(DiscType; DiscType)
                {
                    ApplicationArea = all;
                }
                field(DiscPer; DiscPer)
                {
                    ApplicationArea = all;
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
        ConNumber := ConNumberCode;
        IsConfidential := true;
    end;

    var
        ConNumberCode: Integer;

    procedure SetConNumber(_ConNumber: Integer)
    begin
        ConNumberCode := _ConNumber;
    end;

}