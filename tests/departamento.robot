*** Settings ***
Resource    ../resources/academy.resource
Resource    ../resources/variaveis.resource

*** Test Cases ***
CT - Incluir departamento
    Create API Session
    Login de acesso
    Criar palavras rondomicas para departamento
    Incluir departamento

CT - Departamento com números
     Create API Session
     Login de acesso
     Departamento com números
CT - Departamento com caracteres@
     Create API Session
     Login de acesso
     Departamento com caracteres@
CT - Departamento em branco
     Create API Session
     Login de acesso
     Departamento em branco
CT - Departamento com letras maiúsculas
     Create API Session
     Login de acesso
     Criar palavras rondomicas para departamento
     Departamento com letras maiúsculas
CT - Departamento com letras minúsculas
     Create API Session
     Login de acesso
     Criar palavras rondomicas para departamento
     Departamento com letras minúsculas
Departamento com caracteres especial &
     Create API Session
     Login de acesso
     Criar palavras rondomicas para departamento
     Departamento com caracteres especial &
Departamento com 50 caracteres
     Create API Session
     Login de acesso
     Criar palavras rondomicas para departamento
     Departamento com 50 caracteres
Departamento com 51 caracteres
     Create API Session
     Login de acesso
     Departamento com 51 caracteres
