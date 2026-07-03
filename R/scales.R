# Internal discrete colour / fill scales for each software style.
# Called by ggchoice(); not exported to the user.

# ---- Palette definitions (researched) ----

# GraphPad Prism: pastel-to-bold defaults
prism_palette <- c("#5B9BD5", "#ED7D31", "#A5A5A5", "#FFC000", "#4472C4",
                   "#70AD47", "#264478", "#9B59B6", "#E74C3C", "#1ABC9C")

# SPSS classic palette: blue-dominant, muted, low-saturation professional tones.
# SPSS real output: the same dark blue for single-series; for multi-group,
# it introduces subtle lightness variation within the BLUE family,
# never jumping to red/green/gold.  A 7-group boxplot still reads as
# "SPSS blue" rather than a rainbow.  10 colours, all blue tones.
spss_palette  <- c("#3E58AC", "#4A6DB8", "#5682C4", "#6297D0",
                   "#6EACDC", "#7ABBE8", "#86C8F0", "#92D3F4",
                   "#9EDCF8", "#AAE5FC")

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

# MATLAB R2014b+ default colour order — exactly 7 colours (MathWorks official RGB)
matlab_palette <- c("#0072BD", "#D95319", "#EDB120", "#7E2F8E", "#77AC30",
                    "#4DBEEE", "#A2142F")

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

# ---- Shape scales (per-software default point shape sequences) ----

gen_shape <- function(shapes) function(n) rep_len(shapes, n)

prism_shapes    <- c(16, 15, 17, 18, 21, 22, 24, 25, 23, 8)
spss_shapes     <- c(16, 1,  15, 0,  18, 5,  17, 2,  8,  3)
origin_shapes   <- c(1,  0,  5,  2,  6,  4,  3,  8,  16, 15)
stata_shapes    <- c(1,  16, 0,  15, 5,  18, 2,  17, 8,  4)
academic_shapes <- c(1,  0,  5,  2,  6,  4,  3,  7,  8,  9)
sigmaplot_shapes<- c(16, 1,  15, 0,  17, 2,  18, 5,  8,  3)
jmp_shapes      <- c(16, 19, 15, 18, 17, 21, 22, 24, 25, 23)
matlab_shapes   <- c(1,  0,  5,  2,  3,  4,  6,  16, 15, 8)
minitab_shapes  <- c(16, 15, 18, 17, 21, 22, 24, 25, 23, 8)
medcalc_shapes  <- c(1,  16, 0,  15, 5,  2,  18, 17, 8,  3)

#' Software-specific point shape scales
#'
#' Discrete shape scales that apply each graphing software's default
#' point marker sequence.  Each scale maps shape aesthetics to the
#' marker shapes used by that software's factory defaults.
#'
#' @param ... Arguments passed to \code{\link[ggplot2]{discrete_scale}}.
#' @name scale_shape_software
#' @rdname scale_shape_software
#' @export
scale_shape_prism    <- function(...) ggplot2::discrete_scale("shape", "prism",    palette = gen_shape(prism_shapes),    ...)
#' @rdname scale_shape_software
#' @export
scale_shape_spss     <- function(...) ggplot2::discrete_scale("shape", "spss",     palette = gen_shape(spss_shapes),     ...)
#' @rdname scale_shape_software
#' @export
scale_shape_origin   <- function(...) ggplot2::discrete_scale("shape", "origin",   palette = gen_shape(origin_shapes),   ...)
#' @rdname scale_shape_software
#' @export
scale_shape_stata    <- function(...) ggplot2::discrete_scale("shape", "stata",    palette = gen_shape(stata_shapes),    ...)
#' @rdname scale_shape_software
#' @export
scale_shape_academic <- function(...) ggplot2::discrete_scale("shape", "academic", palette = gen_shape(academic_shapes), ...)
#' @rdname scale_shape_software
#' @export
scale_shape_sigmaplot<- function(...) ggplot2::discrete_scale("shape", "sigmaplot",palette = gen_shape(sigmaplot_shapes),...)
#' @rdname scale_shape_software
#' @export
scale_shape_jmp      <- function(...) ggplot2::discrete_scale("shape", "jmp",      palette = gen_shape(jmp_shapes),      ...)
#' @rdname scale_shape_software
#' @export
scale_shape_matlab   <- function(...) ggplot2::discrete_scale("shape", "matlab",   palette = gen_shape(matlab_shapes),   ...)
#' @rdname scale_shape_software
#' @export
scale_shape_minitab  <- function(...) ggplot2::discrete_scale("shape", "minitab",  palette = gen_shape(minitab_shapes),  ...)
#' @rdname scale_shape_software
#' @export
scale_shape_medcalc  <- function(...) ggplot2::discrete_scale("shape", "medcalc",  palette = gen_shape(medcalc_shapes),  ...)
