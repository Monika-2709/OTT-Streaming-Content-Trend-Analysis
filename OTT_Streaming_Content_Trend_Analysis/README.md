# OTT Streaming Content Trend Analysis

**Project type:** Exploratory Data Analysis (EDA), SQL analytics, business storytelling  
**Tools:** Python, Pandas, Matplotlib, SQL, Excel-compatible CSV

## Important dataset note
The included `data/ott_catalog.csv` is a **synthetic, reproducible demonstration dataset** created for this project. It is not scraped from Netflix, Prime Video, or Hotstar and must not be represented as official platform data. Replace it with a properly licensed public catalog dataset to produce platform-specific findings.

## Business question
What does a streaming catalog's genre, release-year, content-rating, country, and runtime mix suggest about content positioning and acquisition opportunities?

## Project contents
- `data/ott_catalog.csv` — raw illustrative catalog (contains a few deliberate duplicates/missing fields for cleaning practice)
- `data/ott_catalog_cleaned.csv` — cleaned and enriched catalog
- `notebooks/OTT_Content_Trend_Analysis.ipynb` — end-to-end analysis notebook
- `sql/analysis_queries.sql` — core SQL aggregations
- `src/analyze_catalog.py` — repeatable analysis starter script
- `reports/` — charts, content strategy memo, and detailed PDF report
- `requirements.txt` — Python dependencies

## Run locally
```bash
python -m venv .venv
# Windows: .venv\Scripts\activate
# macOS/Linux: source .venv/bin/activate
pip install -r requirements.txt
python src/analyze_catalog.py
jupyter notebook notebooks/OTT_Content_Trend_Analysis.ipynb
```

## Suggested workflow
1. Review `data/ott_catalog.csv` and inspect schema / missing values.
2. Run the notebook from top to bottom.
3. Import `ott_catalog_cleaned.csv` into SQLite, PostgreSQL, MySQL, or SQL Server and adapt date/median syntax as needed.
4. Replace the illustrative data with a licensed real-world dataset before making real commercial recommendations.

## Limitations
This dataset does not contain viewership, completion rate, acquisition cost, subscriber retention, or title performance. Catalog counts alone do not prove audience demand. The strategy memo is a hypothesis-generation exercise, not a claim about any named streaming service.
