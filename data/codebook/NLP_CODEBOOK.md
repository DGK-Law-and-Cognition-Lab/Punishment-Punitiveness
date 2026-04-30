# Codebook: NLP Features

## File: `punishment_212_nlp_features.csv`
**N = 496 | 411 columns**

This file is a superset of `punishment_212_cleaned_data.csv`, containing all original variables plus ~266 NLP-derived features computed from participants' open-ended sentencing justifications.

The first 145 columns are identical to `punishment_212_cleaned_data.csv`. The remaining columns are organized below.

---

## Text Variables

| Variable | Description |
|----------|-------------|
| `text1_clean` | Cleaned version of `Sentence_OpenEnd1` (the first open-ended prompt response) |
| `text2_clean` | Cleaned version of `Sentence_OpenEnd2` (the elaboration prompt response) |
| `text_combined` | Concatenation of `text1_clean` and `text2_clean` — the input for all subsequent analyses |
| `text1_wordcount` | Word count for response 1 |
| `text2_wordcount` | Word count for response 2 |
| `text_combined_wordcount` | Total word count |

---

## Sentiment Analysis (VADER)

Prefix: `vader_*`, `vader1_*`, `vader2_*`

| Variable Pattern | Description |
|-----------------|-------------|
| `vader1_neg / neu / pos / compound` | Sentiment for response 1 |
| `vader2_neg / neu / pos / compound` | Sentiment for response 2 |
| `vader_neg / neu / pos / compound` | Combined sentiment (text1 + text2) |

---

## Empath Categories

Prefix: `empath_*`

Normalized word counts from the Empath lexicon for 25 categories relevant to punishment language: violence, crime, death, pain, suffering, negative_emotion, positive_emotion, anger, fear, hate, disgust, sympathy, help, government, law, order, power, family, children, healing, prison, weapon, fight, kill, trust, achievement.

---

## Hand-Built Dictionaries

Prefix: `just_*`

Custom dictionaries we built for ten justification themes — five prosocial, five dark — plus one composite measure.

| Variable | Theme |
|----------|-------|
| `just_deterrence` | Prosocial: deterrence, prevention, scaring would-be offenders |
| `just_incapacitation` | Prosocial: separating dangerous people from society |
| `just_rehabilitation` | Prosocial: reform, programs, mental health, second chances |
| `just_retribution` | Prosocial: proportional desert, just deserts |
| `just_norm_expression` | Prosocial: signaling societal values, condemnation |
| `just_revenge` | Dark: payback, revenge, getting even |
| `just_suffering` | Dark: making them suffer, infliction of pain |
| `just_degradation` | Dark: dehumanization, treating as subhuman |
| `just_exclusion` | Dark: removing from society, "throw away the key" |
| `just_victim_focus` | Mixed: focused on the victim |
| `just_prosocial` | Sum of the five prosocial counts |
| `just_dark` | Sum of the five dark counts |
| `just_prosocial_minus_dark` | Difference (gap measure) |

---

## DeBERTa Zero-Shot Classifier

Prefix: `deberta_ml_*` (multi-label) and `deberta_fc_*` (forced-choice)

DeBERTa-v3-large, fine-tuned for natural language inference, scored each response against eight candidate labels:

- `proportional_justice`
- `victim_closure`
- `public_safety_and_protection`
- `punishment_and_suffering`
- `rehabilitation_and_reform`
- `societal_condemnation`
- `deterrence_and_prevention`
- `revenge_and_payback`

