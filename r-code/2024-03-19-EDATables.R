pacman::p_load(readxl, tidyverse, gt)

# Read in cleaned data
data <- read_excel("data/2024-03-05-WIF-tis4d-CLEAN.xlsx")

# Create table of summary statistics mean, sd, median, etc. grouping by treatment
# and cell_line
data %>%
  group_by(treatment, cell_line) %>%
  summarise(`Mean Gene Expression` = mean(gene_expression),
            `Minimum Gene Expression` = min(gene_expression),
            `Median Gene Expression` = median(gene_expression),
            `Maximum Gene Expression` = max(gene_expression),
            `STDEV Gene Expression` = sd(gene_expression),
            `Total Observations` = round(n(),0)
  ) %>%
  gt() %>% # generate table from summary stats
  tab_style(
    style = list(
      cell_fill(color = "grey80"),
      cell_text(weight = "bold")
    ),
    locations = cells_row_groups())%>% # style grouped(treatment) rows
  cols_label(
    cell_line = "Cell Line",
  ) %>%
  tab_header(
    title = "Summary of Gene Expression by Cell Line and Treatment"
  ) %>%
  fmt_number(
    columns = c(`Mean Gene Expression`, `Minimum Gene Expression`, `Median Gene Expression`, `Maximum Gene Expression`, `STDEV Gene Expression`),
    decimals = 2
  ) %>% # Labelling
  gtsave(
    here::here("tabs", "cellLineTreatmentTable.docx")
  ) # Save table

# Create table of summary statistics mean, sd, median, etc. grouping by treatment
# and growth factor concentration (with same styling)
data %>%
  group_by(treatment, conc) %>%
  summarise(`Mean Gene Expression` = mean(gene_expression),
            `Minimum Gene Expression` = min(gene_expression),
            `Median Gene Expression` = median(gene_expression),
            `Maximum Gene Expression` = max(gene_expression),
            `STDEV Gene Expression` = sd(gene_expression),
            `Total Observations` = round(n(),0)
  ) %>%
  gt() %>%
  tab_style(
    style = list(
      cell_fill(color = "grey80"),
      cell_text(weight = "bold")
    ),
    locations = cells_row_groups())%>%
  cols_label(
    conc = "Concentration",
  ) %>%
  tab_header(
    title = "Summary of Gene Expression by Concentration and Treatment"
  ) %>%
  fmt_number(
    columns = c(`Mean Gene Expression`, `Minimum Gene Expression`, `Median Gene Expression`, `Maximum Gene Expression`, `STDEV Gene Expression`),
    decimals = 2
  ) %>%
  gtsave(
    here::here("tabs", "concTreatmentTable.docx")
  ) # Save table
