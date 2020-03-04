page 50155 "Invoice Note Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Invoice Notes";
    Caption = 'Invoice Note Card';

    layout
    {
        area(Content)
        {
            group("General")
            {
                field(TerId; TerId)
                {
                    ApplicationArea = All;
                }
                group("Description")
                {
                    Caption = 'Description';
                    field(NotesDescription; NotesDescription)
                    {
                        ApplicationArea = Basic, Suite;
                        MultiLine = true;
                        ShowCaption = false;

                        trigger OnValidate()
                        begin
                            SetNotesDescription(NotesDescription);
                        end;
                    }
                }
                field(Status; Status)
                {
                    ApplicationArea = All;
                }

                field(InoMemos; InoMemos)
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

                trigger OnAction()
                begin

                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        NotesDescription := GetNotesDescription;
    end;

    var
        myInt: Integer;
        NotesDescription: Text;
}
