pacman::p_load(readxl, tidyverse)

# Read in cleaned data, select variables except name so that the dataframe
# can be recast into gene expressions by cell_line and concentration
data <- read_excel("data/2024-03-05-WIF-tis4d-CLEAN.xlsx") %>%
  select(cell_line, treatment, conc, gene_expression) %>%
  pivot_wider(names_from = treatment, values_from = gene_expression)

# Calculate difference between treatment and placebo gene expressions
data$difference <- mapply(function(a, b) a - b, data$`Activating Factor 42`, data$Placebo, SIMPLIFY = FALSE)

# Plot difference and save
PlotDiff <- ggplot(data %>% unnest(difference), aes(x = conc, y = difference, color = cell_line)) +
  geom_point(size = 3) +
  geom_smooth(method = "loess", se = TRUE, level = 0.95) +
  labs(x = "Concentration", y = "Gene Expression Difference", color = "Cell line") +
  theme(axis.text.y = element_text(angle = 0, hjust = 1))
ggsave("figs/EDAPlotDifference.tiff", PlotDiff, width = 8, height = 6, dpi = 300, device = "tiff")

# Plot placebo gene expressions and save
PlotPlacebo <- ggplot(data %>% unnest(Placebo), aes(x = conc, y = Placebo, color = cell_line)) +
  geom_point(size = 3) +
  geom_smooth(method = "loess", se = TRUE, level = 0.95) +
  labs(x = "Concentration", y = "Gene Expression", color = "Cell line") +
  theme(axis.text.y = element_text(angle = 0, hjust = 1))
ggsave("figs/EDAPlotPlacebo.tiff", PlotPlacebo, width = 8, height = 6, dpi = 300, device = "tiff")

# Plot Activating factor 42 gene expressions and save
PlotTreatment <- ggplot(data %>% unnest(`Activating Factor 42`), aes(x = conc, y = `Activating Factor 42`, color = cell_line)) +
  geom_point(size = 3) +
  geom_smooth(method = "loess", se = TRUE, level = 0.95) +
  labs(x = "Concentration", y = "Gene Expression", color = "Cell line") +
  theme(axis.text.y = element_text(angle = 0, hjust = 1))
ggsave("figs/EDAPlotTreatment.tiff", PlotTreatment, width = 8, height = 6, dpi = 300, device = "tiff")
