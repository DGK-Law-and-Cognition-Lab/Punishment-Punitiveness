# Data Directory

This directory contains data files for the PunishmentPunitiveness research project.

## Directory Structure

```
data/
├── raw/                    # Original, unmodified data
│      └── Data_Raw.csv     # Raw Qualtrics export
├── processed/              # Cleaned and transformed data
│   ├── Data_Final.csv      # Slightly Cleaned
│   ├── punishment_212_cleaned_data.csv
│   └── punishment_212_nlp_features.csv
└── codebook/               # Documentation
    ├── CODEBOOK.md         # Variable definitions (quantitative)
    └── NLP_CODEBOOK.md     # Variable definitions (NLP features)
```

## File Descriptions

### Raw Data

**`Data_Final.csv`**
- Original Qualtrics export
- N = 538 responses (before exclusions)
- Contains all raw response values
- Do not modify this file

### Processed Data

**`punishment_212_cleaned_data.csv`**
- Created by: `analysis/r/Punishment_2_1_2_Final_Script.Rmd`
- N = 496 (after attention check exclusions)
- 148 columns
- Includes:
  - Reverse-coded variables (suffix `_R`)
  - Composite scores (suffix `_comp`)
  - Cluster aggregates (suffix `_agg`)
  - Derived categorical variables

**`punishment_212_nlp_features.csv`**
- Created by: `analysis/python/Punishment_212_NLP_Analysis.ipynb`
- N = 496 (same sample as cleaned data)
- 231 columns (all original variables + ~80 NLP features)
- Includes all variables from `punishment_212_cleaned_data.csv` PLUS:
  - Sentiment scores (VADER)
  - Dictionary-based features (Empath, custom justification dictionaries)
  - Zero-shot classification scores (8 justification categories)
  - Semantic similarity to prototype sentences
  - UMAP coordinates and cluster assignments
  - BERTopic topic assignments
  - Facade detection residuals

## Data Dictionary

| Codebook | Coverage |
|----------|----------|
| `codebook/CODEBOOK.md` | Original survey items, reverse coding, composites |
| `codebook/NLP_CODEBOOK.md` | All NLP-derived variables (~80 features) |

## Quick Reference

### Variable Naming Conventions

| Variable Type | Example | Description |
|---------------|---------|-------------|
| Raw item | `hate_1` | Original survey response |
| Reverse-coded | `hate_2_R` | Reversed (8 - original) |
| Composite | `hatred_comp` | Mean of scale items |
| Aggregate | `hostile_agg` | Mean of related composites |
| VADER sentiment | `vader_compound` | Sentiment score (-1 to +1) |
| Empath category | `empath_anger` | Dictionary word count |
| Custom dictionary | `just_prosocial` | Prosocial justification words |
| Zero-shot | `zs_deterrence_and_prevention` | Classification confidence (0-1) |
| Semantic similarity | `sim_proto_revenge` | Cosine similarity to prototype |
| Embedding | `umap_x`, `umap_y` | 2D projection coordinates |

### NLP Variable Prefixes

| Prefix | Source | Description |
|--------|--------|-------------|
| `vader*` | VADER | Sentiment analysis scores |
| `empath_*` | Empath | Dictionary category counts |
| `just_*` | Custom | Punishment justification words |
| `zs_*` | BART-mnli | Zero-shot classification |
| `sim_proto_*` | MPNet | Similarity to prototypes |
| `sim_prosocial_*` | Computed | Aggregate prosocial similarity |
| `sim_dark_*` | Computed | Aggregate dark similarity |

## Usage Notes

### Loading Data in R

```r
# For main quantitative analysis
df <- read.csv("data/processed/punishment_212_cleaned_data.csv", 
               stringsAsFactors = FALSE)

# For NLP integration analysis
df_nlp <- read.csv("data/processed/punishment_212_nlp_features.csv", 
                   stringsAsFactors = FALSE)

# For replication from scratch
raw <- read.csv("data/raw/Data_Final.csv", 
                stringsAsFactors = FALSE)
```

### Loading Data in Python

```python
import pandas as pd

# For NLP analysis
df = pd.read_csv("data/processed/punishment_212_cleaned_data.csv")

# With NLP features already computed
df_nlp = pd.read_csv("data/processed/punishment_212_nlp_features.csv")
```

### Key Variables for Analysis

**Punitiveness (outcome)**
- `punitiveness_agg`: Primary DV (z-scored composite)
- `Sentence_z`: Sentencing decision (z-scored within vignette)

**Correlate clusters (predictors)**
- `crime_concerns_agg`: Crime Concerns cluster
- `emotions_agg`: Emotions Toward Criminals cluster
- `hostile_agg`: Hostile Aggression cluster
- `personality_agg`: Personality cluster

**Construct-level predictors**
- `hatred_comp`, `anger_comp`, `exclusion_comp`, `degradation_comp`
- `suffering_comp`, `prisonvi_comp`, `harsh_comp`, `revenge_comp`
- `rwa_comp`, `sdo_comp`, `venge_comp`, `vprone_comp`
- `raceresent_comp`, `bloodsports_comp`
- `crime_rates_comp`, `fear_comp`

**Key NLP variables for facade detection**
- `sim_prosocial_mean`: Semantic similarity to prosocial prototypes
- `sim_dark_mean`: Semantic similarity to dark prototypes
- `zs_prosocial_mean`: Zero-shot prosocial classification
- `zs_dark_mean`: Zero-shot dark classification
- `vader_compound`: Overall sentiment
- `facade_residual`: Prosocial language residual (positive = more prosocial than expected)

**Text variables**
- `Sentence_OpenEnd1`: "Why did you recommend this sentence?"
- `Sentence_OpenEnd2`: "What do you hope this sentence will accomplish?"
- `text_combined`: Concatenation of both responses (cleaned)
- `text_combined_wordcount`: Total word count

### Missing Data

- Quantitative items use listwise deletion
- Final N = 496 has complete data on all survey variables
- Open-ended responses (`Sentence_OpenEnd1`, `Sentence_OpenEnd2`) may be blank
- NLP features are `NA` for participants with no/minimal text responses
- Check `text_combined_wordcount` for valid text data

### Choosing Which Dataset to Use

| Analysis Type | Use This File |
|---------------|---------------|
| Main confirmatory analysis (H1, H2, H3) | `punishment_212_cleaned_data.csv` |
| NLP/text analysis | `punishment_212_nlp_features.csv` |
| Replication from raw | `Data_Final.csv` |

Note: `punishment_212_nlp_features.csv` is a **superset** of `punishment_212_cleaned_data.csv`—it contains all original variables plus NLP features. You can use it for any analysis.

## Data Access

This data is available for:
- Academic research
- Educational purposes
- Replication studies

Please cite the original study if using this data. See main README for citation.

## Contact

For questions about the data, please open a GitHub issue or contact:
- Professor Dan Simon: dsimon@law.usc.edu
- David G. Kamper: davidgkamper@ucla.edu
