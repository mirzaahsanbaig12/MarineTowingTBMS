page 50145 "Ord Tug SubForm"
{
    AutoSplitKey = false;
    Caption = 'Ordered Tug';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = false;
    PageType = ListPart;
    SourceTable = OrdTug;
    ;


    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(ORDocNumber; ORDocNumber)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(TugId; TugId)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        TugName := GetTugName.GetTugName(TugId);
                    end;

                }

                field(TugName; TugName)
                {
                    ApplicationArea = All;
                }
                field(confirmFlag; confirmFlag)
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

    var
        ORDocNumberCode: Integer;
        GetTugName: Codeunit getdata;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        ORDocNumber := ORDocNumberCode;

    end;


    procedure SetORDocNumber(_ORDocNumber: Integer)
    begin
        ORDocNumberCode := _ORDocNumber;
    end;

}