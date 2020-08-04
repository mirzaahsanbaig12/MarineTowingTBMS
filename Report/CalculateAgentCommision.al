report 50114 "Calculate Agent Commission"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {

    }

    requestpage
    {
        SaveValues = true;
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    field(DocumentDate; DocumentDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Enter end date to calculate agent commission';
                    }
                }
            }
        }


    }

    trigger OnPostReport()
    begin
        CalcAgentCommissionLine.CreateCommissionLines(DocumentDate);
    end;

    var
        DocumentDate: Date;
        CalcAgentCommissionLine: Codeunit CreateAgentCommissionLine;


}

