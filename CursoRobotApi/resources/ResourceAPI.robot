*** Settings ***
Documentation   Documentação da API: https://fakerestapi.azurewebsites.net/swagger/ui/index#!/Books
Library         RequestsLibrary
Library         Collections

*** Variable ***
${URL_API}      https://fakerestapi.azurewebsites.net/api/v1
&{BOOK_15}      id=15
...             title=Book 15
...             pageCount=1500

#payload
&{BOOK_201}     id=201
...             title=Teste
...             description=Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla ultrices odio tortor, id dapibus neque interdum tempus. Phasellus ultrices sapien risus, eu interdum enim lacinia sed. Morbi quis interdum velit. Aliquam ut dictum tellus, et vehicula arcu. Cras condimentum ipsum vel tempus venenatis. Curabitur eu diam eget ex scelerisque euismod. Donec quam est, mollis sit amet ipsum sed, condimentum porta tellus. Praesent tempus porta nulla, eu aliquam justo fermentum sit amet. Fusce scelerisque suscipit sem cursus varius. Curabitur venenatis sed nibh nec ullamcorper. Aliquam nec dapibus augue. Sed quis turpis leo. Mauris leo arcu, congue vitae ultrices quis, malesuada non metus. Etiam eu tortor in est aliquet vehicula. Fusce hendrerit eget leo pellentesque sagittis. Donec egestas nisi dapibus purus faucibus pharetra.
...             pageCount=10
...             excerpt=Lorem ipsum dolor sit amet, consectetur adipiscing elit
...             publishDate=2021-11-12T06:31:08.070Z

*** Keywords ***
####SETUP E TEARDOWNS
Conectar a minha API
	Create Session          fakeAPI                 ${URL_API}
	${HEADERS}              Create Dictionary       content-type=application/json
	Set Suite Variable      ${HEADERS}

#### Ações
Requisitar todos os livros
	${RESPOSTA}             GET On Session          fakeAPI    /Books
	Log                     ${RESPOSTA.text}
	Set Test Variable       ${RESPOSTA}

Requisitar o livro "${ID_LIVRO}"
	${RESPOSTA}             GET On Session          fakeAPI     /Books/${ID_LIVRO}
	Log                     ${RESPOSTA.text}
	Set Test Variable       ${RESPOSTA}

Cadastrar um novo livro
	${RESPOSTA}     POST On Session         fakeAPI    /Books
	...             data={"id": ${BOOK_201.id},"title": "${BOOK_201.title}","description": "${BOOK_201.description}", "pageCount": ${BOOK_201.pageCount},"excerpt": "${BOOK_201.excerpt}","publishDate": "${BOOK_201.publishDate}"}             
	...             headers=${HEADERS}
	Log             ${RESPOSTA.text}
	Set Test Variable    ${RESPOSTA}

#### Conferências
Conferir o status code
	[Arguments]      ${STATUSCODE_DESEJADO}
	Should Be Equal As Strings    ${RESPOSTA.status_code}    ${STATUSCODE_DESEJADO}

Conferir o reason
	[Arguments]    ${REASON_DESEJADO}
	Should Be Equal As Strings    ${RESPOSTA.reason}     ${REASON_DESEJADO}

Conferir se retorna uma lista com "${QTDE_LIVROS}" livros
	Length Should Be      ${RESPOSTA.json()}     ${QTDE_LIVROS}

Conferir se retorna todos os dados corretos do livro 15
	Dictionary Should Contain Item      ${RESPOSTA.json()}    id              ${BOOK_15.id}
	Dictionary Should Contain Item      ${RESPOSTA.json()}    title           ${BOOK_15.title}
	Dictionary Should Contain Item      ${RESPOSTA.json()}    pageCount       ${BOOK_15.pageCount}
	Should Not Be Empty                 ${RESPOSTA.json()["description"]}
	Should Not Be Empty                 ${RESPOSTA.json()["excerpt"]}
	Should Not Be Empty                 ${RESPOSTA.json()["publishDate"]}

Conferir se retorna todos os dados cadastrados para o novo livro
	Dictionary Should Contain Item      ${RESPOSTA.json()}    id              ${BOOK_201.id}
	Dictionary Should Contain Item      ${RESPOSTA.json()}    title           ${BOOK_201.title}
	Dictionary Should Contain Item      ${RESPOSTA.json()}    pageCount       ${BOOK_201.pageCount}
	Should Not Be Empty                 ${RESPOSTA.json()["description"]}
	Should Not Be Empty                 ${RESPOSTA.json()["excerpt"]}
	Should Not Be Empty                 ${RESPOSTA.json()["publishDate"]}