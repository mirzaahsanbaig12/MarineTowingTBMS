page 50172 JobTypeCardPage
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = JobType;
    Caption = 'Job Type Card';
    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(JobType; JobType)
                {
                    ApplicationArea = All;
                    Caption = 'Job Type';
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                    Caption = 'Description';
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

    var
        myInt: Integer;
}