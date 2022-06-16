*** Settings ***
Test Setup      Test Setup
Test Teardown   Test Teardown
Test Template    Get And Check Response
Library         RequestsLibrary     WITH NAME   Req
Library         PostgreSQLDB        WITH NAME   DB

*** Test Cases ***
Check Search One Table #1      customers            age=lt.21&state=eq.SD
Check Search One Table #2      customer             age=lt.21state=eq.SD
Check Search One Table #3      customers            age=lt.twentyOne&state=eq.SD

*** Keywords ***
Get And Check Response
    [Arguments]     ${table}     ${params}
    ${response}             Req.GET On Session     alias    /${table}?   params=${params}     expected_status=any
    ${response_number}      BuiltIn.Convert To String     ${response}
    run keyword if          ${response_number}[11:14] != 200    Error Message   ${response_number}      ${response}     ELSE    BuiltIn.Set Test Message    That's right

Error message
    [Arguments]  ${response_number}     ${response}
    BuiltIn.Set Test Message    Error ${response_number}[11:14]. ${response.json()}[message]

Test Setup
    Req.Create session          alias       http://localhost:3000
    DB.Connect To Postgresql    app_db      app_user    password    localhost   5432

Test Teardown
    Req.Delete All Sessions
    DB.Disconnect From Postgresql

