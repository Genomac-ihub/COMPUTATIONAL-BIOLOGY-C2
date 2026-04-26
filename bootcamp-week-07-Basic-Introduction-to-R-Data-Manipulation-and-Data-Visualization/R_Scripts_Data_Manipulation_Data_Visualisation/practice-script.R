# set working directory
setwd('/home/reyes/COMPUTATIONAL-BIOLOGY-C2/bootcamp-week-07-Basic-Introduction-to-R-Data-Manipulation-and-Data-Visualization/')
# check working directory
getwd()

# loading data
# 1. load the packages to use
# install.packages('devtools')
library(tidyverse)

# 2. load the data
biodata <- read_csv('gene_expression_data.csv')
# ============================================================================
# PRELIMINARY DATA EXPLORATION
# 3. Show the structure of the dataset
str(biodata)

# 4. get summary of the data
summary(biodata)
# ============================================================================
# DATA TRANSFORMATION AND MANIPULATION
subdata_select <- select(biodata, Gene, Sample_1)
subdata_rename_ <- rename(subdata_select, Expression_Level = Sample_1)

# view selection
head(subdata_select)
# view transformed column
head(subdata_rename)

# filtering rows
protein_genes <- filter(biodata, Biotype == "protein_coding")
print(protein_genes)
# filtering - get only highly expressed genes in a sample
high_expressed <- filter(biodata, Sample_1 > 7.2)
print(high_expressed)
head(high_expressed)

# creating new data columns
biod <- mutate(biodata, Avg_Expr = (Sample_1 + Sample_2 + Sample_3) / 3)
head(biod)
# alternative method
biod_new <- mutate(biodata, Avg_Expr = rowMeans(across(c(Sample_1, Sample_2, Sample_3)))) 
head(biod_new)

# filter by sorting
sort_arrange <- arrange(biod_new, desc(Avg_Expr)) # descending order
print(sort_arrange)

sort_arrange_as <- arrange(biod_new, Avg_Expr) # ascending order
print(sort_arrange_as)

# grouping and summarising
biod_new %>% group_by(Biotype) %>% summarise(AvgExp = mean(Avg_Expr))

# transforming wide data to long data format
long_data <- pivot_longer(biod, cols = starts_with("Sample_"),
                          names_to = "Samples", values_to = "Expression")
head(long_data)

# SAVING DATA
# long_data.to_csv("gene_express.csv") # saving in python
write_csv(long_data, "genedata_clean.csv") # saving in R
#=============================================================================
# DATA VISUALIZATION
# 1. Bar plot - for showing individual data point counts
# a. select one data subset
# library(ggplot2)
brca_1 <- filter(long_data, Gene == "BRCA1")
View(brca_1)
bar <- ggplot(brca_1, aes(x = Samples, y = Expression)) + geom_bar(stat = "identity", fill = 'blue' ) + 
  theme_minimal() + labs(title = "BRCA 1 Expression Across Samples")

# 2. Boxplot - for showing distribution per sample
ggplot(long_data, aes(x = Samples, y = Expression)) + geom_boxplot(fill = "coral") +
  theme_minimal() + labs(title = "Gene Expression Distribution Across Samples")

# 3. Violin plot - for distribution shape, median and data spread summary
ggplot(long_data, aes(x = Samples, y = Expression)) + geom_violin(trim = FALSE, fill = 'skyblue') + 
  theme_minimal() + labs(title = "Gene Expression Spread - Violin Plot" )

# 4. Dot plot - for showing expression per gene according to a subdata column
ggplot(long_data, aes(x = Gene, y = Expression, color = Biotype)) + 
  geom_point(size = 3) + theme_minimal() + labs(title = "Gene Expression by Biotype") + 
  theme(axis.text.x = element_text(angle = 45))

# 5. Heatmap
install.packages("pheatmap")
library(pheatmap)
# a. create a matrix 
matrix <- biodata %>% select(starts_with("Sample")) %>% as.matrix()
# b. choose rownames as labels
rownames(matrix) <- biodata$Gene
# c. plot heatmap
pheat <- pheatmap(matrix, scale = "row")

# Saving plots
ggsave("heatmap.png", pheat, width=6, height=5)
ggsave("barplot.png", bar, width=4, height=5)
help(ggsave)
