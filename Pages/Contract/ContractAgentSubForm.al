page 50140 "Contract Agent SubForm"
{
    AutoSplitKey = false;
    Caption = 'Contract Agent';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = false;
    PageType = ListPart;
    SourceTable = ConAgent;
    SourceTableView = WHERE(IsConfidential = const(false));


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
                field(CommonType; CommonType1)
                {
                    ApplicationArea = All;
                }

                field(CommonPer; CommonPer)
                {
                    ApplicationArea = All;
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
        IsConfidential := false;
    end;

    var
        ConNumberCode: Integer;

    procedure SetConNumber(_ConNumber: Integer)
    begin
        ConNumberCode := _ConNumber;
    end;

}