# Windows-Detector
É um script em Bash que busca computadores na porta 445 usando o Nmap.

Funciona da seguinte forma:
Realiza dois scan's na porta 445 e faz a comparação. Se o segundo scan contiver hosts não detectados anteriormente, adiciona no primeiro e realiza outro scan. Repete este processo até não houverem inconsistências.

Desta forma, a precisão da detecção de máquinas Windows aumenta consideravelmente.
