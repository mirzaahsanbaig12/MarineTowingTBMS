tableextension 50120 PurchaseHeaderExt extends "Purchase Header"
{
    fields
    {

        field(50110; SalesOrderNo; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Sales Header"."No." WHERE("Document Type" = const(Order));
        }
        // Add changes to table fields here
    }

    var
        myInt: Integer;
}