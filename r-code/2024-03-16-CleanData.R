pacman::p_load(readxl, openxlsx, tidyverse)

# Read in raw data file (note: no missing entries to handle)
data <- read_excel("raw-data/2024-03-05-WIF-tis4d.xlsx")

# Mutate strings to uppercase
data <- data %>%
  mutate_at(vars(cell_line, treatment, name), toupper)

# Redefine case style for strings
data$treatment <- recode(data$treatment, "PLACEBO" = "Placebo", "ACTIVATING FACTOR 42" = "Activating Factor 42");
data$name <- recode(data$name, "GL-CDZ" = "cDZ", "GL-XIK" = "Xik", "GL-RJS" = "rjS", "GL-XIB" = "XIb", "GL-MFA" = "MFA", "GL-CWN" = "cwN", "GL-KYH" = "kYH", "GL-ZHW" = "ZHw")

# Output cleaned data file
write.xlsx(data, "data/2024-03-05-WIF-tis4d-CLEAN.xlsx")
