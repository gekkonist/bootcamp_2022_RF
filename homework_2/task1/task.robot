*** Settings ***
Resource    resource.robot
Test Setup          Test Setup
Test Teardown       Test Teardown


*** Test Cases ***
Checking the search for data from multiple tables
    ${response}     Take an error PostRest request      table=cust_hist     params=select=customers!inner(firstname,lastname,age,gender),products!inner(title,category,price)&products.price=gt.20&customers.age=gt.20&customers.age=lt.40
    BuiltIn.Should Be Equal  ${response}    200

*** Keywords ***
Take an error PostRest request
    [Arguments]     ${table}       ${params}
    ${response}             Req.GET On Session     alias    /${table}?     params=${params}
    ${response_number}      BuiltIn.Convert To String     ${response}
    [Return]        ${response_number}[11:14]