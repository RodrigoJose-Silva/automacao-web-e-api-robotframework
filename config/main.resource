*** Settings ***
Documentation       Setup responsavel por importar todas as dependencias do framework.

Library             SeleniumLibrary
Library             RequestsLibrary
Library             JSONLibrary
Library             Collections

###### DATA ######
Resource                  ../data/variables.robot

# ###### FIXTURE ######
# Resource                  ../fixture/cnh-digital.jpg

##### Keywords #####
Resource                  ../step_definitions/resource.robot