page 50130 "Tariff Register Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Tariff;
    Caption = 'Tariff Card';

    layout
    {
        area(Content)
        {
            group("General")
            {
                field(TarId; TarId)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        CurrPage."Tariff Base Rate Subfrom".Page.SetTarId(TarId);
                    end;
                }
                field(Descr; Descr)
                {
                    ApplicationArea = All;
                }
                field(Status; Status)
                {
                    ApplicationArea = All;
                }

                field(TariffType; TariffType)
                {
                    ApplicationArea = All;
                }

                field(DateBegining; DateBegining)
                {
                    ApplicationArea = All;
                }

                field(DateEnding; DateEnding)
                {
                    ApplicationArea = All;
                }

            }

            group("Job Docking/ UnDocking and Shifting")
            {
                field(JobStandardTime; JobStandardTime)
                {
                    ApplicationArea = All;
                }

                field(JobShiftTime; JobShiftTime)
                {
                    ApplicationArea = All;
                }

                field(JobSpPer; JobSpPer)
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field(JobShiftType; JobShiftType)
                {
                    ApplicationArea = All;
                }

                field(JobUDPer; JobUDPer)
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field(JobShiftAmount; JobShiftAmount)
                {
                    ApplicationArea = All;
                }

            }

            group("Fuel Surcharge Rate")
            {
                field(FSType; FSType)
                {
                    ApplicationArea = All;
                }

                field(FSDiscountFlag; FSDiscountFlag)
                {
                    ApplicationArea = All;
                }

                field(FSPrcBase; FSPrcBase)
                {
                    ApplicationArea = All;
                }

                field(FSPrcInc; FSPrcInc)
                {
                    ApplicationArea = All;
                }

                field(FSPerBase; FSPerBase)
                {
                    ApplicationArea = All;
                }

                field(FSPerInc; FSPerInc)
                {
                    ApplicationArea = All;
                }

                field(AmountPercent; AmountPercent)
                {
                    Caption = 'Maximum Charge Type';
                    ApplicationArea = All;
                }

                field(MaxiumCharge; MaxiumCharge)
                {
                    ApplicationArea = All;
                }


            }


            /*
            group("Hawser Charge")
            {
                field(HWATBFlag; HWATBFlag)
                {
                    ApplicationArea = All;
                }
                field(HWType; HWType)
                {
                    ApplicationArea = All;
                }

                field(HWRate; HWRate)
                {
                    ApplicationArea = All;
                }
            }
            */
            group("Over Time Rate")
            {
                field(OTATBFlag; OTATBFlag)
                {
                    ApplicationArea = All;
                }

                field(OTType; OTType)
                {
                    ApplicationArea = All;
                }

                field(OTRateAmount; OTRateAmount)
                {
                    ApplicationArea = All;
                }

                field(OTMinAmount; OTMinAmount)
                {
                    ApplicationArea = All;
                }

                field(OTShiftAmount; OTShiftAmount)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }

            group("Turning Charge")
            {
                Visible = false;
                field(TCATBFlag; TCATBFlag)
                {
                    ApplicationArea = All;
                }
                field(TCType; TCType)
                {
                    ApplicationArea = All;
                }

                field(TCRate; TCRate)
                {
                    ApplicationArea = All;
                }
            }

            group("Base Rate")
            {

                group("Zone")
                {
                    field(PrtId; PrtId)
                    {
                        ApplicationArea = All;
                        trigger OnValidate()
                        begin
                            CurrPage."Tariff Base Rate Subfrom".Page.SetPrtId(PrtId);
                        end;
                    }

                    field(FlatRate; FlatRate)
                    {
                        ApplicationArea = All;
                    }

                }

                group("Rate")
                {

                    field(BRInc; BRInc)
                    {
                        ApplicationArea = All;
                    }

                    field(BRAmt; BRAmt)
                    {
                        ApplicationArea = All;
                    }
                }
                //group("Tariff Base Rate")
                //{

                part("Tariff Base Rate Subfrom"; "Tariff Base Rate Subfrom")
                {
                    ApplicationArea = Basic, Suite;
                    SubPageLink = PrtId = FIELD(PrtId), TarId = field(TarId);
                    UpdatePropagation = Both;
                    //Editable = true;
                }
                //}
            }
        }


    }
    trigger OnAfterGetRecord()
    begin
        CurrPage."Tariff Base Rate Subfrom".Page.SetPrtId(PrtId);
        CurrPage."Tariff Base Rate Subfrom".Page.SetTarId(TarId);
    end;

}