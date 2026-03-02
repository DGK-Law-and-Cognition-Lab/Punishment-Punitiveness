# Manuscript

## Is Criminal Punishment Prosocial?
### For *Law and Human Behavior* (APA 7th Edition)

**Authors:** David G. Kamper (UCLA), David E. Melnikoff (Stanford GSB), Dan Simon (USC Gould School of Law)

### Structure
```
manuscript/
├── main.tex                       # Master document
├── main.bbl                       # Compiled bibliography
├── references.bib                 # BibTeX references
├── sections/
│   ├── introduction.tex           # Introduction & literature review
│   ├── method.tex                 # Method (participants, measures, NLP pipeline)
│   ├── results_correlational.tex  # Correlational results (H1–H3)
│   ├── results_nlp.tex            # NLP results (facade tests)
│   ├── discussion.tex             # Discussion & implications
│   └── supplementary.tex          # Supplementary materials
├── figures/                       # Manuscript figures
└── tables/                        # LaTeX table definitions
```

### Compilation
```bash
pdflatex main.tex
bibtex main
pdflatex main.tex
pdflatex main.tex
```

For Overleaf: upload this entire directory as a new project.

### Format
- APA 7th Edition (`apa7` document class, `man` mode)
- Target journal: *Law and Human Behavior* (APA Publishing)

### Open Science
- Pre-registration: https://osf.io/kr7y2/
- Data & Code: https://github.com/DGK-Law-and-Cognition-Lab/Punishment-Punitiveness
