page 50113 Address
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Address;
    //DelayedInsert = true;
    Caption = 'Address';
    //Editable = true;

    layout
    {
        area(Content)
        {
            field(LineNo; LineNo)
            {
                ApplicationArea = All;
                Visible = false;
            }

            field(AddId; AddId)
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Line 1"; "Line 1")
            {
                ApplicationArea = All;
            }

            field("Line 2"; "Line 2")
            {
                ApplicationArea = All;

            }

            field("Line 3"; "Line 3")
            {
                ApplicationArea = All;

            }
            field(City; City)
            {
                ApplicationArea = All;

            }

            field(State; State)
            {
                ApplicationArea = All;

            }

            field(Zip; Zip)
            {
                ApplicationArea = All;
            }


        }
    }




    var
        myInt: Integer;
}
