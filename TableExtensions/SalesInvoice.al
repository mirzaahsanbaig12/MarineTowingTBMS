tableextension 50114 SalesInvoiceHeaderExt extends "Sales Invoice Header"
{
    fields
    {
        field(50110; LogDocNumber; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Number';
            Editable = false;
        }

    }

    var
        myInt: Integer;
}