# =============================================================================
# R package requirements for the statistical pipeline
# =============================================================================
# Tested with R 4.3+. To install all packages, run:
#
#   source("analysis/r/install_packages.R")

required_packages <- c(
  # ---- Core tidyverse ----
  "tidyverse",      # dplyr, tidyr, ggplot2, readr, etc.
  "broom",          # tidy model output

  # ---- Psychometrics and reliability ----
  "psych",          # Cronbach's alpha, factor analysis
  "lavaan",         # Confirmatory factor analysis

  # ---- Correlations and dependent-correlation tests ----
  "Hmisc",          # rcorr() for matrices with p-values
  "cocor",          # Steiger's Z for dependent correlations
  "corrplot",       # Correlation matrix visualization
  "ggcorrplot",     # ggplot2-style correlation heatmaps

  # ---- Mixed-effects and regression diagnostics ----
  "lme4",           # Mixed-effects models
  "lmerTest",       # p-values for lme4
  "car",            # ANOVA, VIF, regression diagnostics
  "performance",    # Model fit indices, R² for mixed models
  "interactions",   # Interaction probing, simple slopes

  # ---- Effect sizes ----
  "effectsize",     # Cohen's d, partial eta², etc.

  # ---- Resampling / bootstrap ----
  "boot",           # Bootstrap CIs (used for tautology sensitivity)

  # ---- Equivalence testing ----
  "TOSTER",         # Two One-Sided Tests (TOST) for equivalence

  # ---- Reporting ----
  "knitr",          # Knit Rmd to HTML
  "rmarkdown",      # Render documents
  "kableExtra",     # Publication-ready tables

  # ---- Plotting helpers ----
  "RColorBrewer",   # Color palettes
  "scales",         # Axis labels, color scales

  # ---- Text processing for NLP integration ----
  "tidytext"        # Lightweight text utilities used in 02_nlp_integration
)

# Install only what's missing
to_install <- required_packages[!required_packages %in% installed.packages()[, "Package"]]
if (length(to_install) > 0) {
  install.packages(to_install)
}

# Sanity check that everything loaded
loaded <- sapply(required_packages, function(p) suppressWarnings(suppressMessages(require(p, character.only = TRUE, quietly = TRUE))))
if (all(loaded)) {
  cat("All", length(required_packages), "required packages installed and loadable.\n")
} else {
  cat("Failed to load:", paste(required_packages[!loaded], collapse = ", "), "\n")
}
