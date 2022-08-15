*** Settings ***
Documentation       Nesse arquivo contem os cenarios de testes referentes a API

Resource            ../config/main.resource

Suite Setup         Conectar APIs 

***Test Cases***
Cenario API 01 - Request a URI Get Animal Types - status 200
    Dado que tenha a autenticação valida
    Quando efetua o request para a rota Get Animal Types
    Então o status code seja "200"
    E reason "OK"
    E o response body não seja vazio

Cenario API 02 - Request a URI Get Animal Types com Authorization invalida- status 200
    Dado que tenha efetuado o request para a rota Get Animal Types com o parametro AUTHORIZATION invalido
    Então o status code seja "401"
    E reason "Unauthorized"