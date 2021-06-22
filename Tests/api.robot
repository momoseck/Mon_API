*** Settings ***
Resource  ../Resources/signupBack.robot
Resource  ../Resources/variables.robot
Resource  ../Resources/loginBack.robot
*** Test Cases ***
Inscrire Un Utilisateur Dans le BD
    [Tags]    First
    signupBack.Verifier si l'utilisateur n'exist pas dans la BD
    signupBack.Inscription Utilisateur par une requete http POST
    signupBack.Verifier que l'utlisateur est ajoute dans la BD
Inscrire le meme utilisateur dans la BD
    [Tags]  Second
    signupBack.Inscription meme Utilisateur par une requete http POST
    signupBack.Verifier que l'utlisateur n'est pas dupliquer dans la BD
Authentifier Utilisateur
    [Tags]  Third
    loginBack.verifier que l'utilisateur exist dans la BD
    loginBack.Authentifier l'utilisateur dans l'application
Supprimer Utilisateur
    [Tags]  fourth
    loginBack.Supprimer Utilisateur de la BD
    loginBack.Authentifier utilisateur inexistant dans l'application