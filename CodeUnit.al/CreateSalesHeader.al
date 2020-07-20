codeunit 50114 CreateSalesHeader
{
    procedure CreateSalesHeader(_LogDocNumber: Integer): code[50];
    var
        SalesHeader: Record "Sales Header";
        logDocRec: Record LogDoc;
        customerAcc: code[50];
        contractRec: Record Contract;
        InvoiceNotes: Record "Invoice Notes";
    begin
        logDocRec.SetFilter(LogDocNumber, format(_LogDocNumber));
        SalesHeader.Init();
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

                if InvoiceNotes.Get(contractRec."Invoice Note Id") then begin

                    InvoiceNotes.CalcFields(Descr);
                    SalesHeader."Invoice Notes" := InvoiceNotes.GetNotesDescription();
                end;
            end;

            SalesHeader."Document Type" := SalesHeader."Document Type"::Order;
            SalesHeader.Validate("Sell-to Customer No.", customerAcc);
            SalesHeader.Validate("LogDocNumber", logDocRec.LogDocNumber);
            SalesHeader.Validate("Vessel", logDocRec.VesId);
            SalesHeader.Validate(ConNumber, logDocRec.ConNumber);
            SalesHeader.Validate(logdate, DT2Date(logDocRec.Datelog));

            if SalesHeader.Insert(true) then begin
                exit(SalesHeader."No."); // return sales order no
            end;

            exit('1111'); //Varible to test is sales order is created or not

        end;


    end;
}