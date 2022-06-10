*** Settings ***
Documentation     Test-case for list with numbers (Homework 1.1)
Library  Collections

*** Variables ***
@{Numbers}      ${1}   ${2}   ${3}   ${5}   ${1}
...             ${0}   ${-1}  ${10}

*** Test Cases ***
Part 1
    Getting the min/max values  ${Numbers}
    BuiltIn.Set Test Message    Part 1 is correct

Part 2
    # Getting unique values   ${Numbers}
    ${numbers unique}    BuiltIn.Create List
    ${numbers unique}=   Collections.Remove Duplicates       ${Numbers}
    log     Unique list - ${numbers unique}
    BuiltIn.Set Test Message    Part 2 is correct

Part 3
    Getting the sum value  ${Numbers}
    BuiltIn.Set Test Message  Part 3 is correct

*** Keywords ***
Getting the min/max values
    [Arguments]         ${numbers}
    ${min}=     BuiltIn.Evaluate    min($numbers)
    ${max}=     BuiltIn.Evaluate    max($numbers)
    log     Minimum value - ${min}
    log     Maximum value - ${max}

Getting unique values
    [Arguments]         ${numbers}
    ${unique}=     BuiltIn.Evaluate    set($numbers)
    Log     Unique list - ${unique}

Getting the sum value
    [Arguments]         ${numbers}
    ${sum}=     BuiltIn.Evaluate    sum($numbers)
    log     Sum - ${sum}