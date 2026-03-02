# Codebook: Quantitative Variables

## File: `punishment_212_cleaned_data.csv`
**N = 496 | 145 columns**

---

## Survey Metadata

| Variable | Type | Description |
|----------|------|-------------|
| `Progress` | Integer | Survey completion percentage |
| `Duration..in.seconds.` | Integer | Total time in seconds |
| `Finished` | Integer | 1 = completed survey |
| `ResponseId` | String | Qualtrics response identifier |
| `Q_RecaptchaScore` | Float | Bot detection score (0–1) |
| `Prolific_ID` | String | Participant ID from Prolific |

## Raw Survey Items

All attitudinal items use a 7-point Likert scale (1 = Strongly Disagree to 7 = Strongly Agree) unless noted.

### Punitiveness
| Variable | Description |
|----------|-------------|
| `punishmore_1` | Support for more punishment (reversed) |
| `punishmore_2` | Support for more punishment |
| `parsimony_1` | Rejection of parsimony (reversed) |
| `parsimony_2` | Rejection of parsimony (reversed) |
| `threestrikes_1` | Support for three-strikes laws |
| `threestrikes_2` | Support for three-strikes laws |
| `LWOP` | Support for life without parole |
| `deathpenalty` | Support for death penalty |
| `Sentence_1` | Recommended sentence in years |
| `Sentence_OpenEnd1` | "Why did you recommend this sentence?" |
| `Sentence_OpenEnd2` | "What do you hope this sentence will accomplish?" |

### Crime Concerns
| Variable | Description |
|----------|-------------|
| `rates_1`, `rates_2` | Perceived crime rates |
| `fear_1` (reversed), `fear_2`, `fear_3` | Fear of crime |

### Emotions Toward Criminals
| Variable | Description |
|----------|-------------|
| `hate_1`, `hate_2` (reversed), `hate_3` | Hatred of criminals |
| `anger_1`, `anger_2` | Anger toward criminals |

### Hostile Aggression
| Variable | Description |
|----------|-------------|
| `exclusion_1–3` | Support for social exclusion |
| `degrad_1` (reversed), `degrad_2`, `degrad_3` | Support for degradation |
| `suffer_1`, `suffer_2` | Support for infliction of suffering |
| `prisonvi_1` (reversed), `prisonvi_2` (reversed) | Prison violence tolerance |
| `harsh_1`, `harsh_2` (reversed), `harsh_3` | Support for harsh conditions |
| `revenge_1–3` | Support for revenge |

### Personality & Worldview
| Variable | Description |
|----------|-------------|
| `rwa_1–5` | Right-Wing Authoritarianism (rwa_3 reversed) |
| `sdo_1–8` | Social Dominance Orientation (sdo_3, sdo_4, sdo_7, sdo_8 reversed) |
| `venge_1–5` | Vengefulness (venge_1, venge_5 reversed) |
| `vprone_1–4` | Violence Proneness |
| `Raceresent_1–4` | Racial Resentment (Raceresent_1, Raceresent_4 reversed) |
| `TV_1–9` | Blood Sports viewership (frequency scale: 1=Never to 7=Very Frequently) |

### Due Process
| Variable | Description |
|----------|-------------|
| `dueprocess_1–3` | Due process concerns (dueprocess_2 reversed) |
| `uncertain_1–4` | Tolerance of uncertain evidence |

### Attention Checks
| Variable | Correct Answer |
|----------|----------------|
| `AttnCheck1` | 9 (Strongly Agree) |
| `AttnCheck2` | 4 (option showing "15") |

### Demographics
| Variable | Description |
|----------|-------------|
| `age_1` | Age in years |
| `gender` | Gender |
| `race` | Race/ethnicity |
| `education` | Education level |
| `politid` | Political identification |

---

## Derived Variables

### Reverse-Coded (suffix `_R`)
Formula: `reversed = 8 - original`

### Composite Scores (suffix `_comp`)
Formula: `mean(constituent items)`

| Variable | Items |
|----------|-------|
| `punishmore_comp` | punishmore_1_R, punishmore_2 |
| `parsimony_comp` | parsimony_1_R, parsimony_2_R |
| `threestrikes_comp` | threestrikes_1, threestrikes_2 |
| `hatred_comp` | hate_1, hate_2_R, hate_3 |
| `anger_comp` | anger_1, anger_2 |
| `exclusion_comp` | exclusion_1, exclusion_2, exclusion_3 |
| `degradation_comp` | degrad_1_R, degrad_2, degrad_3 |
| `suffering_comp` | suffer_1, suffer_2 |
| `prisonvi_comp` | prisonvi_1_R, prisonvi_2_R |
| `harsh_comp` | harsh_1, harsh_2_R, harsh_3 |
| `revenge_comp` | revenge_1, revenge_2, revenge_3 |
| `rwa_comp` | rwa_1, rwa_2, rwa_3_R, rwa_4, rwa_5 |
| `sdo_comp` | sdo_1–8 (4 reversed) |
| `venge_comp` | venge_1_R, venge_2, venge_3, venge_4, venge_5_R |
| `vprone_comp` | vprone_1–4 |
| `raceresent_comp` | Raceresent_1_R, Raceresent_2, Raceresent_3, Raceresent_4_R |
| `bloodsports_comp` | TV_1–9 |
| `crime_rates_comp` | rates_1, rates_2 |
| `fear_comp` | fear_1_R, fear_2, fear_3 |
| `dueprocess_comp` | dueprocess_1, dueprocess_2_R, dueprocess_3 |
| `uncertain_comp` | uncertain_1–4 |

### Cluster Aggregates (suffix `_agg`)
Formula: `mean(constituent composites)`

| Variable | Composites |
|----------|------------|
| `punitiveness_agg` | Z-scored: punishmore, parsimony, threestrikes, LWOP, deathpenalty, Sentence_z |
| `crime_concerns_agg` | crime_rates_comp, fear_comp |
| `emotions_agg` | hatred_comp, anger_comp |
| `hostile_agg` | exclusion, degradation, suffering, prisonvi, harsh, revenge composites |
| `personality_agg` | rwa, sdo, venge, vprone, raceresent, bloodsports composites |
| `process_agg` | dueprocess_comp, uncertain_comp |

### Other Derived Variables
| Variable | Description |
|----------|-------------|
| `Sentence_z` | Sentence z-scored within vignette condition |
| `punitiveness_8item` | 8-item punitiveness (no sentence) |
| `punitiveness_8item_z` | Z-scored 8-item punitiveness |
| `vignette` | Vignette condition (1, 2, or 3) |
| `response_order` | Item order randomization |
| `political_group` | Liberal / Moderate / Conservative |
