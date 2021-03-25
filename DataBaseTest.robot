*** Settings ***
Library           DatabaseLibrary
Library           OperatingSystem

*** Variables ***
${DB_CONNECT_STRING}    'system/oracle@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=localhost)(PORT=4961))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=xe)))'

*** Keywords ***
Connect To DB
    [Arguments]    ${DB_CONNECT_STRING_VALUE}
    Set Environment Variable    PATH    C:\\instantclient_19_10
    Set Global Variable    ${DB_CONNECT_STRING_VALUE}
    #Connect to DB
    connect to database using custom params    cx_Oracle    ${DB_CONNECT_STRING_VALUE}

Run Query and log results
    [Arguments]    ${QUERY_TO_EXECUTE}
    Set Global Variable    ${QUERY_TO_EXECUTE}
    ${queryResults}    Query    ${QUERY_TO_EXECUTE}
    log to console    ${queryResults}

Disconnect From DB
    #Disconnect from DB
    disconnect from database

Count values from table
    Row Count Is Equal To X 	select id from funcionarios  2

*** Test Cases ***
Test Connetion
    [Tags]    DBConnect
    Connect To DB    ${DB_CONNECT_STRING}
    Run Query and log results    select * from funcionarios
    Disconnect From DB

Test Count Values from Table Customers
    [Tags]    DBConnect
    Connect To DB   ${DB_CONNECT_STRING_VALUE}
    Count values from table
    Disconnect From DB
