codeunit 50119 DateTimeTest
{
    trigger OnRun()

    var
        DateTime1: DateTime;
        DateTime2: DateTime;
        Duration1: Duration;
        num: Decimal;
        num2: Decimal;
    begin


        begin
            DateTime1 := CREATEDATETIME(20090101D, 071055T); // January 1, 2009 at 08:00:00 AM  
            DateTime2 := CREATEDATETIME(20090102D, 090000T); // May 5, 2009 at 1:30:01 PM  
            Duration1 := DateTime2 - DateTime1;
            num := Duration1 / 3600000;
            num2 := Round(num, 1, '=');
            MESSAGE('hours %1 and %2', num, num2);
        end;
    end;

    var
        myInt: Integer;
}