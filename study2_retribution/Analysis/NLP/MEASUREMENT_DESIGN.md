# Retribution Study — NLP Measurement Design

**Scope.** The open-ended language analysis (prereg §5.15, §6.7; E3–E7). The preregistration finalized 29 June 2026 is authoritative, and §0 registers every place this design departs from it.

**Corpus.** Three open-ended items per participant, scored separately: the ranking explanation, the sentence justification, and the accomplishment item. The collection is `Data/FullData_Values.csv` — 1,015 raw responses, **N = 948** after the preregistered exclusions of §6.2 (1,015 → 965 finished → 958 → 948), vignettes balanced 315 / 317 / 316. `Data/` also holds an interim partial export (`Pilot_300_*`); always read the full file. The prevalence, length, and survey-correlation figures quoted throughout were measured on the first tranche of 300 participants (`outputs/openends_long.csv`, 900 rows; non-blank 298/300/299; median words 32/19/13), and every rule keyed to a base rate — the ≥5% coverage floor, the ≥10% proportionality floor, the `n_pos ≥ 30` minimum — is evaluated again on the realized full corpus.

**Survey scaffold.** `Retribution R/data/cleaned/retribution_scored.csv`, written by `01_main_analysis.Rmd`: all 24 validator columns present, zero missingness, composite definitions as scored there. The survey inter-scale correlations quoted below are from the first-tranche scored file (N = 295).

**Architecture in one line.** A human-anchored LLM ensemble is the production scorer; a small human-coded gold standard is the validity head; a refined word list and per-facet embedding similarity are *independent convergence checks*, never fitted weights; every **gate-backed** facet must clear a triple gate (human-match **and** inter-model reliability **and** survey construct validity) before it can carry a primary E3–E7 claim — and **every E3–E7 claim is exploratory** (prereg §2.4, §6.7), gate or no gate.

**Two words carry a facet's status.** The preregistration puts *all* of E3–E7 in one exploratory family, so "confirmatory" is not available as a label for any language analysis. What the §7 gate decides is which of two roles a facet plays inside that family:

- **Gate-backed (primary).** The facet cleared the §7 validation gate; its E3–E7 results are the ones the paper leans on. **Still exploratory.**
- **Descriptive-only (not gate-eligible).** The facet cannot clear the gate, or cannot be evaluated against it (censure, moral balance, proportionality); prevalence and reliability are reported, and no facet↔survey claim is made. **Also exploratory, and any test it produces is still inside the E3–E7 FDR family.**

The companion `NOTEBOOK_BLUEPRINT.md` specifies how the four Colab notebooks implement what follows.

---

## 0. Deviations from the final preregistration

Each row gives the preregistered text, what this design does, why, and whether the departure needs an amendment to the OSF registration.

