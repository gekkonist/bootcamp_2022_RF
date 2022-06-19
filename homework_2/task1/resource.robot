*** Settings ***
Library         RequestsLibrary     WITH NAME   Req
Library         PostgreSQLDB        WITH NAME   DB


*** Keywords ***
Test Setup
    Req.Create session          alias       http://localhost:3000
    DB.Connect To Postgresql    app_db      app_user    password    localhost   5432

Test Teardown
    Req.Delete All Sessions
    DB.Disconnect From Postgresql
