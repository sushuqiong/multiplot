# ============================================================
# multiplot — Fidelity comparison: multiplot vs real software
# Generates multiplot boxplots to match real software screenshots.
# Run: source("D:/ssq/fidelity_comparison.R")
# ============================================================
if ("multiplot" %in% .packages()) detach("package:multiplot", unload = TRUE)
try(remove.packages("multiplot"), silent = TRUE)
install.packages("D:/ssq/multiplot", repos = NULL, type = "source")
library(multiplot); library(ggplot2)

dir.create("fidelity_comparison", showWarnings = FALSE)

# Data: mpg for multi-class boxplots, iris for 3-class
p1 <- ggplot(mpg, aes(class, hwy)) +
  geom_boxplot_prism(aes(fill = class), show.legend = FALSE) +
  labs(y = "HWY MPG")

p2 <- ggplot(iris, aes(Species, Sepal.Length)) +
  geom_boxplot_prism(aes(fill = Species), show.legend = FALSE) +
  labs(y = "Sepal Length")

# Generate multiplot output for each software
software <- c("prism","spss","origin","stata","academic",
              "sigmaplot","jmp","matlab","minitab","medcalc")
names <- c("GraphPad-Prism","SPSS","OriginPro","Stata","Academic",
           "SigmaPlot","JMP","MATLAB","Minitab","MedCalc")

cat("Generating fidelity comparison figures...\n")
for (i in seq_along(software)) {
  s <- software[i]; nm <- names[i]
  cat(sprintf("[%02d/10] %s\n", i, nm))

  data <- if (s == "jmp") p2 else p1
  gg <- data + ggchoice(s) + labs(title = paste0("multiplot — ", nm))

  ggsave(sprintf("fidelity_comparison/multiplot_%s.png", s),
         gg, width = 8, height = 5, dpi = 300)
}

cat("\nDone. Compare fidelity_comparison/*.png with real screenshots at:\n")
cat("  C:/Users/fengq/Desktop/软件真实截图/\n")
cat("  C:/Users/fengq/Desktop/其它软件的截图验证/\n")

# ---- Summary notes ----
cat("\n=== Comparison checklist ===\n")
cat("For each software pair (multiplot vs real), check:\n")
cat("  1. Background colour and grid presence\n")
cat("  2. Frame/border style\n")
cat("  3. Font family and title style\n")
cat("  4. Tick direction (inward/outward)\n")
cat("  5. Legend position and border\n")
cat("  6. Colour palette (first 3-5 bar/box fill colours)\n")
cat("  7. Axis label spacing and tick length\n")
cat("===============================\n")
