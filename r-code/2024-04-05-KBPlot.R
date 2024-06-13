pacman::p_load(readxl, tidyverse, showtext, "ggpubr", ggrepel, grid)

# Read in cleaned data
data <- read_excel("data/2024-03-05-WIF-tis4d-CLEAN.xlsx")

# Define treatment and placebo geom_point() fill colours, respectively
fill_colors <- c("#78A8D1","#D5BF98")

# Subset data to only include Wild-type cell line for plotA
data1 <- subset(data, cell_line=="WILD-TYPE",select=c(conc, gene_expression,treatment,name))

# Plot gene_expression ~ concentration with appropriate styling for data1
plotA <- ggplot(data1,aes(x=conc,y=gene_expression))+
  ggtitle("Wild-type")+
  scale_x_continuous(breaks = 0:10, labels = 0:10, limits = c(NA,11)) + # Set custom x-axis tick labels+
  xlab (expression(paste(
    "Concentration (",
    mu, g, "/", ml,
    ")", sep=""))) +
  ylab("Gene Expression")+
  geom_point(shape = 21, aes(fill = treatment), color = "black", size=4)+
  scale_color_manual(values = fill_colors) +
  geom_label_repel(data = subset(data1, conc==10), aes(label = name, fill = treatment),
                   family = "serif",
                   show.legend = FALSE,
                   min.segment.length = unit(0, 'lines'),
                   nudge_x = 0.3) +  # Add labels next to points on the right side
  scale_fill_manual(values = fill_colors)+
  theme_minimal()+
  theme(text = element_text(family = "serif"),
        axis.line = element_line(color = "black"),
        axis.ticks = element_line(color = "black"),
        panel.border = element_rect(color = "black", fill = NA, size = 0.5),
        legend.key.size = unit(1.5, "lines"))+
  labs(color = "Treatment")+
  guides(fill=guide_legend(title="Treatment"))

# Subset data to only include Cell-type 101 cell line for plotB
data2 <- subset(data, cell_line=="CELL-TYPE 101",select=c(conc, gene_expression,treatment,name))

# Plot gene expression ~ concentration with appropriate styling for data2
plotB <- ggplot(data2,aes(x=conc,y=gene_expression))+
  ggtitle("Cell-type 101") +
  scale_x_continuous(breaks = 0:10, labels = 0:10, limits = c(NA,11)) +
  xlab(expression(paste(
    "Concentration (",
    mu, g, "/", ml,
    ")", sep=""))) +
  ylab("Gene Expression") +
  geom_point(shape = 21, aes(fill = treatment), color = "black", size=4)+
  scale_color_manual(values = fill_colors) +
  geom_label_repel(data = subset(data2, conc==10), aes(label = name, fill = treatment),
                   family = "serif",
                   show.legend = FALSE,
                   nudge_x = 0.3) +  # Add labels next to points on the right side
  scale_fill_manual(values = fill_colors)+
  theme_minimal()+
  theme(text = element_text(family = "serif"),
        axis.line = element_line(color = "black"),
        axis.ticks = element_line(color = "black"),
        panel.border = element_rect(color = "black", fill = NA, size = 0.5),
        legend.key.size = unit(1.5, "lines"))+
  labs(color = "Treatment")+
  guides(fill=guide_legend(title="Treatment"))

# Combine plotA and plotB into side-by-side grid with a common legend at the bottom of the pane
# with appropriate labelling
finalPlot <- ggarrange(
  plotA, plotB, labels = c("A", "B"),
  common.legend = TRUE, legend = "bottom",
  font.label = list(family = "serif")
)

# Save figure
ggsave("figs/5-4-24-KarlBeratorPlot.tiff", finalPlot, width = 9, height = 6, dpi = 500, device = "tiff")
