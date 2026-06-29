library(readr)
library(dplyr)
library(tidyr)
library(ggplot2)

LmR <- read_csv("LmR_pi.nSites.depth_no.bin.csv") # Russia
LmV <- read_csv("LmV_pi.nSites.depth_no.bin.csv") # Vallcalent

crom <- "SUPER_1"

LmR_chr <- LmR %>% filter(Chr == crom)
LmV_chr <- LmV %>% filter(Chr == crom)

LmR_chr <- LmR_chr %>% mutate(WinCenter = WinCenter / 1e6)
LmV_chr <- LmV_chr %>% mutate(WinCenter = WinCenter / 1e6)

LmR_long <- LmR_chr %>%
pivot_longer(
cols = 3:5,
names_to = "metric",
values_to = "value"
) %>%
mutate(individual = "LmR")

LmV_long <- LmV_chr %>%
pivot_longer(
cols = 3:5,
names_to = "metric",
values_to = "value"
) %>%
mutate(individual = "LmV")

data_all <- bind_rows(LmR_long, LmV_long)

data_all$metric <- recode(
data_all$metric,
"tP_per_nSites" = "pi",
"nSites" = "Sites",
"depth" = "Depth"
)

LmR_chr$nSites_scaled <- LmR_chr$nSites / 10000
LmV_chr$nSites_scaled <- LmV_chr$nSites / 10000

pi_max <- max(
  c(LmR_chr$tP_per_nSites, LmV_chr$tP_per_nSites),
  na.rm = TRUE
)

cov_max <- max(
  c(
    LmR_chr$depth,
    LmV_chr$depth,
    LmR_chr$nSites_scaled,
    LmV_chr$nSites_scaled
  ),
  na.rm = TRUE
)

scale_factor <- pi_max / cov_max

Plot <- ggplot() +

  geom_line(
    data = LmR_chr,
    aes(WinCenter, tP_per_nSites,
        colour = "L. minor Russia π"),
    linewidth = 0.8
  ) +

  geom_line(
    data = LmV_chr,
    aes(WinCenter, tP_per_nSites,
        colour = "L. minor Vallcalent π"),
    linewidth = 0.8
  ) +

  # nSites/10000 (eje derecho)
  geom_line(
    data = LmR_chr,
    aes(
      WinCenter,
      nSites_scaled * scale_factor,
      colour = "L. minor Russia Sites"
    ),
    linewidth = 0.8,
    linetype = 1
  ) +

  geom_line(
    data = LmV_chr,
    aes(
      WinCenter,
      nSites_scaled * scale_factor,
      colour = "L. minor Vallcalent Sites"
    ),
    linewidth = 0.8,
    linetype = 1
  ) +

  geom_line(
    data = LmR_chr,
    aes(
      WinCenter,
      depth * scale_factor,
      colour = "L. minor Russia Depth"
    ),
    linewidth = 0.8,
    linetype = 2
  ) +

  geom_line(
    data = LmV_chr,
    aes(
      WinCenter,
      depth * scale_factor,
      colour = "L. minor Vallcalent Depth"
    ),
    linewidth = 0.8,
    linetype = 2
  ) +

  scale_y_continuous(
    name = expression(paste("Nucleotide diversity (", pi, ")")),
    sec.axis = sec_axis(
      ~ . / scale_factor,
      name = "Depth / Sites (×10⁴)"
    )
  ) +

  scale_colour_manual(
breaks = c(
"L. minor Russia π",
"L. minor Vallcalent π",

"L. minor Russia Sites",
"L. minor Vallcalent Sites",

"L. minor Russia Depth",
"L. minor Vallcalent Depth"
),
labels = c(
"L. minor Russia π" = "π Russia",
"L. minor Vallcalent π" = "π Vallcalent",

"L. minor Russia Sites" = "Sites Russia",
"L. minor Vallcalent Sites" = "Sites Vallcalent",

"L. minor Russia Depth" = "Depth Russia",
"L. minor Vallcalent Depth" = "Depth Vallcalent"
),
values = c(
"L. minor Russia π" = "red2",
"L. minor Vallcalent π" = "blue3",

"L. minor Russia Sites" = "gray48",
"L. minor Vallcalent Sites" = "grey0",

"L. minor Russia Depth" = "gray48",
"L. minor Vallcalent Depth" = "grey0"
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

  legend.text = element_text(size = 13),
  legend.title = element_text(size = 14)
)

print(Plot)

ggsave(
  filename = "Lm_Nucl.Div.Sites.Depth_SUPER_1.png",
  plot = Plot,
  width = 12,
  height = 7,
  dpi = 300
)
)
