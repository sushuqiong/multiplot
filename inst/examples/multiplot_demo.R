# ============================================================
# multiplot — Reproducible demo (shareable)
# Installs from GitHub, generates all 10 manuscript figures.
# Run anywhere: source("multiplot_demo.R")
# Run: source("D:/ssq/generate_figures.R")
# ============================================================
if ("multiplot" %in% .packages()) detach("package:multiplot", unload = TRUE)
try(remove.packages("multiplot"), silent = TRUE)
if (!requireNamespace("remotes", quietly = TRUE)) install.packages("remotes")
remotes::install_github("sushuqiong/multiplot", upgrade = "always")
library(multiplot)
library(ggplot2)
suppressMessages(library(cowplot))

dir.create("figures", showWarnings = FALSE)
cat("=== multiplot demo ===\n\n")

# ---- Figure 1: 10-style boxplot comparison ----
cat("[1/7] 10-style boxplot comparison\n")
styles <- c("prism","spss","origin","stata","academic",
            "sigmaplot","jmp","matlab","minitab","medcalc")
plots <- lapply(styles, function(s) {
  ggplot(mpg, aes(class, hwy)) +
    geom_boxplot_prism(aes(fill = class), show.legend = FALSE) +
    ggchoice(s) +
    labs(title = s, x = "", y = "HWY MPG") +
    theme(plot.title  = element_text(size = 11),
          axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1, size = 7))
})
fig1 <- plot_grid(plotlist = plots, ncol = 5, nrow = 2,
                  labels = LETTERS[1:10], label_size = 10)
ggsave("figures/Figure1.pdf", fig1, width = 18, height = 9)
ggsave("figures/Figure1.png", fig1, width = 18, height = 9, dpi = 300)

# ---- Figure 2: Prism bar + error bars + axis offset ----
cat("[2/7] Prism bar chart + error bars + axis offset\n")
df_bar <- data.frame(
  group = c("Control","Treatment A","Treatment B"),
  mean  = c(10, 14, 8),
  sd    = c(2, 3, 1.5)
)
fig2 <- ggplot(df_bar, aes(group, mean)) +
  geom_col_prism(fill = "#5B9BD5") +
  geom_errorbar_prism(aes(ymin = mean - sd, ymax = mean + sd)) +
  ggchoice("prism") +
  labs(title = "", x = "", y = "Value")
ggsave("figures/Figure2.pdf", fig2, width = 7, height = 5)
ggsave("figures/Figure2.png", fig2, width = 7, height = 5, dpi = 300)

# ---- Figure 3: Prism scatter + shape + color (inspired by ggprism) ----
cat("[3/7] Prism scatter plot with shape mapping\n")
set.seed(123)
fig3 <- ggplot(iris, aes(Sepal.Length, Petal.Length)) +
  geom_point(aes(colour = Species, fill = Species, shape = Species), size = 3) +
  ggchoice("prism", axis_offset = TRUE) +
  scale_shape_prism() +
  labs(title = "", x = "Sepal Length", y = "Petal Length")
ggsave("figures/Figure3.pdf", fig3, width = 8, height = 5)
ggsave("figures/Figure3.png", fig3, width = 8, height = 5, dpi = 300)

# ---- Figure 4: Prism violin + boxplot overlay (like ggprism ref) ----
cat("[4/7] Prism violin + boxplot overlay\n")
fig4 <- ggplot(iris, aes(Species, Sepal.Width)) +
  geom_violin(aes(colour = Species, fill = Species), trim = FALSE, alpha = 0.4) +
  geom_boxplot_prism(aes(fill = Species), width = 0.15) +
  ggchoice("prism") +
  theme(legend.position = "none") +
  labs(title = "", x = "Species", y = "Sepal Width")
ggsave("figures/Figure4.pdf", fig4, width = 8, height = 5)
ggsave("figures/Figure4.png", fig4, width = 8, height = 5, dpi = 300)

# ---- Figure 5: SPSS line chart + points + shapes ----
cat("[5/7] SPSS line chart with point shapes\n")
set.seed(456)
time_df <- data.frame(
  time  = rep(1:10, 3),
  value = c(rnorm(10, 5, 0.5), rnorm(10, 6, 0.5), rnorm(10, 7, 0.5)),
  group = rep(c("Control","Treatment","Placebo"), each = 10)
)
fig5 <- ggplot(time_df, aes(time, value)) +
  geom_line(aes(colour = group), linewidth = 1) +
  geom_point(aes(colour = group, shape = group), size = 3) +
  ggchoice("spss") +
  scale_shape_spss() +
  labs(title = "", x = "Time", y = "Value")
