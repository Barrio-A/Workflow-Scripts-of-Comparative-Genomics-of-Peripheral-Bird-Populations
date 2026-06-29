library(dplyr)

data <- read.csv("LmR_tP.nSites.csv")

mean_per_chromosome <- data %>%
  group_by(Chr) %>%
  summarise(mean_diversity = mean(tP_per_nSites))

print(mean_per_chromosome)

write.table(mean_per_chromosome,
            file = "LmR_diversity_mean_per_chromosome.txt",
            sep = "\t",
            row.names = FALSE,
            quote = FALSE)
