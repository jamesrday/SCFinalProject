pacman::p_load(readxl, tidyverse, lme4, performance, see, lmerTest, MASS)

# Read in cleaned data
data <- read_excel("data/2024-03-05-WIF-tis4d-CLEAN.xlsx")

# Fit linear mixed effects models of increasing complexity
MNull <- lmer(data=data, log(gene_expression) ~ (1|name))
M0 <- lmer(data=data, log(gene_expression) ~  (1|name) + conc*treatment)
M1 <- lmer(data=data, log(gene_expression) ~ (1|name) + (conc*treatment):cell_line)
M2 <- lmer(data=data, log(gene_expression) ~  (1|name) + (conc*treatment)*cell_line)

# Print summary for chosen model
print(summary(M1))

# Print AIC to justify chosen model (refer to IMRaD for discussion on
# principle of marginality)
print(AIC(MNull,M0,M1,M2))

# Justify box-cox transformation of response (y^lambda-1)/lambda=log(y) when lambda->0
b <- boxcox(lm(data=data, gene_expression ~ 1))
# Note that the above should be
# b <- boxcox(lm(data=data, gene_expression ~ (conc*treatment):cell_line))
# and this will give a lower estimator for lambda
# (the 90% confidence interval still includes lambda=0, which is just outside 95%)
cat("\nBC Estimator:",b$x[which.max(b$y)])

# Generate diagnostic plots from performance package, remove labelling, and save
diagnostic_plots <- plot(check_model(M2, panel = FALSE))
linPlot <- diagnostic_plots[[1]] + labs(
  title = "",
  subtitle = ""
)
ggsave("figs/linearityDiagnosticPlot.tiff", linPlot, width = 8, height = 5, dpi = 500, device = "tiff")

normPlot <- diagnostic_plots[[5]] + labs(
  title = "",
  subtitle = ""
)
ggsave("figs/normalityDiagnosticPlot.tiff", normPlot, width = 8, height = 5, dpi = 500, device = "tiff")

levPlot <- diagnostic_plots[[3]] + labs(
  title = "",
  subtitle = ""
)
ggsave("figs/leverageDiagnosticPlot.tiff", levPlot, width = 8, height = 5, dpi = 500, device = "tiff")
