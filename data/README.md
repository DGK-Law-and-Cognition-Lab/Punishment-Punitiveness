# Data Directory

This directory contains data files for the PunishmentPunitiveness research project.

## Directory Structure

```
data/
├── raw/                    # Original, unmodified data
│   └── Data_Final.csv      # Raw Qualtrics export
├── processed/              # Cleaned and transformed data
│   └── punishment_212_cleaned_data.csv
└── codebook/               # Documentation
    └── CODEBOOK.md         # Variable definitions
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
- Created by: `analysis/Punishment_2_1_2_Final_Script.Rmd`
- N = 496 (after attention check exclusions)
- Includes:
  - Reverse-coded variables (suffix `_R`)
  - Composite scores (suffix `_comp`)
  - Cluster aggregates (suffix `_agg`)
  - Derived categorical variables

## Data Dictionary

See `codebook/CODEBOOK.md` for complete variable documentation.

## Quick Reference

| Variable Type | Example | Description |
|---------------|---------|-------------|
| Raw item | `hate_1` | Original survey response |
| Reverse-coded | `hate_2_R` | Reversed (8 - original) |
| Composite | `hatred_comp` | Mean of scale items |
| Aggregate | `hostile_agg` | Mean of related composites |

## Usage Notes

### Loading Data in R

```r
# For analysis, use processed data
df <- read.csv("data/processed/punishment_212_cleaned_data.csv", 
               stringsAsFactors = FALSE)

# For replication from scratch, use raw data
raw <- read.csv("data/raw/Data_Final.csv", 
                stringsAsFactors = FALSE)
```

### Key Variables for Analysis

**Punitiveness (outcome)**
- `punitiveness_agg`: Primary DV (z-scored composite)

**Correlate clusters (predictors)**
- `crime_concerns_agg`
- `emotions_agg`
- `hostile_agg`
- `personality_agg`

**Construct-level predictors**
- `hatred_comp`, `anger_comp`, `exclusion_comp`, etc.

### Missing Data

- Items use listwise deletion
- Final N = 496 has complete data on all variables
- Open-ended responses (`Sentence_OpenEnd1`, `Sentence_OpenEnd2`) may be blank

## Data Access

This data is available for:
- Academic research
- Educational purposes
- Replication studies

Please cite the original study if using this data. See main README for citation.

## Contact

For questions about the data, please open a GitHub issue or contact:
- Professor Dan Simon: dsimon@law.usc.edu
