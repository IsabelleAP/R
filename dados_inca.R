install.packages("rvest")
install.packages("tidyverse")

library(rvest)
library(tidyverse)

url <- "https://www.gov.br/inca/pt-br/assuntos/cancer/numeros"

pagina <- read_html(url)

tabela <- html_table(html_nodes(pagina, '#b134042f-d2b6-45af-9631-6d2cd451be70 > div > table:nth-child(1)'))
tabela2 <- html_table(html_nodes(pagina, '#b134042f-d2b6-45af-9631-6d2cd451be70 > div > table:nth-child(2)'))

dadosh <- as.data.frame(tabela)
dadosh <- dadosh[-12,]
dadosh

dadosm <- as.data.frame(tabela2)
dadosm <- dadosm[-12,]
dadosm

##calcular o somatório de casos novos para homens e mulheres
resultado <- list()
resultado$htotal <- sum(dadosh$Casos.Novos)
resultado
resultado$mtotal <- sum(dadosm$Casos.Novos)
resultado

##média, mínimo, máximo e mediana de h e m
resultado$hmedia <- mean(dadosh$Casos.Novos)
resultado$median <- median(dadosh$Casos.Novos)
resultado$hmin <- min(dadosh$Casos.Novos)
resultado$hmax <- max(dadosh$Casos.Novos)

resultado$mmedia <- mean(dadosm$Casos.Novos)
resultado$median <- median(dadosm$Casos.Novos)
resultado$mmin <- min(dadosm$Casos.Novos)
resultado$mmax <- max(dadosm$Casos.Novos)
resultado

##pyplot do total
resultado$hplot <- barplot(dadosh$Casos.Novos,
        col = as.factor(dadosh$Localização.Primária),
        legend.text= dadosh$Localização.Primária,
        main='Estimativas de novos tumores em 2023 - homens')


resultado$mplot <- barplot(dadosm$Casos.Novos,
        col = as.factor(dadosm$Localização.Primária),
        legend.text= dadosm$Localização.Primária,
        main='Estimativas de novos tumores em 2023 - mulheres')

barplot(dadosm$Casos.Novos,
        col = as.factor(dadosm$Localização.Primária),
        legend.text= dadosm$Localização.Primária,
        main='Estimativas de novos tumores em 2023 - mulheres')

resultado$hdados <- dadosh
resultado$mdados <- dadosm

getwd()
save(resultado, file='dados_inca')
load("dados_inca")
