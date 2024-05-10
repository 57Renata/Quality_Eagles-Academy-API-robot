*** Settings ***
Resource    ../resources/academy.resource
Resource    ../resources/variaveis.resource


*** Test Cases ***
Cenário de teste: Login de acesso
    Create API Session
    Login de acesso
    Validar o token e gravar em um headers de autorização
