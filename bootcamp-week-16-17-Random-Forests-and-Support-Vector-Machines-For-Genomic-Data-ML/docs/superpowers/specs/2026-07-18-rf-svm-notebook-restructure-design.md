# Design: Restructure Notebook — Random Forests & SVMs for Genomic Data

**Date:** 2026-07-18
**File:** `random_forests.ipynb` (to be restructured; may rename conceptually to cover RF + SVM)

## Goal

Restructure the existing Random Forest notebook into a beginner-friendly,
concepts-first curriculum that teaches **both Random Forests and Support Vector
Machines** for CNV/mutation classification. Target audience: **biologists with
no ML background** (though they have already been taught the basics of ML and
logistic regression in prior sessions).

## Audience Context (from user)

- ML fundamentals ("what is ML", supervised learning) **already taught** — do NOT re-explain.
- Logistic regression **already taught with demos** — do NOT re-teach the concept.
- Linear regression's unsuitability for classification has **NOT** been covered — this is a key new teaching moment.
- Depth: **balanced** — clear explanations with light math where it aids understanding.

## Data

`synthetic_cnv_mutation_data.csv`: 600 samples, 41 columns:
- `CNV_1..CNV_20` — continuous (copy-number log-ratio style values)
- `MUT_1..MUT_20` — binary (0/1 mutation presence)
- `Outcome` — binary target (disease vs. no disease)

Task type: **binary classification**.

## Known Bug to Fix

The current notebook references `feature_names`, `n_mut_features`, and
`n_features` in cells that plot EDA and build the train/test split, but these
variables are **never defined** — the notebook crashes on a clean run. The
restructure must define them explicitly after loading the data.

## Structure

### Part 0 — ML Foundations for Biologists (mostly new)
1. **Brief** classification-vs-regression refresher (frame our task as classification). Short — not a full lesson.
2. **Why linear regression is unsuitable** — markdown explanation + runnable demo:
   fit `LinearRegression` to the 0/1 outcome, show predictions falling below 0 /
   above 1, no probability interpretation, sensitivity to distance from boundary.
3. Logistic regression: **not re-taught**. Referenced only, and fit once in Part 1
   as a baseline score for comparison.
4. **RF vs. SVM intuition** — two philosophies in plain English (ensemble of tree
   rules vs. widest-margin boundary), light markdown diagram.

### Part 1 — Shared Setup
5. Imports (add SVM, scaling, pipeline, logistic regression imports).
6. Data loading + **define `feature_names`, `n_mut_features`, `n_features`** (bug fix).
7. EDA (kept, cleaned): class balance, mutation frequencies, CNV distributions, with existing biological interpretation.
8. Train/test split (stratified, kept).
9. **Logistic regression baseline** — one fit, record AUC (no concept re-teach).

### Part 2 — Random Forest Track
10. How RF works: bagging + decision trees, balanced depth, biology analogy.
11. Train baseline RF, evaluate (classification report, ROC-AUC, confusion matrix, ROC curve).
12. Hyperparameter tuning: GridSearch (kept) with **param-by-param explanation**
    (`n_estimators`, `max_depth`, `max_features`) + shared concept box on
    cross-validation / overfitting-vs-underfitting.
13. Feature importance: Gini + permutation (kept), with biological interpretation.

### Part 3 — Support Vector Machine Track
14. How SVM works: margin, support vectors, "widest street" analogy (light math for margin).
15. Linear vs. non-linear boundaries → **kernel trick** (RBF), what `gamma` does.
16. **Why scaling matters for SVM but not RF** — `Pipeline(StandardScaler -> SVC)`.
17. Train baseline SVM (`SVC(probability=True)`), evaluate (same metrics as RF).
18. Hyperparameter tuning: GridSearch over `C`, `gamma`, `kernel` on the scaled pipeline,
    with param-by-param explanation (`C` = margin softness, `gamma` = kernel reach).

### Part 4 — Head-to-Head
19. Comparison table: Logistic baseline vs. RF vs. SVM — AUC, interpretability,
    scaling needs, feature importance availability, when to pick which.
20. Revised assignments.

## Conventions

- Every code cell preceded by a plain-English markdown cell ("What this does / What to look for").
- Biology↔ML connections as markdown blockquote callout boxes.
- Keep existing seaborn/matplotlib plotting style.
- `SVC(probability=True)` so ROC-AUC is consistent across all models.
- `random_state=42` throughout for reproducibility.
- Balanced math: show the margin and kernel ideas with light notation, avoid heavy derivations.

## Out of Scope (YAGNI)

- Re-teaching "what is ML" or logistic regression concepts.
- Deep neural networks / other model families.
- Deriving SVM optimization (dual form, Lagrangians) — too advanced for audience.
- Renaming the file / repo restructuring beyond the notebook.

## Success Criteria

- Notebook runs top-to-bottom on a clean kernel with no undefined-variable errors.
- A biologist with no ML background can follow why linear regression fails, how RF
  and SVM work, and how to tune both.
- Both models trained, tuned, and compared on the same data with the same metrics.
