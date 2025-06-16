library(dplyr)
library(tm)
library(topicmodels)
library(tidytext)
library(ggplot2)
library(reshape2)
library(knitr)
library(tidyr)

df <- read.csv("D:/Study Materials/SPRING_2024-2025/data science/codes/ids_final_project_group_03_news_clean.csv", stringsAsFactors = FALSE)

corpus <- VCorpus(VectorSource(df$processed_content))

dtm <- DocumentTermMatrix(corpus, control = list(wordLengths = c(3, Inf)))
print(dim(dtm))
print(as.matrix(dtm)[1:5, 1:10])  

lda_model <- LDA(dtm, k = 10, control = list(seed = 1234))

topics_terms <- tidy(lda_model, matrix = "beta")

top_terms <- topics_terms %>%
  group_by(topic) %>%
  top_n(10, beta) %>%
  ungroup() %>%
  arrange(topic, -beta)

cat("Top 10 words per topic:\n")
top_terms %>%
  group_by(topic) %>%
  summarise(top_words = paste(term, collapse = ", ")) %>%
  arrange(topic) %>%
  print(n = 10)

top_terms_wide <- top_terms %>%
  arrange(topic, desc(beta)) %>%
  group_by(topic) %>%
  slice_max(beta, n = 10) %>%
  mutate(Rank = row_number(),
         Term_with_Prob = paste0(term, " (", round(beta, 4), ")")) %>%
  select(topic, Rank, Term_with_Prob) %>%
  pivot_wider(names_from = topic, values_from = Term_with_Prob, names_prefix = "Topic_")
kable(top_terms_wide, caption = "Top 10 Terms per Topic with probability")


doc_topics <- tidy(lda_model, matrix = "gamma")
set.seed(123)  
random_docs <- sample(unique(doc_topics$document), 2)
cat("\nTopic proportions for 10 random documents:\n")
doc_topics %>%
  filter(document %in% random_docs) %>%
  arrange(document, topic) %>%
  print(n = 10)

