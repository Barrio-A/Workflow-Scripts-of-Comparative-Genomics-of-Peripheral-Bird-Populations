library(readr)
library(dplyr)
library(ggplot2)

LmV <- read_csv("LmV_tP.nSites.csv")

crom <- "SUPER_1"

LmV_chr <- LmV %>%
  filter(Chr == crom)

LmV_chr$WinCenter <- LmV_chr$WinCenter / 1e6

LmV_chr_mean <- mean(LmV_chr$tP_per_nSites, na.rm = TRUE)

Plot <- ggplot() +

  geom_line(
    data = LmV_chr,
    aes(x = WinCenter,
        y = tP_per_nSites,
        colour = "Vallcalent"),
    linewidth = 0.8
  ) +

  geom_hline(
    aes(yintercept = LmV_chr_mean,
        colour = "Mean Vallcalent"),
    linetype = "dotdash",
    linewidth = 0.8
  ) +

  scale_colour_manual(
    values = c(
      "Vallcalent" = "blue3",
      "Mean Vallcalent" = "dodgerblue2"
    )
  ) +

  labs(
    title = bquote(
      "Nucleotide Diversity -" ~ italic("Lanius minor") ~ "-" ~ .(crom)
    ),
    x = "Position along chromosome (Mb)",
    colour = NULL
  ) +

theme_bw(base_size = 12) +

theme(
  plot.title = element_text(hjust = 0.5, face = "bold"),

  legend.position = c(0.02, 0.02),
  legend.justification = c(0, 0),

  legend.background = element_blank(),
  legend.key = element_blank(),

  #tamaño de letra
  legend.text = element_text(size = 13),
  legend.title = element_text(size = 14)
)

print(Plot)

ggsave(
  filename = "LmR_Nucl.Div._SUPER_1.png",
  plot = Plot,
  width = 12,
  height = 7,
  dpi = 300
)
