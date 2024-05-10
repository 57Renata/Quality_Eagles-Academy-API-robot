*** Settings ***
Library    SeleniumLibrary  
Library    Collections
Library    String
Library    RequestsLibrary
Resource   variaveis.resource


*** Keywords ***
Create API Session
    ${headers}    Create Dictionary    accept=application/json    Content-Type=application/json
    Create Session     alias=APIquality-eagles      url=https://quality-eagles.qacoders-academy.com.br  
    ...                                             headers=${headers}

Login de acesso  
   ${body}    Create Dictionary       mail=${Emaillogin}     password=${Passwordlogin} 
   Log  ${body}
   Create API Session    # Chamando a keyword diretamente
   ${response}=    POST On Session  alias=APIquality-eagles  url=/api/login   json=${body}
   Log  ${response.json()}
   Set Test Variable    ${TOKEN}     ${response.json()["token"]}

Validar o token e gravar em um headers de autorização
   ${headers}  Create Dictionary  Authorization=Bearer ${TOKEN}
   ${response}  GET On Session   alias=APIquality-eagles   url=/api/validateToken  headers=${headers}
    Log    ${response.content}
    Log   ${TOKEN}

Criar um novo usuário
    ${palavra_rondomica}=    Generate Random String    chars=[LETTERS]
    ${palavra_rondomica}=    Convert To Lower Case     ${palavra_rondomica}
    ${cpf_randomico}=        Generate Random String    11    chars=[NUMBERS] 
    Set Test Variable        ${CPF}                    ${cpf_randomico}
    Set Test Variable        ${EMAIL_TEST}             ${palavra_rondomica}@gmail.com

Criar palavras rondomicas para departamento 
    ${nome_rondomica}=          Generate Random String      8  chars=[LETTERS]
    ${nome_rondomica}=          Convert To Lower Case       ${nome_rondomica}    
    Set Test Variable           ${departamento}             ${nome_rondomica}
    ${50_rondomica}=            Generate Random String      50  chars=[LETTERS]
    ${50_rondomica}=            Convert To Lower Case       ${50_rondomica}    
    Set Test Variable           ${departamento50}           ${50_rondomica}
    ${maiusculas_rondomica}=    Generate Random String      8  chars=[LETTERS]
    ${maiusculas_rondomica}=    Convert To Uppercase        ${maiusculas_rondomica}  
    Set Test Variable           ${MAIUSCULAS}               ${maiusculas_rondomica}   
    ${&_rondomica}=             Generate Random String      7  chars=[LETTERS]
    ${&_rondomica}=             Convert To Lower Case       ${&_rondomica}   
    Set Test Variable           ${department&}              ${&_rondomica}&
   
Cadastrar um usuário 
    ${headers}     Create Dictionary    Authorization=${TOKEN} 
    ${body}        Create Dictionary    fullName=Fulano da Silva      mail=${EMAIL_TEST}      
    ...                                 password=${Passwordlogin}     confirmPassword=${Passwordlogin}     
    ...                                 accessProfile=ADMIN           cpf=${CPF}
    Log    ${body}
    Create API Session
    ${response}    POST On Session      alias=APIquality-eagles    url=/api/user    json=${body}    
    ...                                 expected_status=201        headers=${headers}
    Log                  ${response.json()}
    Set Test Variable    ${ID_USUARIO}        ${response.json()['user']['_id']}
    Set Test Variable    ${ID_USUARIO}        ${response.json()} 


Incluir departamento
    ${headers}=    Create Dictionary    Authorization=${TOKEN} 
    ${body}        Create Dictionary    departmentName=${departamento}    
    ...                                 costCenterId=658ae3f40f617abe798fd68f
    Log    ${body}
    Create API Session
    ${response}    POST On Session      alias=APIquality-eagles    url=/api/department    json=${body}    
    ...                                 expected_status=201       headers=${headers}
    Log    ${response.json()}
    Set Test Variable    ${ID_DEPARTAMENTO}    ${response.json()['newDepartment']['_id']}
    Set Test Variable    ${ID_DEPARTAMENTO}   ${response.json()} 
       
Departamento com números
    ${headers}=    Create Dictionary    Authorization=${TOKEN} 
    ${body}        Create Dictionary    departmentName=${Nomedepartamento12}   
    ...                                 costCenterId=658ae3f40f617abe798fd68f
    Log    ${body}
    Create API Session
    ${response}    POST On Session      alias=APIquality-eagles    url=/api/department    json=${body}    
    ...                                 expected_status=400        headers=${headers}
    Log    ${response.json()}
    Dictionary Should Contain Key       ${response.json()}           error
    List Should Contain Value           ${response.json()}[error]    O campo 'departamento' só pode conter letras e o caractere especial '&'.    

    
