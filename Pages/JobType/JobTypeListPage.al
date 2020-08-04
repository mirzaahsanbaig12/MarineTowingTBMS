page 50171 JobTypeListPage
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = JobType;
    CardPageId = JobTypeCardPage;
    Caption = 'Job Type List Page';
    layout
    {
        area(Content)
        {
            repeater(GroupName)
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
        area(Factboxes)
        {

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
}