| What the preregistration says (§, verbatim) | What this design does | Why | OSF amendment? |
|---|---|---|---|
| **§2.4:** "E3 through E7 are exploratory and depend on the validation step in Section 6.7." **§6.7:** "E3 through E7 form one exploratory family; we control the false discovery rate within it and report effect sizes and confidence intervals." | **Followed exactly.** E3–E7 are ONE exploratory family with BH-FDR applied within it, E5 and E6 included. Nothing in the language analysis is confirmatory; the gate decides only whether a facet is gate-backed or descriptive-only inside the family. | Calling an exploratory test confirmatory inflates its evidential standing, and holding E6 (or a descriptive-only facet's tests) out of the family understates the multiplicity actually incurred. | **No** — no departure. |
| **§6.7:** "Coding is done by an ensemble of language models in place of human raters… we do not treat the ensemble as ground truth." The prereg prescribes **no human-coding step**. **Gate (§6.7):** "A facet supports a claim only if the models agree at an intraclass correlation of at least .60 and the facet correlates at least .30 with its matching survey scale." — **two clauses only.** | Adds a **third gate clause A (human-match)** against a ~250–300-response human-coded gold standard (§8), together with the frozen SEED/TEST split (§8), human-match reported by stratum (§4), and the shared-error cap on clause B (§4). The prereg's two clauses (ICC ≥ .60, r ≥ .30) are **kept unchanged** underneath. | Agreement across models is *reliability*, not *accuracy*; models trained on similar data can share a blind spot and converge confidently on the wrong reading — which is precisely the desert-versus-revenge line this study exists to test. This **adds** to the prereg gate; it never relaxes it. | **Not exercised; withdrawn from the addendum.** The human arm is switched off (`HUMAN_GOLD = False`): no response is human-coded, clause A is recorded as not run, and the gate applied is the two clauses §6.7 names, with the tightenings in rows 7, 8 and 14. The shared-error cap reads the human arm, so it is not applied either. |
| **§6.7 (E4):** "…so we require the same co-occurrence to show up in the **non-model word-list measure**, and we compare it with the relationship between the desert and revenge scales in the survey, before reading it as evidence…" — the **word list** is the named required corroborator. | **The word-list co-occurrence is computed and reported for E4 exactly as preregistered** (desert × revenge from the dictionary stream, with its CI and its realized prevalence). The **human gold set is added as a second, independent non-model corroborator** (§6) — an addition, not a substitute. A near-zero dictionary revenge prevalence is reported as an **observed result of this corpus**, with the counts. | Two motives, kept separate. (i) The preregistered requirement stands and is honoured. (ii) In the first tranche the dictionary fires revenge on ~0.7% of responses and desert > 0 ∧ revenge > 0 on 2 rows corpus-wide, so the word-list correlation is pinned near zero by base rate and has essentially no power either way — a *finding to report*, which readers can check. A corroborator that cannot refute is disclosed as such **after** it is run. | **YES** for the rule that a near-zero-prevalence word-list result is uninformative rather than disconfirming. **Withdrawn** for the human corroborator, because the human arm is not run. The word-list check itself needs no amendment: it is preregistered and it is run. |
| **§5.15:** the facets "line up with the closed-ended items (… **proportionality with the proportionality item** …)" — proportionality is one of the four anchored facets, on the same footing as desert, revenge, and suffering. **§6.7** applies one gate to all of them. | **Proportionality is descriptive-only** (§7), and no primary E3–E7 claim routes through it, on a measured ~1.0% corpus prevalence (backward Q1: 0.3%). | A facet present in ~1% of responses has near-zero predictor variance: it cannot yield a stable r ≥ .30, a meaningful IRR (AC1 dominated by the all-zero cell), or the desert=1 / proportionality=0 dissociation logic. Pretending otherwise would report noise as a test. | **YES.** The prereg gives proportionality an anchor and a gate; setting it aside *before* running the gate is a departure. **The preregistered proportionality gate numbers are reported anyway**, so the demotion is auditable rather than assumed. |
| **§5.15:** the prereg names **exactly four** facet→scale mappings — "just desert purpose items, Retribution 1-4, proportionality with the proportionality item, revenge with the revenge items, suffering with the suffer items." It names **no** anchor for censure or moral balance. | Reports CENSURE and MORAL-BALANCE as **prevalence + IRR only**, never correlated against a survey scale, and strikes the candidate proxies (`society_reject`, `exclusion`, `solidarity_durk`, `just_deserts` — each of which correlates .48–.80 with `deserved` and would launder the desert scale under a new name). | The survey instrument has no censure or moral-balance items. Fabricating an anchor would manufacture convergence. | **No** — this is what §5.15 already implies. The instrument-side answer (dedicated closed-ended items) belongs to a future wave. |
| **§6.7 (safeguard 1):** the word list is named as a standing non-model check, with **no** prevalence condition attached. | Adds a **≥5% minimum-coverage rule** (§6): the word list counts as an *independent convergence leg* for a facet only where it fires on ≥5% of the relevant items. Under it the dictionary is disqualified as a convergence leg for proportionality, censure, moral balance, and revenge (suffering borderline, reported with CI). | Per-facet agreement computed on 3–13 positive cases is noise, and its silence reads falsely as "no independent contradiction" when it is really "no independent measurement." | **YES.** The rule is stated in advance, and **the disqualified legs are still computed and reported** with their counts so the disqualification is checkable. |
| **§6.7 (gate):** "…the facet correlates at least .30 with its matching survey scale," plus "each facet should relate more strongly to its own scale than to an **unrelated** one." | Tightens clause C (§7): the diagonal must beat the facet's **maximally confusable** rival (DESERT vs the `revenge` and `suffering` scales; REVENGE vs `deserved`) by **Δr ≥ .15 with non-overlapping bootstrap CIs**, adds a partial-correlation unique-component test for REVENGE, and demotes a facet where the two survey scales are themselves collinear (r ≥ .6). | `proportionality_jd` is the one near-orthogonal scale (r = .05 with `deserved`), so the literal "unrelated foil" reading is the easiest possible test: a scorer that collapsed all punitive sentiment into one undifferentiated reading would pass it while being blind to the desert-versus-revenge distinction. | **YES.** Stricter than preregistered, but a change to a preregistered criterion nonetheless. **The preregistered "own > unrelated" result is reported alongside** the stricter one. |
| **§6.7 (gate):** "…the models agree at an intraclass correlation of at least **.60**" — a threshold on the estimate. | Gates on the **lower bound of the bootstrap 95% CI ≥ .60** for ICC(2,k), computed over every response the whole panel scored, **pooled across the three items** (notebook 10), and records the clause as **not run** when fewer than **30 responses carry any model's score above zero** (the positive-case floor, counted in notebook 07 and applied to the verdict in notebook 10). Clause C's r ≥ .30 is likewise decided on the lower bound of its bootstrap interval. The shared-error cap reads the human arm and is not applied while that arm is off. | At 0.7–2.5% base rates an ICC computed mostly over responses every model scored zero comes back near 1.000 and says nothing about agreement; the floor stops that from passing. A coefficient estimated on few informative cases has a wide interval, so a facet whose true value sits below the threshold can post a sample value above it by chance; the lower bound stops that from passing. | **YES.** The **point estimate** (the preregistered quantity) is reported next to the CI-bound decision. |
| **§6.7 (gate):** states the gate but names **no item** — "the facet correlates at least .30 with its matching survey scale" is silent on which of the three open-ends it is evaluated on. §3 of this design routes it to **Q1 (backward)** on register-match grounds. | **The routing stands, and its cost is reported beside it.** Q1 is the *scarcest* of the two backward-looking sites for the E4 pair: on the realized corpus the word list fires REVENGE on **2/947 (0.21%)** at Q1 against **8/945 (0.85%)** at Q333, and DESERT on **18.7%** against **31.9%**. The cost falls on **clause C**, which is evaluated at the gate item: a facet scored zero on most Q1 responses has little variance there, and that caps the correlation it can reach with its survey scale however well it is measured. It does **not** fall on clause B, whose ICC and positive-case floor are computed over the three items pooled (row 8). Every clause C number is therefore also computed and reported at **Q333**, separately and never pooled, exactly as §3 already requires of E3; the Q333 numbers decide nothing. Q1 remains the site of record. | The gate site was chosen for register match, which is the right criterion, and it was fixed before any scoring. It was fixed without pricing what it costs in variance, and that price falls hardest on the one facet E4 cannot be tested without. Reporting one site alone would leave a reader unable to separate a facet that failed on the merits from a facet that failed on the site. Fixing the second site here, in advance, keeps the disclosure from becoming site-shopping: choosing the item *after* seeing which one lets REVENGE clear clause C is precisely the practice the lower-bound rule exists to prevent. | **YES** for the two-site reporting rule, which adds a reporting obligation to the registered gate. **No** for the routing itself — §6.7 localizes nothing and Q1 was set in advance. |
| **§6.7:** "**Each model scores every response on the facets**, allowing more than one facet per response, and makes the single principled-versus-vengeful judgment." — one pass, all facets. | For the **E4 pair only**, desert and revenge are elicited in **separate, independent LLM calls** (§4), with the joint-call scores retained and the joint-versus-split difference reported as a halo diagnostic. | E4's hypothesis *is* the desert × revenge association; producing both numbers from one joint read, under a rubric that explicitly teaches co-occurrence, lets within-rater halo manufacture the effect. | **YES.** The joint-call (preregistered) estimate is reported in full; the split-call estimate carries the primary weight. |
| **§6.6:** the non-language exploratory analyses "are exploratory and are **not corrected as a confirmatory family**." | Unchanged. E1/E2 and the other §6.6 analyses stay uncorrected; the **language** family (E3–E7) is BH-corrected within itself per §6.7. | The prereg draws this line itself. | **No.** |
| **§6.7:** "The facet score for a response is the average across models"; the registration gives **no rule for when a facet counts as present**. | **The continuous ensemble mean is the score of record for every test**: every ICC, every clause C correlation, and every E3–E7 estimate. No test thresholds it. A facet is *counted* in exactly two places, each with a definition fixed here. The clause B positive-case floor counts **trace** presence, at least one model scoring the facet above zero (row 8). Base rates count **clear** presence, the ensemble mean above **.50**, and are reported beside trace presence. The proportionality null-by-absence reading for E5 uses clear presence below 10% at both backward-looking items. Settles §11 item 10. | Every inferential step already runs on the continuous score, so a presence rule matters only where a count cannot be avoided, and a count whose definition could still be picked after scoring is a researcher degree of freedom. The two definitions answer different questions: the floor asks whether an ICC could be made of agreed zeros, which any nonzero score rules out; a base rate asks how often the models on balance saw the facet. On the three-model pipeline test, joint-call revenge carried a trace on 2 of 20 response-items and a clear score on none, which is why both are reported rather than one. | **YES.** The registration sets no presence rule; fixing one before scoring is an addition. |
| **§6.7 (safeguard 1):** similarity to short reference passages, "computed with more than one embedding model," is scored alongside the ensemble, and "the absolute level of the similarity scores shifts across embedding models while the ordering of responses stays stable, and we report that for the facet scores as well." The registration does not say what the similarities are evidence *of*. | **The embedding leg is scored and reported, and it counts as convergent evidence for no facet.** Absolute levels and cross-encoder rank stability are reported as registered (notebook 09). Ensemble-versus-embedding agreement is reported in the agreement matrix, labelled as not a convergence leg, with each similarity's correlation with its facet's own survey scale and confusable rival at the gate item beside it (notebook 10). §5's condition that rank-stable, human-validated similarities enter convergence cannot be met and is superseded by this row; the `enters_convergence` flag in `embedding_model_sensitivity.csv` records rank stability only. | Three facts, observed on the embedding output before the ensemble scored the corpus. (1) §5 admits a similarity to convergence only once it is human-validated, and no response is human-coded. (2) Notebook 04 seeded the reference passages from word-list-positive responses, so the only other yardstick is circular: similarity to those passages will find the responses they were drawn from. (3) Against the survey at Q1 the similarities carry almost nothing: correlations with each gated facet's own scale ran from −.16 to .13 across the three encoders, and the revenge similarity correlated *negatively* with the revenge scale on all three (−.11 to −.16). Counting that leg as corroboration would lend claims resting on one method the look of two. | **YES.** It withdraws a role the design promised; the rule can only withhold evidentiary weight, never add it, and the numbers behind it are reported. |
| **§5.15 / §6.7:** "revenge with the revenge items"; "revenge language the revenge scale"; and for E4, "we compare it with the relationship between the desert and revenge scales in the survey." | **Every clause C comparison that uses the survey revenge scale runs twice**: on the registered scale (`revenge_1` to `_4`) and on the **two literal items**, `revenge_1` ("Society has the right to take revenge on criminal offenders") and `revenge_2` ("Society should punish to get back at criminal offenders"). A facet passes clause C only if it passes **both**. That touches REVENGE (its own scale and its unique-component test) and DESERT (the revenge scale is one of its confusable rivals); both verdicts are exported beside the combined one. E4's survey reference is reported on both scorings: r(deserved, revenge) = **.551** on the registered scale and **.485** on the literal items, N = 948 (the .61 quoted in earlier drafts came from the first 300 participants). | `revenge_4`, "Rather than showing criminals so much tolerance, we should be punishing them more severely," asks for harsher punishment and never mentions getting even. On the survey it correlates .78 with punitiveness, more than the four-item scale does (.69), and .61 with desert, while the father item (`revenge_3`) runs the other way (.25 with punitiveness). A revenge *text* facet validated only against the four-item scale is partly validated against punitiveness, and desert text that beats that scale is partly beating a punitiveness item. Requiring both keeps the registered test intact and adds the one that asks the question §5.15 means. | **YES.** Stricter than registered and demote-only; the registered-scale verdict is reported in full beside it. |
| **§6.7:** "The models are run at a fixed setting and pinned versions, with all raw output saved so the scoring can be repeated." | The three models are pinned by **explicit, non-routing identifiers**: `claude-opus-4-6` (Anthropic); `gpt-5.6-terra` with `reasoning_effort = none` (OpenAI); `meta-llama/Llama-3.3-70B-Instruct-Turbo` (Meta, open weights, served by Together). All three run at **temperature 0** with `max_tokens` 900 under rubric fingerprint `fef0381e46892391`, through **pinned client libraries** (`anthropic 0.125.0`, `openai 2.54.0`), and every reply is archived verbatim with its model identifier and the rubric fingerprint. | None of the three providers now publishes a dated snapshot string for these models, and a dated form of any of these identifiers is rejected. What a dated string protected, that the model cannot change under the analysis, is carried instead by identifiers that name one model rather than a moving alias, by the pinned client libraries (a client release in August 2026 removed the temperature parameter outright), and by the archive. GPT runs with reasoning off because that is the only setting at which it accepts temperature 0. | **Disclosure.** The fixed-setting clause is met; the form of pinning differs from the registered wording and is stated so a reader can check it. |

The rows marked YES, with the disclosure row, go up as a single dated addendum to the OSF registration (registration approved 5 July 2026; embargo completed 11 July 2026), posted **before** the ensemble scores the corpus (§11.2). The human arm is not run, so rows 2 and 3 carry no addendum text for it. Where §0 and a later section disagree, §0 governs. Draft: `Retribution/Docs/Preregistration/Retribution Study -- OSF Addendum, language analysis, DRAFT.md`.

---

## 1. Principle — what we measure, and why it is NOT the Dark Side prosocial/dark binary

The prior Punishment 2.1 ("Dark Side") study scored each open-ended response on a single axis: a **prosocial-minus-dark** roll-up, produced by summing "prosocial" categories, summing "dark" categories, and subtracting. That binary is **retired here** and kept only as a single secondary descriptive footnote. Three problems make it unusable for the Retribution study's questions:

1. **It cannot test H6.** The prereg's H6 asks whether **desert** and **proportionality** cohere. In the Dark Side scheme both live inside one undifferentiated "proportional justice / just deserts" category, so the two constructs H6 pulls apart were never separable. You cannot measure a dissociation between two things you have merged into one bucket.
2. **It flattens co-occurrence.** The Retribution study's central object of measurement (E4) is whether a **single person's** justification carries *both* principled desert language *and* vengeful payback language *at the same time*. A prosocial-minus-dark difference score literally subtracts one from the other, destroying exactly the within-person co-occurrence we want to see.
3. **The absolute metric was model-unstable.** In the Dark Side pipeline the "% closer to dark" embedding metric swung from 67.5% (mpnet) to 21–28% (BGE/voyage); only rank order survived (r ≈ .71). A headline number that moves 40 points across encoders cannot anchor a claim.

**What replaces it.** Retributive reasoning is decomposed into a **9-label multi-label scheme**, each label scored **0–1 per response per item** (never forced to sum to 1, never collapsed onto a single axis). A response may carry several facets simultaneously — co-occurrence is *measured, not averaged away*. Six labels decompose retribution itself into principled/bounded vs. vengeful/unbounded facets; three consequentialist goals are scored on the same pass so the retributive facets are measured against a **full menu of punishment justifications**, not in a vacuum. A separate holistic principled/vengeful/both/neither call is collected per response but kept **out** of the facet vector (§4, and the anti-double-dip rules in §9).

**The measurement target is a distinction, not a valence.** We are not asking "is this response good or bad." We are asking whether ordinary people, when they justify a sentence, reach for *desert* (the offender earned it), *proportionality* (the amount fits), *censure* (society condemns it), *moral balance* (a debt is repaid), *revenge* (getting even), or *suffering* (pain for its own sake) — and which of these travel together. That is why a valence binary is the wrong instrument and a multi-label facet scheme is the right one.

---

## 2. The facet scheme

Nine labels, multi-label, each scored 0.0 (absent) to 1.0 (clearly, centrally present) per response per `item_type`. **Never forced to sum to 1. Never a single axis.** A response can be entirely consequentialist (all six retributive facets 0), entirely vengeful, or a genuine mixture.

*Status reminder:* "gate-backed" and "descriptive-only" describe a facet's standing **within the exploratory E3–E7 family**. No facet, however it scores, makes an E3–E7 test confirmatory.

### Six retributive facets

| Facet | Class | Definition | Example language (cues) | Survey validator | Gate status |
|---|---|---|---|---|---|
| **F1 DESERT** | principled/bounded | The **offender** earned/merited punishment as a backward fact about what they did or are. Agent-focused, magnitude-unbounded. | "deserves it," "earned this," "had it coming," "get what they deserve," "pay for what he did" | `deserved` (`Retribution_1..4`) | **Gate-eligible** |
| **F2 PROPORTIONALITY** | principled/bounded | The **punishment's** calibration/amount — a bounded fit with an explicit ceiling/floor. | "fit the crime," "match their crime," "in proportion," "not too harsh / too lenient," "reasonable amount to match" | `proportionality_jd` | **Descriptive-only** (§7) |
| **F3 CENSURE / DENUNCIATION** | principled/bounded | The **social message** — punishment as moral condemnation/accountability, satisfiable symbolically. | "send a message it's wrong," "society condemns," "reflect the seriousness," "held accountable" | **None admissible** | **Descriptive-only (permanent)** |
| **F4 MORAL-BALANCE / DEBT** | principled/bounded | Restoring a **ledger** — righting the wrong, paying a debt, closure. Distinct from proportional sizing: about *closure*, not *calibration*. | "pay his debt to society," "balance the scales," "make it right," "balance out his crime" | **None admissible** | **Descriptive-only (permanent)** |
| **F5 REVENGE / PAYBACK** | vengeful/unbounded | Retaliation, getting even, symmetric hitting-back. | "payback," "eye for an eye," "serves them right," "his turn" | `revenge` (`revenge_1..4`) | **Gate-eligible** |
| **F6 SUFFERING-FOR-ITS-OWN-SAKE** | vengeful/unbounded | Wanting pain beyond any instrumental aim. | "should suffer," "rot," "make it miserable," "feel what the victim felt" | `suffering` (`suffer_1, suffer_2`); `degradation` (r = .64) and `harsh` (r = .68) convergent secondaries | **Gate-eligible** |

### Three consequentialist goals (scored, reported, NEVER summed into any retributivism total)

**deterrence, incapacitation, rehabilitation.** Each validates against its own survey composite as a convergent sanity check — not a gate target for a retributive claim. Their purpose is to give the retributive facets a full menu to be measured against and to power the backward-vs-forward register contrast (§3, §10).

### The four-way distinction that is the whole point

A single "retribution" bucket conflates desert, proportionality, accountability, and payback, and makes H6 untestable. The operational rule that keeps them apart:

- **DESERT** = the *fact* that punishment is owed (the agent's earning).
- **PROPORTIONALITY** = *how much* fits (calibration; empirically orthogonal to desert at survey r = .053).
- **CENSURE** = the *expressive* function (audience-facing message).
- **MORAL-BALANCE** = the *debt/ledger* metaphor (relational closure).

The coding must be able to fire DESERT=1, PROPORTIONALITY=0 on the same sentence and vice versa.

### Independence enforced three ways (one codebook, three scorers)

The human codebook, the LLM rubric, and the word list share **one** written codebook. Independence is enforced identically across all three:

1. **No shared surface token, rubric anchor, or embedding reference passage between two *opposing* facets.** Enforced programmatically by an assertion that the union of facet lexicons contains no duplicate token across opposing facets.
2. **Fixed token routing.** `pay for (what|it|his|her|their)` → DESERT everywhere; `make (him|her|them) pay` and `payback` → REVENGE as separate tokens; bare adverb `just` counts toward nothing.
3. **The rubric shows a mixed-motive anchor and a negation/stance anchor** so the model is told explicitly that facets co-occur and must not collapse to one winner.

### Independence is a test, not a guarantee

The no-shared-token assertion prevents double-counting but says **nothing** about whether two facets fire on the same *texts*. Desert and the vengeful facets demonstrably co-fire (survey r = .55 on N = 948; the E4 premise). Two rules follow:

- **The assertion is not evidence of construct independence.** The actual response-level facet-score correlations are measured and reported, because that is where non-independence lives. Cosmetic token separation is never cited as proof that two facets are distinct constructs.
- **Contestable routing calls are surfaced and stress-tested.** Two token routings are genuinely ambiguous: `pay for the pain they caused` reads as revenge/suffering to many coders, and `held accountable` is one of the most common **desert** phrasings in ordinary speech (accountability = you earned the consequence). These are **not** hard-routed identically across all three scorers, because that manufactures fake convergence. Instead the LLM and human coders resolve them **in context** (they can read scope), and the ambiguous tokens are **removed from the dictionary** rather than fiat-assigned, keeping the word list a true low-recall precision check independent of the routing decisions. Every contestable routing call is registered as an explicit decision with the corpus counts it affects, and NB04 runs a sensitivity check that flips `held accountable` between desert and censure to show the gate result is not an artifact of that one call.

### The desert × proportionality note

If the ensemble's desert and proportionality facet scores turn out to co-occur within-person, that is a **finding** (against the survey r = .05), not an artifact — which is why they must never share a token or a validator. For the **dictionary and embedding streams**, though, enforced token disjointness mechanically depresses joint firing, so those streams are excluded from the H6 text-side co-occurrence estimate (§10, E5).

---

## 3. Input texts

Three items, **scored separately, never concatenated** (prereg §5.15). `openends_long.csv` is in the correct long shape (one row per `response_id × item_type`, vignette-coalesced). Do **not** rebuild a `text_combined`. Every method (LLM, embedding, dictionary) runs per-row; the same participant has up to three desert scores, etc. `item_type` is carried through every scorer and every analysis.

| item_type | Prereg tag / export column | Prompt | n non-blank | median words | Role |
|---|---|---|---|---|---|
| **backward** | Q1 = `Sentence_OpenEnd1` (vignette-split `_V1/_V2/_V3`, coalesced by `Vignette`) | "Please explain why you recommended this sentence for Darryl." | 300/300 | 19 | **Primary retributive site.** Backward justification is where desert/proportionality/moral-balance live; cleanest register match to the closed-ended retributivism scales. |
| **forward** | Q2 = `Sentence_OpenEnd2` (vignette-split, coalesced) | "What do you hope this sentence will accomplish?" | 299/300 | 13 (shortest) | Structurally invites consequentialist goals. Retributive facets appearing *here* are the strongest evidence of a genuinely retributive orientation. |
| **ranking** | Q333 = `Priorit_Explain` (single column, not vignette-split) | "Please explain why you ranked the reasons for punishment in that order." | 298/300 | 32 (longest, mean 43.7w) | **New in this study** (2.1 never had it). Most direct elicitation of retributive reasoning; tied to the categorical retributivist definition (`Prioritization_1 == 1`). |

**Tag note:** the prereg calls the ranking item Q333; the export column is `Priorit_Explain`. NB01 **asserts the export column exists and logs the resolved name** so the Q333/`Priorit_Explain` mismatch cannot silently drop the item.

### The backward-vs-forward contrast is its own measure (E6)

For each participant and facet, compute `delta_f = facet_f(backward: Q1 or Q333) − facet_f(forward: Q2)`. Prediction: retributive facets peak on Q1/Q333, consequentialist goals peak on Q2. This register shift validates the scheme itself, independent of the survey. It is reported as a **descriptive** measure (E6), and — per prereg §6.7 — **E6 sits INSIDE the single E3–E7 exploratory BH-FDR family**.

### Item-specific gate routing

- The facet-vs-survey validation gate (prereg §6.7) is evaluated on **Q1 (backward)** for DESERT / REVENGE / SUFFERING because it is the cleanest register match. (Proportionality is descriptive-only, §7; its preregistered gate numbers are computed and reported anyway.) **Q1 is the site of record, and every clause C number is reported at Q333 beside it**, separately and never pooled: Q1 is the scarcest site for the E4 pair (the word list fires revenge on 0.21% there against 0.85% at Q333), so a facet that fails clause C at Q1 for want of variance must stay distinguishable from one that fails on the merits. The pair is fixed in advance and registered; see §0.
- **Q333** is the official input for the ranking-tied analyses.
- **E3** (open-ends distinguish ranking-defined retributivists, `Prioritization_1 == 1`, from others) is tested on **Q333 AND Q1 separately, never pooled** — agreement between the two backward items is a within-study replication.
- **Q2** (median 13w, consequentialist-leaning) is **not** a primary site for retributive-facet gates; it feeds the consequentialist goals and the backward-vs-forward contrast.

### Word-count and vignette control

Because item medians differ sharply (32/19/13), `n_words` is a covariate in every model, and cross-item comparisons use within-item-standardized scores. For any analysis pooling vignettes, facet scores are standardized **within vignette × item_type** so vignette-specific verbosity/severity does not masquerade as a facet effect. `Sentence1_z` arrives pre-computed within vignette from `01_main_analysis.Rmd`; notebooks only consume it.

---

## 4. Method 1 — LLM ensemble (the production scorer)

The ensemble is the prereg-§6.7 production scorer that runs on the full corpus. **≥3 models from ≥3 developers, ≥1 open-weight.** Every model scores every response (per `item_type`) on all nine labels (multi-label 0–1) **and** makes one holistic principled/vengeful/both/neither call. Facet score = **mean across models**; holistic = **majority**. Temperature 0, pinned dated version strings, seed where supported. **All raw per-model JSON saved verbatim** (one row per response × model) → OSF with prompts and versions.

Scale is trivial: the non-blank responses are already separate rows (897 in the first tranche); one call per response per model, a one-time run.

### Critical validity guard — the ensemble does not license itself

**Before** the ensemble scores the full corpus, NB02 computes **ensemble-vs-human agreement on the gold set**. A facet whose ensemble-vs-human agreement falls below the human-match bar (gate clause A, §7) is reported as *not humanly recoverable* and is **blocked from backing any gate-backed E3–E7 claim, regardless of its inter-model ICC.** (Clause A is this design's addition to the prereg gate — §0.) Only after this check does the ensemble score the full corpus for gate-eligible facets.

### Model set (confirm current IDs at run time — the Dark Side strings are ~1 yr old)

1. **Anthropic Claude** — a stronger tier than Dark Side's Haiku (desert-vs-proportionality-vs-censure is subtler than prosocial/dark; cost is trivial for a one-time batch). Pin the exact dated string.
2. **A second-developer proprietary model** — OpenAI GPT or Google Gemini dated snapshot.
3. **An open-weight model** — current Llama-3.x-70B-instruct or Qwen2.5-72B-instruct at pinned revision, via hosted endpoint or Colab GPU (required by §6.7; fully reproducible from weights).
4. A 4th model is optional but improves ICC stability.

### The open-weight model's standalone verdict is kept, not outvoted

The open-weight model is the **architecturally most different** rater. Its **standalone** human-match is reported **separately**. If the one most-different model disagrees with the proprietary consensus on a facet, that disagreement is **signal about a possible shared blind spot, not noise to be majority-voted away** (see the shared-error diagnostic below).

### Engineering carried over from Dark Side NB02

`JSON_SYSTEM_PROMPT` + prefilled assistant turn `{'role':'assistant','content':'{'}`; `parse_json_safe(prefill='{')` with fence-strip / greedy first-`{` to last-`}` / truncation-repair; `normalize_label()`; module-level `FAILURE_LOG` (cap 5 raw failures); `claude_call(max_retries=4)` exponential backoff on `RateLimitError`; `ThreadPoolExecutor(max_workers=8)` writing `future → index`; `text[:1500]` truncation; ≥3-word `df_valid` filter. **Parse failures are recorded as explicit rows (facet vector = None), never dropped**, so coverage stays honest.

### Rubric / prompt shape

One call = one response's text for one `item_type` (`item_type` passed as context but **not** used to bias labels).

**SYSTEM:** "You are one of several independent expert annotators coding how ordinary people justify a criminal sentence. Score each of nine reasoning facets 0.0 (absent) to 1.0 (clearly, centrally present) for how strongly the passage expresses it. Score each facet **independently** — several can be high at once; real explanations mix motives, so do NOT pick one winner and do NOT spread nonzero scores out of politeness (a response can be entirely consequentialist with all retributive facets 0, or entirely vengeful). Distinguish DESERT (they earned it) from PROPORTIONALITY (the amount fits/is bounded) from CENSURE (condemn/send a message) from MORAL-BALANCE (pay a debt/settle the ledger) — these differ even when they appear together. Handle negation and stance: 'I do NOT want him to suffer' is suffering = 0.0; a passage that calls deserving-punishment 'just revenge' to REJECT it is critiquing desert, not endorsing it. Do not infer a facet from the crime; score only what the text expresses."

**USER schema (strict JSON):** `{desert, proportionality, censure, moral_balance, revenge, suffering, deterrence, incapacitation, rehabilitation: 0.0–1.0, holistic: 'principled'|'vengeful'|'both'|'neither', evidence: {<facet>: '<=12-word verbatim span>'}}`. Include the item prompt text and the passage.

### Anchors without their numeric targets; optional spans; human-match by stratum

Showing the model `desert 0.9, moral_balance 0.4` beside a near-identical corpus quote trains it to reproduce the codebook author's intuitions on easy clean cases, and inflates ensemble-human "agreement" precisely where agreement is cheap. Three rules follow:

- **Split anchors from their numeric targets at scoring time.** Give the model the boundary *definitions* and the co-occurrence/negation *teaching cases*, but **hold out the exact numeric targets**, or draw the rubric's anchors from the **SEED half** of the gold split so no scored item shares an anchor with its own rubric (§8).
- **Make the verbatim-span field optional.** A mandatory span biases the model toward lexical matching — it must find a quotable string to score a facet nonzero, which suppresses exactly the **non-literal** vengeful/censure sentiment the ensemble is supposed to catch where the dictionary fails. Explicitly permit "facet present but not attributable to a single span" so the span requirement stops gating revenge/suffering recall.
- **Report human-match (gate clause A) separately for anchor-adjacent (clean) vs. boundary/mixed strata.** A single pooled ICC is inflated by the easy cases and hides failure exactly where the desert-vs-revenge line is drawn.

### The E4-critical facets are scored in SEPARATE calls

Scoring all nine facets for one passage in **one** call means desert and revenge share the rater's holistic impression, the same 1500-char window, and the rubric's explicit "real explanations mix motives" instruction plus its mixed-motive anchors. The within-person desert × revenge correlation E4 reports would then be partly a **within-rater halo / anchor-conformity artifact**, not a property of the writing — a form of double-dipping, since the same joint read produces both variables whose association is the hypothesis.

- **Score desert and revenge in separate, independent LLM calls** (one facet per call for the E4-critical pair), so a high desert judgment cannot leak into the revenge judgment through shared context and instruction.
- **The E4 co-occurrence estimate comes from independently-elicited facet scores**, and the difference between joint-call and split-call desert × revenge correlations is reported as a **halo diagnostic** — if the correlation collapses under split scoring, it was a rating artifact.
- **Hold out the two symmetric mixed-motive anchors** (which teach co-occurrence) from the E4 facets' rubric, and quantify anchor sensitivity by scoring a subset with vs. without them. A co-occurrence that depends on the rubric's co-occurrence anchors is circular.

### Shared-error diagnostic — what averaging hides

Mean-across-models mechanically converts a *shared* blind spot into a confident, low-variance, high-ICC number: averaging three models that share a systematic misreading does not cancel the error, it launders it into tight consensus. So, on the gold set, per facet:

- Report the **signed bias** of the ensemble mean vs. the human consensus (not just agreement/ICC).
- Test whether the residual model-vs-human error is **correlated across models** (a positive cross-model error correlation is the signature of a shared blind spot).
- **Require the ensemble's errors to be roughly zero-mean and cross-model-independent** before the mean is trusted as the score of record. If errors are correlated and directional, report the facet as **biased and cap its gate-backed (primary) use.**

### Real anchors embedded in the rubric (quotes from this corpus)

Each is shown with its target JSON at **codebook-authoring** time; the targets are held out of the scored prompt (above).

- **DESERT (clean):** `R_3gSICIiGeQ8DCjN` [ranking] "Criminals deserve to be punished… victims need to feel that someone pays for the harm done." → desert 0.9, moral_balance 0.4.
- **PROPORTIONALITY (clean):** `R_70vm1xpQlRxHl1s` [ranking] "They should pay a reasonable amount of time away from society to match their crime." → proportionality 0.9, incapacitation 0.3, desert 0.2.
- **CENSURE (proxy):** `R_732mg1S5ULj0brc` [backward] "The sentencing should always reflect the seriousness of the crime… should be held accountable." → censure 0.6, proportionality 0.5.
- **REVENGE (clean):** `R_77tp3RXMgnxlR4Z` [forward] "eye for an eye is what i beleave in." → revenge 0.9.
- **SUFFERING (clean, co-occurs):** `R_7K3dz3sByxkDqdZ` [backward] "since he's paralyzed, he'll suffer more and 40 years seems like enough time." → suffering 0.7, proportionality 0.3.
- **MIXED-MOTIVE (teaching case, held out for the E4 pair):** `R_3sisTwYexKNQbvd` [forward] "there needs to be an appropriate consequence to causing the death of another human being… An eye for an eye in a sense." → proportionality 0.6 AND revenge 0.6 AND moral_balance 0.4 simultaneously, holistic 'both'.
- **MIXED-MOTIVE #2 (same person, two items):** `R_37e5e0QC8RzXdaV` [ranking] "It serves them right to get a taste of payback" (revenge 0.7) + [backward] "He still deserves to go to prison… a miscarriage of justice" (desert 0.7, moral_balance 0.4).
- **HARD-NEGATIVE / stance:** `R_7V2vfczhki64TTT` [ranking] "Deterrence is shaky, so 'deserving' punishment is just revenge, not a real solution." → the speaker EQUATES desert with revenge and REJECTS both: desert LOW (~0.2), revenge LOW, rehabilitation ~0.6, holistic 'neither'. Teaches stance/negation, not token-spotting.

---

## 5. Method 2 — embedding similarity (secondary / convergence)

Safeguard 2 (prereg §6.7), **secondary and convergence-only** — it never gates a facet and never appears as a headline number.

**Approach:** per-**facet** reference-passage similarity, **never** a prosocial-minus-dark gap (that construct is dropped). For each of the nine facets, build a reference **set** of 8–15 **short** passages **seeded from real human-coded gold-standard exemplars** — responses coders scored highest on that facet AND low on its opposing facet — rather than hand-crafted synthetic sentences, so the seeds carry the same messy, short, mixed register as the corpus. Mixed-motive exemplars are placed in **both** the relevant principled and vengeful sets so anchors reflect real co-occurrence.

A response's facet-similarity = **mean cosine to that facet's reference set**, computed separately per `item_type`. **Leave-one-out:** exclude a response from scoring against any set that contains it.

**≥3 embedding models from different makers** (prereg §6.7 safeguard 2), pinned: `BAAI/bge-large-en-v1.5` (open, REQUIRED/primary), `sentence-transformers/all-mpnet-base-v2` (v2 baseline for continuity), `voyage-4-large` (or current Voyage, via Secrets). Caching follows Dark Side exactly: `encode(batch_size=32, normalize_embeddings=True, convert_to_numpy=True)`; `np.save('{model}_response_embeddings.npy')`; reload with `.shape[0] == len(df)` asserts (BGE required, others optional); `voyage_embed_batch(batch_size=64)` 3-attempt retry + blank guard.

**Model-sensitivity reporting, per facet** (prereg mandate): for each facet report (a) **absolute** mean similarity per model — expected and stated openly to **shift** across models — and (b) the **cross-model rank-order correlation** of response ordering — expected **stable**. Only rank-stable, human-validated facet similarities enter convergence. With no human coding in this run no similarity meets that condition, and the embedding leg is reported but counts as convergence for no facet (§0).

### Coverage floor and the frozen split for the embedding leg

- **Coverage.** For the **sparse** facets (proportionality, censure, moral_balance, revenge), the embedding leg is reported only where it produces a usable, nonzero-variance signal; it is **not** counted as an independent convergence leg where it cannot (the ≥5% rule in §6).
- **Frozen split.** Embedding reference passages draw **only** from the **SEED half** of the gold set; embedding-vs-human convergence is computed **only** on the **TEST half** (responses that contributed nothing to any seed). Leave-one-out alone removes only self-similarity for the exact seed response, not the shared-coder signal across the stratum, so the frozen split is mandatory (§8).

**Why not fitted triangulation weights:** weighting each stream by its human-agreement and folding into a composite would let an unstable embedding stream silently move a headline number. Convergence is **reported and inspected**, not baked into a weighted score.

---

## 6. Method 3 — refined word list (independent check)

Safeguard 1 (prereg §6.7): the non-LLM word list — in principle the **most independent** check, because it uses no language model. It is implemented as nine disjoint regex buckets emitting **raw counts + per-100-word rates + `n_words`** (ported verbatim into Colab NB01 §2 from the retired prototype in `_superseded/02_facet_dictionary.py`). Role: **transparent secondary / independent convergence check, never a primary scorer.**

### Precision rules the list enforces

- **Bare `just` never counts toward desert.** The desert patterns are `deserv\w*`, `just deserts?`, `earn(ed|s)?`, `had it coming`, and the like; the adverb on its own matches nothing.
- **`remove\w* from society` lives only in incapacitation**, enforced by the duplicate/opposing-token assertion.
- **`pay for (what|it|his|her|their)` routes to DESERT everywhere**; `payback` and `make (him|her|them) pay` stay under REVENGE as separate tokens.
- **The lexicon is expanded from the human-coded SEED half, not from intuition** (§8). Desert adds: face the consequences, own up, take responsibility, answer for, reap what they sow, debt to society, pay the price, actions have consequences, get what they deserve, make things right, justice served. Moral-balance adds: debt to society, balance the scales, restore, make it right.
- **Short answers are normalized without discarding counts:** raw counts are kept alongside per-100-word rates, and `n_words` is a covariate throughout.
- **Negation** is handled by the zero-out rule below and by nothing else.

### Negation is ZERO-OUT only, whitelist-based, and excluded from every gate

A raw regex proximity rule that sign-flips near a facet cue mis-handles the exact constructions it targets: "he deserves **NO** sympathy" and "**no** mercy" are **max-desert** statements; "**not** only does he deserve it" does not negate desert; "I **don't** think a light sentence is deserved" is net pro-desert. A sign-flip actively corrupts counts and is worse than raw.

- **No sign-flip.** A secondary precision check must never emit negative facet counts.
- **Keep only a conservative ZERO-OUT on a hand-curated whitelist of verified negation+cue bigrams/trigrams observed in the gold set** (e.g. "don't want him to suffer," "doesn't deserve mercy"), inspected case-by-case, because "deserve no mercy" is pro-desert.
- **Report raw and negation-zeroed counts side by side, and exclude the negation-adjusted column from any gate computation.** The dictionary's role on stance is explicitly disclaimed; it must not feed a stance-sensitive number. All genuine negation/stance handling is delegated to the human coders and the LLM rubric.

### The word list is NOT a convergence leg where it is empirically near-empty

Measured corpus prevalence: proportionality fires on ~1.0% of responses, censure ~1.4%, moral_balance ~0.7%, revenge ~0.7%. On the backward items, revenge has ~3 positive cases in 598. Per-facet ensemble-vs-wordlist agreement on 3–13 positives is **noise**, and its silence reads falsely as "no independent contradiction" when it is really "no independent measurement at all."

- **Minimum-coverage rule, set in advance:** a stream counts as independent corroboration for a facet **only if it produces a usable, nonzero-variance signal on that facet** — operationally, **fires on ≥5% of the relevant items.** By this rule the word list is **disqualified as a convergence leg** for proportionality, censure, moral_balance, and revenge (suffering is borderline and reported with its CI).
- **For those sparse facets, the strongest independent check available is the human coder.** Their validity therefore rests largely on the human gold set, which **raises the stakes on the gold-standard rules in §7–§8**: for these facets the independent evidence is a human anchor, not three-legged triangulation. **The disqualified word-list legs are still computed and reported with their counts**, so that "disqualified" is a visible, checkable result rather than a silent omission of a preregistered safeguard.

### E4 carries both non-model corroborators — *registered deviation, §0*

**What the prereg requires.** Prereg §6.7 makes the word list E4's named corroborator: "we require the same co-occurrence to show up in the **non-model word-list measure**, and we compare it with the relationship between the desert and revenge scales in the survey, before reading it as evidence that ordinary just deserts is bound up with revenge." That check is computed and reported.

**What the corpus shows.** In the first tranche of 300 participants, the dictionary fires **both** desert > 0 AND revenge > 0 on exactly **2 rows corpus-wide** (1 row on the primary backward site), and that one row is `R_7V2vfczhki64TTT` — the designated **hard-negative stance anchor** this design classifies as NOT desert and NOT revenge. The dictionary desert × revenge correlation there is r ≈ 0.02, held near zero by ~0.7% revenge prevalence. A check with that much power can neither corroborate nor refute E4, which is a result to report with its counts.

- **Run and report the preregistered word-list corroboration for E4:** the dictionary desert × revenge correlation with its bootstrap CI, the joint-firing count, and the per-facet prevalence that drives it, so a reader can see for themselves how much power the check had in the realized corpus.
- **Add the human gold standard as a second, independent non-model corroborator** — this is the deviation the amendment covers. The desert × revenge within-person co-occurrence should reproduce in the human-coded gold slice (which oversamples the mixed-motive region) at a stated effect size and direction, computed by coders **blind to the ensemble.**
- **Report the survey comparison too** — r(deserved, revenge) — which prereg §6.7 names in the same sentence, as a convergent reference (§7).
- **Judge the word-list check on the realized corpus.** If revenge fires below the ≥5% floor in the full corpus, report the word-list result as **uninformative by base rate**, with the counts, in the results section as an observed limitation — not as disconfirmation of E4. If it clears 5%, it is a live corroborator and it counts, in whichever direction it falls.
- **A near-empty word-list result is not a veto**, because a statistic with no power cannot veto; the prevalence numbers behind that judgment are reported openly rather than assumed. Any *future* lexical corroborator must clear the ≥5% minimum-prevalence check before it is given weight.

**Role in inference:** where the word list *is* a valid leg (facets that clear the coverage floor), per-facet dictionary-vs-ensemble agreement is reported alongside ICC, and systematic disagreement flags a facet's gate result for extra scrutiny.

---

## 7. Agreement and the §6.7 validation gate

Two kinds of number, kept strictly distinct (the prereg's core reliability-vs-validity point).

### Reliability (agreement across the ensemble, per facet per item_type)

- **Facet 0–1 scores:** ICC across the ≥3 models — two-way random, absolute-agreement; report ICC(2,k) for the k-model mean actually used AND ICC(2,1). Threshold ICC ≥ .60.
- **Holistic call:** Krippendorff's alpha (nominal) across models.
- Also report **ensemble↔word-list** agreement (where the ≥5% coverage floor is cleared, §6) and **ensemble↔human** agreement (the headline).

Agreement is **reliability, not validity** — models can share a blind spot, and the desert/revenge line is exactly what the study interrogates, so high ICC alone **never** licenses a claim.

### The validity gate — a union gate

All E3–E7 claims are **exploratory** (prereg §2.4). What the gate decides is whether a facet is **gate-backed (primary)** or **descriptive-only** inside that exploratory family — never whether a test is confirmatory.

A facet may serve as a **gate-backed (primary)** measure **only if ALL hold** (clauses **B** and **C** are the prereg's two; clause **A** is this design's addition and is registered in §0):

- **(A) HUMAN-MATCH:** ensemble-vs-human agreement on the gold set clears the human-match bar — the front gate that makes convergence mean *accuracy*, not shared bias.
- **(B) RELIABILITY:** ensemble ICC ≥ .60 across models (prereg §6.7).
- **(C) EXTERNAL CONSTRUCT VALIDITY:** ensemble facet score correlates r ≥ .30 (word-count-partialled, within-vignette where relevant) with its matching survey scale, AND passes the **discriminant** test below.

### Clause A gates on the CI lower bound and a minimum positive-case count

With revenge/suffering at 0.7–2.5% base rate and a ~275-response gold set split in half, the TEST half holds on the order of ~14 positive cases for the hardest facets; a kappa/ICC on ~14 positives has a 95% CI half-width ≈ ±0.26, so a facet whose *true* human-match is .40 can post a sample .60 and pass by sampling noise.

- **Gate on the LOWER BOUND of the human-match 95% (bootstrap) CI ≥ .60**, not the point estimate.
- **Require a minimum positive-case count per facet** (`n_pos ≥ 30` in the TEST half); below it, the facet is descriptive-only regardless of the point estimate. **Report the preregistered point estimate beside the CI-bound decision.**
- **Use Gwet's AC1 with its analytic SE** for the imbalanced facets and gate on its interval.
- **Report the CI width alongside every human-match number** so a wide-but-lucky pass is visible.

### The discriminant foil is the maximally confusable neighbour, not the orthogonal one

Survey inter-scale structure: `deserved`, `revenge`, and `suffering` are mutually correlated .56–.69; `proportionality_jd` is the lone near-orthogonal scale (r = .05 with `deserved`). Assigning `proportionality_jd` as DESERT's foil is the single **easiest** foil in the matrix — an ensemble that collapsed all negative-valence punishment sentiment into one undifferentiated "this offender should be punished" reading would correlate strongly with `deserved` and weakly with `proportionality`, passing "own > rival" *while being blind to exactly the desert-vs-vengeance distinction the study exists to test.*

- **Report the full facet × scale correlation matrix, and require the diagonal to beat the STRONGEST off-diagonal rival**, not a hand-picked orthogonal one, by a margin fixed in advance (**Δr ≥ .15 with non-overlapping bootstrap CIs**).
- **DESERT must out-correlate the `revenge` and `suffering` scales** (its r ≈ .6 neighbours), not merely `proportionality_jd`. **REVENGE must out-correlate `deserved`.**
- **Partial correlation for revenge.** Revenge-text must predict the survey revenge scale **controlling for** the survey desert scale (and vice versa) with a significant unique component, not merely "own r > proportionality r." Report both partials so shared-retributive-variance passing is auditable.
- **Where two survey scales are themselves collinear (.6+), the survey cannot arbitrate that facet boundary.** State this explicitly and **demote the facet to descriptive-only** — the survey gate cannot certify a distinction the survey itself does not draw. If DESERT text cannot out-correlate the `revenge` scale, that is the real ceiling on the desert-vs-vengeful distinction, and it is surfaced, not defined away.

### Facet → survey-scale map (validators present, zero missing)

| Facet | Primary validator | Discriminant requirement | Gate status |
|---|---|---|---|
| **DESERT** | `deserved` (`Retribution_1..4`) | Must beat `revenge` AND `suffering` scales (its confusable neighbours) by Δr ≥ .15. `retribution` is NOT a valid control (r = .968 — redundant). | Gate-eligible |
| **PROPORTIONALITY** | `proportionality_jd` | **Descriptive-only** — corpus base rate ~1%. The preregistered gate numbers are still computed and reported. | **Descriptive-only** |
| **REVENGE** | `revenge` (`revenge_1..4`) | Must beat `deserved`, with the partial-correlation requirement above. | Gate-eligible |
| **SUFFERING** | `suffering` (`suffer_1, suffer_2`); `degradation`/`harsh` convergent secondaries | Must beat `deserved` by Δr ≥ .15. | Gate-eligible |
| **CENSURE** | **None admissible** (below); consistent with prereg §5.15, which names no anchor | — | **Descriptive-only (permanent)** |
| **MORAL-BALANCE** | **None admissible** (below); consistent with prereg §5.15, which names no anchor | — | **Descriptive-only (permanent)** |

### Proportionality is descriptive-only — *registered deviation, §0*

Only ~10/883 valid texts (1.0%) contain any proportionality cue (backward Q1: 0.3%, one text). A facet present in ~1% of responses cannot yield a stable r ≥ .30 (near-zero predictor variance), a meaningful human IRR (AC1 dominated by the all-zero cell), or the "desert=1, proportionality=0" dissociation logic (no signal to co-occur).

- **Proportionality is descriptive-only.** This is a **deviation**, not housekeeping: prereg §5.15 gives proportionality a named survey anchor and §6.7 applies the same gate to it as to desert, revenge, and suffering. It is **not** in the same position as censure/moral-balance, which the prereg never anchors at all. It goes in the OSF amendment (§0), and the **preregistered proportionality gate numbers (ICC, r with the proportionality item) are computed and reported anyway** so the demotion is auditable.
- **Route no gate-backed E3–E7 claim (including the text-side H6 dissociation) through a facet with <5% corpus prevalence.**
- **Measure the realized ensemble+human base rate on Q1/Q333 before committing.** If <10% nonzero, the desert-vs-proportionality text dissociation is reported as an honest **descriptive null-by-absence** ("participants almost never articulate calibration/bounding language"), not dressed up as a gate-backed orthogonality test. The **survey-side r = .053 stands on its own as the H6 evidence**; the open-ends are not claimed to corroborate it independently.

### Censure and moral balance have ZERO admissible survey anchor — *consistent with the prereg*

Every proposed proxy's strongest correlation is with `deserved`: `society_reject` r = .48 with deserved (vs .003 with proportionality); `exclusion` r = .56; `solidarity_durk` r = .80; and `just_deserts` is literally `rowMeans(deserved, proportionality_jd)` (`01_main_analysis.Rmd`), r = .80 with deserved. Using any of these would **launder the desert scale under a new name and manufacture false convergence.**

- **Censure and moral balance have ZERO admissible survey anchor — not a weak one — and the named proxies are struck.**
- **Report these two facets as descriptive prevalence + ensemble/human IRR ONLY, never correlated against a survey scale.** They contribute no facet↔survey hypothesis test; **where a censure or moral-balance analysis does produce a test statistic (its E6 backward-vs-forward contrast, say), that test enters the single E3–E7 BH-FDR family like every other E3–E7 test.**
- **Prereg status:** having no anchor here is **consistent with prereg §5.15**, which names only four facet→scale mappings (desert, proportionality, revenge, suffering). No amendment needed for this item (§0).
- The real remedy is instrument-side: add dedicated censure (expressive/denunciation) and moral-balance (ledger/debt) closed-ended items to the QSF in a future wave; an anchor cannot be retrofitted from existing scales.

### FDR and circularity

- **One FDR family** (Benjamini-Hochberg) across **the whole of E3–E7**, which prereg §2.4 and §6.7 define as **one exploratory family** ("E3 through E7 form one exploratory family; we control the false discovery rate within it"); effect sizes + bootstrap/95% CIs throughout. **E5 and E6 are inside the family** — including the backward-vs-forward register contrast and any test produced by a descriptive-only facet. Nothing in E3–E7 is labelled confirmatory. The §6.6 non-language exploratory analyses (E1, E2, factor structure, moderators) stay uncorrected, exactly as prereg §6.6 specifies.
- **Circularity.** E7 predicts `Sentence1_z` from **`punitiveness`** (8 self-report items: `punishmore_1_R`, `punishmore_2`, `parsimony_1_R`, `parsimony_2_R`, `threestrikes_1`, `threestrikes_2`, `LWOP`, `deathpenalty`), **NEVER `punitiveness_full`**, which embeds `Sentence1_z` (r = .44 vs .85). The semantic facet measure is never used to **group** participants for E3–E7 (grouping uses `Prioritization_1 == 1` / survey scales).

### The E4 survey benchmark is a convergent reference, not a criterion

E4's text-side desert × revenge correlation is benchmarked against survey r(deserved, revenge) = .551 on N = 948 (.485 on the two literal revenge items, §0). But .61 is high *precisely because* the survey desert and revenge constructs are not cleanly separable — matching an entangled survey correlation with an entangled text correlation is not an independent check, since both instruments may share the same conflation.

- **The survey r is a convergent reference, not a criterion**; matching it cannot on its own establish E4.
- **The primary weight for E4 sits on the human-gold co-occurrence** (§6), where coders separate desert from revenge by codebook rule — reported **alongside**, never instead of, the preregistered word-list co-occurrence. E4 remains an exploratory test inside the E3–E7 family.

---

## 8. The human-coded gold standard, reconciled with the prereg ensemble stance

The gold standard is the **validity head and the headline validation**. Agreement among automated methods — a 5-way cross-method kappa on synthetic sentences, say — is *agreement*, not *accuracy*: at least one measure must be anchored to human judgment on real responses before convergence means anything. The gold set is kept **small, targeted, one-time** — an anchor and calibrator, not a parallel full-corpus effort.

### Sample and stratification

~250–300 responses drawn from the non-blank corpus, stratified on: (a) the survey retribution composite (deciles/tertiles of `deserved`) so the full range is covered; (b) `item_type` (proportional, since register differs); (c) the mixed-motive/boundary region.

### The hard strata are seeded by MODEL-INDEPENDENT routes

The failure mode that would quietly void the whole anchor: if the gold set's hard strata are seeded by the very models they validate, blind-spot cases are never drawn in, so humans never code them, so the human-match check can never detect the blind spot. Convergence with humans on a model-curated sample is accuracy *on the cases the model already found legible*, not on the corpus. Therefore:

- **(a) Draw a stratified RANDOM slice of the full corpus** (not model-flagged) so blind-spot cases have nonzero inclusion probability.
- **(b) Add strata defined by SURVEY signal only** — oversample high-`revenge`/high-`suffering` survey scorers whose open-ends the models score LOW on those facets (**survey-model disagreement cases**), which is exactly where a shared blind spot lives.
- **(c) Have humans do an open read-through of ~50 random responses** to surface vengeful expressions no model or dictionary tagged, and fold those verbatim patterns back in.
- **No stratum may be defined solely by ensemble or embedding output.**

### Coding

≥2 trained coders (a 3rd for adjudication if resources allow) annotate the full 9-facet multi-label scheme (0/1 or 0–2 intensity) plus the holistic call, blind to survey scores and model output. Disagreements are adjudicated to a consensus gold label.

### One coder pass is theory-only / bottom-up, with disjoint anchors

Giving humans the **same** pinned token decisions and the **same** anchor examples as the LLMs imports the shared blind spot straight into the "independent" anchor: if a boundary call in the codebook is itself wrong (e.g. treating "pay for what he did" as pure desert when many writers mean payback), humans and models agree *because they were instructed identically*, and that would be reported as accuracy.

- **At least one coder pass is a bottom-up code first:** coders get the construct **definitions** but **not** the token-level pinned decisions or the LLM anchor set, and resolve boundary cases from the text. Only then are their independent boundary rulings compared with the codebook's.
- **Where independent human boundary calls diverge from the pinned decisions, that divergence is a FINDING about the construct**, not coder error to be trained away.
- **Keep the LLM anchor examples out of the human materials, or use a disjoint anchor set** for humans vs. models, so agreement cannot be an artifact of shared exemplars.

### IRR

Krippendorff's alpha (holistic) and per-facet Cohen's kappa / **Gwet's AC1** (AC1 for prevalence-imbalanced revenge/suffering). Report IRR per facet as human-side reliability, and note which facets are hard for **humans** too (likely censure/moral-balance) — if humans cannot agree on a facet, no automated match can rescue it, and that facet is descriptive-only regardless.

### Three jobs, all one-time

1. **ANCHOR / HEADLINE** — ensemble-vs-human accuracy **per facet** is the headline validation; a facet's automated scorer is licensed to run on the full corpus only after clearing the human-match bar (gate clause A).
2. **SEED** — supply the embedding reference passages and the data-driven word-list expansion.
3. **SPOT-AUDIT** — after full-corpus scoring, re-check on the held-out slice; poor human agreement demotes the facet regardless of ICC.

### One frozen split governs every use of the gold set

The gold set has three colliding jobs (validity criterion, embedding seeds, dictionary expansion), so without a split the same responses that define "correct" would be baked into two convergence streams, making part of the reported agreement trivially true.

- **Partition the gold responses ONCE into a SEED half and a TEST half.**
- **Embedding reference passages and dictionary lexicon expansion draw ONLY from SEED.**
- **The ensemble-vs-human gate (clause A), embedding-vs-human convergence, and dictionary-vs-human convergence are ALL computed ONLY on TEST responses** that contributed nothing to any seed or lexicon.
- **Never report a convergence number for a stream on responses that seeded that stream.**
- **The split assignment goes to OSF before the ensemble is coded** so it cannot be tuned. The rubric's held-out anchors (§4) draw from SEED.

### How the gold standard sits with the prereg's ensemble-as-workhorse

The prereg (§6.7) says coding uses "an ensemble of language models in place of human raters," treats inter-model agreement as reliability, states "we do not treat the ensemble as ground truth," and prescribes no human-coding step. Agreement is not accuracy: methods sharing a blind spot converge with high kappa on the wrong answer.

**The two are reconcilable once reliability and validity are separated, which the prereg already does.** The ensemble does not replace human judgment as the **criterion**; it **scales** it. Humans cannot reliably code the full corpus × 9 facets at production scale, so the ensemble is a **surrogate rater whose license to stand in for humans is a demonstrated match to humans on a stratified gold set.** The gold standard is precisely the missing **middle anchor** between "models agree with each other" (reliability) and "facet tracks the survey scale" (external construct validity): it establishes that models agree with **humans**, which is what "stand in for human raters" must mean.

**Where this design is stricter than the prereg, it takes the union.** The prereg's gate has **exactly two clauses** — "A facet supports a claim only if the models agree at an intraclass correlation of at least .60 **and** the facet correlates at least .30 with its matching survey scale" — and this design requires **A + B + C**. That is a **deviation, registered in §0**, not a reading of the prereg. It **adds** to the prereg rather than **overriding** its ensemble architecture, its two gate clauses (kept unchanged underneath), the ≥3-developer/open-weight requirement, ICC/Krippendorff, the FDR family, or the circularity rule — all kept verbatim. Because E3–E7 are explicitly exploratory and "depend on the validation step in 6.7," strengthening that step with a human anchor is in keeping with the prereg's logic, **but compatibility is not authorization.** The OSF amendment documents the human-coding step, codebook, coder instructions, IRR, human-match thresholds, and the frozen SEED/TEST split, and posts **before scoring begins**. Gold labels + codebook + IRR + thresholds → OSF.

---

## 9. Anti-circularity / anti-double-dip rules

A single consolidated list; each rule also appears in its home section.

1. **The ensemble does not license itself.** Human-match (clause A — this design's addition to the prereg gate, §0) is computed *before* full-corpus scoring; a failing facet is blocked from gate-backed (primary) use regardless of inter-model ICC. (§4, §7)
2. **The E4 pair is scored in separate LLM calls.** Desert and revenge come from independent calls so a joint read cannot manufacture their correlation; joint-vs-split difference is reported as a halo diagnostic; co-occurrence anchors are held out and their effect quantified. (§4)
3. **E4 carries BOTH non-model corroborators.** The preregistered word-list co-occurrence is computed and reported with its counts, CI, and realized prevalence (prereg §6.7 requires it), and the human gold set is **added** as a second, independent corroborator (the registered deviation). Where the word list is near-empty, that is reported as an observed base-rate limitation in the results. (§6, §0)
4. **One frozen SEED/TEST split governs the gold set.** Seeds (embedding refs, lexicon expansion, held-out rubric anchors) draw only from SEED; every convergence and gate number is computed only on TEST. (§8)
5. **Rubric numeric targets are held out of the scored prompt; spans are optional.** Prevents demand/anchoring leakage and lexical-matching bias. (§4)
6. **The holistic "both" call is barred from the E4 evidence family.** Same-pass, same-rater as the facet vector, so it is descriptive coverage only, never corroboration for facet-level co-occurrence. A holistic corroboration, if wanted, must come from a separate call or from the human coders. (§4)
7. **Shared-error diagnostic before trusting the mean.** Signed bias and cross-model error correlation on the gold set; correlated directional error caps a facet's gate-backed use; the open-weight model's standalone verdict is reported separately, never outvoted. (§4)
8. **The no-shared-token assertion is a double-count guard, not proof of construct independence.** Actual response-level facet correlations are measured and reported; contestable tokens are removed from the dictionary, not fiat-routed identically across scorers; a routing-flip sensitivity check is run. (§2)
9. **H6 text-side co-occurrence excludes the dictionary and embedding streams.** Their enforced token/anchor disjointness mechanically depresses joint firing; the H6 text estimate uses only the separately-called LLM ensemble and human gold codes, and reports whether humans *can and do* co-assign desert=1 and proportionality=1. (§7, §10)
10. **Survey benchmarks are convergent references, not independent criteria** where the two survey scales are themselves entangled (E4's survey r = .55; discriminant collinearity). (§7)
11. **Word-count partialling and within-vignette z everywhere**, so verbosity and vignette severity cannot masquerade as facet effects. (§3)
12. **The negation-adjusted dictionary column never feeds a gate.** (§6)

---

## 10. How each facet maps to E3–E7

The five open-ended analyses (numbered per the prereg). **Prereg §2.4: "E3 through E7 are exploratory and depend on the validation step in Section 6.7." Prereg §6.7: "E3 through E7 form one exploratory family; we control the false discovery rate within it."** So all five are exploratory, and all five sit inside one BH-FDR family — E5 and E6 included. The gate (§7) decides only whether a facet is *gate-backed (primary)* or *descriptive-only* within that family.

### E3 — Open-ends distinguish ranking-defined retributivists from others
Compare **facet intensities** between ranking-defined retributivists (`Prioritization_1 == 1`) and others, on **Q333 and Q1 separately, never pooled.** Leads on gate-passing facets (DESERT, REVENGE, SUFFERING). Agreement between the two backward items is a within-study replication. **Exploratory; gate-backed; inside the single E3–E7 BH-FDR family.**

### E4 — Within-person co-occurrence of principled desert and vengeful revenge
The within-person desert↔revenge correlation, from **independently-called** ensemble facet scores (§4). Corroboration is **both** the **preregistered non-model word list** (prereg §6.7's named corroborator — computed and reported with its counts, CI, and realized prevalence) **and** the **added human gold set** (§6), the latter computed by coders blind to the ensemble at an effect size and direction fixed in advance. The survey r = .61 is a convergent reference, not a criterion (§7). The holistic "both" rate is descriptive only (§9). **Exploratory; gate-backed; inside the single E3–E7 BH-FDR family.**

### E5 / text-side H6 — Does text-proportionality travel with text-desert?
The survey side (r = .053, orthogonal) **is** the H6 evidence and stands on its own. Because proportionality has ~1% textual base rate (§7) and the dictionary/embedding streams enforce token/anchor disjointness that mechanically depresses joint firing, the **text-side** co-occurrence claim is restricted to the **separately-called LLM ensemble plus the human gold codes**, and the dictionary and embedding streams are **excluded** from the H6 estimate. **Verify on the human gold set that coders CAN and sometimes DO assign desert=1 and proportionality=1 to the same response** (report that base rate); if humans essentially never co-assign them, the text-side H6 is reported as a **descriptive null-by-absence**, not a gate-backed orthogonality test. **Exploratory; descriptive-only facet (proportionality is not gate-eligible — registered deviation, §0); still INSIDE the single E3–E7 BH-FDR family wherever it yields a test statistic.**

### E6 — Backward-vs-forward register shift
Within-person `delta_f = facet(backward) − facet(forward)`; retributive facets predicted to peak on Q1/Q333, consequentialist goals on Q2. A construct-validity check independent of the survey. **Exploratory; INSIDE the single E3–E7 BH-FDR family** (prereg §6.7 puts E3 through E7 in one family). Descriptive-only facets (censure, moral-balance, proportionality) may appear here; their tests are corrected with the rest.

### E7 — Do retributive facets predict the sentence beyond self-reported punitiveness?
Predict `Sentence1_z` from the gate-passing facets **beyond `punitiveness` (8 self-report items) — NEVER `punitiveness_full`** (§7, circularity). Also test whether revenge/suffering language predicts `Shark_3` and the sentence (prereg §6.7 asks for both). Within-vignette z consumed from Track 1. **Exploratory; gate-backed; inside the single E3–E7 BH-FDR family.**

### Facet → E-number quick map

**Every cell below is exploratory (prereg §2.4) and every test it produces enters the one E3–E7 BH-FDR family (prereg §6.7).** "Gate-backed" vs. "descriptive-only" is a statement about the facet's validation standing, not about a test's confirmatory status.

| Facet | Facet standing | E3 | E4 | E5/H6 | E6 | E7 |
|---|---|---|---|---|---|---|
| DESERT | gate-backed | ✓ | ✓ (principled leg) | ✓ (desert side) | ✓ | ✓ |
| PROPORTIONALITY | descriptive-only (*registered deviation*, §0) | — | — | ✓ descriptive | ✓ | — |
| REVENGE | gate-backed | ✓ | ✓ (vengeful leg) | — | ✓ | ✓ (→Shark_3, sentence) |
| SUFFERING | gate-backed | ✓ | (vengeful leg, secondary) | — | ✓ | ✓ (→Shark_3, sentence) |
| CENSURE | descriptive-only (*consistent with prereg §5.15*) | descriptive | — | — | ✓ | — |
| MORAL-BALANCE | descriptive-only (*consistent with prereg §5.15*) | descriptive | — | — | ✓ | — |
| deterrence / incapacitation / rehabilitation | convergent sanity check | — | — | — | ✓ (forward-peaking) | — |

---

## 11. Open decisions for the team

1. **Model roster + versions.** Confirm the exact ≥3 current models and pin every dated version string (the Dark Side IDs are ~1 yr old). Which Anthropic tier (above Haiku)? Which second-developer proprietary model (OpenAI vs Google)? Which open-weight model (Llama-3.x-70B vs Qwen2.5-72B) and via what endpoint (hosted vs Colab GPU)?
2. **The OSF amendment (§0).** *Drafted: `Retribution/Docs/Preregistration/Retribution Study -- OSF Addendum, language analysis, DRAFT.md`; posting is the remaining step.* The prereg prescribes no human-coding step and states a two-clause gate, so the human gold standard, gate clause A, the proportionality demotion, the ≥5% word-list coverage rule, the tightened clause C, the CI-bound/`n_pos` gating, and the E4 split-call scoring **all belong in the amendment**. Open only: *who drafts it* and *when it posts* — and it must post **before** any ensemble scoring or human coding begins.
3. **Gold-standard size, strata, and coders.** *Moot while the human arm is off (§0 row 2).* Is ~250–300 stratified responses with 2 coders enough to anchor 9 facets × 3 item_types, or does the mixed/high-desert stratum need oversampling to ~350 and/or a 3rd coder for a defensible alpha? Confirm the **model-independent seeding routes** (§8) and the **minimum positive-case count** (§7) for revenge/suffering.
4. **Human-match threshold (gate clause A).** *Moot while the human arm is off (§0 row 2).* Ratify the bar (proposed: CI **lower bound** ≥ .60 with `n_pos ≥ 30` in TEST, §7) and decide the fate of a facet that clears model ICC but fails the human match: descriptive-only, or dropped.
5. **Strictness of the gate union.** *Moot while the human arm is off: the gate is B + C with the §0 tightenings.* Ratify that a **gate-backed (primary)** facet requires **all** of A (human-match) + B (reliability) + C (discriminant survey gate), rather than the prereg gate (B+C) alone — noting this is a registered deviation (§0), with B and C reported in their preregistered form alongside the stricter union.
6. **CENSURE and MORAL-BALANCE.** Accept as **permanently descriptive-only** (no admissible survey anchor, §7; the named proxies are struck) — **consistent with prereg §5.15**, whose only four facet→scale mappings are desert, proportionality, revenge, and suffering — or commit to adding dedicated closed-ended items to the QSF in a future wave. No amendment needed either way for the absence of an anchor.
7. **PROPORTIONALITY status.** Ratify the demotion to descriptive-only (§7) given the ~1% textual base rate — this **is** a deviation (prereg §5.15 anchors proportionality and §6.7 gates it like the other three), so it goes in the amendment — and agree to (a) report the preregistered proportionality gate numbers anyway and (b) report the desert-vs-proportionality text result as a descriptive null-by-absence if the realized Q1/Q333 base rate is <10%.
8. **Discriminant-foil rule.** Ratify that each facet's foil is its **maximally confusable** neighbour (DESERT beats revenge/suffering; REVENGE beats desert with a partial-correlation requirement), Δr ≥ .15 with non-overlapping bootstrap CIs, and collinear-scale demotion (§7).
9. **E4 elicitation and corroboration.** Ratify separate-call scoring of the desert/revenge pair (§4, a deviation from prereg §6.7's single-pass wording) and the **addition** of the human gold set as a second non-model corroborator (§6); set the effect size and direction that count. **Not open:** the preregistered word-list corroboration and the survey comparison are run and reported regardless.
10. **Facet score representation.** *Settled (§0, the presence row): continuous means for every test; two fixed presence definitions for counts only.* Keep 0–1 continuous means across models (proposed), or also threshold to binary presence for co-occurrence tests (and set the threshold)? Confirm the ensemble **mean** is the score of record, with embedding/word-list as reported convergence (no fitted triangulation weights).
11. **Negation depth.** Confirm the whitelist zero-out (§6, no sign-flip, excluded from gates); stance/critique cases left to the LLM + humans.
12. **Analysis unit / nesting for E4–E6.** Responses nested within participant (3 items) and within 3 vignettes. Decide: participant-level aggregates, mixed models with random intercepts, or item-level with clustered SEs; and how vignette enters (fixed effect vs. the within-vignette z already applied to the sentence).
13. **Multiple-comparison scope — settled by the prereg.** "E3 through E7 form one exploratory family; we control the false discovery rate within it" (§6.7), and "E3 through E7 are exploratory" (§2.4). **All of E3–E7 — E5 and E6 included, and any test produced by a descriptive-only facet — go in one BH-FDR family, and none of them is confirmatory.** The genuinely open item is the *unit* each test contributes at (§11.12), which determines how many p-values the family holds.
14. **OSF release scope.** Confirm all raw per-model JSON, prompts, word lists, embedding reference sets, gold-standard labels + IRR, the frozen SEED/TEST split assignment, and the gate table are posted, and that verbatim participant text is cleared for de-identification.
