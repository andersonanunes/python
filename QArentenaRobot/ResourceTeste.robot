*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${URL}                https://robotizandotestes.blogspot.com/
${BROWSER}            chrome
${BTN_PESQUISAR}      css=button.search-expand.touch-icon-button
${INPUT_PESQUISAR}    name=q
${TEXTO_PESQUISA}     Season Premiere: Introdução ao Robot Framework
${RESULT_PESQUISA}    Mostrando postagens que correspondem à pesquisa por Season Premiere: Introdução ao Robot Framework
${SUBMIT_PESQUISAR}   css=input.search-action.flat-button
${LINK_POST}          xpath=//a[contains(text(), '${TEXTO_PESQUISA}')]
${IMG_ROBO}           xpath=//img[contains(@src, 'if_Robot_18_385830_grande')]
${TEXTO_LEITURA}      nesse post vou apresentar-lhes o astro deste blog


*** Keywords ***
# DADO
Acessar a página do blog
  Open Browser  url=${URL}  browser=${BROWSER}
  # validacao
  Title Should Be   Robotizando Testes

#QUANDO
Pesquisar por um post com "${TEXTO_PESQUISA}"
  Wait Until Element Is Visible     locator=${BTN_PESQUISAR}
  Click Button                      ${BTN_PESQUISAR}
  Input Text                        ${INPUT_PESQUISAR}  ${TEXTO_PESQUISA}
  Click Element                     ${SUBMIT_PESQUISAR}

#ENTAO
Conferir mensagem de pesquisa por "${RESULT_PESQUISA}"
  Page Should Contain               ${RESULT_PESQUISA}

#E
Fechar o browser
  Close Browser


Acessar o post "${TEXTO_PESQUISA}"
  # reaproveitamento do step
  Pesquisar por um post com "${TEXTO_PESQUISA}"
  Click Element                     ${LINK_POST}
  Wait Until Page Contains  O que é Robot Framework?

Conferir se a imagem do robô aparece
  Page Should Contain Image         ${IMG_ROBO}

Conferir se o texto "${TEXTO_LEITURA}" aparece 
  Page Should Contain               ${TEXTO_LEITURA}