table 50124 ConAgent
{
    DataClassification = ToBeClassified;
    Caption = 'Contract Agent';
    LookupPageId = "Contract Agent SubForm";

    fields
    {
        field(50110; LineNo; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'LineNo';
            Caption = 'LineNo';
            AutoIncrement = true;
        }
        field(50111; ConNumber; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'ConNumber';
            TableRelation = Contract;
        }

        field(50112; BusId; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Agent Name';
            TableRelation = Customer where(TBMSAgent = const(true));
        }

        field(50113; DbId; Code[5])
        {
            DataClassification = ToBeClassified;

        }

        field(50114; CommonType; text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Confidential Discount';
            ObsoleteState = Removed;
            ObsoleteReason = 'Field type change';
        }

        field(50115; CommonPer; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Percentage';
            AutoFormatExpression = '<precision, 2:2><standard format,0>%';
            AutoFormatType = 10;
        }
        field(50116; DiscType; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Confidential Discount';
            ObsoleteState = Removed;
            ObsoleteReason = 'Field type change';


        }
        field(50119; DiscType1; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Confidential Discount';
            OptionMembers = "","DISCOUNTABLE","GROSS","NET","NET/NET";

        }

        field(50117; DiscPer; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Discount Percentage';
            AutoFormatExpression = '<precision, 2:2><standard format,0>%';
            AutoFormatType = 10;
        }

        field(50118; IsConfidential; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Is Confidential';
            InitValue = false;
        }

        field(50120; CommonType1; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Commission Type';
            OptionMembers = "","DISCOUNTABLE","GROSS","NET","NET/NET";
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
        if IsConfidential then begin
            if DiscPer = 0 then
                FieldError(DiscPer, 'value cannot be zero');
        end
        else begin

            if CommonPer = 0 then
                FieldError(CommonPer, 'cannot be zero');
        end;

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

}