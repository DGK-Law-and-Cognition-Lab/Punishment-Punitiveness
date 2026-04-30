# How to Regenerate the HTML Reports

The GitHub Pages site (`index.html`) links to six HTML reports — three R Markdown reports and three Jupyter notebook exports. These are not committed to the repo because they're generated artifacts that depend on running the full pipeline (which requires GPU, API keys, and ~30+ minutes of compute).

This document describes how to regenerate them whenever you need to refresh the public-facing site.

---

## What the Site Expects

```
analysis/r/01_main_analysis.html
analysis/r/02_nlp_integration.html
analysis/r/03_supplementary_analyses.html
analysis/python/01_preprocessing_and_dictionaries.html
analysis/python/02_classification.html
analysis/python/03_embeddings_and_similarity.html
```

If any of these are missing, the corresponding card on the GitHub Pages site will 404 when clicked. The site itself still loads.

---

## R Markdown Reports

### One-Time Setup

```bash
cd analysis/r
Rscript -e "source('install_packages.R')"
```

### Knit Each Document

```bash
# From the repo root
Rscript -e "rmarkdown::render('analysis/r/01_main_analysis.Rmd', output_format = 'html_document')"
Rscript -e "rmarkdown::render('analysis/r/02_nlp_integration.Rmd', output_format = 'html_document')"
Rscript -e "rmarkdown::render('analysis/r/03_supplementary_analyses.Rmd', output_format = 'html_document')"
```

Each command produces a `.html` file alongside the `.Rmd` source. Approximate runtimes:

| Notebook | Runtime | Notes |
|----------|---------|-------|
| `01_main_analysis.Rmd` | ~2 min | Pure stats; no external dependencies beyond R packages |
| `02_nlp_integration.Rmd` | ~3 min | Reads `nlp_features.csv`; runs facade matrix, multiverse, regressions |
| `03_supplementary_analyses.Rmd` | ~5–8 min | Bootstrap (10,000 iterations) + CFA + TOST + sentence anchor |

### Path Adjustments

The first chunk of each `.Rmd` sets a data-directory variable. If the file is saved with a path that doesn't match your local checkout, you'll get a "file not found" error in the first chunk. Adjust accordingly — the canonical path inside the repo is `data/processed/`.

---

## Jupyter Notebook Exports

### One-Time Setup

```bash
cd analysis/python
pip install -r requirements.txt
```

### API Keys

Notebooks 02 and 03 require API keys. Set them as environment variables:

```bash
export ANTHROPIC_API_KEY="sk-ant-..."
export VOYAGE_API_KEY="pa-..."
```

Or place them in a `.env` file in the same directory (already in `.gitignore`):

```
ANTHROPIC_API_KEY=sk-ant-...
VOYAGE_API_KEY=pa-...
```

### Export Each Notebook

The cleanest way is to run the notebook end-to-end and then export to HTML:

```bash
# From the repo root
jupyter nbconvert --to notebook --execute analysis/python/01_preprocessing_and_dictionaries.ipynb --inplace
jupyter nbconvert --to html       analysis/python/01_preprocessing_and_dictionaries.ipynb

jupyter nbconvert --to notebook --execute analysis/python/02_classification.ipynb --inplace
jupyter nbconvert --to html       analysis/python/02_classification.ipynb

jupyter nbconvert --to notebook --execute analysis/python/03_embeddings_and_similarity.ipynb --inplace
jupyter nbconvert --to html       analysis/python/03_embeddings_and_similarity.ipynb
```

Approximate runtimes:

| Notebook | Runtime | GPU Required? | API Cost |
|----------|---------|---------------|----------|
| `01_preprocessing_and_dictionaries.ipynb` | ~2 min | No | $0 |
| `02_classification.ipynb` | ~10–20 min | Yes (DeBERTa); falls back to CPU at ~10× slowdown | ~$0.50 (Claude Haiku for 496 responses × 2 calls) |
| `03_embeddings_and_similarity.ipynb` | ~10 min | Helpful but not required | ~$0.10 (voyage-3-large for 496 × 8 prototypes) |

### If You Just Want Quick HTML (No Re-Execution)

If you've already run the notebooks and just need to refresh the HTML output without re-executing, drop the `--execute --inplace` step:

```bash
jupyter nbconvert --to html analysis/python/01_preprocessing_and_dictionaries.ipynb
jupyter nbconvert --to html analysis/python/02_classification.ipynb
jupyter nbconvert --to html analysis/python/03_embeddings_and_similarity.ipynb
```

This is the right call when you've changed prose/comments in the notebook but the actual output hasn't changed.

---

## Optional: Commit the HTMLs to the Repo

By default, `*.html` files inside `analysis/r/` and `analysis/python/` are *not* in `.gitignore`. They'll be committed if you `git add` them. The site links won't work on GitHub Pages until the HTML files are pushed.

If you want to keep the HTMLs out of the repo (they can be ~10 MB each due to embedded plot images), uncomment these lines in `.gitignore`:

```
# analysis/r/*.html
# analysis/python/*.html
```

Trade-off:
- **Commit them**: Pages site works immediately after push. Repo is heavier (~50 MB for all six HTMLs combined).
- **Don't commit them**: Keep the repo tight; users have to regenerate locally. Pages site links 404.

The recommended approach for a public repo with a GitHub Pages site is to **commit the HTMLs** so the site is fully functional out of the box.

---

## Quick Sanity Check After Regeneration

Open one of the HTMLs in a browser. Confirm:

1. Title and section headings render correctly (no LaTeX errors, no Markdown soup)
2. All figures embedded inline (not broken image icons)
3. All tables render (not raw HTML strings)
4. Code chunks are syntax-highlighted
5. The first sentence of the first paragraph reflects the **current** version of the analysis (e.g., 411-column NLP CSV, three embedding models, etc.) — not an older cached version

If any of these fail, the most common cause is that a chunk failed silently mid-knit. Re-run with `--execute --inplace` (Jupyter) or `rmarkdown::render(..., quiet = FALSE)` (R) to see the full error log.
