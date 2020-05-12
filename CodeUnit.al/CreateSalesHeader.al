codeunit 50114 CreateSalesHeader
{
    procedure CreateSalesHeader(_LogDocNumber: Integer): code[50];
    var
        SalesHeader: Record "Sales Header";
        logDocRec: Record LogDoc;
        customerAcc: code[50];
        contractRec: Record Contract;
    begin
        logDocRec.SetFilter(LogDocNumber, format(_LogDocNumber));
        if logDocRec.FindFirst() then begin

            customerAcc := logDocRec.BusOwner;

            if logDocRec.ConNumber <> 0 then begin
                contractRec.SetFilter(ConNumber, format(logDocRec.ConNumber));
                if contractRec.FindFirst() then begin

                    if contractRec.BillingOptions = contractRec.BillingOptions::Agent then begin
                        customerAcc := logDocRec.BusLA;
                    end
                    else
                        customerAcc := logDocRec.BusOwner;
                end;
            end;

            SalesHeader."Document Type" := SalesHeader."Document Type"::Order;
            SalesHeader.Init();
            SalesHeader.Validate("Sell-to Customer No.", customerAcc);
            SalesHeader.Validate("LogDocNumber", logDocRec.LogDocNumber);
            SalesHeader.Validate("Vessel", logDocRec.VesId);

            if SalesHeader.Insert(true) then begin
                exit(SalesHeader."No."); // return sales order no
            end;

            exit('1111'); //Varible to test is sales order is created or not

        end;


    end;
}