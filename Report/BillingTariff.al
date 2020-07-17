report 50110 "Billing Tariff"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Billing Tariff.rdlc';
    Caption = 'Compare Tariff';



    dataset
    {
        dataitem(CT; TariffForCompany)
        {
            RequestFilterFields = CmpId;
            //RequestFilterFields = TarId;
            column(CTCmpId; CmpId) { }
            column(CTTarId; TarId) { }
            column(CTDescr; Descr) { }
            column(CTTariffType; TariffType) { }
            column(CTDateBegining; DateBegining) { }
            column(CTDateEnding; DateEnding) { }
            column(CTStatus; Status) { }
            column(CtJobStandardTime; JobStandardTime) { }
            column(CTJobShiftType; JobShiftType) { }
            column(CTJobShiftTime; JobShiftTime) { }
            column(CTJobUDPer; JobUDPer) { }
            column(CTJobSpPer; JobSpPer) { }
            column(CTJobShiftAmount; JobShiftAmount) { }
            column(CTFSType; FSType) { }
            column(CTFSDiscountFlag; FSDiscountFlag) { }
            column(CTFSPerBase; FSPerBase) { }
            column(CTFSPerInc; FSPerInc) { }
            column(CTFSPrcBase; FSPrcBase) { }
            column(CTFSPrcInc; FSPrcInc) { }
            column(CTAmountPercent; AmountPercent) { }
            column(CTMaxiumCharge; MaxiumCharge) { }
            column(CTOTATBFlag; OTATBFlag) { }
            column(CTOTMinAmount; OTMinAmount) { }
            column(CTOTRateAmount; OTRateAmount) { }
            column(CTOTShiftAmount; OTShiftAmount) { }
            column(CTOTType; OTType) { }
            column(CTTCATBFlag; TCATBFlag) { }
            column(CTTCType; TCType) { }
            column(CTTCRate; TCRate) { }
            column(CTBRInc; BRInc) { }
            column(CTBRAmt; BRAmt) { }


            dataitem(Tr; Tariff)
            {
                RequestFilterFields = TarId;
                //DataItemLink = "TarId" = field("TarId");
                column(TrTarId; TarId) { }
                column(TrDescr; Descr) { }
                column(TrTariffType; TariffType) { }
                column(TrDateBegining; DateBegining) { }
                column(TrDateEnding; DateEnding) { }
                column(TrStatus; Status) { }
                column(TrJobStandardTime; JobStandardTime) { }
                column(TrJobShiftType; JobShiftType) { }
                column(TrJobShiftTime; JobShiftTime) { }
                column(TrJobUDPer; JobUDPer) { }
                column(TrJobSpPer; JobSpPer) { }
                column(TrJobShiftAmount; JobShiftAmount) { }
                column(TrFSType; FSType) { }
                column(TrFSDiscountFlag; FSDiscountFlag) { }
                column(TrFSPerBase; FSPerBase) { }
                column(TrFSPerInc; FSPerInc) { }
                column(TrFSPrcBase; FSPrcBase) { }
                column(TrFSPrcInc; FSPrcInc) { }
                column(TrAmountPercent; AmountPercent) { }
                column(TrMaxiumCharge; MaxiumCharge) { }
                column(TrOTATBFlag; OTATBFlag) { }
                column(TrOTMinAmount; OTMinAmount) { }
                column(TrOTRateAmount; OTRateAmount) { }
                column(TrOTShiftAmount; OTShiftAmount) { }
                column(TrOTType; OTType) { }
                column(TrTCATBFlag; TCATBFlag) { }
                column(TrTCType; TCType) { }
                column(TrTCRate; TCRate) { }
                column(TrBRInc; BRInc) { }
                column(TrBRAmt; BRAmt) { }


                /*
                dataitem(TarBr; TarBr)
                {
                    DataItemLink = "TarId" = field("TarId");
                    column(TrTonnageEnd; TonnageEnd) { }
                    column(TrRate; Rate) { }
                    column(TrPrtId; PrtId) { }

                }
                */

            }
            /*dataitem(CTBaseRate; TarBrForCompany)
            {
                DataItemLink = "CmpTar" = field("CmpTar");
                column(CTTonnageEnd; TonnageEnd) { }
                column(CTRate; Rate) { }
                column(CTPrtId; PrtId) { }
            }*/

        }




    }

    requestpage
    {
        SaveValues = true;

    }
}



