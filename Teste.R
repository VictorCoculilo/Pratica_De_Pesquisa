library(ggplot2)
library(daltoolbox)

data <- read.csv("~/data.csv")
colnames(data) <- c("Tipo", "a1", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13")


# 1a. Calcule a média e desvio padrão para todos os atributos

means <- colMeans(data[,-1])  
sds <- apply(data[,-1], 2, sd)

print("Médias dos atributos:")
print(means)
print("Desvio padrão dos atributos:")
print(sds)

# 1b. Calcule a média e desvio padrão para todos os atributos agrupado pelo tipo de vinho

tipo_1 <- data[data$Tipo == 1, -1]
tipo_2 <- data[data$Tipo == 2, -1]
tipo_3 <- data[data$Tipo == 3, -1]

mean_tipo_1 <- colMeans(tipo_1)
mean_tipo_2 <- colMeans(tipo_2)
mean_tipo_3 <- colMeans(tipo_3)
sd_tipo_1 <- apply(tipo_1, 2, sd)
sd_tipo_2 <- apply(tipo_2, 2, sd)
sd_tipo_3 <- apply(tipo_3, 2, sd)

print("Médias e desvios padrão para o Tipo 1:")
print(mean_tipo_1)
print(sd_tipo_1)
print("Médias e desvios padrão para o Tipo 2:")
print(mean_tipo_2)
print(sd_tipo_2)
print("Médias e desvios padrão para o Tipo 3:")
print(mean_tipo_3)
print(sd_tipo_3)

# 1c. Apresente o gráfico de distribuição de densidade para cada atributo pelo tipo de vinho

data2 <- data
data2$Tipo <- factor(data2$Tipo, levels = c(1, 2, 3), labels = c("Tipo 1", "Tipo 2", "Tipo 3"))

print(data2)

atributos <- paste0("a", 1:13)

for (atributo in atributos) {
  graphic <- ggplot(data2, aes_string(x = atributo, color = "Tipo")) +
    geom_density(na.rm = TRUE) +
    labs(title = paste("Densidade", atributo), x = atributo, y = "Densidade") +
    scale_color_manual(values = c("Tipo 1" = "blue", "Tipo 2" = "red", "Tipo 3" = "green"))
  
    print(graphic)
}

# 1d. Apresente o gráfico de box-plot para cada atributo pelo tipo de vinho
for (atributo in atributos) {
  graphic <- ggplot(data2, aes_string(x = atributo, color = "Tipo")) +
    geom_boxplot(na.rm = TRUE) +
    labs(title = paste("Densidade", atributo), x = atributo, y = "Densidade") +
    scale_color_manual(values = c("Tipo 1" = "blue", "Tipo 2" = "red", "Tipo 3" = "green"))
  
  print(graphic)
}

# 1e. Apresente o gráfico de dispersão entre os atributos

combinacoes <- combn(atributos, 2,simplify = FALSE)

for (comb in combinacoes) {
  atributo_x <- comb[1]
  atributo_y <- comb[2]
  
  graphic <- ggplot(data2, aes_string(x = atributo_x, y = atributo_y, color = "Tipo")) +
    geom_point(na.rm = TRUE)
    labs(title = paste("Gráfico de Dispersão entre", atributo_x, "e", atributo_y),x = atributo_x, y = atributo_y) +
    scale_color_manual(values = c("Tipo 1" = "blue", "Tipo 2" = "red", "Tipo 3" = "green"))
  
  print(graphic)
}


# 2a. Realize a discretização dos atributos números em faixas de valores alto, médio, baixo.

data <- read.csv("~/data.csv")
colnames(data) <- c("Tipo", "a1", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13")

discretizar <- function(data) {
  for (i in 2:ncol(data)) { 
    
    q1 <- quantile(data[, i], 0.33, na.rm = TRUE) 
    q2 <- quantile(data[, i], 0.67, na.rm = TRUE)
    
    data[, i] <- cut(
      data[, i],
      breaks = c(-Inf, q1, q2, Inf),  
      labels = c("Baixo", "Médio", "Alto")
    )
  }
  return(data)
}

data_discretizados <- discretizar(data)
print(data_discretizados)

# 2b. Converta o atributo do tipo de vinho para mapeamento categórico

data$Tipo <- factor(data$Tipo, levels = c(1, 2, 3), labels = c("Tipo 1", "Tipo 2", "Tipo 3"))

print(data)


# 3. Construa um modelo agrupamento k-means para os dados de vinho usando o DAL Toolbox

data <- read.csv("~/data.csv")
colnames(data) <- c("Tipo", "a1", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13")

model <- cluster_kmeans(k=3)
model <- fit(model, data[, -1])
clu <- cluster(model, data[,-1])
table(clu)
eval <- evaluate(model, clu, data$Tipo)
eval
 
# 4. Construa um modelo predição usando redes neurais para os dados de vinho usando o DAL Toolbox

data <- read.csv("~/data.csv")
colnames(data) <- c("Tipo", "a1", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13")

data(data)
print(t(sapply(data, class)))
head(data)

set.seed(1)
sr <- sample_random()
sr <- train_test(sr, data)
data_train <- sr$train
data_test <- sr$test

model <- reg_mlp("a4", size=5, decay=0.54)
model <- fit(model, data_train)

train_prediction <- predict(model, data_train)
data_train_predictand <- data_train[,"a4"]
train_eval <- evaluate(model, data_train_predictand, train_prediction)
print(train_eval$metrics)

test_prediction <- predict(model, data_test)
data_test_predictand <- data_test[,"a4"]
test_eval <- evaluate(model, data_test_predictand, test_prediction)
print(test_eval$metrics)






