pacman::p_load(gt)

# Reproduce neater version of fixed effects table in
# summary(M1) from `2024-05-31-Model.R`
# Entries are left aligned
# Formatting is to 4 decimal places for non p-value columns
fixed_effects <- tibble::tibble(
  Term = c("(Intercept)",
           "Concentration:Cell-type 101",
           "Concentration:Wild-type",
           "Placebo:Cell-type 101",
           "Placebo:Wild-type",
           "Concentration:Placebo:Cell-type 101",
           "Concentration:Placebo:Wild-type"),
  Estimate = c(2.39112, 0.05773, 0.11425, -0.36349, -0.74711, 0.05339, -0.14413),
  `Std. Error` = c(0.16773, 0.01345, 0.01345, 0.29052, 0.29052, 0.01923, 0.01923),
  df = c(5.94041, 80.41245, 80.41245, 5.94041, 5.94041, 78.70838, 78.70838),
  `t value` = c(14.256, 4.291, 8.493, -1.251, -2.572, 2.776, -7.495),
  `Pr(>|t|)` = c("8.08e-06 ***", "4.91e-05 ***", "8.39e-13 ***", "0.25788", "0.04262 *", "0.00687 **", "8.50e-11 ***")
  ) %>%
  gt() %>%
  tab_header(
    title = "Fixed Effects Summary"
  ) %>%
  cols_label(
    Term = "Term",
    Estimate = "Estimate",
    `Std. Error` = "Std. Error",
    df = "df",
    `t value` = "t value",
    `Pr(>|t|)` = "Pr(>|t|)"
  ) %>%
  fmt_number(
    columns = c("Estimate", "Std. Error", "df", "t value"),
    decimals = 4
  ) %>%
  cols_align(
    align = "left",
    columns = everything()
  ) %>%
  tab_options(
    table.width = pct(100)
  ) %>%
  gtsave(
    here::here("tabs", "modelOutput.docx")
  ) # Save
