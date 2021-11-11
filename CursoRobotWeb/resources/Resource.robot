*** Settings ***
# declaracao das libraries
Library           SeleniumLibrary
Library           String


*** Variables ***
# declaracao das variaveis globais
${URL}        http://automationpractice.com
${BROWSER}    Chrome

# dicionario (estrutura de dados que permite passar atributos)
&{CADASTRO}   firstname=ANDERSON            lastname=NUNES                                company=WHO DESIGNERS                passwd=robot
...           days=28                       months=8                                      years=1972
...           address1=AV. TESTE 1234       address2=BL. 4 ED. JABORANDI SL. 142          city=Carapicuiba
...           id_state=11                   postcode=05500                                other=LOREN IPSUN DOLOR SIT AMET
...           phone=5511999998888           phone_mobile=55119999988888                   alias=TESTE


*** Keywords ***
# chamada dos metodos setup e teardown
Abrir o Navegador
  Open Browser      ${URL}  ${BROWSER}

Fechar o Navegador
  Close Browser

# chamada dos metodos que executam os steps do bdd
Acessar a Home
  Go To                           ${URL}
  Wait Until Element Is Visible   xpath=//*[@id="block_top_menu"]/ul
  Title Should Be                 My Store

Pesquisar "${PRODUTO}" no campo de busca
  Input Text                      name=search_query     ${PRODUTO}
  Click Element                   name=submit_search

# asserts
Conferir se o "${PRODUTO}" foi listado
  Wait Until Element Is Visible   css=#center_column > h1
  Title Should Be                 Search - My Store
  Page Should Contain Image       xpath=//*[@id="center_column"]//*[@src='${URL}/img/p/7/7-home_default.jpg'] 
  Page Should Contain Link        xpath=//*[@id='center_column']//a[@class='product-name'][contains(text(), "Blouse")]

Conferir mensagem de erro "${MENSAGEM_ERRO}"
  Wait Until Element Is Visible   xpath=//*[@id="center_column"]//p[@class="alert alert-warning"]
  Element Text Should Be          xpath=//*[@id="center_column"]//p[@class="alert alert-warning"]   ${MENSAGEM_ERRO}

# metodos CT-03
Selecionar Item Menu "${CATEGORIA}"
  Wait Until Element Is Visible   xpath=//*[@id="block_top_menu"]//a[@title="${CATEGORIA}"]
  Mouse Over                      xpath=//*[@id="block_top_menu"]//a[@title="${CATEGORIA}"]    

Selecionar Submenu "${SUBCATEGORIA}"
  Wait Until Element Is Visible   xpath=//*[@id="block_top_menu"]//a[@title="${SUBCATEGORIA}"]
  Click Element                   xpath=//*[@id="block_top_menu"]//a[@title="${SUBCATEGORIA}"]

Exibir página de produtos
  Wait Until Element Is Visible   css=#center_column
  Title Should Be                 Summer Dresses - My Store

# metodos CT-04
Exibir página de pesquisa
  Wait Until Element Is Visible   css=#center_column > h1
  Title Should Be                 Search - My Store

Adicionar ao carrinho
  Wait Until Element Is Visible   xpath=//*[@id="center_column"]//img[@alt="Faded Short Sleeve T-shirts"]
  Click Element                   xpath=//*[@id="center_column"]//img[@alt="Faded Short Sleeve T-shirts"]
  Wait Until Element Is Visible   xpath=//*[@id="add_to_cart"]/button
  Click Button                    xpath=//*[@id="add_to_cart"]/button

Exibir tela checkout
  Wait Until Element Is Visible   xpath=//*[@id="layer_cart"]//a[@title="Proceed to checkout"]
  Click Element                   xpath=//*[@id="layer_cart"]//a[@title="Proceed to checkout"]

# metodos CT-05
Clicar no carrinho de compras
  Adicionar ao carrinho
  Exibir tela checkout
  Click Element                   xpath=//*[@title="View my shopping cart"]

Excluir produto do carrinho
  Click Element                   xpath=//*[@class="cart_quantity_delete"]

Exibir mensagem "${MENSAGEM_PRODUTO}"
  Wait Until Element Is Visible   xpath=//*[@id="center_column"]//p[@class="alert alert-warning"]
  Element Text Should Be          xpath=//*[@id="center_column"]//p[@class="alert alert-warning"]   ${MENSAGEM_PRODUTO}

# metodos CT-06
Fazer Login
  Wait Until Element Is Visible   xpath=//*[@id="header"]//a[contains(text(), "Sign in")]
  Click Element                   xpath=//*[@id="header"]//*[@class="login"][contains(text(),"Sign in")]
  Wait Until Element Is Visible   id=email_create
  ${EMAIL}                        Generate Random String
  Input Text                      id=email_create    ${EMAIL}@robot.com.br
  Click Button                    id=SubmitCreate

Preencher formulário
  Wait Until Element Is Visible   css=#center_column > h1
  Title Should Be                 Login - My Store

  # elementos do form - personal information
  Wait Until Element Is Visible   xpath=//*[@id="account-creation_form"]//h3[contains(text(),"Your personal information")]
  Click Element                   id=id_gender1
  Input Text                      id=customer_firstname     ${CADASTRO.firstname}
  Input Text                      id=customer_lastname      ${CADASTRO.lastname}
  Input Text                      id=passwd                 ${CADASTRO.passwd}
  Select From List By Value       id=days                   ${CADASTRO.days}
  Select From List By Value       id=months                 ${CADASTRO.months}
  Select From List By Value       id=years                  ${CADASTRO.years}
  Click Element                   id=newsletter

  # elementos do form - your address
  Input Text                      id=firstname              ${CADASTRO.firstname}
  Input Text                      id=lastname               ${CADASTRO.lastname}
  Input Text                      id=company                ${CADASTRO.company}
  Input Text                      id=address1               ${CADASTRO.address1}
  Input Text                      id=address2               ${CADASTRO.address2}
  Input Text                      id=city                   ${CADASTRO.city}
  Select From List By Value       id=id_state               ${CADASTRO.id_state}
  Input Text                      id=postcode               ${CADASTRO.postcode}
  Input Text                      id=other                  ${CADASTRO.other}
  Input Text                      id=phone                  ${CADASTRO.phone}
  Input Text                      id=phone_mobile           ${CADASTRO.phone_mobile}
  Input Text                      id=alias                  ${CADASTRO.alias}

Exibir página de gerenciamento
  Click Button                    id=submitAccount
  Wait Until Element Is Visible   xpath=//*[@id="center_column"]/p
  Element Text Should Be          xpath=//*[@id="center_column"]/p
  ...                             Welcome to your account. Here you can manage all of your personal information and orders.
  Element Text Should Be          xpath=//*[@id="header"]/div[2]//div[1]/a/span    ANDERSON NUNES