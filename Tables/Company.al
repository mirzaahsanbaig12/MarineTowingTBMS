table 50110 "Company Register"
{
    DataClassification = ToBeClassified;
    //LookupPageId = "Company Register Card";
    DrillDownPageId = "Company Register Card";

    fields
    {
        field(50110; CmpId; Code[5])
        {
            DataClassification = ToBeClassified;
            Description = 'Ident';
            Caption = 'Company Id';
        }
        field(50111; DbId; Code[5])
        {
            DataClassification = ToBeClassified;
            Description = 'DB';
            Caption = 'DB';
        }

        field(50112; TarId; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Default Tariff';
            Caption = 'Default Tariff';
            TableRelation = Tariff.TarId where(TariffType = const(0));
        }

        field(50113; Name; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'Name';
            Caption = 'Name';
        }

        field(50114; Title; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'Title';
            Caption = 'Title';

        }

        field(50115; Email; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'Email';
            Caption = 'Email';
        }


        field(50116; "Phone"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'Phone';
            Caption = 'Phone';
        }

        field(50117; "Fax"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'Fax';
            Caption = 'Fax';
        }

        field(50118; "CmpType"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'Company Type';
            Caption = 'Company Type';
            OptionMembers = "","Internal","External";
        }

        field(50119; Status; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'Status';
            Caption = 'Status';
            OptionMembers = "Active","Inactive","Purge";
        }

        field(50120; Logo; Blob)
        {
            DataClassification = ToBeClassified;
            Description = 'Company Logo';
            Caption = 'Company logo';
        }

        field(50121; AcctRev; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Revenue Account';
            Caption = 'Revenue Account';
            TableRelation = "G/L Account";
        }

        field(50122; DbName; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'Database Name';
            Caption = 'Database Name';

        }

        field(50123; InoInvNumber; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'Next Number';
            Caption = 'Next Number';
        }

        field(50124; InoSegType; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'Sequence Type';
            Caption = 'Sequence Type';

        }

        field(50125; RemitToMessage; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'Remit To memo';
            Caption = 'Remit To memo';
        }

        field(50126; CmpTar; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'Ident';
            Caption = 'Company Tariff';

        }
    }

    keys
    {
        key(PK; CmpId)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;



    trigger OnInsert()
    begin
        IF CmpId = ''
                THEN
            ERROR('Please Add Company Id');

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

    procedure deleteTariffForCompany(CurCmpTar: Integer; PervCmpTar: Integer)
    var
        CompanyTariff: Record TariffForCompany;
        CompanyBaseTariff: Record TarBrForCompany;
    begin
        if (PervCmpTar <> 0) And (CmpTar <> PervCmpTar)
        then begin
            CompanyTariff.SetFilter(CmpTar, format(PervCmpTar));
            CompanyBaseTariff.SetFilter(CmpTar, format(PervCmpTar));
            if (CompanyTariff.FindFirst())
            then begin
                CompanyTariff.Delete();
                if CompanyBaseTariff.FindSet() then begin
                    CompanyBaseTariff.DeleteAll();
                end;
            end;
        end;
    end;

}