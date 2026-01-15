# Data Codebook

## PunishmentPunitiveness Study 2.1.2

This codebook describes all variables in the cleaned dataset (`punishment_212_cleaned_data.csv`).

---

## Metadata Variables

| Variable | Description | Values |
|----------|-------------|--------|
| `ResponseId` | Unique participant identifier | String |
| `Prolific_ID` | Prolific participant ID | String |
| `Progress` | Survey completion percentage | 0-100 |
| `Duration..in.seconds.` | Time to complete survey | Integer |
| `Finished` | Survey completion flag | 0 = incomplete, 1 = complete |
| `Q_RecaptchaScore` | reCAPTCHA bot detection score | 0-1 |

---

## Attention Checks

| Variable | Description | Correct Response |
|----------|-------------|------------------|
| `AttnCheck1` | "Please select 'Strongly agree' for this item" | 9 |
| `AttnCheck2` | "What is 8 + 7?" | 4 (15) |

---

## Punitiveness Measures

### Policy Attitudes (1-7 scale: Strongly disagree to Strongly agree)

| Variable | Item Text | Direction |
|----------|-----------|-----------|
| `punishmore_1` | "The current level of punishment in the United States is too high" | R |
| `punishmore_2` | "The level of criminal punishment in this country should be increased" | + |
| `parsimony_1` | "Criminal punishments should be as light as possible while still meeting the goals of punishment" | R |
| `parsimony_2` | "The state should not punish criminals more than necessary" | R |
| `threestrikes_1` | "I support three-strikes laws" | + |
| `threestrikes_2` | "Offenders who repeatedly break the law should receive life sentences" | + |
| `LWOP` | "Offenders who commit particularly heinous crimes should receive life sentences without possibility of parole" | + |
| `deathpenalty` | "I support the death penalty" | + |

### Sentencing Decision

| Variable | Description | Range |
|----------|-------------|-------|
| `Sentence_1` | Recommended sentence in years | 0-50 |
| `Sentence_z` | Z-scored sentence (within vignette) | Continuous |

### Open-Ended Responses

| Variable | Description |
|----------|-------------|
| `Sentence_OpenEnd1` | Explanation of sentencing decision |
| `Sentence_OpenEnd2` | Additional sentencing comments |

---

## Crime Concerns Cluster

### Perceived Crime Rates (1-7 scale)

| Variable | Item Text |
|----------|-----------|
| `rates_1` | "The crime rates in this country are increasing" |
| `rates_2` | "The US has higher crime rates than other comparable countries" |

### Fear of Crime (1-7 scale)

| Variable | Item Text | Direction |
|----------|-----------|-----------|
| `fear_1` | "How safe do you feel walking alone at night in your neighborhood?" | R |
| `fear_2` | "How worried are you about becoming a victim of crime?" | + |
| `fear_3` | "How often do you think about your personal safety from crime?" | + |

---

## Emotions Toward Criminals Cluster

### Hatred (1-7 scale)

| Variable | Item Text | Direction |
|----------|-----------|-----------|
| `hate_1` | "I feel hatred towards criminals" | + |
| `hate_2` | "I am sympathetic towards criminals" | R |
| `hate_3` | "Criminals disgust me" | + |

### Anger (1-7 scale)

| Variable | Item Text |
|----------|-----------|
| `anger_1` | "When I think about criminals, I feel angry" |
| `anger_2` | "I am furious at people who commit crimes" |

---

## Hostile Aggression Cluster

### Social Exclusion (1-7 scale)

| Variable | Item Text |
|----------|-----------|
| `exclusion_1` | "Criminals should be cut off from society" |
| `exclusion_2` | "Convicted felons should lose their right to vote" |
| `exclusion_3` | "Ex-convicts should face restrictions on employment" |

### Degradation (1-7 scale)

| Variable | Item Text | Direction |
|----------|-----------|-----------|
| `degrad_1` | "Prisoners deserve dignity and respect" | R |
| `degrad_2` | "Prisoners have forfeited their right to be treated with respect" | + |
| `degrad_3` | "It is acceptable to humiliate criminals as part of their punishment" | + |

### Infliction of Suffering (1-7 scale)

| Variable | Item Text |
|----------|-----------|
| `suffer_1` | "Criminals should suffer for what they have done" |
| `suffer_2` | "Part of the purpose of prison should be to make criminals suffer" |

### Prison Violence Tolerance (1-7 scale)

| Variable | Item Text | Direction |
|----------|-----------|-----------|
| `prisonvi_1` | "I feel bad when I hear about a prisoner being assaulted" | R |
| `prisonvi_2` | "Sexual assault of prisoners is a serious problem that needs to be addressed" | R |

### Harsh Prison Conditions (1-7 scale)

