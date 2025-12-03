README: LLM-Based Text-to-SQL on Spider
Project Overview

This project implements a complete Text-to-SQL pipeline using the T5-small language model to translate natural-language questions into SQL queries. We evaluate the system using the Spider benchmark, which tests cross-database generalization.

The system includes:
Data preprocessing
Schema serialization
Model training
SQL generation
Evaluation and analysis

Repository Structure
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

Requirements Installation

Create a virtual environment:

python -m venv venv
# Activate (Windows):
venv\Scripts\activate
# macOS/Linux:
source venv/bin/activate


Install dependencies:

pip install -r requirements.txt

Data Setup

The Spider dataset is publicly available at:

https://yale-lily.github.io/spider

Our project uses preprocessed versions of the data stored inside data/:

train.json

dev.json

tables.json

These files are already included and small enough to fit in this zip.
You do not need the full Spider raw database to run evaluation on our prepared data.

If you want to regenerate the processed files:

Download Spider from the URL above

Place it at:

project_root/spider/


Run the preprocessing script:

python -m src.prep_spider

How to Run Training

To train T5-small on the preprocessed Spider dataset:

python -m src.train_t5_spider \
    --train_file data/train.json \
    --dev_file data/dev.json \
    --output_dir model


This will fine-tune the model and save updated tokenizer and model config files.

How to Generate Predictions
python -m src.predict_baseline \
    --model_dir model \
    --dev_file data/dev.json \
    --output_file results/pred_dev_baseline.jsonl


Convert predictions to plain SQL:

python -m src.to_eval_format \
    --pred_file results/pred_dev_baseline.jsonl \
    --output_file results/pred_dev_baseline.sql

How to Reproduce the Evaluation Files

Generate gold pairs:

python -m src.make_dev_gold_pairs \
    --dev_file data/dev.json \
    --output_file results/dev_gold_pairs.txt


Generate gold SQL only:

python -m src.make_dev_gold_sql \
    --dev_file data/dev.json \
    --output_file results/dev_gold.sql

Notes

The full Spider dataset is too large to include in this zip, but the preprocessed versions are sufficient.

All scripts in src/ run on CPU and GPU.

The model weights are not included—only the tokenizer/config needed to rebuild the model.
