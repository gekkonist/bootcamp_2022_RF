*** Settings ***
Documentation     Test-case for checking formula (Homework 1.2)
Library  Collections

*** Test Cases ***
Celsios to Fahrenheit
    ${celsios}      BuiltIn.Create List      ${0}           ${350}
    ...                                      ${-32}         ${100}
    ${fahrenheit}   BuiltIn.Create List      ${32}          ${662}
    ...                                      ${-25.6}       ${212}
    ${answer}   Check the formula       ${celsios}
    BuiltIn.Should Be Equal     ${answer}   ${fahrenheit}
    BuiltIn.Set Test Message    Formula is correct

*** Keywords ***
Check the formula
    [Arguments]     ${numbers}
    ${answer}       BuiltIn.Create List
    FOR     ${number}    IN       @{numbers}
        ${gap}=     BuiltIn.Evaluate        9/5 * ${number} + 32
        Collections.Append To List    ${answer}     ${gap}
    END
    [Return]        ${answer}