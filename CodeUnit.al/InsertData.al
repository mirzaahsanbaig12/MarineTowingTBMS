codeunit 50112 InsertData
{
    procedure InsertContract(_BusOc: code[20]): Boolean
    var

        Contract: Record "Contract";
        Company: Record "Company Register";
    begin
        Contract.Reset();

        if Company.FindFirst() then begin
            Contract.Validate(BusOc, _BusOc);
            Contract.Validate(BusOc, _BusOc);
            Contract.Validate(CmpId, Company.CmpId); //addind company by default
            if Contract.Insert(true) then
                exit(true);
        end;

        exit(false);

    end;

    procedure InsertTariffBaseRate(_portId: code[20]; _TarId: code[20]): Boolean
    var
        Tonnage: Integer;
        BaseRate: Record TarBr;
        BaseRateExist: Record TarBr;
    Begin
        Tonnage := 0;
        while Tonnage < 30000 do begin

            Tonnage := Tonnage + 1000;
            BaseRate.Reset();
            BaseRate.PrtId := _portId;
            baseRate.TarId := _TarId;
            BaseRate.TonnageEnd := Tonnage;
            BaseRate.Rate := 0;

            BaseRateExist.SetFilter(TarId, _TarId);
            BaseRateExist.SetFilter(PrtId, _portId);
            BaseRateExist.SetRange(TonnageEnd, Tonnage);

            if BaseRateExist.FindFirst() then begin // if tonnage already adde then dont add it
            end

            else begin
                BaseRate.Insert(true)
            end;

            ;
        end;

        exit(true);

    End;

    procedure CopyTariff(_tarId: Code[20]): Boolean
    var
        tariffOrg: Record Tariff;
        tariffNew: Record Tariff;
        TarBaseRateOrg: Record TarBr;
        TarBaseRateNew: Record TarBr;
        lineNo: Integer;
    begin

        TarBaseRateNew.Init();

        TarBaseRateNew.Reset();
        tariffNew.Reset();
        tariffNew.Init();

        lineNo := TarBaseRateOrg.GetLineNo();

        if tariffOrg.Get(_tarId) then begin
            tariffNew.TransferFields(tariffOrg);
            tariffNew.TarId := 'T' + Format(Random(999999999));
            tariffNew.Insert(true);
            Commit();

            TarBaseRateOrg.SetFilter(TarId, _tarId);
            if TarBaseRateOrg.FindSet() then begin
                repeat

                    lineNo := lineNo + 1;
                    TarBaseRateNew.TransferFields(TarBaseRateOrg);
                    TarBaseRateNew.TarId := tariffNew.TarId;
                    TarBaseRateNew.LineNo := lineNo;
                    TarBaseRateNew.Insert(false);
                until TarBaseRateOrg.Next = 0;
            end;
            Message('New Tariff Created with name %1', tariffNew.TarId);
            exit(true);
        end;
        exit(false);

    End;

    procedure InsertTariffForCompany(_tarId: code[20]; _cmpId: Code[20]): Integer
    var
        tariffOrg: Record Tariff;
        tariffCompany: Record TariffForCompany;
        TarBaseRateOrg: Record TarBr;
        TarBaseCompany: Record TarBrForCompany;
        lineNo: Integer;
        CmpTarNo: Integer;
    begin

        TarBaseCompany.Init();

        TarBaseCompany.Reset();
        tariffCompany.Reset();
        tariffCompany.Init();

        lineNo := TarBaseCompany.GetLineNo();
        CmpTarNo := tariffCompany.GetLastLineNo();
        if tariffOrg.Get(_tarId) then begin
            tariffCompany.TransferFields(tariffOrg);
            tariffCompany.CmpId := _cmpId;
            tariffCompany.CmpTar := CmpTarNo;
            tariffCompany.Insert(true);
            Commit();

            TarBaseRateOrg.SetFilter(TarId, _tarId);
            if TarBaseRateOrg.FindSet() then begin
                repeat

                    lineNo := lineNo + 1;
                    TarBaseCompany.TransferFields(TarBaseRateOrg);
                    TarBaseCompany.LineNo := lineNo;
                    TarBaseCompany.CmpId := _cmpId;
                    TarBaseCompany.CmpTar := CmpTarNo;
                    TarBaseCompany.Insert(false);
                until TarBaseRateOrg.Next = 0;
            end;
            exit(CmpTarNo);
        end;
        exit(0);

    end;



}
