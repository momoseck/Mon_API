*** Settings ***
Library  SeleniumLibrary
Library  RequestsLibrary
Library  DatabaseLibrary
Resource  variables.robot
*** Keywords ***
Verifier si l'utilisateur n'exist pas dans la BD
    Connect To Database Using Custom Params  pymysql  database='demo', user='root', password='', host='localhost'
    Row Count Is 0  select id from users where username = '${USERNAME}' and password = md5('${PASSWORD}')
Inscription Utilisateur par une requete http POST
    Create Session  session1  ${WEBSITE_LINK}
    ${data} =  Create Dictionary  username=${USERNAME}  password=${PASSWORD}
    ${headers} =  Create Dictionary  Content-Type=Application/x-www-form-urlencoded
    ${response} =  Post Request  session1  signup.php  data=${data}  headers=${headers}
    ${json} =  Set Variable  ${response.json()}
    Log  ${json}
    Should Be Equal As Strings  ${response.status_code}  200
Verifier que l'utlisateur est ajoute dans la BD
     Connect To Database Using Custom Params  pymysql  database='demo', user='root', password='', host='localhost'
    Row Count Is Equal To X  select id from users where username = '${USERNAME}' and password = md5('${PASSWORD}')  1
Inscription meme Utilisateur par une requete http POST
    Create Session  session2  ${WEBSITE_LINK}
    ${data} =  Create Dictionary  username=${USERNAME}  password=${PASSWORD}
    ${headers} =  Create Dictionary  Content-Type=Application/x-www-form-urlencoded
    ${response} =  Post Request  session2  signup.php  data=${data}  headers=${headers}
    ${json} =  Set Variable  ${response.json()}
    Log  ${json}
    Should Be Equal As Strings  ${response.status_code}  200
    Should Be Equal As Strings  ${json['message']}  Username already exists!
Verifier que l'utlisateur n'est pas dupliquer dans la BD
    Connect To Database Using Custom Params  pymysql  database='demo', user='root', password='', host='localhost'
    Row Count Is Equal To X  select id from users where username = '${USERNAME}' and password = md5('${PASSWORD}')  1
