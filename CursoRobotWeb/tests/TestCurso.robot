*** Settings ***
# declaracao do arquivo resource onde estão as libraries
Resource          ../resources/Resource.robot
Documentation     Tags in Robot Framework

# setup executa antes de iniciar o teste (suite para a feature, test para o caso de teste)
#Suite Setup       Abrir o browser 
Test Setup        Abrir o Navegador

# teardown executa apos finalizar o teste (suite para a feature, test para o caso de teste)
#Suite Teardown    Fechar o browser
Test Teardown        Fechar o Navegador


*** Variables ***
# declaracao das variaveis globais
${URL}        http://automationpractice.com
${BROWSER}    chrome


*** Test Cases ***
# declaracao dos casos de teste
Caso de Teste 01 - Pesquisar produto existente
  [Tags] CT-001
  Dado que estou na home do site
  Quando pesquisar por "Blouse"
  Então o produto "Blouse" deve ser listado nos resultados da busca

Caso de Teste 02 - Pesquisar produto não existente
  [Tags] CT-002
  Dado que estou na home do site
  Quando pesquisar por "itemNãoExistente"
  Então devo ver a mensagem "No results were found for your search "itemNãoExistente""


*** Keywords ***
# declaracao dos steps
Dado que estou na home do site
  Acessar a Home

Quando pesquisar por "${PRODUTO}"
  Pesquisar "${PRODUTO}" no campo de busca

Então o produto "${PRODUTO}" deve ser listado nos resultados da busca
  Conferir se o "${PRODUTO}" foi listado

Então devo ver a mensagem "${MENSAGEM}"
  Conferir mensagem de erro "${MENSAGEM}"