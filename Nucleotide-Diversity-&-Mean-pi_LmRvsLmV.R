library(readr)
library(dplyr)
library(ggplot2)

LmR <- read_csv("LmR_tP.nSites.csv")
LmV <- read_csv("LmV_tP.nSites.csv")

crom <- "SUPER_1"

LmR_chr <- LmR %>%
  filter(Chr == crom)

LmV_chr <- LmV %>%
  filter(Chr == crom)

LmR_chr$WinCenter <- LmR_chr$WinCenter / 1e6
LmV_chr$WinCenter <- LmV_chr$WinCenter / 1e6

LmR_chr_mean <- mean(LmR_chr$tP_per_nSites, na.rm = TRUE)
LmV_chr_mean <- mean(LmV_chr$tP_per_nSites, na.rm = TRUE)

Plot <- ggplot() +

  geom_line(
    data = LmR_chr,
    aes(x = WinCenter,
        y = tP_per_nSites,
        colour = "L.minor Russia"),
    linewidth = 0.8
  ) +

  geom_line(
    data = LmV_chr,
    aes(x = WinCenter,
        y = tP_per_nSites,
        colour = "L.minor Vallcalent"),
    linewidth = 0.8
  ) +

  geom_hline(
    aes(yintercept = LmR_chr_mean,
        colour = "Mean L.minor Russia"),
    linetype = "dotdash",
    linewidth = 0.8
  ) +

  geom_hline(
    aes(yintercept = LmV_chr_mean,
        colour = "Mean L.minor Vallcalent"),
    linetype = "dotdash",
    linewidth = 0.8
  ) +

  scale_colour_manual(
    values = c(
      "L.minor Russia" = "red2",
      "L.minor Vallcalent" = "blue3",
      "Mean L.minor Russia" = "indianred3",
      "Mean L.minor Vallcalent" = "dodgerblue2"
    )
  ) +

  labs(
    title = paste("Nucleotide Diversity -", crom),
    x = "Position along chromosome (Mb)",
    y = expression(paste("Nucleotide diversity (", pi, ")")),
    colour = NULL
  ) +

  theme_bw(base_size = 14) +

theme(
  plot.title = element_text(hjust = 0.5, face = "bold"),
  legend.position = c(0.82, 0.88),
  legend.background = element_blank(),
  legend.key = element_blank()
)

print(Plot)

ggsave(
  filename = "/home/andrea/Desktop/TFM/Lm_Nucl.Div._Chr/Lm_Nucl.Div._SUPER_1.png",
  plot = Plot,
  width = 12,
  height = 7,
  dpi = 300
)
