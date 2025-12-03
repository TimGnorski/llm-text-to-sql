
# LLM-based Text-to-SQL on Spider

This repository contains Group 2's final project for the **Fundamentals of AI** course.  
The goal is to train and evaluate a **T5-based Text-to-SQL model** on the **Spider** dataset, mapping natural language questions to SQL queries over relational databases.

---

## 1. Project Overview

- **Task:** Text-to-SQL (NL question → SQL query)
- **Model:** Fine-tuned `t5-small` using Hugging Face Transformers
- **Dataset:** Spider-style JSON splits (`train.json`, `dev.json`, `tables.json`)
- **Main outputs:**
  - Exact-match accuracy of predicted SQL vs. gold SQL on the dev set
  - Prediction files and gold pairs used for evaluation and error analysis

High-level pipeline:

1. Preprocess Spider into a convenient JSON format  
2. Fine-tune `t5-small` on (question, schema) → SQL pairs  
3. Generate SQL predictions on the dev split  
4. Convert predictions to evaluation format and compare with gold SQL  

---

## 2. Repository Structure

```text
llm-text-to-sql/
├─ README.md               # Project description (this file)
├─ requirements.txt        # Python dependencies
├─ .gitignore              # Ignore large / generated files
├─ src/
│  ├─ train_t5_spider.py   # Training script for T5 on Spider
│  ├─ predict_baseline.py  # Generate predictions on dev set
│  ├─ prep_spider.py       # Preprocess Spider into train/dev JSON
│  ├─ to_eval_format.py    # Convert predictions to evaluation format
│  ├─ make_dev_gold_pairs.py  # Build dev question/SQL gold pairs
│  └─ make_dev_gold_sql.py    # Extract gold SQL for dev split
├─ data/
│  ├─ train.json           # Processed training split
│  ├─ dev.json             # Processed dev split
│  └─ tables.json          # Schema information for databases
├─ model/
│  ├─ config.json          # T5 model configuration
│  ├─ tokenizer.json       # Tokenizer vocabulary
│  ├─ tokenizer_config.json
│  ├─ special_tokens_map.json
│  └─ spiece.model         # SentencePiece model for tokenizer
└─ results/
   ├─ dev_gold_pairs.txt       # Gold question/SQL pairs for dev
   ├─ pred_dev_baseline.jsonl  # Model predictions on dev (JSONL)
   └─ pred_dev_baseline.sql    # Predictions in plain SQL format
