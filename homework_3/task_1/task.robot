*** Settings ***
Resource            resource.robot
Default Tags        defaults
Documentation       Тест на проверку поиска данных из нескольких таблиц
Metadata            Автор                   Костин Георгий
Metadata            Поток                   Тестирование
Metadata            Домашнее задание        RF/3
Metadata            Задача                  1

Test Timeout        1s

Test Setup          Test Setup
Test Teardown       Test Teardown


*** Test Cases ***
Checking the search for data from multiple tables
    ${response}     EPS.Take An Error Postrest Request      table=cust_hist     params=select=customers!inner(firstname,lastname,age,gender),products!inner(title,category,price)&products.price=gt.20&customers.age=gt.20&customers.age=lt.40
    BuiltIn.Should Be Equal  ${response}    200