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


*** Test Cases ***
# declaracao dos casos de teste
Caso de Teste 01 - Pesquisar produto existente
  [Tags]  CT-001
  Dado que estou na home do site
  Quando pesquiso por "Blouse"
  Então o produto "Blouse" deve ser listado nos resultados da busca

Caso de Teste 02 - Pesquisar produto não existente
  [Tags]  CT-002
  Dado que estou na home do site
  Quando pesquiso por "itemNãoExistente"
  Então devo ver a mensagem de erro "No results were found for your search "itemNãoExistente""

Caso de Teste 03 - Listar Produtos
  [Tags]  CT-003
  Dado que estou na home do site
  Quando passo o mouse na categoria "Women"
  E seleciono a sub-categoria "Summer Dresses"
  Então sou redirecionado para a página com os produtos

Caso de Teste 04 - Adicionar Produtos ao carrinho
  [Tags]  CT-004
  Dado que estou na home do site
  Quando pesquiso por "t-shirt"
  E vejo a tela do resultado da pesquisa
  Então adiciono o produto "t-shirt" ao carrinho de compras
  E devo ser redirecionado para a tela de checkout

Caso de Teste 05 - Remover produtos do carrinho
  [Tags]  CT-005
  Dado que estou na home do site
  Quando clico no ícone carrinho de compras
  E excluo um produto único
  Então devo ver a mensagem de carrinho vazio "Your shopping cart is empty."

Caso de Teste 06 - Adicionar Cliente
  [Tags]  CT-006
  Dado que estou na home do site
  Quando realizo login com um email válido
  E preencho os campos obrigatórios
  Então sou redirecionado para a página de gerenciamento


*** Keywords ***
# declaracao dos steps
Dado que estou na home do site
  Acessar a Home

Quando pesquiso por "${PRODUTO}"
  Pesquisar "${PRODUTO}" no campo de busca

Então o produto "${PRODUTO}" deve ser listado nos resultados da busca
  Conferir se o "${PRODUTO}" foi listado

Então devo ver a mensagem de erro "${MENSAGEM_ERRO}"
  Conferir mensagem de erro "${MENSAGEM_ERRO}"

# CT-03
Quando passo o mouse na categoria "${CATEGORIA}"
  Selecionar Item Menu "${CATEGORIA}"

E seleciono a sub-categoria "${SUBCATEGORIA}"
  Selecionar Submenu "${SUBCATEGORIA}"

Então sou redirecionado para a página com os produtos
  Exibir página de produtos

# CT-04
E vejo a tela do resultado da pesquisa
  Exibir página de pesquisa

Então adiciono o produto "t-shirt" ao carrinho de compras
  Adicionar ao carrinho

E devo ser redirecionado para a tela de checkout
  Exibir tela checkout

# CT-05
Quando clico no ícone carrinho de compras
  Clicar no carrinho de compras

E excluo um produto único
  Excluir produto do carrinho

Então devo ver a mensagem de carrinho vazio "${MENSAGEM_PRODUTO}"
  Exibir mensagem "${MENSAGEM_PRODUTO}"

# CT-06
Quando realizo login com um email válido
  Fazer Login

E preencho os campos obrigatórios
  Preencher formulário

Então sou redirecionado para a página de gerenciamento
  Exibir página de gerenciamento