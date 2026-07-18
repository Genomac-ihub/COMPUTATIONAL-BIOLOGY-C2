# 🌲🔷 Weeks 16–17: Random Forests & Support Vector Machines for CNV & Mutation Analysis

Welcome to Weeks 16–17 of the Computational Biology Bootcamp!
These weeks we cover two workhorse machine-learning models for genomic data —
**Random Forests** and **Support Vector Machines (SVMs)** — and apply them to
**copy number variation (CNV)** and **mutation** data.

The notebook is written for **biologists who are new to machine learning**: the
maths is kept light, every code cell has a plain-English explanation above it, and
each result is tied back to the underlying biology.

---

## 📚 Overview

Biological datasets are often **noisy and high-dimensional**, which makes simple
models prone to overfitting — and makes ordinary linear regression the *wrong tool*
for yes/no questions like "does this patient have the disease?"

- **Random Forests** — an ensemble of decision trees — give **robustness** to noise,
  **strong predictive power** by averaging many weak learners, and **feature importance**
  to highlight which genomic features matter.
- **Support Vector Machines** — find the single boundary with the **widest margin**
  between classes, can bend that boundary with the **kernel trick**, and shine when the
  classes are separable (after proper feature scaling).

We compare both against a familiar **logistic-regression baseline** to see when the
extra complexity is worth it.

---

## 🎯 Learning Objectives

By the end of these weeks, you should be able to:

- ✅ Explain **why linear regression is unsuitable** for classification, and how logistic regression fixes it
- ✅ Train and evaluate **Random Forest** and **SVM** classifiers on genomic data
- ✅ Understand **how each model works** (bagging & trees vs. margins & kernels)
- ✅ Know **why SVMs need feature scaling** but Random Forests don't
- ✅ Perform **hyperparameter tuning** for both models with cross-validation
- ✅ Assess **feature importance** to identify key biological signals
- ✅ **Compare models** and choose the right one for the biological question

---

## 🔧 Topics Covered

- ❌ Why linear regression breaks on yes/no outcomes (with a runnable demo)
- 🌱 Ensemble methods and decision-tree mechanics (bagging)
- 🌲 Random Forest training, tuning (`n_estimators`, `max_depth`, `max_features`)
- 🔷 SVM margins, support vectors, and the kernel trick (`C`, `gamma`, `kernel`)
- ⚖️ Feature scaling with `StandardScaler` + `Pipeline`
- 📊 Feature importance (Gini & permutation) in CNV & mutation datasets
- 🏆 Head-to-head model comparison with ROC-AUC

---

## 🧪 Assignment

📢 **Assignment Instructions:**

1. Load the provided CNV/mutation dataset.
2. Train **both** a Random Forest and an SVM to predict the disease outcome.
3. Tune the hyperparameters of each model with cross-validation.
4. Evaluate the models (accuracy, ROC-AUC, confusion matrix).
5. Generate and interpret a **feature importance plot** — which features are biologically meaningful?
6. Compare the models (and the logistic baseline) and justify which you'd choose.
7. Write a short PDF report with your findings.
   - Save as:
     ```
     Assignment-week16-17-done.pdf
     ```
8. Push your completed assignment to your branch on GitHub.

The full set of exercises is at the end of `random_forests.ipynb`.

---

## ⚙️ Environment

Run the notebook with a Python environment that has `scikit-learn`, `pandas`,
`numpy`, `matplotlib`, and `seaborn` installed (developed and tested against
scikit-learn 1.9).

---

> **Tip:** Random Forests excel at **messy, high-dimensional data** and stay
> interpretable via feature importance. SVMs can draw sharp boundaries but need
> careful scaling and tuning. Always reconnect predictions back to the biology.

Happy analyzing!
— The Bootcamp Team
