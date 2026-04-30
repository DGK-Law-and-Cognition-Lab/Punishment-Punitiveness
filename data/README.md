# Data

This directory contains the raw and processed data for *The Dark Side of Punishment*. All identifying information has been removed; Prolific IDs were used only for completion verification and are not retained in the analysis files.

## Files

### `raw/`

| File | Description | Rows × Cols |
|------|-------------|-------------|
| `Data_Final.csv` | Complete Qualtrics export including incomplete responses | 514 × 95 |

### `processed/`

| File | Description | Rows × Cols |
|------|-------------|-------------|
| `punishment_212_cleaned_data.csv` | Cleaned data after exclusions, reverse-coding, and composite construction | 496 × 145 |
| `punishment_212_nlp_features.csv` | Cleaned data + ~266 NLP-derived features from the Python pipeline | 496 × 411 |

### `codebook/`

| File | Description |
|------|-------------|
| `CODEBOOK.md` | All quantitative variables: items, composites, demographics |
| `NLP_CODEBOOK.md` | All NLP-derived columns: VADER, Empath, dictionary, classifier outputs, embedding similarities, BERTopic |

## Exclusions

From the initial 538 respondents, **42 were excluded**:
- 8 incomplete responses (did not finish the survey)
- 34 failed at least one of two embedded attention checks

The 496 retained participants make up the analytic sample reported throughout the manuscript.

## Sampling

Participants were recruited via **Prolific's Politically Representative US Sample**, which balances on age, sex, ethnicity, and political affiliation. The resulting sample distribution: 38.3% liberal, 23.4% moderate, 38.3% conservative.

## Why Two Processed Files?

The `_cleaned_data.csv` file is the canonical "Study 1" version — quantitative variables only, sufficient for replicating any Study 1 analysis. The `_nlp_features.csv` file is a **superset** that adds the columns produced by the NLP pipeline (`analysis/python/01–03`); these columns enter the Study 2 analyses but are not needed for Study 1.

This separation is by convention only; both files share the same row order and `ResponseId` keys.

## Variables of Particular Note

- `vignette` (1, 2, 3) — randomly assigned criminal vignette (Stranger Felony-Murder, Domestic Violence Murder, Organized Crime Murder)
- `Sentence_1` — recommended sentence (0–50 years, integer)
- `Sentence_z` — within-vignette *z*-scored sentencing decision; the version that enters the punitiveness aggregate
- `punitiveness_agg` — 9-item composite (8 attitudinal + Sentence_z)
- `punitiveness_8item_z` — 8-item attitudinal-only version (used as Step 1 predictor when sentencing is the dependent variable to avoid circularity)
- `political_group` — categorical (Liberal / Moderate / Conservative) collapsing the 7-point `politid` scale
- `text_combined` — concatenated open-ended response (Sentence_OpenEnd1 + Sentence_OpenEnd2); the input for the NLP pipeline

See the codebook files for the complete variable inventory.
