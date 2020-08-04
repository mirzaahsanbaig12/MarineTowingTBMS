tableextension 50121 PurchaseInvoiceHeaderExt extends "Purch. Inv. Header"
{
    fields
    {
        // Add changes to table fields here
        field(50110; SalesOrderNo; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Sales Invoice Header"."No.";
        }
    }

    var
        myInt: Integer;
}