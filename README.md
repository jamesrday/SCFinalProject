# Statistical Consulting Final Project

This repository contains all the materials and code for the analysis used in our final paper. Below is an overview of the contents and instructions on how to run the provided R scripts.

## Contents

### IMRaD Report
The final IMRaD report, detailing the statistical analysis, is available as a `.html` file in the **docs** folder. This report includes all statistical methodologies, results, and discussions pertinent to our study.

### Data
- **raw-data**: This folder contains the provided experimental data file `2024-03-05-WIF-tis4d.xlsx`. It includes 88 observations with the following variables:
  - `cell_line`: Type of cell line used (Wild-type or Cell-type 101).
  - `treatment`: Treatment applied (Placebo or Activating Factor 42).
  - `name`: Name of specific cell culture.
  - `conc`: Concentration of growth factor.
  - `gene_expression`: Resultant gene expression.

- **data**: This folder contains the processed and cleaned data (derived from the raw data).

### Figures and Tables
- **figs**: This folder contains all figures saved as `.tiff` files.
- **tabs**: This folder contains all tables saved as `.docx` files.

### Code
- **r-code**: This folder contains all R scripts used for data processing, analysis, and visualisation.

## Running the Scripts

To run any of the R scripts provided in the `r-code` folder, follow these steps:

1. Open RStudio with the `.Rproj` file.
2. Ensure the project folder is set as the working directory. You can do this by using the `Session` menu in RStudio:
   - `Session -> Set Working Directory -> To Project Directory`
3. Locate and open the desired R script in the `r-code` folder.
4. Press <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>S</kbd> (or <kbd>Cmd</kbd>+<kbd>Shift</kbd>+<kbd>S</kbd> on macOS) to source and execute the script.

Upon execution, any relevant output will be printed to the console. Additionally, figures and tables will be generated and saved to the appropriate folders (`figs` and `tabs`, respectively). 

**Note**: If you do not want to overwrite the original figures and tables, you may rename the file names used by `gtsave()` and `ggsave()` functions in the scripts.

## Contact

For any questions, feel free to contact me at james.r.day@student.adelaide.edu.au.
