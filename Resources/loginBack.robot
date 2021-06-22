*** Settings ***
Library  SeleniumLibrary
Library  RequestsLibrary
Library  DatabaseLibrary
Resource  variables.robot

*** Keywords ***
verifier que l'utilisateur exist dans la BD
    Connect To Database Using Custom Params  pymysql  database='demo', user='root', password='', host='localhost'
    Row Count Is Equal To X  select id from users where username = '${USERNAME}' and password = md5('${PASSWORD}')  1
Authentifier l'utilisateur dans l'application
    Create Session  session3  ${WEBSITE_LINK}
    ${response} =  Get Request  session3  login.php?username=${USERNAME}&password=${PASSWORD}
    ${json} =  Set Variable  ${response.json()}
    Log  ${json}
    Should Be Equal As Strings  ${response.status_code}  200
    Should Be Equal As Strings  ${json['message']}  Successfully Login!
Supprimer Utilisateur de la BD
    Connect To Database Using Custom Params  pymysql  database='demo', user='root', password='', host='localhost'
    Execute Sql String  DELETE from users where username = '${USERNAME}' and password = md5('${PASSWORD}')
    Disconnect from Database
Authentifier utilisateur inexistant dans l'application
    Create Session  session4  ${WEBSITE_LINK}
    ${response} =  Get Request  session4  login.php?username=${USERNAME}&password=${PASSWORD}
    ${json} =  Set Variable  ${response.json()}
    Log  ${json}
    Should Be Equal As Strings  ${response.status_code}  200
    Should Be Equal As Strings  ${json['message']}  Invalid Username or Password!