Departamento com caracteres@
    ${headers}=    Create Dictionary    Authorization=${TOKEN} 
    ${body}        Create Dictionary    departmentName=${Caracteres@}   
    ...                                 costCenterId=658ae3f40f617abe798fd68f
    Log    ${body}
    Create API Session
    ${response}    POST On Session      alias=APIquality-eagles    url=/api/department    json=${body}    
    ...                                 expected_status=400      headers=${headers}
    Log    ${response.json()}
    Dictionary Should Contain Key    ${response.json()}       error
    List Should Contain Value    ${response.json()}[error]    O campo 'departamento' só pode conter letras e o caractere especial '&'.    


Departamento em branco
    ${headers}=    Create Dictionary    Authorization=${TOKEN} 
    ${body}        Create Dictionary    departmentName=
    ...                                 costCenterId=658ae3f40f617abe798fd68f
    Log    ${body}
    Create API Session
    ${response}    POST On Session      alias=APIquality-eagles    url=/api/department    json=${body}    
    ...                                 expected_status=400       headers=${headers}
    Log    ${response.json()}
    Dictionary Should Contain Key    ${response.json()}          error
    List Should Contain Value        ${response.json()}[error]   O campo 'departamento' é obrigatório.


Departamento com letras maiúsculas
    ${headers}=    Create Dictionary    Authorization=${TOKEN} 
    ${body}        Create Dictionary    departmentName=${MAIUSCULAS}   
    ...                                 costCenterId=658ae3f40f617abe798fd68f
    Log    ${body}
    Create API Session
    ${response}    POST On Session      alias=APIquality-eagles    url=/api/department    json=${body}    
    ...                                 expected_status=201       headers=${headers}
    Log    ${response.json()}
    Set Test Variable    ${ID_DEPARTAMENTO}   ${response.json()['newDepartment']['_id']}
    Set Test Variable    ${ID_DEPARTAMENTO}    ${response.json()} 


Departamento com letras minúsculas
  ${headers}=      Create Dictionary       Authorization=${TOKEN} 
    ${body}        Create Dictionary       departmentName=${departamento}  
    ...                                    costCenterId=658ae3f40f617abe798fd68f
    Log    ${body}
    Create API Session
    ${response}    POST On Session         alias=APIquality-eagles    url=/api/department    json=${body}    
    ...                                    expected_status=201        headers=${headers}
    Log    ${response.json()}
    Set Test Variable     ${ID_DEPARTAMENTO}   ${response.json()['newDepartment']['_id']}
    Set Test Variable     ${ID_DEPARTAMENTO}   ${response.json()} 

Departamento com caracteres especial &
    ${headers}=      Create Dictionary     Authorization=${TOKEN} 
    ${body}          Create Dictionary     departmentName=${department&}  
    ...                                    costCenterId=658ae3f40f617abe798fd68f
    Log    ${body}
    Create API Session
    ${response}    POST On Session         alias=APIquality-eagles    url=/api/department    json=${body}    
    ...                                    expected_status=201        headers=${headers}
    Log    ${response.json()}
    Set Test Variable     ${ID_DEPARTAMENTO}    ${response.json()['newDepartment']['_id']}
    Set Test Variable     ${ID_DEPARTAMENTO}  ${response.json()} 

Departamento com 50 caracteres
     ${headers}=      Create Dictionary    Authorization=${TOKEN} 
     ${body}          Create Dictionary    departmentName=${departamento50}  
    ...                                    costCenterId=658ae3f40f617abe798fd68f
    Log    ${body}
    Create API Session
    ${response}    POST On Session         alias=APIquality-eagles    url=/api/department    json=${body}    
    ...                                    expected_status=201        headers=${headers}
    Log    ${response.json()}
    Set Test Variable     ${ID_DEPARTAMENTO}    ${response.json()['newDepartment']['_id']}
    Set Test Variable     ${ID_DEPARTAMENTO}  ${response.json()} 

Departamento com 51 caracteres
    ${headers}=    Create Dictionary    Authorization=${TOKEN} 
    ${body}        Create Dictionary    departmentName=${Departamento51} 
    ...                                 costCenterId=658ae3f40f617abe798fd68f
    Log    ${body}
    Create API Session
    ${response}    POST On Session      alias=APIquality-eagles    url=/api/department    json=${body}    
    ...                                 expected_status=400       headers=${headers}
    Log    ${response.json()}
    Dictionary Should Contain Key       ${response.json()}          error
    List Should Contain Value           ${response.json()}[error]   O campo 'departamento' deve possuir no máximo 50 caracteres.

