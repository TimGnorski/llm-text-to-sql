**LLM-Based Text-to-SQL on the Spider Dataset**

### *Final Project — COSC 4600: Fundamentals of AI*

**Group 2: Christian Blair, Ihonesty Serrano, Kane Undag, Tim Gnorski, Krishay Toomu, Aydan Smith-Tetrev**

---

<p align="center">
  <img src="https://img.shields.io/badge/Python-3.10-blue?style=flat-square">
  <img src="https://img.shields.io/badge/Model-T5--Small-green?style=flat-square">
  <img src="https://img.shields.io/badge/Dataset-Spider-orange?style=flat-square">
</p>

---

#  **1. Project Overview**

This repository contains our implementation of an **LLM-based Text-to-SQL system**, designed to translate **natural-language questions** into **SQL queries** using the **T5-small** transformer model.

The project includes:

* Dataset preprocessing
* Schema serialization
* Fine-tuning T5-small on Spider
* SQL generation (beam search decoding)
* Evaluation (exact match, execution accuracy, validity)
* Error and ablation analysis

The code is fully runnable following the instructions below.

---

#  **2. Repository Structure**

```
llm-text-to-sql/
│
├── README.md                      # This file
├── requirements.txt               # Python dependencies
│
├── data/                          # Preprocessed Spider data (included)
│     ├── train.json
│     ├── dev.json
│     └── tables.json
│
├── model/                         # Model tokenizer & configuration
│     ├── config.json
│     ├── tokenizer.json
│     ├── tokenizer_config.json
│     ├── special_tokens_map.json
│     └── spiece.model
│
├── src/                           # All source code
│     ├── train_t5_spider.py
│     ├── predict_baseline.py
│     ├── prep_spider.py
│     ├── to_eval_format.py
│     ├── make_dev_gold_pairs.py
│     └── make_dev_gold_sql.py
│
└── results/                       # Prediction files for evaluation
      ├── pred_dev_baseline.jsonl
      ├── pred_dev_baseline.sql
      └── dev_gold_pairs.txt
```

All code in `src/` runs directly using the folder layout above.

---

#  **3. Installation**

### **Create a virtual environment**

**Windows**

```bash
python -m venv venv
venv\Scripts\activate
```

**macOS / Linux**

```bash
python3 -m venv venv
source venv/bin/activate
```

### **Install dependencies**

```bash
pip install -r requirements.txt
```

Dependencies include:

* `torch`
* `transformers`
* `sentencepiece`
* `pandas`, `numpy`
* `sqlparse`
* `datasets`
* `tqdm`

---

#  **4. Data Setup**

We provide preprocessed Spider dataset files inside the `data/` folder:

* `train.json`
* `dev.json`
* `tables.json`

###  If you want to access the full Spider dataset:

Download it from the official site:

**[https://yale-lily.github.io/spider](https://yale-lily.github.io/spider)**

Place it in this directory:

```
llm-text-to-sql/spider/
```

Then run:

```bash
python -m src.prep_spider
```

This will regenerate `train.json` and `dev.json`.

---

#  **5. Running the Code**

## **5.1. Train the T5-small model**

```bash
python -m src.train_t5_spider \
    --train_file data/train.json \
    --dev_file data/dev.json \
    --output_dir model
```

This script fine-tunes T5-small and saves updated configuration files.

---

## **5.2. Generate SQL predictions**

```bash
python -m src.predict_baseline \
    --model_dir model \
    --dev_file data/dev.json \
    --output_file results/pred_dev_baseline.jsonl
```

This produces a JSONL file of predictions.

---

## **5.3. Convert predictions to SQL-only format**

```bash
python -m src.to_eval_format \
    --pred_file results/pred_dev_baseline.jsonl \
    --output_file results/pred_dev_baseline.sql
```

---

## **5.4. Generate gold SQL files for evaluation**

```bash
python -m src.make_dev_gold_pairs \
    --dev_file data/dev.json \
    --output_file results/dev_gold_pairs.txt
```

```bash
python -m src.make_dev_gold_sql \
    --dev_file data/dev.json \
    --output_file results/dev_gold.sql
```

---

#  **6. Notes on Large Files**

The **full Spider dataset** and **model weight files** are intentionally **NOT** included because they exceed file size limits.

Instead, we provide:

* Preprocessed small JSON files required to run all scripts
* Instructions for downloading & placing the raw Spider data
---

#  **7. Quick Start Summary**

To reproduce our full pipeline:

```bash
# Install dependencies
pip install -r requirements.txt

# Train model
python -m src.train_t5_spider --train_file data/train.json --dev_file data/dev.json --output_dir model

# Generate predictions
python -m src.predict_baseline --model_dir model --dev_file data/dev.json --output_file results/pred_dev_baseline.jsonl

# Convert to SQL
python -m src.to_eval_format --pred_file results/pred_dev_baseline.jsonl --output_file results/pred_dev_baseline.sql

# Extract gold SQL
python -m src.make_dev_gold_success --dev_file data/dev.json --output_file results/dev_gold_pairs.txt
```

Everything is runnable from the root folder.

---

#  **8. Contact**

Group 2 — COSC 4600
Marquette University
Fall 2025

---
