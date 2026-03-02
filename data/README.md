# Data Directory

## Directory Structure

```
data/
├── raw/                    # Original Qualtrics export (not included; available on request)
├── processed/              # Cleaned and transformed data
│   ├── punishment_212_cleaned_data.csv    # N=496, 145 columns
│   └── punishment_212_nlp_features.csv    # N=496, 258 columns (superset)
└── codebook/
    ├── CODEBOOK.md         # Variable definitions (quantitative)
    └── NLP_CODEBOOK.md     # Variable definitions (NLP features)
```

## Processed Data

### `punishment_212_cleaned_data.csv`
- **Created by:** `analysis/r/Punishment_2_1_2_Final_Script.Rmd`
- **N = 496** (after attention check exclusions)
- **145 columns** including raw items, reverse-coded items (`_R`), composite scores (`_comp`), cluster aggregates (`_agg`), and derived variables

### `punishment_212_nlp_features.csv`
- **Created by:** `analysis/python/Punishment_212_NLP_Analysis.ipynb`
- **N = 496** (same sample)
- **258 columns** — all original variables plus ~113 NLP features (sentiment, dictionary, zero-shot, semantic similarity, embeddings, topic assignments)

## Key Variables

### Outcome Variables
| Variable | Description |
|----------|-------------|
| `punitiveness_agg` | Primary DV (z-scored composite of 9 indicators) |
| `Sentence_z` | Sentencing decision (z-scored within vignette) |

### Predictor Clusters
| Variable | Description |
|----------|-------------|
| `crime_concerns_agg` | Crime Concerns cluster mean |
| `emotions_agg` | Emotions Toward Criminals cluster mean |
| `hostile_agg` | Hostile Aggression cluster mean |
| `personality_agg` | Personality cluster mean |

### Key NLP Variables
| Variable | Description |
|----------|-------------|
| `sim_prosocial_mean` | Semantic similarity to prosocial prototypes |
| `sim_dark_mean` | Semantic similarity to dark prototypes |
| `zs_prosocial_mean` | Zero-shot prosocial classification |
| `zs_dark_mean` | Zero-shot dark classification |
| `vader_compound` | Overall sentiment (-1 to +1) |
| `facade_residual` | Prosocial language residual |

## Choosing Which Dataset

| Analysis Type | Use This File |
|---------------|---------------|
| Main confirmatory (H1–H3) | `punishment_212_cleaned_data.csv` |
| NLP/text analysis | `punishment_212_nlp_features.csv` |
| Any analysis | `punishment_212_nlp_features.csv` (superset) |

## Loading Data

```r
# R
df <- read.csv("data/processed/punishment_212_cleaned_data.csv", stringsAsFactors = FALSE)
```

```python
# Python
import pandas as pd
df = pd.read_csv("data/processed/punishment_212_cleaned_data.csv")
```

## Contact
For questions about the data, please open a GitHub issue or contact:
- Dan Simon: dsimon@law.usc.edu
- David G. Kamper: davidgkamper@ucla.edu
