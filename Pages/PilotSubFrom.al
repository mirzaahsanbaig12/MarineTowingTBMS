page 50133 "Pilot Subform"
{
    AutoSplitKey = false;
    Caption = 'Pilots';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = false;
    PageType = ListPart;
    SourceTable = "Pilot";
    Editable = true;


    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(PaId; PaId)
                {
                    ApplicationArea = All;
                    Visible = false;

                }
                field(PilId; PilId)
                {
                    ApplicationArea = All;

                }

                field(Status; Status)
                {
                    ApplicationArea = All;

                }

                field(Name; Name)
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
        PaId := paIdCode;
    end;

    var
        paIdCode: code[5];

    procedure SetPaId(_paIdCode: Code[5])
    begin
        paIdCode := _paIdCode;
    end;

}