*** Settings ***
Documentation       Nesse arquivo contem as keywords de teste

Resource           ../config/main.resource

*** Keywords ***
#######################  WEB ####################
### Resource Web
####  Teardown
Fechar o navegador
    Close Browser

#### Ação
### Step Web
Dado que acesse o site Buger Eats
    Open Browser        ${URL}      ${BROWSER}
    Maximize Browser Window
    
Quando preencher o formulario sem informar o CPF
    Click Element           ${CADASTRE_SE}
    Page Should Contain     Cadastre-se para fazer entregas

    # Dados
    Input Text              ${NAME}           Pietro Carlos Vieira
    Input Text              ${EMAIL}          qa.pietro@tester.com
    Input Text              ${WHATSAPP}       (11)99999-9999

    # Endereço
    Input Text              ${POSTAL_CODE}          06186150
    Click Button            ${SEACH_POSTAL_CODE}
    Input Text              ${ADDRESS_NUMBER}       100
    
    # Método de entrega
    Click Element           ${CHOOSE_DELIVER}
    
E submeter o formulario
    Click Element         ${SUBMITE_FORM}

### Verificações
### Step Web
Então apresenta o alert 'É necessário informar o CPF'
    Element Should Be Visible      ${ALERT_CPF}
    
E o alert 'Adicione uma foto da sua CNH'
    Element Should Be Visible      ${ALERT_FILE} 



     ###########################  API #################
### resource API
Conectar APIs
    Create Session      API_TOKEN       ${URI_TOKEN}            verify=False        disable_warnings=True
    Create Session      API_SERVER      ${URI_SERVER}           verify=False        disable_warnings=True

Dado que tenha a autenticação valida
    ${HEADER}                   Create Dictionary
    ...                         Content-type=application/json
    ${BODY_TOKEN}               Create Dictionary
    ...                         grant_type=client_credentials
    ...                         client_id=MHCHyJKDn4BDcGEWwXQjofkFJmQtFeNKdKAbL04HExPW0QVTEy
    ...                         client_secret=YiVpHSitfDVW6miF263xVvW83YyTOXTWqzbIsYOP

    ${RESPONSE}         Post On Session      API_TOKEN
    ...                                      ${PATH_TOKEN}
    ...                                      json=${BODY_TOKEN}
    ...                                      expected_status=any
    Log                 ${RESPONSE.text}

    ${TOKEN}        Collections.Get From Dictionary     ${RESPONSE.json()}      access_token
    Set Suite Variable    ${TOKEN}
    
Quando efetua o request para a rota Get Animal Types
    ${HEADER_SERVER}        Create Dictionary
    ...                     Content-type=application/json
    ...                     Authorization=Bearer ${TOKEN}

    ${RESPONSE}     GET On Session      API_SERVER       
    ...                                 ${PATH_SERVER}
    ...                                 headers=${HEADER_SERVER}
    ...                                 expected_status=any
    Log             ${RESPONSE.text}
    
    Set Test Variable       ${RESPONSE}
    Set Test Variable       ${HEADER_SERVER}

Dado que tenha efetuado o request para a rota Get Animal Types com o parametro AUTHORIZATION invalido
    ${HEADER_SERVER}        Create Dictionary
    ...                     Authorization=Bearer Abc123

    ${RESPONSE}     GET On Session      API_SERVER       
    ...                                 ${PATH_SERVER}
    ...                                 headers=${HEADER_SERVER}
    ...                                 expected_status=any
    Log             ${RESPONSE.text}
    
    Set Test Variable       ${RESPONSE}
    
    
### Verificações
### Step API
Então o status code seja "${STATUS_DESEJADO}"
    Should Be Equal As Strings       ${RESPONSE.status_code}     ${STATUS_DESEJADO}

E reason "${REASON_DESEJADO}"
    Should Be Equal As Strings       ${RESPONSE.reason}     ${REASON_DESEJADO}

E o response body não seja vazio
    Should Not Be Empty             ${RESPONSE.json()}