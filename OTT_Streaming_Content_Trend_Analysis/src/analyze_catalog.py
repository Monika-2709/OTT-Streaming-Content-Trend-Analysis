"""
OTT Streaming Content Trend Analysis
Run: pip install -r requirements.txt
     python src/analyze_catalog.py
Note: bundled catalog is synthetic and illustrative, not official platform data.
"""
from pathlib import Path
import pandas as pd
import matplotlib.pyplot as plt

ROOT = Path(__file__).resolve().parents[1]
DATA = ROOT / "data" / "ott_catalog.csv"
OUT = ROOT / "reports" / "generated"
OUT.mkdir(parents=True, exist_ok=True)

raw = pd.read_csv(DATA)
summary = {
    "raw_rows": len(raw),
    "duplicate_show_ids": int(raw["show_id"].duplicated().sum()),
    "missing_cells": int(raw.isna().sum().sum()),
}
df = raw.drop_duplicates(subset=["show_id"]).copy()
df["date_added"] = pd.to_datetime(df["date_added"], errors="coerce")
for col in ["director", "country", "rating", "genre", "type"]:
    df[col] = df[col].fillna("Unknown")
df["duration_value"] = pd.to_numeric(df["duration"].astype(str).str.extract(r"(\\d+)")[0], errors="coerce")
df["duration_unit"] = df["duration"].astype(str).apply(lambda x: "Seasons" if "season" in x.lower() else "Minutes")
df.to_csv(OUT / "ott_catalog_cleaned.csv", index=False)
df["type"].value_counts().rename_axis("type").reset_index(name="count").to_csv(OUT / "type_summary.csv", index=False)
df["genre"].value_counts().rename_axis("genre").reset_index(name="count").to_csv(OUT / "genre_summary.csv", index=False)
df.groupby("release_year").size().rename("count").reset_index().to_csv(OUT / "release_year_summary.csv", index=False)
pd.DataFrame([summary]).to_csv(OUT / "data_quality_summary.csv", index=False)
print("Analysis complete.")
print(summary)
print("Cleaned rows:", len(df))
print("Top genres:", df["genre"].value_counts().head(5).to_dict())
