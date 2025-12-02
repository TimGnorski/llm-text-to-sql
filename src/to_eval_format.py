import json
with open("pred_dev_baseline.jsonl","r",encoding="utf-8") as f, \
     open("pred_dev_baseline.sql","w",encoding="utf-8") as w:
    for line in f:
        w.write(json.loads(line)["pred"].strip()+"\n")
print("Wrote pred_dev_baseline.sql")
