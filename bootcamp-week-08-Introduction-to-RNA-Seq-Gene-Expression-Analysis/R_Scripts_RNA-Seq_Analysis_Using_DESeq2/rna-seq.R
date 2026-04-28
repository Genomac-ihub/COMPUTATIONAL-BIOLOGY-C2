
# Install required packages from Bioconductor and CRAN

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

# Install Bioconductor packages
BiocManager::install(c(
  "TCGAbiolinks",
  "SummarizedExperiment",
  "DESeq2",
  "biomaRt",
  "EnhancedVolcano"
))

# Install CRAN packages
install.packages(c("ggplot2", "dplyr", "pheatmap"))

# Load required libraries
library(TCGAbiolinks)            # Access and download GDC/ TCGA
library(SummarizedExperiment)    # Work with expression dataset
library(DESeq2)                  # Perform differential gene expression analysis
library(biomaRt)                 # Map Ensembl IDs to gene symbols
library(ggplot2)                # Visualisation
library(dplyr)                  # Data manipulation, filtering, etc
library(pheatmap)               # Generate heatmaps
library(EnhancedVolcano)        # Create volcano plots

## -----------------------------------------------
##    Step 1:  Query and Download RNA-seq Data
## -----------------------------------------------


# Using the TARGET-ALL-P2 project (Lymphoid Leukemia)
query <- GDCquery(
  project = "TARGET-ALL-P2",
  data.category = "Transcriptome Profiling",
  data.type = "Gene Expression Quantification",
  sample.type = c("Primary Blood Derived Cancer - Bone Marrow", "Recurrent Blood Derived Cancer - Bone Marrow")
)


GDCdownload(query)

# Prepare it as a SummarizedExperiment object
expression_data <- GDCprepare(query)

# --------------------------------------------
# Step 2: Inspect Expression Matrix
# --------------------------------------------


counts <- assay(expression_data)


# Take a look at the count matrix
head(counts)  # show first few genes and samples   
View(counts)    # View in spreadsheet format (genes are rows, samples are columns) 


# --------------------------------------------
# Step 3: Prepare Sample Metadata
# --------------------------------------------

# Get sample metadata
sample_metadata <- as.data.frame(colData(expression_data))
sample_metadata$barcode_short <- substr(sample_metadata$barcode, 1, 16) # trim barcode for mapping

# Assign sample type to a new column
sample_metadata$group <- sample_metadata$sample_type
table(sample_metadata$group)   # count how many samples are primary vs recurrent


# Select 25 samples from each group
primary_samples <- sample_metadata %>% filter(group == "Primary Blood Derived Cancer - Bone Marrow") %>% head(25)
recurrent_samples <- sample_metadata %>% filter(group == "Recurrent Blood Derived Cancer - Bone Marrow") %>% head(25)


# Combine both into one metadata table
selected_metadata <- rbind(primary_samples, recurrent_samples)
selected_barcodes <- selected_metadata$barcode


# Create group labels: "Primary" or "Recurrent"
selected_metadata$group_label <- ifelse(grepl("Primary", selected_metadata$group), "Primary", "Recurrent")


counts_subset <- counts[, selected_metadata$barcode]


## -----------------------------------------------
##         Step 4: DESEQ2 DIFFERENTIAL ANALYSIS
## -----------------------------------------------

View(counts_subset)

# Check for and remove genes with all-zero counts
counts_subset <- counts_subset[rowSums(counts_subset) > 0, ]

# Create a group factor
colData_df <- data.frame(row.names = colnames(counts_subset), group = factor(selected_metadata$group_label))

# Create DESeq2 dataset
dds <- DESeqDataSetFromMatrix(countData = counts_subset, colData = colData_df, design = ~ group)

# View the DESeq object
dds


# --------------------------------------------
# Step 5: Run DESeq2
# --------------------------------------------


# this performs normalisation, dispersion/ size factor estimation and the differential testing
dds <- DESeq(dds)

# Get differential expression results for recurrent vs primary
res <- results(dds, contrast = c("group", "Recurrent", "Primary"))

# Install Bioconductor package: apeglm
BiocManager::install("apeglm")

# Shrink large fold changes
res <- lfcShrink(dds, coef="group_Recurrent_vs_Primary", type="apeglm")

