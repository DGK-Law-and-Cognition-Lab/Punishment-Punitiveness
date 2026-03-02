# Codebook: NLP Features

## File: `punishment_212_nlp_features.csv`
**N = 496 | 258 columns**

This file is a superset of `punishment_212_cleaned_data.csv`, containing all original variables plus ~113 NLP-derived features computed from participants' open-ended justification responses.

---

## Text Variables

| Variable | Description |
|----------|-------------|
| `text1_clean` | Cleaned version of Sentence_OpenEnd1 |
| `text2_clean` | Cleaned version of Sentence_OpenEnd2 |
| `text_combined` | Concatenation of both responses |
| `text1_wordcount` | Word count for response 1 |
| `text2_wordcount` | Word count for response 2 |
| `text_combined_wordcount` | Total word count |

---

## Sentiment Analysis (VADER)

Prefix: `vader*`

| Variable | Range | Description |
|----------|-------|-------------|
| `vader1_neg/neu/pos/compound` | 0–1 / -1 to +1 | Sentiment for response 1 |
| `vader2_neg/neu/pos/compound` | 0–1 / -1 to +1 | Sentiment for response 2 |
| `vader_neg/neu/pos/compound` | 0–1 / -1 to +1 | Combined sentiment |

---

## Dictionary-Based Features (Empath)

Prefix: `empath_*`

Normalized word counts from the Empath lexicon.

| Variable | Description |
|----------|-------------|
| `empath_violence` | Violence-related words |
| `empath_crime` | Crime-related words |
| `empath_death` | Death-related words |
| `empath_pain` | Pain-related words |
| `empath_suffering` | Suffering-related words |
| `empath_negative_emotion` | Negative emotion words |
| `empath_positive_emotion` | Positive emotion words |
| `empath_anger` | Anger words |
| `empath_fear` | Fear words |
| `empath_hate` | Hate words |
| `empath_disgust` | Disgust words |
| `empath_sympathy` | Sympathy words |
| `empath_help` | Help words |
| `empath_government` | Government words |
| `empath_law` | Law words |
| `empath_order` | Order words |
| `empath_power` | Power words |
| `empath_family` | Family words |
| `empath_children` | Children words |
| `empath_healing` | Healing words |
| `empath_prison` | Prison words |
| `empath_weapon` | Weapon words |
| `empath_fight` | Fight words |
| `empath_kill` | Kill words |
| `empath_trust` | Trust words |
| `empath_achievement` | Achievement words |

---

## Custom Justification Dictionaries

Prefix: `just_*`

| Variable | Range | Description |
|----------|-------|-------------|
| `just_deterrence` | Count | Deterrence-related words |
| `just_incapacitation` | Count | Incapacitation words |
| `just_rehabilitation` | Count | Rehabilitation words |
| `just_retribution` | Count | Retribution words |
| `just_norm_expression` | Count | Norm expression words |
| `just_revenge` | Count | Revenge words |
| `just_suffering` | Count | Suffering words |
| `just_degradation` | Count | Degradation words |
| `just_exclusion` | Count | Exclusion words |
| `just_victim_focus` | Count | Victim focus words |
| `just_prosocial` | Sum | Prosocial categories combined |
| `just_dark` | Sum | Dark categories combined |
| `just_prosocial_minus_dark` | Difference | Prosocial − Dark |

---

## Zero-Shot Classification (BART-large-mnli)

Prefix: `zs_*`

Classification confidence (0–1) for each justification category.

| Variable | Category |
|----------|----------|
| `zs_proportional_justice` | Proportional justice |
| `zs_victim_closure` | Victim closure |
| `zs_rehabilitation_and_reform` | Rehabilitation and reform |
| `zs_deterrence_and_prevention` | Deterrence and prevention |
| `zs_public_safety_and_protection` | Public safety and protection |
| `zs_societal_condemnation` | Societal condemnation |
| `zs_punishment_and_suffering` | Punishment and suffering |
| `zs_revenge_and_payback` | Revenge and payback |
| `zs_prosocial_mean` | Mean of prosocial categories |
| `zs_dark_mean` | Mean of dark categories |
| `zs_prosocial_minus_dark` | Prosocial − Dark |

---

## Forced-Choice Classification

Prefix: `fc_*`

Same categories as zero-shot, but using forced-choice (top category assigned full weight).

---

## Semantic Similarity (all-mpnet-base-v2)

Prefix: `sim_proto_*`

Cosine similarity between participant text embedding and prototype sentence embeddings.

| Variable | Prototype |
|----------|-----------|
| `sim_proto_deterrence` | "This sentence will deter others..." |
| `sim_proto_incapacitation` | "Society is safer with this person behind bars..." |
| `sim_proto_rehabilitation` | "Everyone deserves a second chance..." |
| `sim_proto_retribution` | "The offender deserves this punishment..." |
| `sim_proto_revenge` | "He deserves to suffer for what he did..." |
| `sim_proto_suffering` | "Let him rot and suffer behind bars..." |
| `sim_proto_exclusion` | "He has no place in our society..." |

### Aggregate Similarity
| Variable | Description |
|----------|-------------|
| `sim_prosocial_mean` | Mean similarity to prosocial prototypes |
| `sim_dark_mean` | Mean similarity to dark prototypes |
| `sim_prosocial_minus_dark` | Prosocial − Dark similarity |

---

## Alternative Prototype Sets

| Prefix | Description |
|--------|-------------|
| `alt_formal_*` | Formal/academic wording prototypes |
| `alt_colloquial_*` | Colloquial/everyday wording prototypes |
| `datadriven_*` | Data-driven prototypes from BERTopic clusters |

---

## Classification Summaries

| Variable | Description |
|----------|-------------|
| `ml_top` | Top zero-shot category |
| `fc_top` | Top forced-choice category |
| `method_zs_top` | Top category (zero-shot method) |
| `method_fc_top` | Top category (forced-choice method) |
| `method_dict_top` | Top category (dictionary method) |
| `method_sim_top` | Top category (similarity method) |
| `zs_top_broad` | Broad classification (prosocial/dark) |
| `fc_top_broad` | Broad classification (prosocial/dark) |
| `dict_top_broad` | Broad classification (prosocial/dark) |
| `sim_top_broad` | Broad classification (prosocial/dark) |

---

## Embedding & Clustering

| Variable | Description |
|----------|-------------|
| `umap_x` | UMAP dimension 1 |
| `umap_y` | UMAP dimension 2 |
| `cluster` | UMAP-based cluster assignment |
| `bertopic_topic` | BERTopic topic assignment |

---

## Facade Detection

| Variable | Description |
|----------|-------------|
| `facade_residual` | Residual from regressing prosocial language on hostile aggression; positive = more prosocial language than expected given hostile aggression level |
