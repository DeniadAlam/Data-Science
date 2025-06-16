# Data-Science

# 📊 Introduction to Data Science Final Project – Group 03  
**Introduction to Data Science** – Spring 2024-2025  
**American International University-Bangladesh (AIUB)**  
**Course Teacher:** Dr. Abdus Salam  
**Section:** E  

## 👥 Group Members
| Serial | Name                | ID           |
|--------|---------------------|--------------|
| 01     | Md. Ashfaq Bin Hoque | 22-46662-1 |
| 02     | Md. Deniad Alam      | 22-46658-1 |
| 03     | Maruf Billah Siddiki | 22-47177-1 |
| 04     | Al Fahim             | 22-46402-1 |

---

## 📝 Project Overview

This project performs **web scraping**, **text preprocessing**, and **topic modeling** on real news articles sourced from the **Dhaka Tribune** website. The aim is to identify hidden topics in the news content using **Latent Dirichlet Allocation (LDA)**.

---

## 📦 Technologies & Libraries

**Language:** R  
**Key Libraries:**
- `rvest`, `RSelenium`, `dplyr`, `tm`, `textstem`, `textclean`, `stopwords`, `tidytext`, `topicmodels`, `knitr`, `reshape2`, `stringr`

---

## 🕸️ Part 1: Web Scraping

### ✅ Steps:
1. **AJAX Handling:**  
   Using `RSelenium` to simulate “Load More” button clicks with `clickAjaxButton()`

2. **Helper Functions:**  
   - `get_title()`, `get_content()`, `get_date()`

3. **Scraping Categories:**  
   - Sports, Politics, Entertainment, Foreign Affairs, Elections

4. **Final Output:**  
   - A combined CSV file containing titles, dates, categories, and article contents from 5 sections of the news site.

---

## 🧹 Part 2: Text Preprocessing

### ✅ Techniques Used:
- **Emoji Replacement**
- **Contraction Expansion**
- **Lowercasing**
- **Dash & Punctuation Removal**
- **Whitespace Normalization**
- **Tokenization**
- **Stopword Removal**
- **Lemmatization**
- **Numeric Token Removal**

### ✅ Output:
A cleaned version of the dataset saved to CSV, ready for analysis.

---

## 🔍 Part 3: Topic Modeling (LDA)

### ✅ LDA Workflow:
1. Convert cleaned text into **Document-Term Matrix (DTM)**
2. Apply **Latent Dirichlet Allocation** with `k = 10` topics
3. Extract:
   - **Top 10 terms per topic** (based on β)
   - **Topic proportions per document** (based on γ)

### 🧠 Example Topics:
- **Topic 2**: film, director, story → Entertainment  
- **Topic 4**: election, commission, reform → Politics/Elections  
- **Topic 7**: india, pakistan, cricket → International Cricket

---

## 📈 Results & Interpretation

- **β (Beta values)** show strong associations between keywords and topics.
- **γ (Gamma values)** indicate dominant topics per article.
- Clear distinction found between categories like politics, sports, and entertainment.

---

## 📁 Project Structure

```text
📦 ids_final_project_group_03/
├── scraping/
│   ├── 01_load_libraries.R             # Load required libraries for scraping
│   ├── 02_click_ajax_button.R         # Simulate "Load More" button clicks
│   ├── 03_helper_functions.R          # get_title(), get_content(), get_date()
│   ├── 04_scrape_category.R           # Scrape a single news category
│   ├── 05_launch_selenium.R           # Set up Firefox driver with RSelenium
│   ├── 06_scrape_multiple_categories.R# Scrape 5 categories from Dhaka Tribune
│   ├── 07_combine_and_save.R          # Combine and save raw data to CSV
│   ├── 08_close_browser.R             # Close browser and Selenium server
│   └── raw_data.csv                   # Output: All scraped articles
│
├── preprocessing/
│   ├── 01_load_libraries.R            # Load libraries for text preprocessing
│   ├── 02_preprocessing_functions.R  # Clean, tokenize, lemmatize, etc.
│   ├── 03_run_pipeline.R             # Apply preprocessing pipeline
│   └── cleaned_data.csv              # Output: Cleaned/preprocessed text data
│
├── topic_modeling/
│   ├── 01_load_libraries.R           # Load libraries for topic modeling
│   ├── 02_data_loading.R             # Load cleaned CSV into a corpus
│   ├── 03_create_dtm.R               # Create Document-Term Matrix
│   ├── 04_run_lda.R                  # Apply LDA (k = 10 topics)
│   ├── 05_extract_topics.R           # Extract top terms per topic
│   ├── 06_topic_probabilities.R      # Document-topic gamma values
│   └── topic_model_results.csv       # Output: Top terms and topic weights
│
├── figures/                          # Optional: Save any plots/tables
│   ├── top_terms_table.png
│   └── topic_distributions.png
│
├── data/                             # Backup or supporting data files
│   └── dhakatribune_urls.txt
│
└── README.md                         # Project summary and documentation

```




---

## 🚀 How to Run (Locally)
1. Clone this repo
2. Install required R packages
3. Run `scraping/scrape_functions.R`
4. Run `preprocessing/text_cleaning_pipeline.R`
5. Run `topic_modeling/lda_model.R` to generate topics

---

## 🏁 Final Notes
This project demonstrates real-world **data acquisition**, **natural language processing**, and **unsupervised learning** using R.  
Feel free to explore, reuse, or expand the analysis.

---

## 📜 License
This project is for academic use under AIUB's course guidelines.


