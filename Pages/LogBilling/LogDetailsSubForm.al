page 50149 "Log Details"
{
    AutoSplitKey = false;
    Caption = 'Log Details';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = false;
    PageType = ListPart;
    SourceTable = LogDet;


    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {

                field(TugId; TugId)
                {
                    ApplicationArea = All;

                }

                field(CapId; CapId)
                {
                    ApplicationArea = All;
                }

                field(LocStr; LocStr)
                {
                    ApplicationArea = All;
                }

                field(DestinationStr; DestinationStr)
                {
                    ApplicationArea = All;
                }

                field(TimeStart; TimeStart)
                {
                    ApplicationArea = All;
                }

                field(Timefinish; Timefinish)
                {
                    ApplicationArea = All;
                }

                field(Distance; Distance)
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field(TCFlag; TCFlag)
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field(SBFlag; SBFlag)
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field(NumberCables; NumberCables)
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field(NumberLines; NumberLines)
                {
                    ApplicationArea = All;
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
        LogDocNumberCode: Integer;


    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        LogDocNumber := LogDocNumberCode;

    end;


    procedure SetLogDocNumber(_LogDocNumber: Integer)
    begin
        LogDocNumberCode := _LogDocNumber;
    end;

}