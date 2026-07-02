#' Prism-style statistical comparison annotations
#'
#' Wraps \code{\link[ggpubr]{stat_compare_means}} with defaults tuned to
#' match GraphPad Prism's significance bracket formatting: P-value cutoffs
#' at 0.05 / 0.01 / 0.001 / 0.0001, Prism-style label formatting,
#' and bracket positioning appropriate for column / bar charts.
#'
#' @param comparisons A list of length-2 vectors specifying the groups to
#'   compare (e.g. \code{list(c("A","B"), c("B","C"))}).
#' @param method Statistical test method. One of \code{"t.test"},
#'   \code{"wilcox.test"}, \code{"anova"}, \code{"kruskal.test"}.
#'   Default \code{"t.test"}.
#' @param p.format How to display p-values. \code{"prism"} (default) shows
#'   exact P value or "P < 0.0001"; \code{"signif"} shows significance
#'   stars only; \code{"numeric"} shows raw p-value; \code{"scientific"}
#'   uses scientific notation.
#' @param label Position of the p-value label along the bracket.
#'   \code{"bracket"} (default) places the label above the bracket;
#'   \code{"middle"} places it on the bracket.
#' @param tip.length Tip length of the comparison brackets in native units
#'   (default 0.02).
#' @param step.increase Vertical spacing increment between stacked brackets
#'   (default 0.12).
#' @param hide.ns If \code{TRUE}, hide "ns" (non-significant) annotations.
#'   Default \code{FALSE}.
#' @param ... Other arguments passed to
#'   \code{\link[ggpubr]{stat_compare_means}}.
#'
#' @return A ggplot2 layer (invisibly).
#' @export
#'
#' @examples
#' \dontrun{
#' library(ggplot2)
#' ggplot(ToothGrowth, aes(supp, len)) +
#'   geom_boxplot(aes(fill = supp)) +
#'   ggchoice("prism") +
#'   stat_compare_means_prism(comparisons = list(c("OJ", "VC")))
#' }
stat_compare_means_prism <- function(comparisons,
                                     method = "t.test",
                                     p.format = c("prism", "signif",
                                                  "numeric", "scientific"),
                                     label = c("bracket", "middle"),
                                     tip.length = 0.02,
                                     step.increase = 0.12,
                                     hide.ns = FALSE,
                                     ...) {

  if (!requireNamespace("ggpubr", quietly = TRUE)) {
    stop("Package 'ggpubr' is required for stat_compare_means_prism(). ",
         "Install it with: install.packages('ggpubr')", call. = FALSE)
  }

  p.format   <- match.arg(p.format)
  label      <- match.arg(label)

  # Build Prism-style p-value formatter
  prism_p_fun <- if (p.format == "prism") {
    function(p) {
      ifelse(p < 0.0001, "P < 0.0001",
      ifelse(p < 0.001,  sprintf("P = %.4f", p),
      ifelse(p < 0.01,   sprintf("P = %.4f", p),
      ifelse(p < 0.05,   sprintf("P = %.4f", p),
                          sprintf("P = %.4f", p)))))
    }
  } else {
    NULL
  }

  # Map to ggpubr's p.format
  ggpubr_pfmt <- switch(p.format,
    prism      = "expression",
    signif     = "signif",
    numeric    = "numeric",
    scientific = "scientific"
  )

  ggpubr::stat_compare_means(
    comparisons   = comparisons,
    method        = method,
    p.format      = ggpubr_pfmt,
    label         = label,
    tip.length    = tip.length,
    step.increase = step.increase,
    hide.ns       = hide.ns,
    symnum.args   = list(
      cutpoints = c(0, 0.0001, 0.001, 0.01, 0.05, 1),
      symbols   = c("****", "***", "**", "*", "ns")
    ),
    ...
  )
}
