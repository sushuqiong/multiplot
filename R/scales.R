# Internal discrete colour / fill scales for each software style.
# Called by ggchoice(); not exported to the user.

# ---- Palette definitions (researched) ----

# GraphPad Prism: pastel-to-bold defaults
prism_palette <- c("#5B9BD5", "#ED7D31", "#A5A5A5", "#FFC000", "#4472C4",
                   "#70AD47", "#264478", "#9B59B6", "#E74C3C", "#1ABC9C")

# SPSS 12–24 classic blue-dominant palette (blue = RGB 62,88,172)
spss_palette  <- c("#3E58AC", "#C0392B", "#27AE60", "#F39C12", "#8E44AD",
                   "#16A085", "#D35400", "#7F8C8D", "#2980B9", "#E67E22")

# OriginPro classic: Black → Red → Green → Blue (and beyond)
origin_palette <- c("#000000", "#FF0000", "#008000", "#0000FF", "#00FFFF",
                    "#FF00FF", "#FFFF00", "#800080", "#008080", "#FF8C00")

# Stata s2color: 15-colour factory scheme (navy, maroon, forest_green, …)
stata_palette  <- c("#000080", "#800000", "#228B22", "#FF8C00", "#008080",
                    "#CD5C5C", "#B57EDC", "#C3B091", "#A0522D", "#4682B4",
                    "#50C878", "#A52A2A", "#F4C2C2", "#FFD700", "#B0C4DE")

# Academic: grayscale for journal submission
academic_palette <- c("#000000", "#525252", "#969696", "#BDBDBD", "#D9D9D9",
                      "#737373", "#252525", "#A6A6A6", "#404040", "#CCCCCC")

# SigmaPlot: single-series black, multi-series grayscale
sigmaplot_palette <- c("#000000", "#595959", "#8C8C8C", "#BFBFBF", "#D9D9D9",
                       "#404040", "#737373", "#A6A6A6", "#262626", "#CCCCCC")

# JMP: JMPer blue + Tableau-inspired categorical
jmp_palette <- c("#1F77B4", "#FF7F0E", "#2CA02C", "#D62728", "#9467BD",
                 "#8C564B", "#E377C2", "#7F7F7F", "#BCBD22", "#17BECF")

# MATLAB R2014b+ new default colour order (exact RGB→hex)
matlab_palette <- c("#0072BD", "#D95319", "#EDB120", "#7E2F8E", "#77AC30",
                    "#4DBEEE", "#A2142F", "#000000", "#FF0000", "#00FF00")

# Minitab: dark blue primary → accent palette
minitab_palette <- c("#1F497D", "#C0504D", "#9BBB59", "#8064A2", "#4BACC6",
                     "#F79646", "#2C3E50", "#7F8C8D", "#E67E22", "#3498DB")

# MedCalc: clinical ROC-optimised, strong contrast
medcalc_palette <- c("#000000", "#E41A1C", "#377EB8", "#4DAF4A", "#984EA3",
                     "#FF7F00", "#A65628", "#F781BF", "#999999", "#66C2A5")

# ---- Internal palette generator ----

pal_gen <- function(palette) {
  function(n) {
    if (n <= length(palette)) {
      palette[seq_len(n)]
    } else {
      grDevices::colorRampPalette(palette)(n)
    }
  }
}

# ---- Internal scale constructors ----

scale_color_prism    <- function(...) ggplot2::discrete_scale("colour", "prism",    palette = pal_gen(prism_palette),    ...)
scale_fill_prism     <- function(...) ggplot2::discrete_scale("fill",   "prism",    palette = pal_gen(prism_palette),    ...)

scale_color_spss     <- function(...) ggplot2::discrete_scale("colour", "spss",     palette = pal_gen(spss_palette),     ...)
scale_fill_spss      <- function(...) ggplot2::discrete_scale("fill",   "spss",     palette = pal_gen(spss_palette),     ...)

scale_color_origin   <- function(...) ggplot2::discrete_scale("colour", "origin",   palette = pal_gen(origin_palette),   ...)
scale_fill_origin    <- function(...) ggplot2::discrete_scale("fill",   "origin",   palette = pal_gen(origin_palette),   ...)

scale_color_stata    <- function(...) ggplot2::discrete_scale("colour", "stata",    palette = pal_gen(stata_palette),    ...)
scale_fill_stata     <- function(...) ggplot2::discrete_scale("fill",   "stata",    palette = pal_gen(stata_palette),    ...)

scale_color_academic <- function(...) ggplot2::discrete_scale("colour", "academic", palette = pal_gen(academic_palette), ...)
scale_fill_academic  <- function(...) ggplot2::discrete_scale("fill",   "academic", palette = pal_gen(academic_palette), ...)

scale_color_sigmaplot <- function(...) ggplot2::discrete_scale("colour", "sigmaplot", palette = pal_gen(sigmaplot_palette), ...)
scale_fill_sigmaplot  <- function(...) ggplot2::discrete_scale("fill",   "sigmaplot", palette = pal_gen(sigmaplot_palette), ...)

scale_color_jmp      <- function(...) ggplot2::discrete_scale("colour", "jmp",      palette = pal_gen(jmp_palette),      ...)
scale_fill_jmp       <- function(...) ggplot2::discrete_scale("fill",   "jmp",      palette = pal_gen(jmp_palette),      ...)

scale_color_matlab   <- function(...) ggplot2::discrete_scale("colour", "matlab",   palette = pal_gen(matlab_palette),   ...)
scale_fill_matlab    <- function(...) ggplot2::discrete_scale("fill",   "matlab",   palette = pal_gen(matlab_palette),   ...)

scale_color_minitab  <- function(...) ggplot2::discrete_scale("colour", "minitab",  palette = pal_gen(minitab_palette),  ...)
scale_fill_minitab   <- function(...) ggplot2::discrete_scale("fill",   "minitab",  palette = pal_gen(minitab_palette),  ...)

scale_color_medcalc  <- function(...) ggplot2::discrete_scale("colour", "medcalc",  palette = pal_gen(medcalc_palette),  ...)
scale_fill_medcalc   <- function(...) ggplot2::discrete_scale("fill",   "medcalc",  palette = pal_gen(medcalc_palette),  ...)
