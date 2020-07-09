table 50122 TarBr
{
    DataClassification = ToBeClassified;


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
            Caption = 'Zone Id';
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
            //AutoFormatType = 10;
            //AutoFormatExpression = '1,USD';
            DecimalPlaces = 0 : 5;
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