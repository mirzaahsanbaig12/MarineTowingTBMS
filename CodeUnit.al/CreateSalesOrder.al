codeunit 50113 CreateSalesOrder
{
    procedure CreateSalesOrder(_LogDocNumber: Integer)
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        logDocRec: Record LogDoc;
        logDetRec: Record LogDet;
        lineNo: Integer;
    begin
        logDocRec.SetFilter(LogDocNumber, format(_LogDocNumber));
        if logDocRec.FindFirst() then begin
            SalesHeader."Document Type" := SalesHeader."Document Type"::Order;
            SalesHeader.Init();
            SalesHeader.Validate("Sell-to Customer No.", logDocRec.BusOwner);

            if SalesHeader.Insert(true) then begin
                Commit();
                Message('Sale Order : %1 has been created', SalesHeader."No.");

                SalesLine.SetFilter("Document Type", format(SalesLine."Document Type"::Order));
                SalesLine.SetFilter("Document No.", SalesHeader."No.");


                if SalesLine.FindLast() then begin
                    lineNo := SalesLine."Line No."
                end
                else
                    lineNo := 1000;


                logDetRec.SetFilter(LogDocNumber, Format(_LogDocNumber));
                if logDetRec.FindSet() then Begin
                    repeat
                        SalesLine."Document No." := SalesHeader."No.";
                        SalesLine.Init();
                        SalesLine.Validate("Line No.", lineNo);
                        SalesLine.Validate("Document Type", SalesLine."Document Type"::Order);
                        SalesLine.Validate("Type", SalesLine.Type::"G/L Account");
                        SalesLine.Validate("No.", Format(40100));
                        SalesLine.Validate("Quantity", 1);
                        SalesLine.Validate("Unit Price", 1500);
                        SalesLine.Validate("Line Amount", 1500);
                        SalesLine.Insert(true);
                        lineNo := lineNo + 100;

                    until logDetRec.Next() = 0;

                end;



            end;


        end;


    end;
}