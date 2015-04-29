# Clusterizando o TOR

Agressivamente "anônimo" com docker e tor

- Marcelo Machado Fleury
- marcelomf@gmail.com
- http://github.com/marcelomf
- ~marcelomf

## FLISOL 2015


## WHOAMI

- Interesse por computadores a partir de 1998
- Foco em P&D voltado a segurança da informação
- Linguagens: C, ASM, JAVASCRIPT, PYTHON, PHP, RUBY, JAVA...GO(!)
- Protocolos: TCP/IP, HTTP, SSL/TLS, KERBEROS, LDAP, SASL...HTTP2/WEBSOCKETS(!)
- Security researcher na CONVISO


## Objetivo

- Acessar a internet com um IP que não seja o meu
- Balancear as requisições com IPs(routers/exitnodes) distintos
- Manter uma blacklist de IPS/exitnodes
- Ser 100% anônimo ? Não...


## Por que ...

- Em um pentest, bypassar WAF...
- Em uma modelagem de risco, avaliar o seu ambiente
- Manter uma blacklist de IPs "maliciosos"(exitnodes)


## O que é TOR

Uma rede colaborativa e distribuída de servidores que trafegam dados criptografados


## Como funciona o TOR

- Servidores no mundo inteiro
- Um daemon local que escuta uma porta TCP/IP
- Aceita comandos através de sockets
- Escolhe randomicamente um node
- De tempos em tempos, renova a sua rede de conexão
(IP/entry\_node/[...]/exit\_node)
- A última conexão(exit_node) esta sujeita a MITM/snooping


## ..

user 
<> 
entry\_node\_tor 
<> 
node\_tor\_1 
<> 
node\_tor\_N 
<> 
exit\_node\_tor 
<> 
recurso\_internet


## Contra ataque

- Como analista de segurança, quanto mais IPs/exitnodes tentarem comprometer a minha aplicação, mais vetores de ataque eu terei para contraatacar um ataque.
- Mas não basta comprometer apenas o exitnode, é necessário todos os nodes anteriores a ele, até chegar na origem.


## O que é o Docker

- Um servidor de containers com caracteristicas de virtualização e versionamento:
- Stop
- Resume
- Snapshots
- Import/Export de imagens e containers
- TAGs
- HUB de imagens
- Uma forma de documentar, descrever, executar, balancear e versionar servidores
- DEVOPS na prática
- Produtividade monstra, adeus retrabalho!


## Como funciona o Docker

- Cria-se um Dockerfile que descreve uma imagem
- Um Dockerfile pode herdar outro Dockerfile
- Um Dockerfile é extretamente simples e similiar/"compatível" com shellscript
- Cria-se uma imagem que é resultado do build de um Dockerfile
- Instancia-se N containers desta imagem


## Outros envolvidos

- curl
- netcat
- privoxy
- proxychains


## O que temos...

1. Um Dockerfile/imagem docker
2. Um script de inicialização do container(robot.sh)
3. Um script de renovação de exitnode(tornewid.sh)
4. Um arquivo texto para blacklist de exitnodes(iplist)
5. Um alvo(?)


# Dockerfile ...


# robot.sh ...


# tornewid.sh ...


# Roda roda a roleta ROCKIE! ...


## Ideias para o futuro

- Utilizar memcached para blacklist de IPs
- Desenvolver em C, modulos para o clusterizar o TOR


# The End!
