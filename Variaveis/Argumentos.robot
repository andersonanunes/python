*** Settings ***
Documentation   Exemplo de uso de variáveis passadas como argumentos para keywords
Library         String

*** Variables ***
&{PESSOA}       nome=Anderson       sobrenome=Nunes     email=annunes@gmail.com     idade=49        sexo=masculino

*** Test Cases ***
Caso de Teste 01
  Uma keyword qualquer

Caso de Teste 02
  Exibe email válido


*** Keywords ***
Uma keyword qualquer
  Uma subkeyword com argumentos     ${PESSOA.nome}      ${PESSOA.email}
  # recebe o return e armazena o valor na variável MENSAGEM_ALERTA
  ${MENSAGEM_ALERTA}                Uma subkeyword com retorno    ${PESSOA.nome}        ${PESSOA.idade}
  Log                               ${MENSAGEM_ALERTA}

# recebe 2 argumentos do metodo uma keyword qualquer
Uma subkeyword com argumentos
  [Arguments]                       ${NOME_USUARIO}     ${EMAIL_USUARIO}      
  Log                               Username: ${NOME_USUARIO}
  Log                               Email: ${EMAIL_USUARIO}

# recebe 2 argumentos do metodo uma keyword qualquer e armazena o texto na variável MENSAGEM
Uma subkeyword com retorno
  [Arguments]                       ${NOME_USUARIO}     ${IDADE_USUARIO}
  ${MENSAGEM}                       Set Variable If     ${IDADE_USUARIO} < 18       Não Autorizado! O usuário ${NOME_USUARIO} é menor!
  [Return]                          ${MENSAGEM}

# cria uma subkeyword com string randomica e retorna o valor do email completo
Criar email randomico               
  [Arguments]                       ${NOME}             ${SOBRENOME}
  ${STRING_EMAIL}                   Generate Random String
  ${RANDOM_EMAIL}                   Set Variable        ${NOME}${SOBRENOME}${STRING_EMAIL}@gmail.com
  Log                               ${RANDOM_EMAIL}
  [Return]                          ${RANDOM_EMAIL}

# keyword que recebe os parametros do return
Exibe email válido
  ${EMAIL}                          Criar email randomico  ${PESSOA.nome}  ${PESSOA.sobrenome}
  Log                               ${EMAIL}