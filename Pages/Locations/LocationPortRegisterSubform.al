page 50152 "LocationPortRegisterSubform"
{
    AutoSplitKey = false;
    Caption = 'Port Register';
    DelayedInsert = true;
    LinksAllowed = false;
    Editable = true;
    InsertAllowed = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = LocationPort;


    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {

                field(LocId; LocId)
                {
                    ApplicationArea = All;
                    Visible = false;

                }

                field(PrtId; PrtId)
                {
                    ApplicationArea = All;

                }
            }


        }
    }

}