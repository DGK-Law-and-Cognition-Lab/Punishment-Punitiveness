# How to Regenerate the Analysis Reports

The analysis reports come in two flavors:

- **R Markdown reports** — three HTML files, committed to the repo and served by GitHub Pages. Need to be regenerated whenever the underlying analysis changes.
- **Python notebooks** — four `.ipynb` files served via Google Colab links. The notebooks themselves are committed; their outputs are the Python tables and figures in `analysis/output/`. No HTML versions.

This document covers regenerating both.

---

## R Markdown Reports

These are the public-facing analyses that the GitHub Pages site links to:

```
analysis/r/01_main_analysis.html
analysis/r/02_nlp_integration.html
analysis/r/03_supplementary_analyses.html
```

These HTMLs are committed to the repo. Regenerate them whenever the `.Rmd` source or the underlying data changes.

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

Approximate runtimes:

| Notebook | Runtime | Notes |
|----------|---------|-------|
| `01_main_analysis.Rmd` | ~2 min | Pure stats; no external dependencies beyond R packages |
| `02_nlp_integration.Rmd` | ~3 min | Reads `nlp_features.csv`; runs facade matrix, multiverse, regressions |
| `03_supplementary_analyses.Rmd` | ~5–8 min | Bootstrap (10,000 iterations) + CFA + TOST + sentence anchor |

### Path Adjustments

The first chunk of each `.Rmd` sets a data-directory variable. If the file is opened on a different machine where the path doesn't match, the first chunk will error out with "file not found." Adjust the path to point at `data/processed/` in the local checkout.

### After Regeneration

```bash
git add analysis/r/*.html
git commit -m "Refresh R Markdown reports"
git push
```

The GitHub Pages site will auto-rebuild within ~2 minutes.

---

## Python Notebooks (via Google Colab)

The four Python notebooks in `analysis/python/` are served as Open in Colab links from the README and the GitHub Pages site:

| Notebook | Open in Colab |
|----------|---------------|
| `01_preprocessing_and_dictionaries.ipynb` | <https://colab.research.google.com/drive/1oQSBmuGCB48b5hF1DWkte1qpHw9etV0X> |
| `02_classification.ipynb` | <https://colab.research.google.com/drive/1Qjk3VlOik9ObHZmyDurYIfFaUzYhpGJ0> |
| `03_embeddings_and_similarity.ipynb` | <https://colab.research.google.com/drive/11Dpj5cgn0LTxxwjn7DMI-sZvj1F4wOJC> |
| `04_topics_convergence_export.ipynb` | <https://colab.research.google.com/drive/1JJDWBjEQO-dCKisftIBXK--E7HN-BGKT> |

There are no HTML exports of the Python notebooks. Anyone who wants to inspect outputs without running them can either:
- View the `.ipynb` files directly on GitHub (it renders notebook cells inline)
- Open the Colab link and view the rendered notebook
- Browse the generated tables/figures in `analysis/output/tables/python/` and `analysis/output/figures/python/`

### When to Re-Run the Python Pipeline

You only need to re-execute the Python notebooks when the *raw text data* changes (new responses added, text cleaning rules updated). The pipeline output — `data/processed/punishment_212_nlp_features.csv` — feeds into all R analyses. After re-running the Python pipeline:

```bash
# 1. Download the new punishment_212_nlp_features.csv from the Colab outputs
# 2. Place it in data/processed/
# 3. Commit it to the repo
git add data/processed/punishment_212_nlp_features.csv
git commit -m "Refresh NLP features"
# 4. Re-run the R analyses (see above) since their inputs changed
```

### API Keys

Notebooks 02, 03, and 04 require API keys:

- **Notebook 02**: `ANTHROPIC_API_KEY` (for the Claude forced-choice classifier)
- **Notebook 03**: `VOYAGE_API_KEY` (for voyage-3-large embeddings)
- **Notebook 04**: Inherits cached outputs from 02 and 03

In Colab, set these as **Runtime → Secrets** (the key icon in the left sidebar). The notebooks use `userdata.get('ANTHROPIC_API_KEY')` to read them.

### GPU Requirement

Notebook 02 needs a GPU runtime for DeBERTa zero-shot classification. In Colab: **Runtime → Change runtime type → T4 GPU** (free tier is sufficient). On CPU it works but is roughly 10× slower.

### API Costs

| Notebook | Approximate Cost |
|----------|------------------|
| 01 | $0 (no API calls) |
| 02 | ~$0.50 (Claude Haiku × 496 responses × 2 calls each — forced-choice + multi-label) |
| 03 | ~$0.10 (voyage-3-large × ~2,500 embeddings) |
| 04 | $0 (no API calls — operates on cached outputs) |

---

## Quick Sanity Checks

After regenerating either set, open one report in a browser and confirm:

1. Title and section headings render correctly (no LaTeX errors)
2. All figures embedded inline (not broken image icons)
3. All tables render properly
4. The first sentence of the first paragraph reflects the **current** version of the analysis (e.g., 411-column NLP CSV, three embedding models, 71%–96% prosocial range) — not an older cached version

If any of these fail, the most common cause is that a chunk failed silently mid-knit. Re-run with `quiet = FALSE` to see the full error log.
