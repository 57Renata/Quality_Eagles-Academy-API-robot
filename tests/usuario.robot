*** Settings ***
Resource    ../resources/academy.resource
Resource    ../resources/variaveis.resource

*** Test Cases ***
Cenário com POST: Cadastrar um novo usuário com sucesso
    Create API Session
    Login de acesso
    Criar um novo usuário
    Cadastrar um usuário
    