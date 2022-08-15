*** Settings ***
Documentation       Nesse arquivo contem todas as variáveis de testes

Resource            ../config/main.resource

*** Variable ***
### variáveis Web
${BROWSER}                  chrome
${URL}                      https://buger-eats.vercel.app/
${FILE}                     ..\cnh-digital.jpg

${CADASTRE_SE}              xpath=//a[@href='/deliver']//span
${NAME}                     name=name
${EMAIL}                    name=email
${WHATSAPP}                 name=whatsapp
${POSTAL_CODE}              name=postalcode
${SEACH_POSTAL_CODE}        xpath=//input[@value='Buscar CEP']
${ADDRESS_NUMBER}           name=address-number
${CHOOSE_DELIVER}           xpath=//li[1]
${SUBMITE_FORM}             xpath=//button[normalize-space()='Cadastre-se para fazer entregas']
${ALERT_CPF}                xpath=//span[normalize-space()='É necessário informar o CPF']
${ALERT_FILE}               xpath=//span[normalize-space()='Adicione uma foto da sua CNH']


### variáveis API
${URI_TOKEN}                https://api.petfinder.com/v2/
${URI_SERVER}               https://api.petfinder.com/v2/
${PATH_TOKEN}               oauth2/token
${PATH_SERVER}              types