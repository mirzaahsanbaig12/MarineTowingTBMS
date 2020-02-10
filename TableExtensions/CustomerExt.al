tableextension 50110 CustomerExt extends Customer
{
    fields
    {
        // Add changes to table fields here
        field(50110; TBMSAgent; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Agent';

        }

        field(50111; TBMSCustomer; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Customer';

        }

        field(50112; TBMSOwner; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Owner/Charter';

        }

        field(50113; TBMSBusinessType; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'Business Type';
            Caption = 'Business Type';
            OptionMembers = "","Internal","External";
        }

    }

    var
        myInt: Integer;
}