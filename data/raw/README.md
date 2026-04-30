# Raw Data

`Data_Final.csv` is the complete Qualtrics export from the survey (N = 538 before exclusions).

To replicate the cleaning and analysis from raw:

1. Open `analysis/r/01_main_analysis.Rmd`
2. Update the data path in the setup chunk to point at `data/raw/Data_Final.csv`
3. Knit the document

The first phase of `01_main_analysis.Rmd` reproduces all exclusion logic, reverse coding, and composite construction. Output is written to `data/processed/punishment_212_cleaned_data.csv`.

For the NLP pipeline, the cleaned data is the input. The Python notebooks in `analysis/python/` consume `data/processed/punishment_212_cleaned_data.csv` and produce `data/processed/punishment_212_nlp_features.csv`.

Contact for questions: dsimon@law.usc.edu, davidgkamper@ucla.edu
