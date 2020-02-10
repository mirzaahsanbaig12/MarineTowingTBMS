page 50139 "Contract SubForm"
{
    AutoSplitKey = false;
    Caption = 'Contract';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = false;
    PageType = ListPart;
    SourceTable = Contract;


    layout
    {
        area(Content)
        {
            repeater(groupname)
            {
                field(BusOc; BusOc)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(ConNumber; ConNumber)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(CmpId; CmpId)
                {
                    ApplicationArea = All;
                }

                field(Status; Status)
                {
                    ApplicationArea = All;
                }

                field(Descr; Descr)
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
        BusOc := BusOcCode;
    end;

    var
        BusOcCode: code[20];

    procedure SetBusOc(_BusOc: Code[20])
    begin
        BusOcCode := _BusOc;
    end;

}