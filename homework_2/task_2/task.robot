*** Settings ***
Resource            resource.robot
Test Setup          Test Setup
Test Teardown       Test Teardown


*** Variables ***
${SQL}                      SELECT *
...                         from bootcamp.categories


*** Test Cases ***
Checking data changes in one table
    ${data}         BuiltIn.Create Dictionary       category=17     categoryname=BootcampUser
    POST new data   ${data}
    ${category}     ${categoryname}             Get Category ID And Category Name Customers From PostRest
    ${categoryname_db}      ${category_db}      Get Category ID And Category Name Customers From DB    ${SQL}
    Compare results     ${category}      ${categoryname}   ${category_db}      ${categoryname_db}


*** Keywords ***
POST new data
    [Arguments]     ${data}
    ${response}   Req.POST On Session     alias       /categories?    data=${data}    json=application/json

Get Category ID And Category Name Customers From PostRest
    ${resp}         Req.GET On Session     alias    /categories?
    ${category}             JS.get elements   ${resp.json()}    $..category
    ${categoryname}         JS.get elements   ${resp.json()}    $..categoryname
    [Return]    ${category}     ${categoryname}

Get Category ID And Category Name Customers From DB
    [Arguments]     ${SQL}
    @{result}     DB.Execute Sql String Mapped   ${SQL}
    ${categoryname_db}              Create List
    ${category_db}                  Create List
    FOR   ${k}  IN  @{result}
        ${k2}   convert to number     ${k}[category]
        Col.Append To List                  ${categoryname_db}          ${k}[categoryname]
        Col.Append To List                  ${category_db}              ${k2}
    END
    [Return]    ${categoryname_db}      ${category_db}

Compare results
    [Arguments]    ${category_id_rest}   ${categoryname_rest}   ${category_db}      ${categoryname_db}
    Col.Lists Should Be Equal   ${category_id_rest}         ${category_db}
    Col.Lists Should Be Equal   ${categoryname_rest}        ${categoryname_db}