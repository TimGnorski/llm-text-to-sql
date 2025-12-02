# makes dev_gold_pairs.txt with 100 lines matching your 100 preds
import json

dev = json.load(open("spider/dev.json","r",encoding="utf-8"))
with open("dev_gold_pairs.txt","w",encoding="utf-8") as w:
    for ex in dev[:100]:  # match the [:100] used in predict_baseline.py
        sql = ex["query"].strip().replace("\n"," ")
        db  = ex["db_id"]
        # Most test-suite evaluators expect: gold_sql <TAB> db_id
        w.write(f"{sql}\t{db}\n")

print("Wrote dev_gold_pairs.txt (first 100).")
