# The Dark Side of Punishment

This repository contains the data, analysis code, survey materials, and manuscript files for the paper "The Dark Side of Punishment" by Dan Simon and David G. Kamper.

__Contents__:

- [Introduction](#introduction)
- [Preregistrations](#preregistrations)
- [Repository structure](#repository-structure)
- [De-identification](#de-identification)

## Introduction

The paper asks what role the psychology of the punisher plays in criminal punishment, and whether people who favor retribution live up to the theory's image. Both studies surveyed U.S. adults recruited through Prolific's representative sample, with quotas for age, sex, ethnicity, and political affiliation. Study 1 (496 participants) relates punitiveness to a range of psychological factors and finds strong correlations, most of them with forms of hostile aggression, such as hatred of offenders, support for revenge, and support for degrading them; these factors were more closely related to punitiveness than concerns about crime were. Study 2 (948 participants) repeats Study 1's main tests and then examines retribution: whether its two components, desert theory and the proportionality principle, hang together, and how the participants who ranked retribution first among four goals of punishment (the retributivists) compare with the other participants. The retributivists were more punitive and scored higher on nearly every other measure compared.

The files in the top-level folders come from an earlier version of this project, by Dan Simon, David E. Melnikoff, and David G. Kamper, which reported Study 1 and a language analysis of its participants' open-ended answers.

## Preregistrations

- [Study 1](https://osf.io/kr7y2) (osf.io/kr7y2)
- [Study 2](https://osf.io/u97xs) (osf.io/u97xs)

## Repository structure

```
.
├── README.md
├── CITATION.cff
├── CONTRIBUTING.md
├── HOW_TO_REGENERATE_REPORTS.md
├── LICENSE
├── index.html
├── analysis
│   ├── r
│   ├── python
│   └── output
├── data
│   ├── raw
│   ├── processed
│   └── codebook
├── docs
├── manuscript
├── materials
│   ├── preregistration
│   └── stimuli
└── study2_retribution
    ├── Analysis
    ├── Data
    ├── Docs
    └── Experiment
```

The top-level folders hold Study 1. They were written for an earlier version of this project, in which "Study 2" was the language analysis of the open-ended answers of Study 1's participants. In the current paper, Study 2 is the Retribution study in `study2_retribution/`. Each Study 1 folder except `docs/` has its own `README.md`, written for that earlier version.

### Files at the top level

- `CITATION.cff`, `LICENSE` (MIT), `CONTRIBUTING.md` and `HOW_TO_REGENERATE_REPORTS.md` also come from the earlier version. `CITATION.cff` cites the earlier manuscript and its three authors, and `HOW_TO_REGENERATE_REPORTS.md` explains how to regenerate Study 1's reports.

### analysis

- `r/`: the R Markdown analyses of Study 1 (`01_main_analysis`, `02_nlp_integration`, `03_supplementary_analyses`), each with its knitted HTML report.
- `python/`: the notebooks of the language analysis of Study 1's open-ended answers.
- `output/`: the tables and figures these write.

### data

- `raw/`: the Qualtrics export of Study 1.
- `processed/`: the cleaned data, and the cleaned data with the language-analysis features added.
- `codebook/`: the variables in the processed files.

### docs

- Notes on the methods, the analysis plan, and the language analysis of Study 1.

### manuscript

- LaTeX source, tables, and figures of the earlier manuscript, by Dan Simon, David E. Melnikoff, and David G. Kamper, which reported Study 1 and the language analysis of its open-ended answers, and of its supplement.

### materials

- `preregistration/`: the Study 1 preregistration.
- `stimuli/`: the Study 1 Qualtrics survey (`.qsf`).

### index.html

- A web page, from the earlier version, that presents Study 1 and links to its knitted reports.

### study2_retribution

- Study 2: its data, R Markdown analyses and knitted reports, language-analysis notebooks, Qualtrics survey, preregistration, and the paper, Supplementary Materials, and figures. Its own `README.md` describes the folder and how to reproduce the analyses.

## De-identification

- Prolific IDs were replaced by pseudonyms, "P" followed by six digits. One map covers the participants of both studies, so a participant who took part in both studies has the same pseudonym in each.
- Study 1: in the files in `data/` and the tables in `analysis/output/`, Prolific IDs were replaced by pseudonyms, including two entries in which a participant had entered a Prolific relay e-mail address. The Qualtrics export in `data/raw/` has no IP address or location columns. An earlier raw export that did have them was removed from the repository's history.
- Study 2: the IP address, location, recipient, and external reference columns of the Qualtrics exports were blanked, and Prolific IDs were replaced by pseudonyms, in the exports and in the scored data. Seven entries in the Prolific ID column that were not a Prolific ID on their own were replaced by distinct codes. `study2_retribution/README.md` gives the details, including the changed file checksum.
- The raw, identifiable data of both studies and the map from Prolific IDs to pseudonyms are kept by the authors and are not public.
