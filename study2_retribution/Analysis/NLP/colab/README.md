# The language pipeline: run order and what each step costs

Fourteen notebooks. Run them in order. Each one does a single job, checks its own
inputs, and records what it produced so the next one can find it.

## The one thing to set

Every notebook opens with a config cell. In normal use you change nothing except,
in notebooks 06 and 08, which model or encoder this run is for.

    RUN_MODE    = "full"    # "smoke" = first 20 participants, costs pennies,
                            #           proves the whole chain works end to end
    HUMAN_GOLD  = False     # the pre-registered pipeline. Leave this alone.

**Run the whole chain in smoke mode first.** It costs about two cents and takes
a few minutes, and it will catch a missing file or a bad API key before you spend
real money on notebook 06.

## The order

| # | notebook | cost | runtime | produces |
|---|---|---|---|---|
| 00 | extract_openends | free | CPU | `openends_long.csv` |
| 01 | word_list_scores | free | CPU | `facet_dictionary_scores.csv` |
| 02 | word_list_coverage | free | CPU | which facets clear the 5% floor |
| 03 | strata_and_split | free | CPU | `gold_split_assignment.csv` |
| 04 | reference_pools | free | CPU | `embedding_seed_pools.json` |
| 05 | rubric_and_smoke_test | ~$0.02 | CPU | `rubric.json`, and proof it parses |
| 06 | score_one_model | **paid** | CPU | `llm_scores_<MODEL>.csv` |
| 07 | ensemble_merge_and_icc | free | CPU | gate clause B |
| 08 | embed_one_encoder | GPU/paid | **GPU** | `embeddings_<ENCODER>.npy` |
| 09 | facet_similarity | free | CPU | `facet_similarity.csv` |
| 10 | gate_B_and_C | free | CPU | `gate_results.csv` |
| 11 | exploratory_E3_E7 | free | CPU | `E3_to_E7_results.csv` |
| 12 | export_bundle | free | CPU | what `02_nlp_integration.Rmd` reads |
| 99 | human_gold_arm | free | CPU | **optional, see below** |

**Notebook 06 runs once per model.** Change `MODEL_KEY` at the top and run it
again. It checkpoints after every batch and resumes where it stopped, which
matters because Colab drops long runtimes and these are paid calls.

**Notebook 08 runs once per encoder**, the same way. BGE is required; mpnet and
Voyage are optional. Pick a GPU runtime for this one.

## The manifest

Each notebook writes what it produced into `_manifest.json` beside the data. The
next notebook reads it. If an input is missing you get a sentence naming the
notebook to run, not a stack trace three cells later.

## Notebook 99 is not part of the chain

Preregistration section 6.7 says coding is done by an ensemble of language models
**in place of** human raters, and prescribes no human-coding step. The human arm
is therefore a deviation from the registration. Running it requires a dated
amendment posted to OSF **before** any coding happens.

Nothing in notebooks 00 to 12 depends on it. With `HUMAN_GOLD = False` the gate
reports clause A as "not run", which is correct rather than a failure.

## The contract every notebook checks

The corpus is 948 participants times 3 open-ended answers, keyed on
`(response_id, item_type)`. A duplicate on that key silently multiplies rows
through every merge downstream: sample sizes rise, printed counts do not, and
every p-value in the corrected family shrinks with nothing raised.

Every notebook that reads or writes such a file now asserts the key is unique,
before the merge and again before writing. The assertions were tested by
injecting duplicates and confirming they fire. If one stops your run, the file it
names really is malformed.

## If something stops

Read the message. Every stop names the file and the notebook that produces it.
The common ones:

- **A missing input.** Run the notebook the message names.
- **A duplicate key.** The named file has more than one row per participant per
  question. Do not delete rows to get past it; find out why they are there.
- **Analytic restriction matched nothing** in notebook 00. The id column in
  `retribution_scored.csv` does not line up with the Qualtrics export.

## The four originals

`superseded/` holds the four notebooks this chain replaces. They are kept for the
record and should not be run: their outputs use older filenames, and notebook 01
of that set stops partway and asks for human coder files the registration never
called for.
