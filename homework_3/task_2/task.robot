*** Settings ***
Resource            resource.robot
Default Tags        defaults
Documentation       Tест на проверку изменения данных в одной таблице
Metadata            Автор                   Костин Георгий
Metadata            Поток                   Тестирование
Metadata            Домашнее задание        RF/3
Metadata            Задача                  2

Test Timeout        1s

Test Setup          Test Setup
Test Teardown       Test Teardown


*** Variables ***
&{data}                     category=17     categoryname=BootcampUser


*** Test Cases ***
Checking data changes in one table
    CCDB.Post new data      data=&{data}
    ${category}             ${categoryname}     CCDB.Get Category ID And Category Name Customers From Postrest
    ${categoryname_db}      ${category_db}      CCDB.Get Category ID And Category Name Customers From DB
    CCDB.Compare results    category=${category}    categoryname=${categoryname}    category_db=${category_db}    categoryname_db=${categoryname_db}