| Variable | Item Text | Direction |
|----------|-----------|-----------|
| `harsh_1` | "Prisons should be uncomfortable places" | + |
| `harsh_2` | "Prisoners deserve decent living conditions" | R |
| `harsh_3` | "Prison conditions in this country are too lenient" | + |

### Revenge (1-7 scale)

| Variable | Item Text |
|----------|-----------|
| `revenge_1` | "Part of the purpose of punishment is to get revenge on criminals" |
| `revenge_2` | "Victims deserve to see criminals get what's coming to them" |
| `revenge_3` | "There is nothing wrong with wanting revenge against criminals" |

---

## Personality Measures Cluster

### Right-Wing Authoritarianism (RWA, 1-7 scale)

| Variable | Item Text | Direction |
|----------|-----------|-----------|
| `rwa_1` | "We should have stronger authorities to help control troublemakers" | + |
| `rwa_2` | "Our country needs a powerful leader to destroy the radical elements in society" | + |
| `rwa_3` | "There is nothing wrong with premarital sexual intercourse" | R |
| `rwa_4` | "Obedience and respect for authority are the most important virtues" | + |
| `rwa_5` | "Our society would be better off if we showed tolerance and understanding for alternative lifestyles" | + |

### Social Dominance Orientation (SDO, 1-7 scale)

| Variable | Item Text | Direction |
|----------|-----------|-----------|
| `sdo_1` | "Some groups of people are simply inferior to other groups" | + |
| `sdo_2` | "In getting what you want, it is sometimes necessary to use force" | + |
| `sdo_3` | "No one group should dominate in society" | R |
| `sdo_4` | "Groups at the bottom are just as deserving as groups at the top" | R |
| `sdo_5` | "Superior groups should dominate inferior groups" | + |
| `sdo_6` | "To get ahead in life, it is sometimes necessary to step on other groups" | + |
| `sdo_7` | "We should do what we can to equalize conditions for different groups" | R |
| `sdo_8` | "We should give all groups an equal chance in life" | R |

### Vengefulness (1-7 scale)

| Variable | Item Text | Direction |
|----------|-----------|-----------|
| `venge_1` | "It is not worth my time and effort to pay back someone who has wronged me" | R |
| `venge_2` | "I try to even the score with anyone who hurts me" | + |
| `venge_3` | "I live by the motto 'Don't get mad, get even'" | + |
| `venge_4` | "There is nothing wrong in getting back at someone who has hurt you" | + |
| `venge_5` | "I am not a vindictive person" | R |

### Violence Proneness (1-7 scale)

| Variable | Item Text |
|----------|-----------|
| `vprone_1` | "In certain situations, it is acceptable to use physical force against others" |
| `vprone_2` | "I sometimes feel the urge to be physically violent" |
| `vprone_3` | "Some people deserve to be physically punished" |
| `vprone_4` | "Violence is sometimes the only way to solve problems" |

### Racial Resentment (1-7 scale)

| Variable | Item Text | Direction |
|----------|-----------|-----------|
| `Raceresent_1` | "Generations of slavery and discrimination have created conditions that make it difficult for Blacks to work their way out of the lower class" | R |
| `Raceresent_2` | "It's really a matter of some people not trying hard enough; if Blacks would only try harder they could be just as well off as Whites" | + |
| `Raceresent_3` | "Irish, Italian, Jewish and many other minorities overcame prejudice and worked their way up. Blacks should do the same without any special favors" | + |
| `Raceresent_4` | "Over the past few years, Blacks have gotten less than they deserve" | R |

### Blood Sports Viewership (1-7 scale: Never to Very frequently)

| Variable | Item Text |
|----------|-----------|
| `TV_1` | "How often do you watch UFC or MMA?" |
| `TV_2` | "How often do you watch boxing?" |
| `TV_3` | "How often do you watch professional wrestling?" |
| `TV_4` | "How often do you watch hunting shows?" |

---

## Due Process / Procedural (Exploratory)

### Due Process Violations (1-7 scale)

| Variable | Item Text | Direction |
|----------|-----------|-----------|
| `dueprocess_1` | "Police should be allowed to use deception to obtain confessions" | + |
| `dueprocess_2` | "It is important that suspects are informed of their rights" | R |
| `dueprocess_3` | "Sometimes it is necessary to cut corners in criminal investigations" | + |

### Uncertain Evidence (1-7 scale)

| Variable | Item Text |
|----------|-----------|
| `uncertain_1` | "Even with some uncertainty, it is better to convict the guilty than let them go free" |
| `uncertain_2` | "A jury should convict if they think the defendant is probably guilty" |
| `uncertain_3` | "The standard of 'beyond a reasonable doubt' is too strict" |
| `uncertain_4` | "Sometimes we have to accept that innocent people will be convicted" |

---

## Demographics

