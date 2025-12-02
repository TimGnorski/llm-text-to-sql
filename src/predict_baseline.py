import json
from transformers import T5ForConditionalGeneration, T5TokenizerFast

MODEL_DIR = "t5_small_spider_baseline"
DATA_FILE = "data_spider_t5/dev.json"
OUT_FILE  = "pred_dev_baseline.jsonl"

tokenizer = T5TokenizerFast.from_pretrained(MODEL_DIR)
model = T5ForConditionalGeneration.from_pretrained(MODEL_DIR)

def generate_sql(prompt, max_new_tokens=256):
    inputs = tokenizer([prompt], return_tensors="pt")
    outputs = model.generate(
        **inputs,
        max_new_tokens=max_new_tokens,  # avoids that max_length warning
        num_beams=4,
        do_sample=False
    )
    return tokenizer.decode(outputs[0], skip_special_tokens=True).strip()

dev = json.load(open(DATA_FILE, "r", encoding="utf-8"))
with open(OUT_FILE, "w", encoding="utf-8") as w:
    for ex in dev[:100]:  # first 100 for speed; remove slice to do all 1034
        pred = generate_sql(ex["input"])
        w.write(json.dumps({"db_id": ex["db_id"], "input": ex["input"],
                            "gold": ex["target"], "pred": pred}) + "\n")
print(f"wrote predictions to {OUT_FILE}")
