import json, os, numpy as np
from datasets import Dataset
from transformers import (T5ForConditionalGeneration, T5TokenizerFast,
                          DataCollatorForSeq2Seq, Seq2SeqTrainingArguments, Seq2SeqTrainer)

MODEL_NAME = "t5-small"
DATA_DIR = "data_spider_t5"
OUTPUT_DIR = "t5_small_spider_baseline"

tokenizer = T5TokenizerFast.from_pretrained(MODEL_NAME)

raw_train = json.load(open(os.path.join(DATA_DIR, "train.json"), "r", encoding="utf-8"))
raw_dev   = json.load(open(os.path.join(DATA_DIR, "dev.json"),   "r", encoding="utf-8"))

train_ds = Dataset.from_list(raw_train)
dev_ds   = Dataset.from_list(raw_dev)

max_input_len = 1024
max_target_len = 512

def preprocess(batch):
    model_inputs = tokenizer(batch["input"], max_length=max_input_len, truncation=True)
    labels = tokenizer(batch["target"], max_length=max_target_len, truncation=True)
    model_inputs["labels"] = labels["input_ids"]
    return model_inputs

train_tok = train_ds.map(preprocess, batched=True, remove_columns=train_ds.column_names)
dev_tok   = dev_ds.map(preprocess,   batched=True, remove_columns=dev_ds.column_names)

model = T5ForConditionalGeneration.from_pretrained(MODEL_NAME)
data_collator = DataCollatorForSeq2Seq(tokenizer=tokenizer, model=model)

def compute_metrics(eval_preds):
    preds, labels = eval_preds
    preds = np.where(preds != -100, preds, tokenizer.pad_token_id)
    labels = np.where(labels != -100, labels, tokenizer.pad_token_id)
    decoded_preds  = tokenizer.batch_decode(preds,  skip_special_tokens=True)
    decoded_labels = tokenizer.batch_decode(labels, skip_special_tokens=True)
    correct = [(p.strip() == l.strip()) for p, l in zip(decoded_preds, decoded_labels)]
    return {"string_em": float(np.mean(correct))}

args = Seq2SeqTrainingArguments(
    output_dir=OUTPUT_DIR,
    per_device_train_batch_size=2,   # conservative for CPU/RAM; bump to 4–8 if comfy
    per_device_eval_batch_size=2,
    learning_rate=3e-4,
    num_train_epochs=1,              # start with 1 for POC; can raise later
    logging_steps=100,
    evaluation_strategy="epoch",
    save_strategy="epoch",
    predict_with_generate=True,
    fp16=False,
    report_to=[],
)

trainer = Seq2SeqTrainer(
    model=model,
    args=args,
    train_dataset=train_tok,
    eval_dataset=dev_tok,
    data_collator=data_collator,
    tokenizer=tokenizer,
    compute_metrics=compute_metrics,
)

trainer.train()
trainer.save_model(OUTPUT_DIR)
tokenizer.save_pretrained(OUTPUT_DIR)
