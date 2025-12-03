LLM-Based Text-to-SQL on the Spider Dataset

COSC 4600 – Fundamentals of AI
Group 6

1. Overview

This project implements an end-to-end Text-to-SQL system using a fine-tuned T5-small language model.
The system takes a natural-language question and generates an SQL query that can be executed on the target database.

Our pipeline includes:

Data preprocessing

Schema serialization

Fine-tuning T5-small

SQL generation using beam search

Evaluation of accuracy and SQL validity

Error analysis

This README includes all instructions required to run our code.

2. Directory Structure

Your project folder should look like this:

llm-text-to-sql/
│
├── README.md
├── requirements.txt
│
├── data/
│     ├── train.json
│     ├── dev.json
│     └── tables.json
│
├── model/
│     ├── config.json
│     ├── tokenizer.json
│     ├── tokenizer_config.json
│     ├── special_tokens_map.json
│     └── spiece.model
│
├── src/
│     ├── train_t5_spider.py
│     ├── predict_baseline.py
│     ├── prep_spider.py
│     ├── to_eval_format.py
│     ├── make_dev_gold_pairs.py
│     └── make_dev_gold_sql.py
│
└── results/
      ├── pred_dev_baseline.jsonl
      ├── pred_dev_baseline.sql
      └── dev_gold_pairs.txt


All scripts run from this structure.

3. Installation
Step 1 — Create a virtual environment

Windows:

python -m venv venv
venv\Scripts\activate


macOS/Linux:

python3 -m venv venv
source venv/bin/activate

Step 2 — Install dependencies
pip install -r requirements.txt


Required packages include:

torch

transformers

sentencepiece

pandas

numpy

tqdm

sqlparse

datasets

4. Data Setup

We include the preprocessed Spider data inside the data/ directory:

train.json

dev.json

tables.json

These files are small and allow the code to run without needing to download the full Spider dataset.

If you want to regenerate the processed data

Download Spider from the official source:

🔗 https://yale-lily.github.io/spider

Place the raw dataset here:

llm-text-to-sql/spider/


Then run:

python -m src.prep_spider


This will produce new train/dev sets in data/.

5. Running the Code
5.1. Train the model

This fine-tunes T5-small using the training split:

python -m src.train_t5_spider \
    --train_file data/train.json \
    --dev_file data/dev.json \
    --output_dir model


Training outputs:

Updated tokenizer configs

Model configuration

Saved checkpoints (if enabled)

5.2. Generate SQL predictions on the dev set
python -m src.predict_baseline \
    --model_dir model \
    --dev_file data/dev.json \
    --output_file results/pred_dev_baseline.jsonl


This produces predictions in JSONL format.

5.3. Convert predictions to SQL-only format
python -m src.to_eval_format \
    --pred_file results/pred_dev_baseline.jsonl \
    --output_file results/pred_dev_baseline.sql

5.4. Generate gold SQL files (for evaluation)

These help compare predictions to the correct SQL:

python -m src.make_dev_gold_pairs \
    --dev_file data/dev.json \
    --output_file results/dev_gold_pairs.txt

python -m src.make_dev_gold_sql \
    --dev_file data/dev.json \
    --output_file results/dev_gold.sql

6. Notes on Large Data Files

The full Spider dataset is too large to include in the submission zip file.
This README provides:

A download link

Instructions for placement

Steps to preprocess the data

This satisfies the assignment requirement:

“If data files are very large… include the data link in the readme… add proper instructions where to put the downloaded data.”
(✔ done)

7. How to Run Everything (Quick Summary)

Install Python requirements

Make sure data/ and model/ folders are present

Run:

train_t5_spider.py to train

predict_baseline.py to generate SQL

to_eval_format.py to clean predictions

make_dev_gold_pairs.py to extract gold labels

Compare predicted SQL vs gold SQL in results/

8. Contact

Group 6 — COSC 4600 (Fall 2025)
Marquette University
