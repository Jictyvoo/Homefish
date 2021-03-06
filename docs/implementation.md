# Implementação

Esse arquivo visa informar o papel de cada arquivo e pacote (pasta) para os futuros desenvolvedores que forem utilizar os códigos, e/ou contribuir com o projeto

## docs

Pasta que armazena todos os arquivos Markdown de documentação do projeto

## src

Pasta que contém todos os arquivos de código do game

* main - Arquivo principal de execução, arquivo que será executado pela engine para rodar o jogo
* conf - Arquivo que determina quais módulos serão utilizados durante a execução do game, visando dessa forma diminuir o processamento. Esse arquivo também é responsável por definir tamanho de tela, icone e nome da janela de execução do game. Esse arquivo será executado antes de qualquer outro, inclusive a main

## src/assets

Essa pasta tem o intuito de armazenar todos os arquivos de imagem, áudio e fontes do jogo, visando dessa forma uma maior organização do projeto como um todo

## src/controllers

Essa pasta contém os principais controladores que são utilizados no jogo.

* CameraController - Controller que possui os scripts de camera para realizar a movimentação e manipulação do mundo do jogo.
* GameDirector - Controller mais importante de todos, ele manipula todo o jogo, faz a inclusão de cenas, e gerencia os métodos necessários para o funcionamento do game. Ele fica armazenada na tabela global do interpretador, para assim ser acessado em qualquer local.
* SceneDirector - Controller que gerencia o uso das funções do Love2d através da cena atual de execução

## src/libs

Essa pasta contém os arquivos de biblioteca externos utilizados

## src/models

Pasta que contém os arquivos de modelagem do game

* Class - Arquivo que auxilia na geração de classes e objetos, bem como herança entre os mesmos utilizando o conceito de POO

### src/models/actors

Pasta que contém todos os scripts de atores do jogo, como balas, inimigos, dentre outros

* Enemy - Classe que contém os sprites e funcionamento dos inimigos no jogo
* MainCharacter - Classe que detecta os eventos de input no teclado para que o jogador possa se locomover e realizar ações

### src/models/value

Pasta que contém os arquivos de armazenamento de dados do sistema

* LifeForm - Classe que armazena as informações que uma forma de vida do jogo necessita ter

### src/models/business

Pasta que contém classes de modelagem que servem como uma abstração para manipulação de recursos importantes

* GameState - Classe que contém os estados anteriores dos objetos, para que dessa forma seja possível carregar os mesmos para um estado anterior ao estado atual do game, dessa forma é possível realizar checkpoints e restartar o game sem que seja necessário finalizar o processo do game
* World - Faz as manipulações no Mundo do game, alterando seus efeitos na física do mesmo

#### src/models/business/enemies_ai

Pasta que contém as inteligências artificiais de todos os inimigos do jogo de forma separada, para que assim possa ser criados inimigos que agem de formas distintas

* MegalodonAi - Classe que controla a movimentação e ações do inimigo do tipo "Megalodon"

### src/models/submenus

Pata que contém os submenus que irão aparecer durante o jogo, sem que haja a necessidade que tenha a cena atual do jogo alterada totalmente

* PauseGame - Classe que conterá a GUI do submenu do game quando o mesmo for pausado

## src/scenes

Pasta que contém as cenas do game, ou seja, cada uma das telas do jogo

* CreditsScene - Transcorrer dos créditos da criação do game
* ConfigurationScene - Cena que contém as informações de configuração do game, como tamanho da tela, controles, dentre outros
* InGameScene - Cena que possuirá todos os elementos do jogo e da fase
* MainMenuScene - Tela de Menu do Game

## src/util

Pasta que contém os scripts para auxiliar o desenvolvimento do jogo

* ScaleDimension - Arquivo que realiza os cáculos de redimensionamento de tela para que o jogo possa ser portado em telas de tamanhos distintos

### src/util/GUI

Pasta que contém os scrpits de itens de interface de usuário

* Button - Classe que contém o botão e sua detecção, bem como manipulação dos sprites
* ButtonManager - Classe que faz a gerencia dos botões, e manipula os mesmos para que possam ser usados tanto pelo mouse, como pelo teclado
* ProgressBar - Classe que permite a criação e visualização de uma barra de progresso durante o jogo
