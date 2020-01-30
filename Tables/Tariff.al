table 50129 "Tariff"
{
    DataClassification = ToBeClassified;
    Caption = 'Tariff Register';

    fields
    {
        field(50110; TarId; Code[5])
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



    }

    keys
    {
        key(PK; TarId)
        {
            Clustered = true;
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
    begin

    end;

    trigger OnRename()
    begin

    end;



}