# Since unable to install apeglm, let's try the 'normal' method
res <- lfcShrink(dds, coef="group_Recurrent_vs_Primary", type="normal")



# --------------------------------------------
# Step 6: Inspect Results
# --------------------------------------------

# View the top DE genes
head(res)
View(as.data.frame(res))

nrow(res) #57,127 genes

# Clean gene IDs by removing the version numbers
rownames(res) <- gsub("\\..*", "", rownames(res))

# Filter significant DE genes
res_sig <- res[!is.na(res$padj) & res$padj < 0.05 & abs(res$log2FoldChange) > 1, ]
nrow(res_sig)  # 19,559 genes

head(res_sig)

# Save the results
write.csv(as.data.frame(res_sig), "DESeq2_sig_results.csv")

## -----------------------------------------------
##        Step 7: BIOMART GENE SYMBOL ANNOTATION
## -----------------------------------------------


mart <- useMart("ensembl", dataset = "hsapiens_gene_ensembl")

# fetch gene symbols
annot <- getBM(
  attributes = c("ensembl_gene_id", "hgnc_symbol"),
  filters = "ensembl_gene_id",
  values = rownames(res_sig),
  mart = mart
)

head(annot)
# Merge annotation with results
res_sig$ensembl_gene_id <- rownames(res_sig)

res_annotated <- merge(as.data.frame(res_sig), annot, by = "ensembl_gene_id", all.x = TRUE)

res_annotated <- res_annotated[!is.na(res_annotated$hgnc_symbol), ]

# check what type 

str(res_annotated$hgnc_symbol)
res_annotated$hgnc_symbol <- make.unique(res_annotated$hgnc_symbol)
rownames(res_annotated) <- res_annotated$hgnc_symbol
res_annotated$hgnc_symbol <- NULL

write.csv(res_annotated, "DESeq2_results_with_symbols.csv")


# --------------------------------------------
# Step 8: Extract Upregulated and Downregulated Genes
# --------------------------------------------

# Upregulated genes
upregulated <- res_annotated[res_annotated$log2FoldChange > 1 & res_annotated$padj < 0.05, ]
write.csv(upregulated, "upregulated_genes.csv")

View(upregulated)

# Downregulated genes
downregulated <- res_annotated[res_annotated$log2FoldChange < -1 & res_annotated$padj < 0.05, ]
write.csv(downregulated, "downregulated_genes.csv")

View(downregulated)

cat("Number of upregulated genes:", nrow(upregulated), "\n")   # 7593
cat("Number of downregulated genes:", nrow(downregulated), "\n")  # 11583

up_gene_names <- rownames(upregulated)
down_gene_names <- rownames(downregulated)

View(up_gene_names)

## -----------------------------------------------
##      Step 9: DATA INTEGRITY CHECKS
## -----------------------------------------------

# Check NA and zero counts
sum(is.na(counts_subset))  # any missing values?
sum(counts_subset == 0)     # how many zeros


boxplot(log2(counts_subset + 1), las = 2, main = "Raw log2(counts)")




## -----------------------------------------------
##     Step 10: VISUALIZATION
## -----------------------------------------------


EnhancedVolcano(
  res_annotated,
  lab = rownames(res_annotated),
  x = 'log2FoldChange',
  y = 'padj',
  pCutoff = 0.05,
  FCcutoff = 1,
  title = 'Volcano Plot: Recurrent vs Primary',
  xlim = c(-3, 3)
)
dev.off()


head(rownames(counts_subset))

rownames(counts_subset) <- gsub("\\..*", "", rownames(counts_subset))


# Use the Ensembl IDs instead of gene symbols
# top 50 genes for heatmap
top_ensembl <- res_annotated$ensembl_gene_id[order(abs(res_annotated$log2FoldChange), decreasing = TRUE)[1:50]]
heatmat <- counts_subset[top_ensembl, ]


# top 50 genes for heatmap


heatmat <- as.matrix(heatmat)
annotation_col <- data.frame(Group = selected_metadata$group_label)
rownames(annotation_col) <- colnames(heatmat)

pheatmap(heatmat,
         scale = "row",
         show_colnames = FALSE,
         clustering_distance_rows = "euclidean",
         annotation_col = annotation_col,
         main = "Top 50 DE Genes Heatmap")

