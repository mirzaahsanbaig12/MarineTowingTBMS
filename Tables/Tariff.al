table 50118 "Tariff"
{
    DataClassification = ToBeClassified;
    Caption = 'Tariff';
    LookupPageId = "Tariff Register Card";

    fields
    {
        field(50110; TarId; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Ident';
            Caption = 'Tariff Id';
        }
        field(50111; Descr; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Description';
        }

        field(50112; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Active","Inactive","Purge";
            Caption = 'Status';
        }

        field(50113; JobStandardTime; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Standard Time';
        }
        field(50114; JobShiftTime; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Shift Time';
        }

        field(50115; JobSpPer; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Stand By Charge %';
        }

        field(50116; JobShiftType; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Shift Adj Type';
            OptionMembers = "Percentage","Amount";
        }

        field(50117; JobUDPer; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Dead Ships/ Unattended Barges %';
        }

        field(50118; JobShiftAmount; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Shift Adj Amount';
        }

        field(50119; FSType; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Type';
            OptionMembers = "All Charges","Base Charges";
        }

        field(50120; FSDiscountFlag; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Discountable';
            OptionMembers = "No","Yes";
        }

        field(50121; FSPrcBase; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Fuel Base Price';
        }

        field(50122; FSPrcInc; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Fuel Price Incr';
        }

        field(50123; FSPerBase; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Surcharge Base %';
            AutoFormatExpression = '<precision, 2:2><standard format,0>%';
            AutoFormatType = 10;
        }

        field(50124; FSPerInc; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Surcharge % incr';
        }

        field(50125; OTATBFlag; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Type';
            OptionMembers = "No","Yes";
        }

        field(50126; OTType; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Add To Base';
            OptionMembers = "Amount Per Base","Percent Of Base","Percent Of Total";
        }

        field(50127; OTRateAmount; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount/Percent';

        }

        field(50128; OTMinAmount; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Minimum Charge';
        }

        field(50129; OTShiftAmount; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Shift Adj Amount';
        }


        field(50130; HWATBFlag; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Add To Base';
            OptionMembers = "No","Yes";
        }

        field(50131; HWType; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Type';
            OptionMembers = "Amount Per Tug","Percent Of Base";
        }

        field(50132; HWRate; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount/ Percent';

        }

        field(50133; TCATBFlag; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Add To Base';
            OptionMembers = "No","Yes";
        }

        field(50134; TCType; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Type';
            OptionMembers = "Amount Per Tug","Percent Of Base";
        }

        field(50135; TCRate; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount/ Percent';
        }

        field(50136; PrtId; code[5])
        {
            Caption = 'Port Id';
            TableRelation = "Port Zone".PrtId;
            DataClassification = ToBeClassified;
        }

        field(50137; DateBegining; Date)
        {
            Caption = 'To Date';
            DataClassification = ToBeClassified;
        }

        field(50138; DateEnding; Date)
        {
            Caption = 'From Date';
            DataClassification = ToBeClassified;
        }

        field(50139; BRInc; Integer)
        {
            Caption = 'Increment Tons';
            DataClassification = ToBeClassified;
        }

        field(50140; BRAmt; Integer)
        {
            Caption = 'Rate Amount';
            DataClassification = ToBeClassified;
        }

        field(50141; TariffType; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Tariff Type';
            OptionMembers = "Base","Change","Customer";
        }

        field(50142; MaxiumCharge; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Maximum Charge';
        }

        field(50143; AmountPercent; Option)
        {
            OptionMembers = "","Amount","Percent";
            Caption = 'Amount/Percent';
        }


    }
    keys
    {
        key(PK; TarId)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; TarId, Descr, TariffType, DateBegining, DateEnding, Status)
        {

        }
    }


    var
        myInt: Integer;

    trigger OnInsert()
    begin
        IF TarId = ''
                THEN
            ERROR('Please Add Tariff Id');

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    var
        baseRate: Record TarBr;
    begin
        baseRate.SetFilter(TarId, TarId);
        if baseRate.FindSet() then
            baseRate.DeleteAll();
    end;

    trigger OnRename()
    begin

    end;


    procedure LookupTariff(var TariffRec: Record Tariff): Boolean
    var
        TariffLookup: Page "Tariff Register List";
        Result: Boolean;
    begin
        TariffLookup.SetTableView(TariffRec);
        TariffLookup.SetRecord(TariffRec);
        TariffLookup.LookupMode := true;
        Result := TariffLookup.RunModal = ACTION::LookupOK;
        if Result then
            TariffLookup.GetRecord(TariffRec)
        else
            Clear(TariffRec);

        exit(Result);
    end;



}