library(rvest)
library(dplyr)
library(RSelenium)
library(wdman)
library(netstat)

clickAjaxButton <- function(times, button_selector, delay = 5000) {
  for (i in 1:times) {
    button <- remote_driver$findElement(using = "css selector", paste0("", button_selector))
    
    if (!is.null(button)) {
      button$clickElement()
      Sys.sleep(delay / 1000)
    } else {
      cat("Button not found!\n")
      break
    }
  }
}
get_title = function(inside_link){
  inside_page = read_html(inside_link)
  title = inside_page %>%  html_nodes(".mb10") %>% html_text()
  return(title)
}
get_content = function(inside_link){
  inside_page = read_html(inside_link)
  content = inside_page %>%  html_nodes("p") %>% html_text() %>% paste(collapse = " ")
  return(content)
}
get_date = function(inside_link){
  inside_page = read_html(inside_link)
  date = inside_page %>%  html_nodes(".published_time") %>% html_text() %>% sub("^Publish\\s*:\\s*", "", .)
  return(date)
}

scrape_category <- function(section_url, category, max_articles = 100) {
  
  remote_driver$navigate(section_url)
  Sys.sleep(5)
  
  clickAjaxButton(times = 10, button_selector = "#ajax_load_more_704_btn")
  
  page_source <- remote_driver$getPageSource()[[1]]
  page <- read_html(page_source)
  inside_link <- page %>% html_nodes(".link_overlay") %>% html_attr("href") %>% paste("https:", ., sep = "") %>% head(max_articles)
  
  titles <- sapply(inside_link, FUN = get_title)
  dates <- sapply(inside_link, FUN = get_date)
  contents <- sapply(inside_link, FUN = get_content)
  
  df <- data.frame(
    title = titles,
    date = dates,
    content = contents,
    category = category,
    stringsAsFactors = FALSE
  )
  return(df)
  
}

binman::list_versions("geckodriver")
port <- netstat::free_port()
driver <<- rsDriver(browser = "firefox",
                    geckover="0.35.0",
                    chromever=NULL,
                    check = FALSE,
                    port = port,
                    verbose = TRUE
)

remote_driver <- driver[["client"]]

sports_data <- scrape_category("https://www.dhakatribune.com/sport", "sports")
politics_data <- scrape_category("https://www.dhakatribune.com/bangladesh/politics", "politics")
entertainment_data <- scrape_category("https://www.dhakatribune.com/showtime", "entertainment")
foreign_affairs_data <- scrape_category("https://www.dhakatribune.com/bangladesh/foreign-affairs", "foreign_affairs")
election_data <- scrape_category("https://www.dhakatribune.com/bangladesh/election", "election")

df <- bind_rows(sports_data, politics_data, entertainment_data, foreign_affairs_data, election_data)
write.csv(df, "D:/Study Materials/SPRING_2024-2025/data science/codes/ids_final_project_group_03_news_raw.csv")

remote_driver$close()
driver$server$stop()

library(dplyr)
library(stopwords)
library(textclean)
library(textstem)
library(stringr)

clean_text <- function(text_vector) {
  text_vector <- tolower(text_vector)
  text_vector <- gsub("-", " ", text_vector)
  text_vector <- gsub("[[:punct:]]+", "", text_vector)
  text_vector <- gsub("\\s+", " ", text_vector)
  text_vector <- trimws(text_vector)
  return(text_vector)
}

tokenization <- function(text_vector) {
  strsplit(text_vector, " ")
}

remove_stopwords <- function(token_list) {
  stop_words <- stopwords("en")
  lapply(token_list, function(words) {
    words[!(words %in% stop_words)]
  })
}

remove_numeric_tokens <- function(token_list) {
  lapply(token_list, function(words) {
    words[!grepl("[0-9]", words)]
  })
}

preprocess_pipeline <- function(corpus) {
  corpus <- replace_emoji(corpus)
  corpus <- replace_contraction(corpus)
  corpus <- clean_text(corpus)
  tokens <- tokenization(corpus)
  tokens <- remove_stopwords(tokens)
  tokens <- lapply(tokens, lemmatize_words) 
  tokens <- remove_numeric_tokens(tokens)
  combined_text <- sapply(tokens, paste, collapse = " ")
  return(combined_text)
}

df <- read.csv("D:/Study Materials/SPRING_2024-2025/data science/codes/ids_final_project_group_03_news_raw.csv", stringsAsFactors = FALSE)

processed_content <- preprocess_pipeline(df$content)
processed_df <- data.frame(processed_content = processed_content)

write.csv(processed_df, "D:/Study Materials/SPRING_2024-2025/data science/codes/ids_final_project_group_03_news_clean.csv", row.names = FALSE)