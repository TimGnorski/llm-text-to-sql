# prep_spider.py
import json, os
from pathlib import Path

SPIDER_DIR = "spider"
OUT_DIR = "data_spider_t5"
os.makedirs(OUT_DIR, exist_ok=True)

tables_json = json.load(open(os.path.join(SPIDER_DIR, "tables.json"), "r", encoding="utf-8"))

schemas = {}
for db in tables_json:
    db_id = db["db_id"]
    table_names = db["table_names_original"]
    column_names = db["column_names_original"]  # [(table_id, col_name)]
    fks = db["foreign_keys"]  # [(src_col_idx, dst_col_idx)]
    table_cols = {t: [] for t in table_names}
    for idx, (tid, col) in enumerate(column_names):
        if tid == -1:  # skip '*'
            continue
        table_cols[table_names[tid]].append(col)
    fk_triples = []
    for src_idx, dst_idx in fks:
        s_tid, s_col = column_names[src_idx]
        d_tid, d_col = column_names[dst_idx]
        s_table = table_names[s_tid]
        d_table = table_names[d_tid]
        fk_triples.append((s_table, s_col, d_table, d_col))
    schemas[db_id] = {"tables": table_names, "table_cols": table_cols, "fks": fk_triples}

def serialize_schema(db_id):
    sc = schemas[db_id]
    parts = []
    for t in sc["tables"]:
        cols = [c for c in sc["table_cols"][t] if c != "*"]
        parts.append(f"table {t} (" + ", ".join(cols) + ");")
    for (st, scn, dt, dcn) in sc["fks"]:
        parts.append(f"fk {st}.{scn} = {dt}.{dcn};")
    return " ".join(parts)

def read_split(split_json):
    items = []
    data = json.load(open(split_json, "r", encoding="utf-8"))
    for ex in data:
        q = ex["question"].strip()
        sql = ex["query"].strip()
        db_id = ex["db_id"]
        schema_text = serialize_schema(db_id)
        inp = f"translate to SQL:\nquestion: {q}\nschema: {schema_text}"
        items.append({"input": inp, "target": sql, "db_id": db_id})
    return items

train = read_split(os.path.join(SPIDER_DIR, "train_spider.json"))
dev   = read_split(os.path.join(SPIDER_DIR, "dev.json"))

json.dump(train, open(os.path.join(OUT_DIR, "train.json"), "w", encoding="utf-8"), ensure_ascii=False, indent=2)
json.dump(dev,   open(os.path.join(OUT_DIR, "dev.json"),   "w", encoding="utf-8"), ensure_ascii=False, indent=2)
print(f"wrote {len(train)} train and {len(dev)} dev examples to {OUT_DIR}")
