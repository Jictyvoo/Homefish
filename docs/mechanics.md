# Mecânicas do jogo

* Você tem uma barra de perigo, indicando quando deve sair do local.
* O jogo contará a quantidade de tempo que levou até zerá-lo.
* O jogador deve ir coletando comida conforme for passando o jogo.
* O jogador tem uma barra de fome.
* O jogador só poderá comer/buscar comida quando a barra de perigo estiver em menos de 60%
* O objetivo do jogador é chegar a uma nova casa.
* O mapa será side-scroller
* O peixe vai aumentando o tamanho conforme encontrar mais comida (ou virar peixes maiores)
* Se for grande o suficiente pode comer outros peixes

## Movimentação

Mover-se para direita e esquerda, podendo haver possibilidade de olhar para cima e abaixar-se, bem como pular. As teclas correspondente são:

* Esquerda: Seta Esquerda
* Direita: Seta Direita
* Olhar para cima: Seta Cima
* Olhar para baixo: Seta Baixo

## Customização

Será possível customizar os controles utilizados numa tela de configuração

## Cenários

* Cidade Submersa

## Camera

O script de camera funciona da seguinte forma:

* Começará a seguir o personagem principal sempre que o mesmo chega ao meio da tela depois de mudar a orientação
* Caso o personagem se encontre nas bordas da tela, a camera permanecerá fixa e não seguirá o mesmo
* A camera não seguirá o personagem quando o mesmo salta, apenas quando o mesmo cai em uma plataforma que a posição vertical da camera será atualizada

## Inteligência dos Inimigos

Os inimigos irão cegamente para cima do jogador, atirando com tudo

* Seu Barriga - Ele irá correr atrás do jogador, o qual deve fugir do mesmo para que dessa forma não precise pagar o dinheiro do aluguel naquele momento e economize para as fases posteriores. É possível atirar no mesmo para que dessa forma o atrase
