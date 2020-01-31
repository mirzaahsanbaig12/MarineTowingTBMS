page 50130 "Tariff Register Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Tariff;
    Caption = 'Tariff Register Card';

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
                }
                field(Descr; Descr)
                {
                    ApplicationArea = All;
                }
                field(Status; Status)
                {
                    ApplicationArea = All;
                }

            }

            group("Tariff")
            {
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
                    }

                    field(JobShiftType; JobShiftType)
                    {
                        ApplicationArea = All;
                    }

                    field(JobUDPer; JobUDPer)
                    {
                        ApplicationArea = All;
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
                }


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
                    }
                }

                group("Turning Charge")
                {
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

            }
        }
    }





    /*actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }
    */

    var
        myInt: Integer;
}
