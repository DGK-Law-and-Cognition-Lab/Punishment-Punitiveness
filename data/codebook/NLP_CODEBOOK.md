# NLP Variables Codebook
## Punishment Study 2.1.2

This codebook describes the NLP-derived variables added to the dataset through computational text analysis of open-ended justification responses.

---

## Source Text Variables

| Variable | Description | Type |
|----------|-------------|------|
| `Sentence_OpenEnd1` | Response to "Why did you recommend this sentence?" | String |
| `Sentence_OpenEnd2` | Response to "What do you hope this sentence will accomplish?" | String |
| `text1_clean` | Cleaned version of OpenEnd1 (lowercase, punctuation removed) | String |
| `text2_clean` | Cleaned version of OpenEnd2 | String |
| `text_combined` | Concatenation of both responses | String |
| `text1_wordcount` | Word count for OpenEnd1 | Integer |
| `text2_wordcount` | Word count for OpenEnd2 | Integer |
| `text_combined_wordcount` | Total word count | Integer |

---

## Sentiment Analysis (VADER)

VADER (Valence Aware Dictionary and sEntiment Reasoner) provides sentiment scores.

| Variable | Description | Range |
|----------|-------------|-------|
| `vader1_compound` | Overall sentiment for OpenEnd1 | -1 to +1 |
| `vader1_pos` | Proportion positive words (OpenEnd1) | 0 to 1 |
| `vader1_neg` | Proportion negative words (OpenEnd1) | 0 to 1 |
| `vader1_neu` | Proportion neutral words (OpenEnd1) | 0 to 1 |
| `vader2_compound` | Overall sentiment for OpenEnd2 | -1 to +1 |
| `vader2_pos` | Proportion positive words (OpenEnd2) | 0 to 1 |
| `vader2_neg` | Proportion negative words (OpenEnd2) | 0 to 1 |
| `vader2_neu` | Proportion neutral words (OpenEnd2) | 0 to 1 |
| `vader_compound` | Overall sentiment for combined text | -1 to +1 |
| `vader_pos` | Proportion positive (combined) | 0 to 1 |
| `vader_neg` | Proportion negative (combined) | 0 to 1 |
| `vader_neu` | Proportion neutral (combined) | 0 to 1 |

**Interpretation:** Compound score < -0.05 = negative; > 0.05 = positive; between = neutral

---

## Empath Categories

Empath is a dictionary-based tool that counts words in predefined categories. Scores are normalized by word count.

| Variable | Description |
|----------|-------------|
| `empath_violence` | Violence-related words |
| `empath_crime` | Crime-related words |
| `empath_death` | Death-related words |
| `empath_pain` | Pain-related words |
| `empath_suffering` | Suffering-related words |
| `empath_negative_emotion` | Negative emotion words |
| `empath_positive_emotion` | Positive emotion words |
| `empath_anger` | Anger-related words |
| `empath_fear` | Fear-related words |
| `empath_hate` | Hate-related words |
| `empath_disgust` | Disgust-related words |
| `empath_sympathy` | Sympathy-related words |
| `empath_help` | Help-related words |
| `empath_government` | Government-related words |
| `empath_law` | Law-related words |
| `empath_order` | Order-related words |
| `empath_power` | Power-related words |
| `empath_family` | Family-related words |
| `empath_children` | Children-related words |
| `empath_healing` | Healing-related words |
| `empath_prison` | Prison-related words |
| `empath_weapon` | Weapon-related words |
| `empath_fight` | Fighting-related words |
| `empath_kill` | Killing-related words |
| `empath_trust` | Trust-related words |
| `empath_achievement` | Achievement-related words |

---

## Custom Dictionary: Punishment Justifications

Custom word lists based on punishment philosophy literature.

### Prosocial Justification Words

| Variable | Description | Example Words |
|----------|-------------|---------------|
| `just_deterrence` | Deterrence language | deter, prevent, discourage, example |
| `just_incapacitation` | Incapacitation language | protect, safety, remove, incapacitate |
| `just_rehabilitation` | Rehabilitation language | reform, rehabilitate, change, treatment |
| `just_retribution` | Retribution language | deserve, proportional, justice, earned |
| `just_norm_expression` | Norm expression | values, standards, society, condemn |

### Dark Justification Words

| Variable | Description | Example Words |
|----------|-------------|---------------|
| `just_revenge` | Revenge language | revenge, payback, vengeance, retaliate |
| `just_suffering` | Suffering language | suffer, pain, agony, torment |
| `just_degradation` | Degradation language | humiliate, degrade, shame, strip |
| `just_exclusion` | Exclusion language | exile, banish, remove, outcast |
| `just_victim_focus` | Victim focus | victim, closure, family, loss |

### Aggregate Scores

