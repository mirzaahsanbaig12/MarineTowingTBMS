page 50139 "Contract SubForm"
{
    AutoSplitKey = false;
    Caption = 'Contract';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = false;
    PageType = ListPart;
    SourceTable = Contract;
    CardPageId = "Contract Card";

    layout
    {
        area(Content)
        {
            repeater(groupname)
            {
                field(BusOc; BusOc)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(ConNumber; ConNumber)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(CmpId; CmpId)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }

                field(Status; Status)
                {
                    ApplicationArea = All;
                }

                field(Descr; Descr)
                {
                    ApplicationArea = all;
                }

            }
        }
    }



    actions
    {
        area(Processing)
        {
            action("New With Current Customer")
            {
                ApplicationArea = All;

                trigger OnAction();
                begin
                    InsertContract.InsertContract(BusOcCode);
                    contractRec.Reset();
                    contractRec.SetRange(BusOc, BusOcCode);
                    contractRec.FindLast();
                    ContractCardLocal.SetRecord(contractRec);
                    ContractCardLocal.Run();
                end;
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        BusOc := BusOcCode;
    end;

    var
        BusOcCode: code[20];
        ContractCardLocal: Page "Contract Card";
        InsertContract: Codeunit InsertData;
        contractRec: Record Contract;

    procedure SetBusOc(_BusOc: Code[20])
    begin
        BusOcCode := _BusOc;
    end;



}