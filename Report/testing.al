report 50133 "API Call"
{
    UsageCategory = Tasks;
    ApplicationArea = All;
    ProcessingOnly = true;
    Caption = 'Api Call';

    dataset
    {
    }

    trigger OnPostReport()
    var
        TimeStart: DateTime;
        Timefinish: DateTime;
    begin
        TimeStart := CREATEDATETIME(20200725D, 030000T);
        Timefinish := CREATEDATETIME(20200725D, 050000T);
        GetOverTimeHours(TimeStart, Timefinish);
    end;

    local procedure CallApi()
    var
    begin
        Username := 'd8589ed80b7f8fe825d868339515db80ebe14293fe6a68a4e7faa3ad6c6a319b';
        Password := '43eab72720cd99058ee94e714df414f2ebc83a9b46ef06ce462f20aa9cb47a9e';
        AuthString := STRSUBSTNO('%1:%2', Username, Password);
        AuthString := Base64Convert.ToBase64(AuthString);
        AuthString := STRSUBSTNO('Basic %1', AuthString);

        //WebRequest.SetProxy();

        client.DefaultRequestHeaders().Add('Authorization', AuthString);
        Url := 'https://api.paycomonline.net/v4/rest/index.php/api/v1/employeeid/';
        // client.DefaultRequestHeaders().Add('user')
        //client.DefaultRequestHeaders().Add('Authorization', 'Basic MTUzZjYxN2I5MjY3ZDcwZDIzZDkwN2QyNGIyYmI0ZmQ5N2E0Nzk2MDQ4MWRlOTYxYTg2MTRlNmZlMGY5ZDE5MjpiNTQ3MmNjYjg0NjUwNTU0NWUzN2VhN2VmYTVkNWFjZWNkZGNlOWQzMzBhYTI1Y2Y0YzNlMGMwNmJhNzg4Zjc1');
        client.Get(Url, Response);

        //Reads the response content from the Azure Function


        Response.Content().ReadAs(json);


        if not jsonObj.ReadFrom(json) then
            Error('invalid response');

        if jsonObj.Get('errors', jToken) then
            jToken.WriteTo(values);
        Message(values);

        tempBlob.CreateOutStream(fileOutStream);
        job.Reset();
        if Job.FindFirst() then
            repeat
                JobTask.Reset();
                JobTask.SetRange("Job No.", Job."No.");
                if JobTask.FindSet() then
                    repeat
                        JobPlanningLine.Reset();
                        JobPlanningLine.SetRange(Type, JobPlanningLine.Type::Item);
                        JobPlanningLine.SetRange("Job Task No.", JobTask."Job Task No.");
                        if JobPlanningLine.FindFirst() then begin
                            fieldCode := FORMAT(JobPlanningLine."No.");
                            fieldSBU := JobTask."Global Dimension 1 Code";
                            FieldGLCode := FORMAT(Job."No.");

                            if Item.Get(JobPlanningLine."No.") then begin
                                fieldDescription := FORMAT(Job."No.") + '-' + Item.Description + '-' + FORMAT(JobTask."Job Task No.");
                                csvLine := fieldCode + ',' + fieldDescription + ',' + fieldSBU + ',' + FieldGLCode;
                                fileOutStream.WriteText(csvLine);
                                fileOutStream.WriteText();
                            end;
                        end;
                    until JobTask.Next() = 0;
            until Job.Next() = 0;


        tempBlob.CreateInStream(fileInstream);
        fileName := 'job items.csv';
        DOWNLOADFROMSTREAM(fileInstream, 'Export', '', 'All Files (*.*)|*.*', fileName);
    end;

    local procedure GetOverTimeHours(startDT: DateTime; endDT: DateTime): Duration
    var
        CompInfo: Record "Company Information";
        CustomizedCalendarChange: Record "Customized Calendar Change";
        CalendarMgmt: Codeunit "Calendar Management";
        baseCalendar: Record "Base Calendar";
        tempStartDate: DateTime;
        OvertimeDuration: Duration;
        tempTime: Time;
        isOverTimeHour: Boolean;
    begin
        baseCalendar.Reset();
        CustomizedCalendarChange.Reset();
        CompInfo.Get();
        baseCalendar.SetRange(Code, CompInfo."Base Calendar Code");
        if baseCalendar.FindFirst() then begin
            CalendarMgmt.SetSource(baseCalendar, CustomizedCalendarChange);
        end;

        tempStartDate := startDT;
        REPEAT
            //CHECK IF HOLIDAY
            IF CalendarMgmt.IsNonworkingDay(DT2DATE(tempStartDate), CustomizedCalendarChange) then begin
                OvertimeDuration := OvertimeDuration + (CreateDateTime(CalcDate('+1D', DT2Date(tempStartDate)), DT2Time(tempStartDate)) - tempStartDate);
                Message('Holiday');
            end
            else begin
                //CHECK FOR NON WORKING HOURS ON WORKING DAY
                tempTime := DT2Time(tempStartDate);
                if (tempTime < 080000T) OR (tempTime > 170000T) then begin
                    isOverTimeHour := true;
                    Message(format(tempTime));
                end;
                Message('working day');
            end;
            tempStartDate := CreateDateTime(CALCDATE('+1D', DT2DATE(tempStartDate)), 000000T);
            Message('loop');
            Message(Format(OvertimeDuration));
        UNTIL endDT < tempStartDate;
        Message('final:%1', format(OvertimeDuration));
        exit(OvertimeDuration);
    end;

    local procedure CalcWorkingHours()
    var
        tempStartDate: DateTime;
        CalendarMgmt: Codeunit 7600;
        TimeStart: DateTime;
        Timefinish: DateTime;
        hours: Duration;
        CompInfo: Record "Company Information";
        CustomizedCalendarChange: Record "Customized Calendar Change";
        baseCalendar: Record "Base Calendar";
    begin
        //calculation working dates
        baseCalendar.Reset();
        CustomizedCalendarChange.Reset();
        CompInfo.Get();
        baseCalendar.SetRange(Code, CompInfo."Base Calendar Code");
        if baseCalendar.FindFirst() then begin
            CalendarMgmt.SetSource(baseCalendar, CustomizedCalendarChange);
        end;
        TimeStart := CREATEDATETIME(20200725D, 050000T);
        Timefinish := CREATEDATETIME(20200725D, 020000T);
        tempStartDate := TimeStart;

        REPEAT
            IF CalendarMgmt.IsNonworkingDay(DT2DATE(tempStartDate), CustomizedCalendarChange) then begin
                hours := hours + (CreateDateTime(CalcDate('+1D', DT2Date(tempStartDate)), 000000T) - tempStartDate);
            end;
            tempStartDate := CreateDateTime(CALCDATE('+1D', DT2DATE(tempStartDate)), 000000T);

        UNTIL Timefinish < tempStartDate;

        Message(Format(hours));
    end;

    var
        fileInstream: InStream;
        fileOutStream: OutStream;
        tempBlob: Codeunit "Temp Blob";
        fileName: Text;
        dialogCaption: Text;
        uploadResult: Boolean;
        client: HttpClient;
        Response: HttpResponseMessage;
        Url: Text;
        json: Text;
        values: Text;
        jsonObj: JsonObject;
        jToken: JsonToken;
        pagss: Page "Document Attachment Details";
        tables: Record "Document Attachment";
        AuthString: Text;
        Base64Convert: Codeunit "Base64 Convert";
        Username: Text;
        Password: Text;
        Job: Record Job;
        Item: Record Item;
        JobTask: Record "Job Task";
        JobPlanningLine: Record "Job Planning Line";
        fieldCode: Text;
        fieldDescription: Text;
        fieldSBU: Text;
        FieldGLCode: Text;
        csvLine: Text;
        WebRequest: Codeunit "Http Web Request Mgt.";
        WebRequestHelper: Codeunit "Web Request Helper";
        test: Record "Sales Header";


}