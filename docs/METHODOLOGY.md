# Methodology

## Detailed Methodological Notes for Punishment Study 2.1.2

This document provides comprehensive methodological details beyond what is typically included in a methods section.

---

## Theoretical Background

### The Prosocial Thesis

The conventional view holds that criminal punishment serves prosocial goals:

1. **Retribution**: Restoring moral balance, proportional desert
2. **Deterrence**: Preventing future crime through threat
3. **Incapacitation**: Protecting society from dangerous individuals
4. **Rehabilitation**: Reforming offenders for reintegration
5. **Norm expression**: Reinforcing social values

### Our Challenge

We test whether punishment attitudes actually correlate with prosocial concerns (crime rates, public safety) or whether they are better predicted by darker psychological factors (hatred, revenge, hostile aggression).

### Predictions

If punishment is truly prosocially motivated:
- Punitiveness should correlate strongly with crime concerns
- Punitiveness should correlate weakly or negatively with hostile factors

If punishment masks darker motivations:
- Hostile factors should outpredict crime concerns
- Multiple antisocial traits should converge on punitiveness

---

## Construct Operationalization

### Punitiveness

We operationalized punitiveness as a multi-indicator construct to enhance generalizability (following Gerber, 2021):

| Component | Rationale |
|-----------|-----------|
| Policy attitudes | General punishment philosophy |
| Sentencing decision | Behavioral manifestation |
| Multiple items per facet | Reliability |

**Composite approach**: Z-scoring and averaging allows different metrics (7-point scales, years in prison) to contribute equally.

### Correlate Selection

Correlates were selected based on:
1. Prior theoretical relevance to punishment attitudes
2. Representation across psychological domains
3. Balance of established and novel constructs

**Novel constructs tested in this research**:
- Hatred of criminals (distinct from anger)
- Prison violence tolerance
- Blood sports viewership (appetitive aggression proxy)

### Vignette Design

Three vignettes involving second-degree murder were created to:
1. Ensure scenario warranted meaningful sentencing variation
2. Test generalizability across perpetrator contexts
3. Control for crime severity while varying circumstances

| Vignette | Context | Perpetrator-Victim Relationship |
|----------|---------|--------------------------------|
| 1 | Domestic dispute | Intimate partners |
| 2 | Robbery | Strangers |
| 3 | Road rage | Strangers |

---

## Measurement Details

### Scale Sources

| Construct | Source | Modifications |
|-----------|--------|---------------|
| RWA | Bizumic & Duckitt (2018) | Shortened to 5 items |
| SDO | Ho et al. (2015) | SDO₇ short form |
| Racial Resentment | Kinder & Sanders (1996) | Unchanged |
| Fear of Crime | Mayhew & van Kesteren (2002) | Minor wording |
| Punitiveness items | Cullen et al. (1985); Gerber & Jackson (2013) | Combined |

### Response Format

All attitudinal items used a 7-point Likert scale:
1. Strongly disagree
2. Disagree
3. Somewhat disagree
4. Neither agree nor disagree
5. Somewhat agree
6. Agree
7. Strongly agree

Blood sports items used frequency scale:
1. Never
2. Rarely
3. Occasionally
4. Sometimes
5. Often
6. Frequently
7. Very frequently

### Item Order

- **Block order**: Fixed (to prevent fatigue effects on key measures)
- **Item order within blocks**: Randomized
- **Vignette placement**: After attitudinal measures, before demographics

---

## Sampling and Recruitment

### Platform
- **Prolific Academic**: High-quality online panel
- Pre-screening for US residency, 18+

### Sample Characteristics (Pre-registered targets)
- N = 500 (anticipated 10% exclusion)
- Gender: 50/50 balance
- Age: Representative of US adult population

### Compensation
- Prolific standard rate
- Median completion time: ~15 minutes
- Payment: $2.50 (approximately $10/hour)

---

## Data Quality Procedures

### Attention Checks

Two attention checks embedded throughout survey:

1. **Instructed response**: "Please select 'Strongly agree' for this item"
   - Correct: 9 (Strongly agree)
   - Location: Early in survey

2. **Arithmetic verification**: "What is 8 + 7?"
   - Correct: 4 (option showing "15")
   - Location: Mid-survey

### Additional Quality Indicators (Monitored but not used for exclusion)

