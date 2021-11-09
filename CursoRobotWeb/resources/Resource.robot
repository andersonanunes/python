*** Settings ***
# declaracao das libraries
Library           SeleniumLibrary


*** Variables ***
# declaracao das variaveis globais
${URL}        http://automationpractice.com
${BROWSER}    Chrome

*** Keywords ***
# chamada dos metodos setup e teardown
Abrir o Navegador
  Open Browser      ${URL}  ${BROWSER}

Fechar o Navegador
  Close Browser

# chamada dos metodos que executam os steps do bdd
Acessar a Home
  Go To             ${URL}
  Title Should Be   My Store

Pesquisar "${PRODUTO}" no campo de busca
  Input Text        name=search_query     ${PRODUTO}
  Click Element     name=submit_search

# asserts
Conferir se o "${PRODUTO}" foi listado
  Wait Until Element Is Visible   css=#center_column > h1
  Title Should Be                 Search - My Store
  Page Should Contain Image       xpath=//*[@id='center_column']//*[@src='http://automationpractice.com/img/p/7/7-home_default.jpg']       
  Page Should Contain Link        xpath=//*[@id='center_column']//a[@class='product-name'][contains(text(), "Blouse")]

Conferir mensagem de erro "${MENSAGEM}"
  Wait Until Element Is Visible   xpath=//*[@id="center_column"]//p[@class="alert alert-warning"]
  Element Text Should Be          xpath=//*[@id="center_column"]//p[@class="alert alert-warning"]   ${MENSAGEM}