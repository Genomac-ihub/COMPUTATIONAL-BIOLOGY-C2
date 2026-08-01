**📊 Week 19: Comparative Model Evaluation & Statistical Analysis**  
Welcome to **Week 19** of the Computational Biology Bootcamp!  
   
 This week focuses on **evaluating machine learning models rigorously** and performing  **statistical analysis** to compare their performance across datasets and cancer types.  
![](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAnEAAAACCAYAAAA3pIp+AAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAANUlEQVR4nO3OMQ2AABAAsSPBCj7fFjsymJHAjAU2QtIq6DIzW7UHAMBfnGt1V8fXEwAAXrsexNkF4H1/HJoAAAAASUVORK5CYII=)  
**📚 Overview**  
Building models is only half the journey — the real challenge lies in **evaluating them correctly**.  
   
 In genomics and cancer research, one model may outperform another on a given dataset, but we need **multiple metrics and statistical validation** to ensure the results are meaningful.  
This module covers:  
- Core **performance metrics**: Accuracy, Precision, Recall, F1-score, and AUC-ROC  
- **Cross-cancer comparisons**: How models generalize across different tumor datasets  
- **Statistical tests**: Assessing whether differences in performance are statistically significant  
![](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAnEAAAACCAYAAAA3pIp+AAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAANElEQVR4nO3OQQmAABRAsad4EjtY9fewnUms4E2ELcGWmTmrKwAA/uLeqrU6vp4AAPDa/gDzWAM6QQXRdAAAAABJRU5ErkJggg==)  
**🎯 Learning Objectives**  
By the end of this module, you should be able to:  
- ✅ Compute and interpret **multiple evaluation metrics** for genomic prediction tasks  
- ✅ Generate and analyze **ROC and Precision-Recall curves**  
- ✅ Perform **cross-cancer model comparisons** to assess generalizability  
- ✅ Use **statistical significance testing** (e.g., paired t-tests, Wilcoxon tests) to validate model differences  
![](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAnEAAAACCAYAAAA3pIp+AAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAANUlEQVR4nO3OQQmAABRAsSd4NIGBzPXBmAawhhW8ibAl2DIze3UGAMBf3Gu1VcfXEwAAXrsehaQEN+8fLHEAAAAASUVORK5CYII=)  
**🔧 Topics Covered**  
- 📈 **Evaluation Metrics**: Why accuracy alone can be misleading in imbalanced data  
- 📉 **Precision vs. Recall**: Trade-offs in mutation and variant detection tasks  
- 📊 **ROC & AUC**: Visualizing separability of classes  
- 🔄 **Cross-Cancer Evaluation**: Testing models across heterogeneous datasets  
- 🧮 **Statistical Analysis**: Determining whether model performance improvements are real or due to chance  
![](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAnEAAAACCAYAAAA3pIp+AAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAANklEQVR4nO3OQQmAABRAsSeYxZw/lieLGMACBrCCNxG2BFtmZquOAAD4i3Ot7mr/egIAwGvXA6fGBdgoVMwYAAAAAElFTkSuQmCC)  
|  
**🧪 Assignment**  
📢 **Assignment Instructions**  
1. **Model Comparison**  
  - Train at least **two models** (e.g., Logistic Regression, Random Forest, SVM, CNN).  
  - Evaluate them on the same dataset using Accuracy, Precision, Recall, F1, and AUC-ROC.  
2. **Visualization**  
  - Plot **ROC and Precision-Recall curves** for each model.  
  - Highlight key differences in performance.  
3. **Cross-Cancer Generalization**  
  - Apply your trained models to at least **one additional dataset** (different cancer type).  
  - Compare performance shifts across datasets.  
4. **Statistical Testing**  
  - Use a statistical test (paired t-test or Wilcoxon signed-rank test) to determine if observed differences in model performance are significant.  
5. **Report Writing**  
  - Summarize metrics, curves, statistical test results, and interpretation.  
  - Discuss why multiple metrics are necessary and how significance testing supports conclusions.  
6. **Submission**  
  - Save your report as:  
  - Assignment-week19-done.pdf  
   
  - Push to your branch on GitHub.  
![](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAnEAAAACCAYAAAA3pIp+AAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAANklEQVR4nO3OQQmAABRAsSfYxZo/kSGMYQLPJrCCNxG2BFtmZquOAAD4i3Ot7mr/egIAwGvXA4qrBdGuSdJuAAAAAElFTkSuQmCC)  
**✅ Key Takeaways**  
- A **single metric** cannot fully capture model performance, especially with  **imbalanced datasets**.  
- **ROC curves and AUC** provide insight into classifier separability.  
- **Cross-cancer evaluation** tests the robustness and generalizability of models.  
- **Statistical tests** are essential to confirm that performance differences are  **real, not random**.  
![](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAnEAAAACCAYAAAA3pIp+AAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAANUlEQVR4nO3OMQ2AUBBAsUeCE4yeIiT9CRVMWGAjJK2CbjNzVGcAAPzF2qu7Wl9PAAB47XoA/vcF8exqpY4AAAAASUVORK5CYII=)  
Keep questioning, comparing, and validating — rigorous evaluation is the heart of computational biology research.  
   
 *— The Bootcamp Team*  