- reCAPTCHA score (bot detection)
- Completion time (too fast/slow flagged)
- Straight-lining patterns

### Exclusion Rates

| Stage | N | Excluded | Reason |
|-------|---|----------|--------|
| Started | 538 | - | - |
| Completed | 522 | 16 | Incomplete |
| Attention 1 | 508 | 14 | Failed |
| Attention 2 | 496 | 12 | Failed |
| **Final** | **496** | **42** | **7.8% total** |

---

## Statistical Considerations

### Power Analysis

For correlation analyses:
- α = .05, power = .80
- Minimum detectable r = .13 (N = 500)
- Expected effect sizes based on pilot: r = .30-.60

### Multiple Comparisons

**Problem**: 16+ correlations tested simultaneously
**Solution**: Benjamini-Hochberg FDR correction

```r
p_fdr <- p.adjust(p_values, method = "fdr")
```

### Dependent Correlation Comparison

Steiger's Z-test accounts for the shared variance between predictors when comparing two correlations with the same criterion:

$$Z = \frac{(r_{jk} - r_{jh}) \sqrt{(n-3)(1+r_{kh})}}{2\sqrt{|R|}}$$

Where |R| is the determinant of the full correlation matrix.

### Effect Size Interpretation

| r | Interpretation |
|---|----------------|
| .10 | Small |
| .30 | Medium |
| .50 | Large |

---

## Potential Biases and Limitations

### Social Desirability

**Issue**: Respondents may underreport socially undesirable attitudes (hatred, racism, etc.)

**Implications**:
- True correlations likely *underestimated*
- Focus on correlations rather than absolute values helps
- Anonymous online administration reduces but doesn't eliminate

### Common Method Variance

**Issue**: All measures are self-report, potentially inflating correlations

**Mitigations**:
- Multiple indicators per construct
- Reverse-coded items
- CFA to test measurement model
- Behavioral component (sentencing decision)

### Sample Generalizability

**Limitations**:
- Prolific users skew younger, more educated
- US-only sample
- May not generalize to actual policy makers

### Correlational Design

**Cannot establish**:
- Causal direction (does hostility cause punitiveness, or vice versa?)
- Third variables (personality disposition driving both)

**Value**: Pattern of correlations still informative for evaluating prosocial thesis

---

## Ethical Considerations

### IRB Approval
- USC IRB approved
- Exempt status (minimal risk)

### Informed Consent
- Described study purpose generally
- Voluntary participation emphasized
- Right to withdraw without penalty

### Sensitive Content
- Questions about race, crime, punishment
- Participants warned in advance
- Debriefing available upon request

### Data Protection
- No identifying information collected
- Prolific IDs stored separately from responses
- Data anonymized before analysis

---

## Reproducibility Measures

### Pre-registration
- Analysis plan registered on OSF before data collection
- Deviations documented and justified

### Open Materials
- All stimuli available in repository
- Analysis code fully documented
- Data available for replication

### Version Control
- R Markdown ensures code-output correspondence
- GitHub for version tracking
- Session info reported with results

---

## References

Bizumic, B., & Duckitt, J. (2018). Investigating right wing authoritarianism with a very short authoritarianism scale. *Journal of Social and Political Psychology*.

Cullen, F. T., Clark, G. A., Cullen, J. B., & Mathers, R. A. (1985). Attribution, salience, and attitudes toward criminal sanctioning. *Criminal Justice and Behavior*.

Gerber, M. M. (2021). Measuring punitiveness in criminological research: Towards a multidimensional approach. *European Journal of Criminology*.

Gerber, M. M., & Jackson, J. (2013). Retribution as revenge and retribution as just deserts. *Social Justice Research*.

Ho, A. K., Sidanius, J., Kteily, N., Sheehy-Skeffington, J., Pratto, F., Henkel, K. E., ... & Stewart, A. L. (2015). The nature of social dominance orientation: Theorizing and measuring preferences for intergroup inequality using the new SDO₇ scale. *Journal of Personality and Social Psychology*.

Kinder, D. R., & Sanders, L. M. (1996). *Divided by color: Racial politics and democratic ideals*. University of Chicago Press.

Mayhew, P., & Van Kesteren, J. (2002). National criminal victimisation surveys: The ICVS and beyond. In *International comparison of crime and victimisation*.
