table 50123 Contract
{
    DataClassification = ToBeClassified;
    Caption = 'Contract';
    LookupPageId = "Contract Card";

    fields
    {
        field(50110; ConNumber; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'Number';
            Caption = 'Number';
        }

        field(50111; BusOc; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Owner/Charter';
            TableRelation = Customer;
            ValidateTableRelation = false;
        }

        field(50112; CmpId; Code[5])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Company Register";
            NotBlank = true;
            Caption = 'Company';

        }
        field(50113; DbId; Code[5])
        {
            DataClassification = ToBeClassified;
            Caption = 'DataBase Id';
        }

        field(50114; TerID; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Term Id';
            TableRelation = "Payment Terms";
        }

        field(50115; AgentDiscountDescr; text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Agent Discount Description';
        }


        field(50116; VesLDSurf; text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'VesLDSurf';
        }

        field(50117; Class; text[1])
        {
            DataClassification = ToBeClassified;
            Caption = 'Class';
        }

        field(50118; BDFlag; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Bill Direct';
            OptionMembers = "Yes","No";
        }
        field(50119; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Active","Inactive","Purge";
            Caption = 'Status';
        }

        field(50120; StartDate; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Start Date';
        }

        field(50121; EndDate; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'End Date';
        }

        field(50122; DiscType; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Gross On All Charges","Gross On Base Charges";
            Caption = 'Type';
        }

        field(50123; DiscPer; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Discount Percentage';
            AutoFormatExpression = '<precision, 2:2><standard format,0>%';
            AutoFormatType = 10;
        }

        field(50124; Memo; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Memo';
        }

        field(50125; Descr; text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Description';
        }

        field(50126; TarBase; code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Base Tariff';
            TableRelation = Tariff where(TariffType = const(Base));
        }

        field(50127; TarChange; code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Change Tariff';
            TableRelation = Tariff where(TariffType = const(Customer));
        }
        field(50128; AssistFixedRate; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Fixed Rate';
        }

        field(50129; Rate; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Docking (Un) Rate';
        }

        field(50130; TarCustomer; code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Customer Tariff';
            TableRelation = Tariff where(TariffType = const(Customer));

        }

        field(50131; TarCustomerName; text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Customer Tariff';
            TableRelation = Tariff.Descr where(TariffType = const(Customer));
            ValidateTableRelation = false;
            trigger OnLookup()
            var
                TarCustRec: Record Tariff;
            begin
                if TarCustomer <> '' then
                    TarCustRec.Get(TarCustomer);

                TarCustRec.SetFilter(TariffType, format(TarCustRec.TariffType::Customer));
                if TarCustRec.LookupTariff(TarCustRec) then begin
                    TarCustomerName := TarCustRec.Descr;
                    Validate(TarCustomer, TarCustRec.TarId);
                end;

            end;

        }

        field(50132; BillingOptions; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Billing Options';
            OptionMembers = "","Owner/Charter","Agent";
        }

        field(50133; AssistRate; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Shifting';
        }

    }

    keys
    {
        key(PK; ConNumber)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; ConNumber, CmpId, Descr, Status)
        {

        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin
        ConNumber := GetLastLineNo();
        if CmpId = '' then
            FieldError(CmpId, 'Can not be null');
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

    procedure GetLastLineNo(): Integer
    var
        contractRec: Record Contract;
        lineNoLocal: Integer;
    begin
        ;
        if (contractRec.FindLast()) then begin
            linenolocal := contractRec.ConNumber;
        end
        else begin
            linenolocal := 100;

        end;

        exit(lineNoLocal + 10);

    end;

}