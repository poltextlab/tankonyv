library(stringr)
library(dplyr)
library(quanteda)
library(caret)
library(quanteda.textmodels)
library(HunMineR)

set.seed(1234)

Data_NOL_MNO <- HunMineR::data_nol_mno_clean
glimpse(Data_NOL_MNO)

Data_NOL <- Data_NOL_MNO %>% 
  subset(corpus == "NOL" & is.na(text) == F) %>% 
  mutate(label = if_else(majortopic_code == 1, 1, 0)) %>% 
  group_by(label) %>% 
  sample_n(5000) %>% 
  ungroup() %>% 
  select(text, label)

nol_corpus <- corpus(Data_NOL)

id_train <- sample(1:10000, 2500, replace = FALSE)
nol_corpus$id_numeric <- 1:ndoc(nol_corpus)

stopszavak <- HunMineR::data_stopwords_extra

nol_toks <- tokens(nol_corpus, remove_punct = TRUE, remove_number = TRUE) %>% 
  tokens_remove(pattern = stopszavak) %>% 
  tokens_wordstem()

nol_dfm <- dfm(nol_toks)

train_dfm <- dfm_subset(nol_dfm, id_numeric %in% id_train)
test_dfm <- dfm_subset(nol_dfm, !id_numeric %in% id_train)

#NB

nol_nb <- textmodel_nb(train_dfm, train_dfm$label)
dfm_kozos <- dfm_match(test_dfm, features = featnames(train_dfm))

tenyleges_osztaly <- dfm_kozos$label

becsult_osztaly <- predict(nol_nb, newdata = dfm_kozos)

eredmeny_tabla <- table(tenyleges_osztaly, becsult_osztaly)
eredmeny_tabla

confusionMatrix(eredmeny_tabla, mode = "everything")

nb_eredmenyek <- data.frame(confusionMatrix(eredmeny_tabla, mode = "prec_recall")[4])
nb_eredmenyek$mérés <- row.names(nb_eredmenyek)
nb_eredmenyek$módszer <- "Naïve Bayes"
row.names(nb_eredmenyek) <- 1:nrow(nb_eredmenyek)

#SVM

nol_svm <- textmodel_svm(train_dfm, y = train_dfm$label)

tenyleges_osztaly_svm <- dfm_kozos$label
becsult_osztaly_svm <- predict(nol_svm, newdata = dfm_kozos)

eredmeny_tabla_svm <- table(tenyleges_osztaly_svm, becsult_osztaly_svm)
eredmeny_tabla_svm

confusionMatrix(eredmeny_tabla_svm, mode = "everything")

svm_eredmenyek <- data.frame(confusionMatrix(eredmeny_tabla_svm, mode = "prec_recall")[4])
svm_eredmenyek$mérés <- row.names(svm_eredmenyek)
svm_eredmenyek$módszer <- "Support-vector machine"
row.names(svm_eredmenyek) <- 1:nrow(svm_eredmenyek)

eredmenyek <- rbind(svm_eredmenyek, nb_eredmenyek) %>% subset(mérés %in% c("Precision", "Recall", "F1"))

names(eredmenyek)[1] <- "érték"


ggplot(eredmenyek, aes(x = módszer, y = érték, fill = módszer)) +
  geom_bar(stat = "identity", width = 0.1) +
  facet_wrap(~mérés, ncol=1)

eredmenyek$módszer
