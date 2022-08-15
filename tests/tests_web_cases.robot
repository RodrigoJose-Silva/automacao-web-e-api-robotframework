*** Settings ***
Documentation       Nesse arquivo contem os cenarios de teste referente a WEB

Resource        ../config/main.resource

Test Teardown       Fechar o navegador

***Test Cases***

Cenário Web 01 - Fazendo cadastro de novo candidato
    Dado que acesse o site Buger Eats
    Quando preencher o formulario sem informar o CPF
    E submeter o formulario
    Então apresenta o alert 'É necessário informar o CPF'
    E o alert 'Adicione uma foto da sua CNH'