Criar palavras rondomicas para diretoria
    ${nomediretoria_rondomica}=          Generate Random String      8  chars=[LETTERS]
    ${nomediretoria_rondomica}=          Convert To Lower Case       ${nomediretoria_rondomica}=    
    Set Test Variable                    ${diretoria}                ${nomediretoria_rondomica}=
    ${letrasmaiusculas_rondomica}=       Generate Random String      8  chars=[LETTERS]
    ${letrasmaiusculas_rondomica}=       Convert To Uppercase        ${letrasmaiusculas_rondomica}  
    Set Test Variable                    ${DIRETORIA}                ${letrasmaiusculas_rondomica}  
    ${board&_rondomica}=                 Generate Random String      7  chars=[LETTERS]
    ${board&_rondomica}=                 Convert To Lower Case       ${board&_rondomica}  
    Set Test Variable                    ${diretoria&}               ${board&_rondomica}&
    
Incluir diretoria
    ${headers}=    Create Dictionary    Authorization=${TOKEN} 
    ${body}        Create Dictionary    boardName=${diretoria}                                    
    Log    ${body}
    Create API Session
    ${response}    POST On Session      alias=APIquality-eagles    url=/api/board   json=${body}    
    ...                                 expected_status=201       headers=${headers}
    Log    ${response.json()}
    Set Test Variable    ${ID_DIRETORIA}    ${response.json()['newBoard']['_id']}
    Set Test Variable    ${ID_DIRETORIA}   ${response.json()} 
       
Diretoria com números
    ${headers}=    Create Dictionary    Authorization=${TOKEN} 
    ${body}        Create Dictionary    boardName=${Numeros50}                                 
    Log    ${body}
    Create API Session
    ${response}    POST On Session      alias=APIquality-eagles    url=/api/board    json=${body}    
    ...                                 expected_status=400        headers=${headers}
    Log    ${response.json()}
    Dictionary Should Contain Key       ${response.json()}           error
    List Should Contain Value           ${response.json()}[error]    O campo 'diretoria' só pode conter letras e o caractere especial '&'.    

    
Diretoria com caracteres@
    ${headers}=    Create Dictionary    Authorization=${TOKEN} 
    ${body}        Create Dictionary    boardName=${Diretoria@}                                    
    Log    ${body}
    Create API Session
    ${response}    POST On Session      alias=APIquality-eagles    url=/api/board    json=${body}    
    ...                                 expected_status=400      headers=${headers}
    Log    ${response.json()}
    Dictionary Should Contain Key    ${response.json()}       error
    List Should Contain Value    ${response.json()}[error]    O campo 'diretoria' só pode conter letras e o caractere especial '&'.    


Diretoria em branco
    ${headers}=    Create Dictionary    Authorization=${TOKEN} 
    ${body}        Create Dictionary    boardName=                                
    Log    ${body}
    Create API Session
    ${response}    POST On Session      alias=APIquality-eagles    url=/api/board   json=${body}    
    ...                                 expected_status=400       headers=${headers}
    Log    ${response.json()}
    Dictionary Should Contain Key    ${response.json()}          error
    List Should Contain Value        ${response.json()}[error]   O campo 'diretoria' é obrigatório.


Diretoria com letras maiúsculas
    ${headers}=    Create Dictionary    Authorization=${TOKEN} 
    ${body}        Create Dictionary    boardName=${DIRETORIA}                                    
    Log    ${body}
    Create API Session
    ${response}    POST On Session      alias=APIquality-eagles    url=/api/board    json=${body}    
    ...                                 expected_status=201       headers=${headers}
    Log    ${response.json()}
    Set Test Variable    ${ID_DIRETORIA}    ${response.json()['newBoard']['_id']}
    Set Test Variable    ${ID_DIRETORIA}    ${response.json()} 


Diretoria com letras minúsculas
  ${headers}=      Create Dictionary       Authorization=${TOKEN} 
    ${body}        Create Dictionary       boardName=${diretoria}                                      
    Log    ${body}
    Create API Session
    ${response}    POST On Session         alias=APIquality-eagles    url=/api/board   json=${body}    
    ...                                    expected_status=201        headers=${headers}
    Log    ${response.json()}
    Set Test Variable     ${ID_DIRETORIA}   ${response.json()['newBoard']['_id']}
    Set Test Variable     ${ID_DIRETORIA}  ${response.json()} 

Diretoria com caracteres especial &
    ${headers}=      Create Dictionary     Authorization=${TOKEN} 
    ${body}          Create Dictionary     boardName=${diretoria&}                                    
    Log    ${body}
    Create API Session
    ${response}    POST On Session         alias=APIquality-eagles    url=/api/board/    json=${body}    
    ...                                    expected_status=201        headers=${headers}
    Log    ${response.json()}
    Set Test Variable     ${ID_DIRETORIA}    ${response.json()['newBoard']['_id']}
    Set Test Variable     ${ID_DIRETORIA}  ${response.json()} 
