# 🧬 Week 18: Neural Networks & CNNs for DNA Sequences

Welcome to **Week 18** of the Computational Biology Bootcamp!
This week we step into **deep learning** — but gently, and *building directly on the
models you already know* (logistic regression and random forests).

## 📚 Overview

We use the classic **UCI Molecular Biology (Splice-junction Gene Sequences)** dataset.
Each example is a 60-base DNA window, and the task is to classify it as:

- **EI** — an Exon→Intron boundary (a *donor* splice site)
- **IE** — an Intron→Exon boundary (an *acceptor* splice site)
- **N**  — Neither

The notebook is built with **PyTorch** (for the neural networks) and **scikit-learn**
(for the baselines and metrics). Everything runs on **CPU in ~15 seconds**.

## 🎯 The learning arc (the whole point)

> **logistic regression = one neuron → stack neurons into a network (MLP) → give the
> network a "motif scanner" (CNN)**

Every model is trained on the *same* splice data and compared honestly:

| Step | Model | Big idea |
|------|-------|----------|
| 1 | Logistic regression | **one neuron** = weighted sum → activation |
| 2 | Random forest | strong classical **baseline to beat** |
| 3 | MLP | a network is **neurons stacked in layers** |
| 4 | 1D CNN | a **filter is a learned motif detector** that scans the sequence |
| 5 | — | **overfitting** (train vs. validation gap) and how to curb it |
| 6 | — | the same recipe powers **mutation / variant-effect** prediction |

## 🔧 Topics Covered

- 🧬 **Biology first**: exons/introns, donor/acceptor sites, why *local* motifs carry signal
- 🔢 **One-hot encoding** of DNA (including IUPAC ambiguity codes → uniform 0.25)
- 🧩 **Neural network foundations**: neurons, layers, activations, loss, optimizer, epochs
- 🔄 **Convolutional layers**: filters/kernels as learned motif detectors, feature maps, pooling
- ⚠️ **Overfitting & regularization**: train-vs-validation curves, dropout, early stopping
- 📊 **Honest evaluation**: confusion matrix and per-class precision/recall on imbalanced data

## 📈 Results (executed, CPU)

On a stratified 25% test split (data is imbalanced — N ≈ 52% majority baseline):

| Model | Test accuracy |
|-------|---------------|
| Random Forest | 0.957 |
| 1D CNN (motif scanner) | 0.950 |
| Logistic Regression (1 neuron) | 0.936 |
| MLP (neural net) | 0.922 |
| Majority-N baseline | 0.519 |

**An honest lesson:** on this small, fairly linear dataset the models land *close
together* — deep learning is **not automatically better**. Its advantage grows with longer
sequences, more data, and subtler motifs. The CNN's real win here is *conceptual*: it
learns position-independent motif detectors from raw sequence with no feature engineering —
the same machinery that scales up to genome-wide models (DNABERT, Enformer, ...).

## 🧪 Assignment

1. **Dataset preparation** — load `splice.data`; one-hot encode the sequences (mind the
   ambiguity codes).
2. **Build & train** — reproduce the logreg/RF baselines, then an MLP and a 1D CNN.
3. **Evaluate honestly** — report a confusion matrix and per-class precision/recall/F1,
   not just accuracy. Compare every model against the majority-class baseline.
4. **Experiment** — add `nn.Dropout` or change the CNN `kernel_size` (a wider filter = a
   longer motif) and explain what happens to the train-vs-validation curve.

## ✅ Key Takeaways

- A **neuron is logistic regression**; a **network** is neurons stacked in layers; a **CNN**
  adds filters that scan for local motifs — a perfect match for DNA.
- On imbalanced genomic data, **accuracy alone lies** — always read the confusion matrix.
- **Overfitting** is visible as a train-vs-validation gap; dropout and early stopping curb it.
- The same **encode → convolve → classify** recipe underlies **variant-effect prediction**
  and scales up to RNNs and Transformers in modern genomics.

---

Happy coding and exploring deep learning!
*— The Bootcamp Team*