ggsave("figures/Figure5.pdf", fig5, width = 8, height = 5)
ggsave("figures/Figure5.png", fig5, width = 8, height = 5, dpi = 300)

# ---- Figure 6: Continuous heatmaps (MATLAB + Academic) ----
cat("[6/7] Continuous heatmaps\n")
set.seed(42)
dm <- expand.grid(gene = LETTERS[1:15], sample = 1:10)
dm$expr <- rnorm(150)
p6a <- ggplot(dm, aes(sample, gene, fill = expr)) +
  geom_tile() +
  ggchoice("matlab") + scale_fill_matlab_c() +
  labs(title = "MATLAB parula", x = "Sample", y = "Gene") +
  theme(plot.title = element_text(size = 10))
p6b <- ggplot(dm, aes(sample, gene, fill = expr)) +
  geom_tile() +
  ggchoice("academic") + scale_fill_academic_c() +
  labs(title = "Academic grayscale", x = "Sample", y = "Gene") +
  theme(plot.title = element_text(size = 10))
fig6 <- plot_grid(p6a, p6b, labels = c("A","B"))
ggsave("figures/Figure6.pdf", fig6, width = 12, height = 5)
ggsave("figures/Figure6.png", fig6, width = 12, height = 5, dpi = 300)

# ---- Figure 7: Scale override + axis offset demo ----
cat("[7/7] Scale override + axis offset\n")
fig7 <- ggplot(mpg, aes(class, hwy)) +
  geom_boxplot_prism(aes(fill = class)) +
  ggchoice("prism") +
  scale_fill_brewer(palette = "Set2") +
  labs(title = "", x = "Vehicle class", y = "HWY MPG")
ggsave("figures/Figure7.pdf", fig7, width = 8, height = 5)
ggsave("figures/Figure7.png", fig7, width = 8, height = 5, dpi = 300)

# ---- Figure 8: Stata scatter with s2color style ----
cat("[8/10] Stata s2color scatter + line\n")
set.seed(789)
fig8 <- ggplot(mtcars, aes(wt, mpg)) +
  geom_point(aes(colour = factor(cyl), shape = factor(cyl)), size = 3) +
  ggchoice("stata") +
  labs(title = "", x = "Weight (1000 lbs)", y = "MPG", colour = "Cylinders", shape = "Cylinders")
ggsave("figures/Figure8.pdf", fig8, width = 8, height = 5)
ggsave("figures/Figure8.png", fig8, width = 8, height = 5, dpi = 300)

# ---- Figure 9: Origin density + rug plot ----
cat("[9/10] Origin multi-group density\n")
fig9 <- ggplot(mpg, aes(hwy, fill = class)) +
  geom_density(alpha = 0.4, linewidth = 0.5) +
  ggchoice("origin") +
  labs(title = "", x = "HWY MPG", y = "Density")
ggsave("figures/Figure9.pdf", fig9, width = 8, height = 5)
ggsave("figures/Figure9.png", fig9, width = 8, height = 5, dpi = 300)

# ---- Figure 10: Medical KM curve (SPSS style) ----
cat("[10/10] SPSS-style Kaplan-Meier survival curve\n")
if (!requireNamespace("survival", quietly = TRUE)) install.packages("survival")
suppressMessages(library(survival))
km_fit <- survfit(Surv(time, status) ~ sex, data = lung)
km_df <- data.frame(
  time = km_fit$time, surv = km_fit$surv,
  strata = rep(names(km_fit$strata), km_fit$strata)
)
fig10 <- ggplot(km_df, aes(time, surv)) +
  geom_step(aes(colour = strata), linewidth = 1) +
  ggchoice("spss") +
  labs(title = "", x = "Survival Time (days)", y = "Survival Probability",
       colour = "Sex") +
  ylim(0, 1)
ggsave("figures/Figure10.pdf", fig10, width = 8, height = 5)
ggsave("figures/Figure10.png", fig10, width = 8, height = 5, dpi = 300)

cat("\n=== All 10 figures saved to figures/ ===\n")
cat("Files:", paste(list.files("figures", pattern="*.pdf"), collapse=", "), "\n")
