page 50146 "Ord Loc SubForm"
{
    AutoSplitKey = false;
    Caption = 'Locations';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = false;
    PageType = ListPart;
    SourceTable = OrdLoc;

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
                field(LocId; LocId)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        LocationName := GetLocationName.GetLocationName(LocId);
                        ordLocRec.updateLocationOnOrdoc(LocId, ORDocNumber, firstRec);
                    end;


                }

                field(LocationName; LocationName)
                {
                    ApplicationArea = All;
                }
                field(PositionType; PositionType)
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
        GetLocationName: Codeunit getdata;
        ordLocRec: Record OrdLoc;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        ORDocNumber := ORDocNumberCode;

    end;


    procedure SetORDocNumber(_ORDocNumber: Integer)
    begin
        ORDocNumberCode := _ORDocNumber;
    end;

}