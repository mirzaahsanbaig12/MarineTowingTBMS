codeunit 50110 "Insert Address"
{
    procedure InsertAddress(_AddId: Code[5])
    var
        address: Record Address;
    begin
        address.SetFilter(AddId, _AddId);
        if not address.FindFirst()
        then begin
            address.Validate(AddId, _AddId);
            address.Insert(true);
        end;
    end;

    procedure webService()
    var
        httpclient: HttpClient;
        httpresonse: HttpResponseMessage;
        httpresponseText: Text;
        url: text;
    Begin
        url := StrSubstNo('https://businesscentral.dynamics.com/sandbox?page=22&redirectedfromsignup=1&runinframe=1#');
        httpclient.Get(url, httpresonse);
        httpresonse.Content.ReadAs(httpresponseText);
        Message(httpresponseText);
    End;



    var
        myInt: Integer;
}