| Variable | Description |
|----------|-------------|
| `deberta_ml_<label>` | Multi-label probability (each label scored independently, can sum > 1) |
| `deberta_fc_<label>` | Forced-choice probability (sums to 1 across all 8 labels) |
| `deberta_ml_top` / `deberta_fc_top` | Highest-probability label (the response's "primary theme") |
| `deberta_ml_prosocial_mean` | Mean of the four prosocial labels' multi-label probabilities |
| `deberta_ml_dark_mean` | Mean of the four dark labels' multi-label probabilities |
| `deberta_ml_prosocial_minus_dark` | Gap measure (used in the multiverse analysis) |

---

## Claude Forced-Choice Classifier

Prefix: `claude_fc_*` and `claude_ml_*`

Claude Haiku 4.5 was prompted with a structured task: assign each response to one best-fitting label from the same eight categories, with a confidence score. Multi-label scores were also collected separately.

| Variable | Description |
|----------|-------------|
| `claude_fc_top` | Single best-fitting label (forced-choice) |
| `claude_fc_confidence` | Self-reported confidence (0–1) |
| `claude_ml_<label>` | Multi-label score for each of the 8 categories |
| `claude_ml_top` | Highest-scored multi-label category |
| `claude_ml_prosocial_mean` / `claude_ml_dark_mean` | Aggregated prosocial / dark scores |
| `claude_ml_prosocial_minus_dark` | Gap measure |
| `claude_fc_is_prosocial` / `claude_fc_is_dark` | Binary indicator from the forced-choice top label |

---

## Embedding Similarities

We computed cosine similarities between each response and seven prototype sentences (one per justification theme), using **three sentence-embedding models** crossed with **five prototype variants**, for 15 model × prototype combinations and 105 similarity columns total.

### Models
- `mpnet_*` — Sentence-MPNet-base-v2
- `bge_*` — BGE-large-en-v1.5 (BAAI)
- `voyage_*` — voyage-3-large (Voyage AI)

### Prototype variants
- `_orig` — original prototype set used in the preregistered analysis
- `_formal` — formal legal/academic phrasing
- `_colloquial` — informal lay phrasing
- `_layformal` — lay-formal hybrid
- `_antitaut` — anti-tautology variant (theme words stripped from the prototype)

### Per-model-per-variant column structure
For each `<model>_<variant>` combination, seven theme similarity columns plus three composite gap measures:

| Variable | Description |
|----------|-------------|
| `<model>_<variant>_deterrence` | Cosine similarity to deterrence prototype |
| `<model>_<variant>_incapacitation` | Incapacitation prototype |
| `<model>_<variant>_rehabilitation` | Rehabilitation prototype |
| `<model>_<variant>_retribution` | Retribution prototype |
| `<model>_<variant>_revenge` | Revenge prototype |
| `<model>_<variant>_suffering` | Suffering prototype |
| `<model>_<variant>_exclusion` | Exclusion prototype |
| `<model>_<variant>_b3a_pro_minus_dark` | Gap (variant A): mean(deterrence, rehab) − mean(revenge, suffering) |
| `<model>_<variant>_b3b_pro_minus_dark` | Gap (variant B): mean(prosocial 4) − mean(dark 3) |
| `<model>_<variant>_b3c_pro_minus_dark` | Gap (variant C): max(prosocial) − max(dark) |

The `_orig` columns are the ones that appear in the main-text Study 2 analyses; the other variants appear only in the multiverse sensitivity tables in the supplementary materials.

---

## BERTopic Topic Model

| Variable | Description |
|----------|-------------|
| `bertopic_topic` | Assigned topic ID (-1 = outlier; 0–6 = the seven discovered topics) |
| `bertopic_prob` | Topic assignment probability |
| `umap_x`, `umap_y` | 2-D UMAP embedding coordinates (BGE-based) |
| `umap_x_mpnet`, `umap_y_mpnet` | Alternative UMAP using MPNet embeddings |
| `umap_x_voyage`, `umap_y_voyage` | Alternative UMAP using voyage embeddings |

---

## Cross-Method Top Categories

Convenience columns showing the top assigned category and a broad prosocial/dark grouping for each of the five classification methods:

| Variable | Description |
|----------|-------------|
| `method_dict_top` / `dict_top_broad` | Dictionary classifier top + broad |
| `method_deberta_top` / `deberta_top_broad` | DeBERTa top + broad |
| `method_claude_top` / `claude_top_broad` | Claude top + broad |
| `method_bge_top` / `bge_top_broad` | BGE-similarity top + broad |
| `method_voyage_top` / `voyage_top_broad` | Voyage-similarity top + broad |

---

## Hostile-Aggression Tertile

| Variable | Description |
|----------|-------------|
| `hostile_tertile` | "Low" / "Mid" / "High" tertile split on the hostile aggression composite, used in the BERTopic-by-tertile analysis and the word cloud visualization |

---

## What's NOT Included

The repository's NLP feature CSV does not include the raw embedding vectors themselves (each is 768–1024 dimensions). The cosine similarities are sufficient for all reported analyses; the raw embeddings can be regenerated by running `analysis/python/03_embeddings_and_similarity.ipynb`.
