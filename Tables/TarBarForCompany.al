table 50134 TarBrForCompany
{
    DataClassification = ToBeClassified;
    Caption = 'Tariff Rate for Company';

    fields
    {
        field(50110; LineNo; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(50111; TarId; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Tariff.TarId;
        }

        field(50112; PrtId; code[5])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Port Zone".PrtId;
            Caption = 'Port';
        }

        field(50113; class; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(50114; TonnageBeg; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(50115; TonnageEnd; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Tonnage';
        }
        field(50116; Rate; Decimal)
        {
            DataClassification = ToBeClassified;
            AutoFormatType = 10;
            AutoFormatExpression = '1,USD';
        }

        field(50117; CmpId; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Ident';
            Caption = 'Company Id';
            TableRelation = "Company Register";
        }

        field(50118; CmpTar; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'Ident';
            Caption = 'Company Tariff';

        }
    }

    keys
    {
        key(PK; LineNo)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

        LineNo := GetLineNo();

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

    procedure GetLineNo(): Integer
    var
        LineNo: Integer;
        TarBarRec: Record TarBr;
    begin
        TarBarRec.Reset();
        if (TarBarRec.FindLast())
        then begin

            LineNo := TarBarRec.LineNo;
        end
        else begin
            LineNo := 0;
        end;

        exit(LineNo + 1);

    end;

}