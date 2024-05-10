*** Settings ***
Resource    ../resources/academy.resource
Resource    ../resources/variaveis.resource

*** Test Cases ***
CT - Incluir diretoria
     Create API Session
     Login de acesso
     Criar palavras rondomicas para diretoria
     Incluir diretoria
CT - Diretoria com números
     Create API Session
     Login de acesso
     Diretoria com números
CT - Diretoria com caracteres@
     Create API Session
     Login de acesso
     Diretoria com caracteres@
CT - Diretoria em branco
     Create API Session
     Login de acesso
     Diretoria em branco
CT - Diretoria com letras maiúsculas
     Create API Session
     Login de acesso
     Criar palavras rondomicas para diretoria
     Diretoria com letras maiúsculas
CT - Diretoria com letras minúsculas
     Create API Session
     Login de acesso
     Criar palavras rondomicas para diretoria
     Diretoria com letras minúsculas
Diretoria com caracteres especial &
     Create API Session
     Login de acesso
     Criar palavras rondomicas para diretoria
     Diretoria com caracteres especial &