| Variable | Description | Values |
|----------|-------------|--------|
| `age_1` | Participant age | Years |
| `gender` | Gender identity | 1 = Male, 2 = Female, 3 = Other |
| `race` | Racial/ethnic identity | 1 = White, 2 = Black, 3 = Hispanic, 4 = Asian, 5 = Other |
| `education` | Highest education level | 1 = < High school, 2 = High school, 3 = Some college, 4 = Bachelor's, 5 = Graduate |
| `politid` | Political identification | 1 = Very liberal to 7 = Very conservative |

---

## Condition Variables

| Variable | Description | Values |
|----------|-------------|--------|
| `vignette` | Vignette condition | 1 = Domestic, 2 = Robbery, 3 = Road rage |
| `response_order` | Order of survey blocks | Randomized |

---

## Computed Variables

### Reverse-Coded Items (suffix `_R`)

All reverse-coded items are transformed using: `8 - original_value`

### Composite Scores (suffix `_comp`)

| Variable | Formula | Items |
|----------|---------|-------|
| `punishmore_comp` | Mean of punishmore_1_R, punishmore_2 | 2 |
| `parsimony_comp` | Mean of parsimony_1_R, parsimony_2_R | 2 |
| `threestrikes_comp` | Mean of threestrikes_1, threestrikes_2 | 2 |
| `crime_rates_comp` | Mean of rates_1, rates_2 | 2 |
| `fear_comp` | Mean of fear_1_R, fear_2, fear_3 | 3 |
| `hatred_comp` | Mean of hate_1, hate_2_R, hate_3 | 3 |
| `anger_comp` | Mean of anger_1, anger_2 | 2 |
| `exclusion_comp` | Mean of exclusion_1, exclusion_2, exclusion_3 | 3 |
| `degradation_comp` | Mean of degrad_1_R, degrad_2, degrad_3 | 3 |
| `suffering_comp` | Mean of suffer_1, suffer_2 | 2 |
| `prisonvi_comp` | Mean of prisonvi_1_R, prisonvi_2_R | 2 |
| `harsh_comp` | Mean of harsh_1, harsh_2_R, harsh_3 | 3 |
| `revenge_comp` | Mean of revenge_1, revenge_2, revenge_3 | 3 |
| `rwa_comp` | Mean of rwa_1, rwa_2, rwa_3_R, rwa_4, rwa_5 | 5 |
| `sdo_comp` | Mean of sdo_1, sdo_2, sdo_3_R, sdo_4_R, sdo_5, sdo_6, sdo_7_R, sdo_8_R | 8 |
| `venge_comp` | Mean of venge_1_R, venge_2, venge_3, venge_4, venge_5_R | 5 |
| `vprone_comp` | Mean of vprone_1, vprone_2, vprone_3, vprone_4 | 4 |
| `raceresent_comp` | Mean of Raceresent_1_R, Raceresent_2, Raceresent_3, Raceresent_4_R | 4 |
| `bloodsports_comp` | Mean of TV_1, TV_2, TV_3, TV_4 | 4 |
| `dueprocess_comp` | Mean of dueprocess_1, dueprocess_2_R, dueprocess_3 | 3 |
| `uncertain_comp` | Mean of uncertain_1, uncertain_2, uncertain_3, uncertain_4 | 4 |

### Cluster Aggregates (suffix `_agg`)

| Variable | Components |
|----------|------------|
| `punitiveness_agg` | Z-scored mean of punishmore_comp, parsimony_comp, threestrikes_comp, LWOP, deathpenalty, Sentence_z |
| `crime_concerns_agg` | Mean of crime_rates_comp, fear_comp |
| `emotions_agg` | Mean of hatred_comp, anger_comp |
| `hostile_agg` | Mean of exclusion_comp, degradation_comp, suffering_comp, prisonvi_comp, harsh_comp, revenge_comp |
| `personality_agg` | Mean of rwa_comp, sdo_comp, venge_comp, vprone_comp, raceresent_comp, bloodsports_comp |
| `process_agg` | Mean of dueprocess_comp, uncertain_comp |

### Derived Variables

| Variable | Description |
|----------|-------------|
| `punitiveness_8item` | Alternative punitiveness composite (8 policy items) |
| `punitiveness_8item_z` | Z-scored version of above |
| `political_group` | Categorical political identity (Liberal/Moderate/Conservative) |

---

## Scale Scoring Notes

1. **Higher scores = more of construct** (e.g., higher punitiveness_agg = more punitive)
2. **Reverse-coded items** denoted with `_R` suffix
3. **Z-scoring**: Sentence_z computed within vignette condition to account for different base rates
4. **Missing data**: Listwise deletion for composite scores
5. **Scale range**: Most items 1-7; composites maintain this range

---

## Data Quality Flags

Participants excluded if:
- Progress < 100
- Finished ≠ 1
- AttnCheck1 ≠ 9
- AttnCheck2 ≠ 4

Final N = 496 (from 538 collected)
