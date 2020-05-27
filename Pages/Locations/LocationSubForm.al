page 50122 "Location SubForm"
{
    AutoSplitKey = false;
    Caption = 'Locations';
    DelayedInsert = true;
    LinksAllowed = false;
    Editable = false;
    InsertAllowed = false;
    MultipleNewLines = false;
    PageType = ListPart;
    SourceTable = "Location Register";
    SourceTableView = where(PrtId = filter(<> ''));
    // SourceTableView = WHERE("Document Type" = FILTER(Order));


    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {

                field(LocId; LocId)
                {
                    ApplicationArea = All;

                }

                field("type"; "type")
                {
                    ApplicationArea = All;

                }

                field(Status; Status)
                {
                    ApplicationArea = All;

                }

                field(Description; Description)
                {
                    ApplicationArea = All;

                }

            }
        }
    }

}