| Variable | Description | Calculation |
|----------|-------------|-------------|
| `just_prosocial` | Total prosocial words | Sum of deterrence + incapacitation + rehabilitation + retribution + norm_expression |
| `just_dark` | Total dark words | Sum of revenge + suffering + degradation + exclusion + victim_focus |
| `just_prosocial_minus_dark` | Prosocial minus dark | just_prosocial - just_dark |

---

## Zero-Shot Classification

Using facebook/bart-large-mnli to classify justification types. Each variable represents the model's confidence (0-1) that the response expresses that justification.

| Variable | Justification Category |
|----------|----------------------|
| `zs_deterrence_and_prevention` | "This punishment is meant to deter or prevent crime" |
| `zs_public_safety_and_protection` | "This punishment protects the public and society" |
| `zs_rehabilitation_and_reform` | "This punishment aims to rehabilitate or reform the offender" |
| `zs_proportional_justice` | "This punishment fits the crime proportionally" |
| `zs_revenge_and_payback` | "This punishment is about revenge or payback" |
| `zs_punishment_and_suffering` | "This punishment is meant to cause suffering" |
| `zs_victim_closure` | "This punishment provides closure for victims" |
| `zs_societal_condemnation` | "This punishment expresses society's condemnation" |

### Aggregate Scores

| Variable | Description | Components |
|----------|-------------|------------|
| `zs_prosocial_mean` | Mean of prosocial classifications | deterrence, public_safety, rehabilitation, proportional_justice |
| `zs_dark_mean` | Mean of dark classifications | revenge, punishment_suffering |
| `zs_prosocial_minus_dark` | Difference score | zs_prosocial_mean - zs_dark_mean |

---

## Semantic Similarity to Prototypes

Using all-mpnet-base-v2 sentence embeddings to compute cosine similarity between each response and prototype sentences for each justification category.

### Prototype Sentences Used

**Prosocial:**
- Deterrence: "This sentence will deter others from committing similar crimes"
- Incapacitation: "Society is safer with this person behind bars"
- Rehabilitation: "Everyone deserves a second chance to become a better person"
- Retribution: "The offender deserves this punishment for their actions"

**Dark:**
- Revenge: "He deserves to suffer for what he did"
- Suffering: "Let him rot and suffer behind bars"
- Exclusion: "He has no place in our society"

| Variable | Description | Range |
|----------|-------------|-------|
| `sim_proto_deterrence` | Similarity to deterrence prototypes | 0 to 1 |
| `sim_proto_incapacitation` | Similarity to incapacitation prototypes | 0 to 1 |
| `sim_proto_rehabilitation` | Similarity to rehabilitation prototypes | 0 to 1 |
| `sim_proto_retribution` | Similarity to retribution prototypes | 0 to 1 |
| `sim_proto_revenge` | Similarity to revenge prototypes | 0 to 1 |
| `sim_proto_suffering` | Similarity to suffering prototypes | 0 to 1 |
| `sim_proto_exclusion` | Similarity to exclusion prototypes | 0 to 1 |

### Aggregate Scores

| Variable | Description |
|----------|-------------|
| `sim_prosocial_mean` | Mean similarity to prosocial prototypes |
| `sim_dark_mean` | Mean similarity to dark prototypes |
| `sim_prosocial_minus_dark` | Prosocial minus dark similarity |

---

## Embedding-Based Variables

| Variable | Description |
|----------|-------------|
| `umap_x` | UMAP dimension 1 (2D projection of embeddings) |
| `umap_y` | UMAP dimension 2 |
| `cluster` | K-means cluster assignment (0-4) |
| `bertopic_topic` | BERTopic topic assignment |

---

## Facade Detection Variable

| Variable | Description | Interpretation |
|----------|-------------|----------------|
| `facade_residual` | Residual from regressing prosocial similarity on hostile aggression | Positive = uses MORE prosocial language than expected given psychology; Negative = uses LESS |

**Calculation:** 
1. Fit: `sim_prosocial_mean ~ hostile_agg`
2. `facade_residual = actual - predicted`

---

## Variable Naming Conventions

| Prefix | Meaning |
|--------|---------|
| `vader*` | VADER sentiment scores |
| `empath_*` | Empath dictionary categories |
| `just_*` | Custom punishment justification dictionary |
| `zs_*` | Zero-shot classification scores |
| `sim_proto_*` | Semantic similarity to prototypes |
| `sim_prosocial_*` | Aggregate prosocial similarity |
| `sim_dark_*` | Aggregate dark similarity |

---

## Missing Data

NLP variables are missing for participants who:
- Left both open-ended questions blank
- Provided responses with fewer than 3 words (after cleaning)

Check `text_combined_wordcount` for valid text data.
